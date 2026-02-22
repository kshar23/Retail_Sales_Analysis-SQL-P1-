create database Retail_Sales_Analysis;

create table Retail_Sales_tb (
			transactions_id	int primary key,
            sale_date date,
            sale_time time,
            customer_id	int,
            gender varchar (20),
            age	int,
            category varchar (50),
            quantiy	int,
            price_per_unit float,
            cogs float,
            total_sale float );
            
select * from retail_sales_tb
where 
transactions_id is null
or
sale_date is null
or
sale_time is null
or 
customer_id is null
or
gender is null
or 
age is null
or
category is null
or
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale;


-- retrive all column for sale made on 2022-11-05

select * from retail_sales_tb
where sale_date = 2022-11-05;

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales_tb
where category = 'clothing' and 
quantiy >=4 and
year(sale_date) = 2022 and
month(sale_date) = 11;
            
-- Write a SQL query to calculate the total sales (total_sale) for each category.:

select category, 
sum(total_sale) as net_sales from retail_sales_tb
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select ROUND (avg(age),2) as avg_age from retail_sales_tb
where category ='beauty';   

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from retail_sales_tb
where total_sale > 1000;    

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.: 

select gender, category, 
count(*) as transaction_id
from retail_sales_tb
group by gender, category
order by category;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT *
FROM (
    SELECT
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (
            PARTITION BY YEAR(sale_date)
            ORDER BY SUM(total_sale) DESC
        ) AS rnk
    FROM retail_sales_tb
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t1
WHERE rnk = 1;


-- **Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id, sum(total_sale) as total_sales
from retail_sales_tb
group by customer_id
order by total_sales desc
limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.:

select count(distinct(customer_id)) as unique_customers, category
from retail_sales_tb
group by category;

-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


select sale_time,
case
when hour(sale_time) <12 then 'morning'
when hour(sale_time) between 12 and 17 then 'afternoon'
else 'evening'
end as shift,
count(*) as no_of_orders
from retail_sales_tb
group by shift, sale_time
order by shift;	



	
            
           

