-- 1.) Lets look at total sales (Jan - Oct)
SELECT SUM(Total_price) AS Sales
FROM e_commerce.sales;


-- 2.) Lets look at what are sales month wise (Jan - Oct)
SELECT MONTH(orders.order_date) AS Month, SUM(sales.total_price) AS Sales
FROM e_commerce.orders
JOIN e_commerce.sales
ON e_commerce.orders.order_id = e_commerce.sales.order_id
GROUP BY MONTH(order_date)
ORDER BY MONTH(orders.order_date);


--  3.) Which products were most preffered by customers?
SELECT products.product_name AS Product, SUM(sales.quantity) AS Total_quantity, products.price
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_ID = e_commerce.sales.product_Id
GROUP BY Product
ORDER BY Total_quantity DESC
LIMIT 10;


-- 4.)  WHICH PRODUCT HAD THE MOST SALES?
SELECT products.product_name, SUM(sales.total_price)
FROM e_commerce.sales
JOIN e_commerce.products 
ON e_commerce.sales.product_ID = e_commerce.products.product_ID
GROUP BY product_name
ORDER BY SUM(total_price) DESC;


-- 5.) Type of products sold
SELECT DISTINCT(product_type)
FROM e_commerce.products;


-- 6.) Which type of product is most popular?
SELECT products.product_type, SUM(sales.quantity) AS Total_Quantity
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_id = e_commerce.sales.product_id
GROUP BY products.product_type
ORDER BY Total_Quantity DESC;


-- 7.) Sales by product type
SELECT products.product_type, SUM(total_price) AS Sales
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_ID = e_commerce.sales.product_id
GROUP BY product_type
ORDER BY Sales DESC;


-- 8.) What is Avg delivery time provided?
SELECT ROUND(AVG(DATEDIFF(DD, OD)),1) AS Delivery_time
FROM
  (SELECT date_format(Order_date,"%Y-%m-%d") AS OD, date_format(Delivery_date, "%Y-%m-%d") AS DD
   FROM e_commerce.orders) AS D
ORDER BY OD;


-- 9.) Which state gets fast delivery?
SELECT customers.state, ROUND(AVG(DATEDIFF(DD, OD)),1) AS Delivery_time
FROM
  (SELECT date_format(Order_date,"%Y-%m-%d") AS OD, date_format(Delivery_date, "%Y-%m-%d") AS DD, customer_id
   FROM e_commerce.orders) AS D
JOIN e_commerce.customers
ON   D.customer_id = e_commerce.customers.customer_id
GROUP BY customers.state
ORDER BY Delivery_time;


-- 10.) Are there any repeated customers & how many distinct customers we had in last year?
SELECT COUNT(DISTINCT(Customer_id)) AS Distinct_customers
FROM e_commerce.orders;

SELECT COUNT(*) AS num_of_repeated_customers
FROM
   (SELECT customer_id, COUNT(customer_id )
    FROM e_commerce.orders
    GROUP BY customer_id
    HAVING COUNT(customer_id ) > '1') AS C;
    

-- 11.) How much stock is remaining of each product?
SELECT products.product_name, (products.quantity - sales.quantity)/products.quantity*100 AS Remaining_stock_percentage
FROM e_commerce.products
JOIN e_commerce.sales
ON   e_commerce.products.product_id = e_commerce.sales.product_id
GROUP BY products.product_name
ORDER BY Remaining_stock_percentage;


-- 12.)  Lets look at sales state wise
SELECT customers.state, SUM(sales.total_price) AS Total_sales
FROM e_commerce.orders
JOIN e_commerce.customers
ON   e_commerce.orders.customer_id = e_commerce.customers.customer_id
JOIN e_commerce.sales
ON   e_commerce.orders.order_id = e_commerce.sales.order_id
GROUP BY customers.state 
ORDER BY Total_sales DESC;


-- 13.) How have sales changed month by month?
SELECT MONTH(orders.order_date) AS Months, SUM(sales.total_price) AS Sales
FROM e_commerce.orders
JOIN e_commerce.sales
ON   e_commerce.orders.order_id = e_commerce.sales.order_id
GROUP BY Months
ORDER BY Months;


-- 14.) What is avg age of customers?
SELECT ROUND(AVG(age),1) AS Avg_age
FROM e_commerce.customers;


-- 15.) Avg quantity per order?
SELECT ROUND(SUM(Quantity)/COUNT(DISTINCT(order_id)),2) AS Avg_quantity_per_order
FROM e_commerce.sales;


-- 16.) Avg order value?
SELECT ROUND(SUM(sales.total_price)/COUNT(DISTINCT(order_id)),2) AS Avg_order_value
FROM e_commerce.sales;


-- 17.) What are avg sales per month?
SELECT ROUND(SUM(sales.total_price)/COUNT(DISTINCT(MONTH(orders.order_date))),0) AS Avg_sales_per_month
FROM e_commerce.orders
JOIN e_commerce.sales
ON e_commerce.orders.order_id = e_commerce.sales.order_id;


-- 18.) What are avg no. of orders per month?
SELECT ROUND(COUNT(DISTINCT(order_id))/COUNT(DISTINCT(MONTH(order_date))),0) AS Avg_orders_per_month
FROM e_commerce.orders;


-- 19.) What are sales by product size?
SELECT products.size, SUM(sales.quantity) AS Sales
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_id = e_commerce.sales.product_id
GROUP BY products.size
ORDER BY Sales DESC;


--  20.) Where are majority of orders coming from?
SELECT DISTINCT(COUNT(orders.order_id)) AS no_of_orders, customers.city, customers.state
FROM e_commerce.orders
JOIN e_commerce.customers
ON e_commerce.orders.customer_id = e_commerce.customers.customer_id
GROUP BY customers.city
ORDER BY no_of_orders DESC;


-- 21.) Sales of products by color
SELECT products.colour, COUNT(sales.quantity) AS Quantity_sold
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_id = e_commerce.sales.product_id
GROUP BY products.colour
ORDER BY Quantity_sold DESC;


-- 22.) Lets look at top 10 least sold products
SELECT products.product_name, SUM(sales.quantity) AS Quantity, products.price
FROM e_commerce.products
JOIN e_commerce.sales
ON e_commerce.products.product_id = e_commerce.sales.product_id
GROUP BY products.product_name
ORDER BY Quantity
LIMIT 10;










