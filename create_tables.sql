CREATE TABLE product_catalog (
    ASIN VARCHAR(20) PRIMARY KEY,
    Category VARCHAR(100),
    Price FLOAT
);

CREATE TABLE sales_data (
    Date DATE,
    ASIN VARCHAR(20),
    Units_Sold INT,
    Revenue FLOAT,
    Price FLOAT,
    Ad_Spend FLOAT,
    Is_Promotion BIT
);

CREATE TABLE returns_data (
    Date DATE,
    ASIN VARCHAR(20),
    Return_Qty INT,
    Return_Reason VARCHAR(255)
);

CREATE TABLE reviews_data (
    Date DATE,
    ASIN VARCHAR(20),
    Star_Rating INT,
    Review_Text NVARCHAR(MAX)
);
