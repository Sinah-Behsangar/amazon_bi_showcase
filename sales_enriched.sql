-- End any previous statements with a semicolon (just in case)
;WITH return_summary AS (
  SELECT ASIN, Date, SUM(Return_Qty) AS Total_Returns
  FROM dbo.returns_data
  GROUP BY ASIN, Date
),
review_summary AS (
  SELECT ASIN,
         ROUND(AVG(CAST(Star_Rating AS FLOAT)), 2) AS Avg_Review_Score,
         COUNT(*) AS Review_Count
  FROM dbo.reviews_data
  GROUP BY ASIN
)

SELECT
  s.Date,
  s.ASIN,
  p.Category,
  s.Price,
  s.Units_Sold,
  s.Revenue,
  s.Ad_Spend,
  s.Is_Promotion,
  ISNULL(rs.Total_Returns, 0) AS Return_Qty,
  ROUND(CAST(ISNULL(rs.Total_Returns, 0) AS FLOAT) / NULLIF(s.Units_Sold, 0), 2) AS Return_Rate,
  rv.Avg_Review_Score,
  rv.Review_Count
INTO dbo.sales_enriched  -- 👈 This creates the new table
FROM dbo.sales_data s
LEFT JOIN dbo.product_catalog p ON s.ASIN = p.ASIN
LEFT JOIN return_summary rs ON s.ASIN = rs.ASIN AND s.Date = rs.Date
LEFT JOIN review_summary rv ON s.ASIN = rv.ASIN;
