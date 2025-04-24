USE  walmart_db;
SELECT * FROM walmart;


SELECT count(*) FROM walmart;
   

## total no. of different stores

select
      count(distinct branch)
from   walmart;
                         -- BUSSINESS PROBLEM
 -- Q1  find different payment methods and no. of transactions , no. of qty sold
 
select
      payment_method,
      COUNT(*) as no_payments,
      SUM(quantity) as no_qty_sold
from  walmart
group by payment_method;

-- Q2  identify the highest-rated category in each branch , displaying the branch, category
-- AVG RATING
select 
      branch,
      category,
      avg(rating) as avg_rating,
	  RANK() over(partition by branch order by avg(rating) desc) as ranking
from walmart
group by 1,2
order by 1,3 DESC;


-- Q3 identify the busiest day for each branch based on the number o ftransactions
select branch, 
       date,
	   count(invoice_id) 
from walmart
group by date, branch;


-- Q4 calculate the total quantity of items sold per payment method. list payment_method and total_quantity
select 
     payment_method,
	sum(quantity) as total_quantity_sold,
     count(*) as no_transactions
from walmart
group by payment_method
;

-- Q5  Determine the average , min , max rating of products for each city. list the city, avg_rating ,min_rating and max_rating

select 
      city,
      category,
	  avg(rating) as avg_rating,
      min(rating) as min_rating,
      max(rating) as max_rating
from walmart
group by city, category;
     
-- Q6. Calculate the total profit for each category by considering total_profit as 
-- (unit_price* quantity*profit_margin). list category and total_profit ordered from highest to least profit

select
      category,
      sum(total) as total_revenue,
      sum(total*profit_margin) as profit
 from walmart
  group by  category;
  

-- Q7.  find the most common payment method for each branch. display branch and the prefered payment_method
select
      branch,
      payment_method,
      count( *) as total_trans,
      rank() over(partition by branch order by count(*) desc ) as ranking
from walmart
group by branch, payment_method;


-- Q8 categorize sales into 3 groups morning, afternoon, evening 
  -- find out each of the shift and number of invoices
 
SELECT 
    branch,
    COUNT(*) AS total_entries,
    CASE
        WHEN EXTRACT(HOUR FROM STR_TO_DATE(time, '%H:%i:%s')) < 12 THEN 'morning'
        WHEN EXTRACT(HOUR FROM STR_TO_DATE(time, '%H:%i:%s')) BETWEEN 12 AND 17 THEN 'afternoon'
        ELSE 'evening'
    END AS day_time
FROM walmart
GROUP BY branch, day_time;







     
      