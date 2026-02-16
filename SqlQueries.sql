create database superstore_db;
use superstore_db;

-- view entire data
select * from updated_superstores;

-- select specific columns
select order_id,customer_name,sales,profit from updated_superstores;

-- sales greater than 5000
select customer_name,sales from updated_superstores 
where sales>5000;

-- Orders from New York City
select customer_name,city,sales from updated_superstores
where city='New York City';

-- Highest sales first
select customer_name,sales from updated_superstores
order by sales desc;

-- Total sales by region
select region,sum(sales) as Total_sales from updated_superstores
group by region 
order by Total_sales desc;

-- Total profit by category
select category,sum(profit) as Total_profit from updated_superstores
group by category;

-- Regions with sales greater than 100000
select region,sum(sales) as total_sales from updated_superstores
group by region
having total_sales>100000;

-- Average revenue per customer
select sum(sales)/count(distinct customer_id) as avg_revenue from updated_superstores;

-- customers with above average sales
SELECT customer_name, SUM(sales) AS total_sales
FROM updated_superstores
GROUP BY customer_name
HAVING SUM(sales) >
    (SELECT AVG(total_sales)
     FROM (
         SELECT SUM(sales) AS total_sales
         FROM updated_superstores
         GROUP BY customer_name
     ) AS temp);

-- create view
create view sales_summary as 
select region,category,sum(sales) as total_sales,sum(profit) as total_profit from updated_superstores
group by category,region;

select * from sales_summary;

-- handle null values
SELECT customer_name,COALESCE(discount, 0) AS discount_value
FROM updated_superstores;

-- Monthly sales
SELECT MONTH(order_date) AS order_month,SUM(sales) AS monthly_sales
FROM updated_superstores
GROUP BY MONTH(order_date)
ORDER BY order_month;

-- Top 5 products by profit
SELECT product_name,SUM(profit) AS total_profit
FROM updated_superstores
GROUP BY product_name
ORDER BY total_profit DESC
LIMIT 5;