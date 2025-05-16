use project;
SELECT * FROM martsales;

--  How many unique cities does the data have?
select count(distinct(city)) from martsales;

--	In which city is each branch?
select distinct(branch),city from martsales;

-- 	How many unique product lines does the data have?
select distinct(product_line) from martsales;

-- 	What is the most common payment method?
select max(payment) from martsales;

-- 	What is the most selling product line?
select max(product_line) from martsales;

-- 	What is the total revenue by month?
select monthname(date) as month_name,
round(sum(total),2) as total_revenue
from martsales group by monthname(date);

--  What month had the largest COGS?
select monthname(date) as month_name,
sum(cogs) as cogs
from martsales
group by month_name
order by cogs desc
limit 1;

-- 	What product line had the largest revenue?
select product_line,sum(total) as revenue
from martsales 
group by Product_line 
order by revenue desc
limit 1;

-- 	What is the city with the largest revenue?
select city,sum(total)as revenue
from martsales
group by city
order by revenue desc
limit 1;

-- 	What product line had the largest gross income?
select product_line,round(sum(gross_income),2)as total_gross_income
from martsales
group by product_line
order by total_gross_income desc;

-- 	Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales select product_line,case
SELECT product_line,
  SUM(quantity) AS total_quantity,
  CASE 
  WHEN SUM(quantity) < (SELECT AVG(quantity) FROM martsales)
  THEN 'Good'
  ELSE 'Bad'
  END AS status
FROM martsales
GROUP BY product_line;

-- 	Which branch sold more products than average product sold?
select branch,sum(quantity) 
from martsales 
group by branch
having sum(quantity)> avg(Quantity);

-- 	What is the most common product line by gender?
select gender,product_line,count(gender)
from martsales
group by gender,product_line
order by count(gender) desc;

-- 	What is the average rating of each product line?
select product_line,round(avg(rating),2) as avg_rating
from martsales
group by product_line
order by avg_rating desc;

-- 	Number of sales made in each time of the day per weekday
alter table martsales 
add column time_of_day varchar(50);

update martsales 
set time_of_day = (
 case 
  when time between '00:00:00' and '12:00:00' then 'morning'
  when time between '12:01:00' and '16:00:00' then 'afternoon'
  else 'evening'
 end
);
set sql_safe_updates=0;
select dayname(date),count(quantity),time_of_day
from martsales
group by dayname(date),time_of_day
order by dayname(date),count(quantity) desc;

-- 	Which of the customer types brings the most revenue?
select customer_type,round(sum(total),2)
from martsales
group by Customer_type
order by sum(total) desc;

-- Which city has the average tax percent?
select city,round(avg(tax_percentage),2) as avg_tax_pct
from martsales
group by city
order by avg_tax_pct;

-- 	Which customer type pays the most in VAT?
select customer_type,round(sum(tax_percentage),2)
from martsales
group by Customer_type;

--  How many unique customer types does the data have?
select count(distinct(customer_type)) from martsales;

--  How many unique payment methods does the data have?
select count(distinct(payment)) from martsales;

-- 	What is the most common customer type?
select max(customer_type) from martsales;

-- 	Which customer type buys the most?
select customer_type
from martsales
group by customer_type
having count(quantity) 
order by count(quantity) desc
limit 1;

-- 	What is the gender of most of the customers?
select gender,count(quantity)
from martsales
group by gender;

-- 	What is the gender distribution per branch?
select branch,gender,count(gender)
from martsales
group by branch,gender
order by branch;

-- 	Which time of the day do customers give most ratings?
select time_of_day,count(rating)
from martsales
group by time_of_day
order by count(rating) desc;

--  Which time of the day do customers give most ratings per branch?
select branch,time_of_day,count(rating)
from martsales
group by branch,time_of_day
order by count(rating) desc;

-- 	Which day of the week has the best avg ratings?
select dayname(date),round(avg(rating),2) as rating
from martsales
group by dayname(date)
order by rating desc;

-- 	Which day of the week has the best average ratings per branch?
select branch,dayname(date),round(avg(rating),2)as avg_rating
from martsales
group by branch,dayname(date)
having avg(rating)
order by avg(rating) desc;


