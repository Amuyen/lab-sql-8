
-- Write a query to display for each store its store ID, city, and country.

select s.Store_ID, c.City, co.Country from store s
join address a
on s.address_id=a.address_id
join city c
on a.city_id=c.city_id
join country co
on c.country_id=co.country_id;

-- Write a query to display how much business, in dollars, each store brought in.

select concat(c.City,' store') as Store, concat('$',sum(p.amount)) as Revenue from city c
join address a
on c.city_id=a.city_id
join store s
on a.address_id=s.address_id
join staff st
on s.store_id=st.store_id
join payment p
on st.staff_id=p.staff_id
group by s.store_id;

-- which film categories are longest?

select ct.name as Category, concat(avg(f.length) div 60,' hours ',round(avg(f.length),0)%60,' minutes') as Average_Length from film f
join film_category fc
on f.film_id=fc.film_id
join category ct
on fc.category_id=ct.category_id
group by ct.category_id
order by Average_Length desc;


-- Display the most frequently rented movies in descending order.
select f.Title, count(*) as Rentals from film f
join inventory i
on f.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
group by Title
order by Rentals desc;

-- List the top five genres in gross revenue in descending order.

select ct.name as Category_TOP5, concat('$',sum(p.amount)) as Revenue from category ct
join film_category fc
on ct.category_id=fc.category_id
join inventory i
on fc.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
join payment p
on r.rental_id=p.rental_id
group by Category_TOP5
order by Revenue desc
limit 5;

-- Is "Academy Dinosaur" available for rent from Store 1? YES, only inventory id 6 is is out.
select t.inventory_id, t.Title, t.Last_rented, re.return_date from (
select r.inventory_id,f.Title, max(r.rental_date) as last_rented from film f
join inventory i
on f.film_id=i.film_id
join rental r
on i.inventory_id=r.inventory_id
where Title = 'Academy Dinosaur'
group by r.inventory_id
order by last_rented  desc) as t
join rental re
on t.inventory_id=re.inventory_id and t.last_rented=re.rental_date;

select concat(a1.first_name,' ',a1.last_name) as Actor1, concat(a2.first_name,' ',a2.last_name) as Actor2, count(distinct fa.film_id) as 'Movies Collaborated' from actor a1
join film_actor fa
on a1.actor_id=fa.actor_id
join film_actor fa2
on fa.actor_id!=fa2.actor_id and fa.film_id=fa2.film_id
join actor a2
on fa2.actor_id=a2.actor_id
group by Actor1, Actor2;

select count(*) from actor;

/*Get all pairs of actors that worked together.

select a1.c
Bonus:
These questions are tricky, you can wait until after Monday's lesson to use new techniques to answer them!

Get all pairs of customers that have rented the same film more than 3 times.
For each film, list actor that has acted in more films.


