WITH produk AS 
(
  SELECT pc.CategoryName, p.ProdName, p.ProdNumber, p.Price FROM `Rakamin.Products` p
  left join `Rakamin.ProductCategory` pc
  on p.Category = pc.CategoryID
),
transaksi as 
(
  SELECT o.Date, produk.CategoryName, produk.ProdName, produk.Price, o.Quantity, o.CustomerID from `Rakamin.Orders` o
  inner join produk
  on o.ProdNumber = produk.ProdNumber
)

SELECT 
  transaksi.Date order_date, 
  transaksi.CategoryName category_name, 
  transaksi.ProdName product_name, 
  transaksi.Price product_price, 
  transaksi.Quantity order_qty, 
  (transaksi.Price * transaksi.Quantity) total_sales, 
  c.CustomerEmail cust_email, 
  c.CustomerCity cust_city 
FROM `Rakamin.Customers` c
inner join transaksi
on c.CustomerID = transaksi.CustomerID
order by transaksi.Date
