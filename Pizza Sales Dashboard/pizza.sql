
select * from pizza_sales

--total revenue
select sum(total_price) as [total revenue] from pizza_sales

--average order value
select (sum(total_price) / count(distinct order_id)) as average from pizza_sales

--total pizza sold
select sum(quantity) as [total sold] from pizza_sales

--tottal orders
select count(distinct order_id) as [total orders] from pizza_sales

--average pizza per order
select cast(cast(sum(quantity) as decimal(10, 2))  /
cast(count(distinct order_id) as decimal(10, 2)) as decimal(10, 2))
as average from pizza_sales

--Daily Trend for Total Orders
select DATENAME(dw, order_date) as order_day, count(distinct order_id) as total_order from pizza_sales group by DATENAME(dw, order_date)

select DATENAME(month, order_date) as order_day, count(distinct order_id) as total_order from pizza_sales group by DATENAME(month, order_date) order by order_day

-- total pizza sold
select count(quantity) from pizza_sales where order_id in (select distinct order_id from pizza_sales)

--total sales by category
select pizza_category, sum(total_price), cast(sum(total_price) * 100 / (select cast(sum(total_price) as decimal(10, 2))
from pizza_sales) as decimal(10, 2)) as pct from pizza_sales  group by pizza_category order by pct desc
--where Month(order_date) = 1

--total sales by sizes
select pizza_size, sum(total_price), cast(sum(total_price) * 100 / (select cast(sum(total_price) as decimal(10, 2))
from pizza_sales) as decimal(10, 2)) as pct from pizza_sales  group by pizza_size order by pct


--top 5 pizza sales
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue 

--bottom 5 pizza sales
SELECT Top 5 pizza_name, SUM(total_price) AS Total_Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Revenue desc
--for best elling not in revenue then use quantity in place of price


--for hours sale is max
SELECT COUNT(DISTINCT order_id), DATEPART(hour, order_time) AS timetable
FROM pizza_sales
GROUP BY DATEPART(hour, order_time);

SELECT @@SERVERNAME AS ServerName;


select count(order_id) from pizza_sales
select count(distinct order_id) from pizza_sales
