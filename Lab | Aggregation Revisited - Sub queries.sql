use sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie

select first_name, last_name, email, count(rental_id) as rentals from rental
join  customer as c
using (customer_id)
group by customer_id;

-- What is the average payment made by each customer 
-- (display the customer id, customer name (concatenated), and the average payment made)
select r.customer_id, concat(first_name, ' ', last_name) as name, email, round(avg(amount),2) as avgpayment from rental as r
join  customer as c
using (customer_id)
join payment
using(customer_id)
group by customer_id;

-- ===============================================================================

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using multiple join statements
select distinct customer_id, concat(first_name, ' ', last_name) as name, email from customer as c
join rental as r
using (customer_id)
join inventory as i
using (inventory_id)
join film as f
using (film_id)
join film_category as fc
using (film_id)
join category as cy
using (category_id)
where cy.name = 'Action'
;
-- Write the query using sub queries with multiple WHERE clause and IN condition
select distinct customer_id, concat(first_name, ' ', last_name) as name, email from customer 
where customer_id in (

	select customer_id from rental
	where inventory_id in (
    
		select inventory_id from inventory
		where film_id in (
        
			select film_id from film_category
			where category_id in (
            
				select category_id from category 
				where name = 'action'))));


-- Verify if the above two queries produce the same results or not
'Yes, same same but different.';

-- ===============================================================================

-- Use the case statement to create a new column classifying existing columns
-- as either or high value transactions based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
-- the label should be medium, and if it is more than 4, then it should be high.

select payment_id, amount,
	case when amount <=2 then 'low'
		when amount between 2 and 4 then 'medium'
        when amount > 4 then 'high'
        end as classification		
from payment;