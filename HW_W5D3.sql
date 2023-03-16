--1. List all customers who live in Texas (use JOINs)
SELECT first_name, last_name, district
FROM customer 
JOIN address
ON customer.address_id  = address.address_id
WHERE district = 'Texas';

--Ans first_name|last_name|district|
------------+---------+--------+
--Jennifer  |Davis    |Texas   |
--Kim       |Cruz     |Texas   |
--Richard   |Mccrary  |Texas   |
--Bryan     |Hardison |Texas   |
--Ian       |Still    |Texas   |


--2. List all payments of more than $7.00 with the customer’s first and last name

SELECT first_name, last_name, amount
FROM customer 
JOIN payment
ON customer.customer_id  = payment.customer_id
WHERE amount > 7;

--Ans
--first_name|last_name  |amount|
------------+-----------+------+
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Peter     |Menard     |  7.99|
--Douglas   |Graf       |  8.99|
--Ryan      |Salisbury  |  8.99|
--Ryan      |Salisbury  |  8.99|
--Ryan      |Salisbury  |  7.99|
--Roger     |Quintanilla|  8.99|
--Joe       |Gilliland  |  8.99|
--Jonathan  |Scarborough|  7.99|
--Harry     |Arce       |  9.99|
--...1406 total rows


--3. Show all customer names who have made over $175 in payments (use subqueries)
SELECT first_name, last_name, SUM(amount)
FROM customer 
JOIN payment
ON customer.customer_id  = payment.customer_id
GROUP BY first_name, last_name
HAVING SUM(amount)>175;

--first_name|last_name|sum   |
------------+---------+------+
--Tommy     |Collazo  |183.63|
--Clara     |Shaw     |189.60|
--Karl      |Seal     |208.58|
--Eleanor   |Hunt     |211.55|
--Marion    |Snyder   |194.61|
--Rhonda    |Kennedy  |191.62|

--4. List all customers that live in Argentina (use the city table)

SELECT first_name, last_name, country
FROM customer 
JOIN address
ON customer.address_id  = address.address_id
JOIN city c
ON address.city_id  = c.city_id 
JOIN country c2
ON c.country_id = c2.country_id 
WHERE country = 'Argentina';
--Ans
--first_name|last_name|country  |
------------+---------+---------+
--Willie    |Markham  |Argentina|
--Jordan    |Archuleta|Argentina|
--Jason     |Morrissey|Argentina|
--Kimberly  |Lee      |Argentina|
--Micheal   |Forman   |Argentina|
--Darryl    |Ashcraft |Argentina|
--Julia     |Flores   |Argentina|
--Florence  |Woods    |Argentina|
--Perry     |Swafford |Argentina|
--Lydia     |Burke    |Argentina|
--Eric      |Robert   |Argentina|
--Leonard   |Schofield|Argentina|
--Willie    |Howell   |Argentina|

--5. Show all the film categories with their count in descending order
SELECT "name", COUNT(film_ID)
FROM category c
JOIN film_category fc
ON c.category_id =fc.category_id 
GROUP BY "name"
ORDER BY COUNT(film_ID)DESC;
--Ans
--name       |count|
-------------+-----+
--Sports     |   74|
--Foreign    |   73|
--Family     |   69|
--Documentary|   68|
--Animation  |   66|
--Action     |   64|
--New        |   63|
--Drama      |   62|
--Sci-Fi     |   61|
--Games      |   61|
--Children   |   60|
--Comedy     |   58|
--Travel     |   57|
--Classics   |   57|
--Horror     |   56|
--Music      |   51|

--6. What film had the most actors in it (show film info)?
SELECT f.title, f.release_year, f.description, COUNT(actor_id)
FROM film_actor fa
JOIN film f 
ON fa.film_id = f.film_id 
GROUP BY f.title, f.release_year, f.description 
ORDER BY COUNT(actor_id) DESC
LIMIT 1;
--Ans
--title           |release_year|description                                                                      |count|
----------------+------------+---------------------------------------------------------------------------------+-----+
--Lambs Cincinatti|        2006|A Insightful Story of a Man And a Feminist who must Fight a Composer in Australia|   15|

--7. Which actor has been in the least movies?
SELECT a.first_name, a.last_name, COUNT(film_id)
FROM film_actor fa
JOIN actor a 
ON fa.actor_id = a.actor_id 
GROUP BY a.first_name, a.last_name 
ORDER BY COUNT(film_id) 
LIMIT 1;

--Ans
--first_name|last_name|count|
----------+---------+-----+
--Emily     |Dee      |   14|

--8. Which country has the most cities?

SELECT country, COUNT(city)
FROM city
JOIN country
ON city.country_id = country.country_id 
GROUP BY country
ORDER BY COUNT(city) DESC
LIMIT 1;
--Ans
--country|count|
-------+-----+
--India  |   60|

--9. List the actors who have been in between 20 and 25 films.
SELECT a.first_name, a.last_name, COUNT(film_id)
FROM film_actor fa
JOIN actor a 
ON fa.actor_id = a.actor_id 
GROUP BY a.first_name, a.last_name 
HAVING COUNT(film_id) BETWEEN 20 and 25
ORDER BY COUNT(film_id);
--Ans
--first_name |last_name  |count|
---------+-----------+-----+
--Bette      |Nicholson  |   20|
--Christopher|Berry      |   20|
--Rita       |Reynolds   |   20|
--Thora      |Temple     |   20|
--Chris      |Depp       |   20|
--Matthew    |Johansson  |   20|
--Kenneth    |Pesci      |   20|
--Fay        |Kilmer     |   20|
--Minnie     |Kilmer     |   20|
--Christopher|West       |   21|
--Spencer    |Peck       |   21|
--Kevin      |Bloom      |   21|
--Kenneth    |Paltrow    |   21|
--Nick       |Degeneres  |   22|
--Meryl      |Allen      |   22|
--Ed         |Chase      |   22|
--Dan        |Torn       |   22|
--Sylvester  |Dern       |   22|
--Fay        |Wood       |   22|
--Adam       |Hopper     |   22|
--Gene       |Hopkins    |   22|
--Christian  |Gable      |   22|
--Jennifer   |Davis      |   22|
--Michelle   |Mcconaughey|   23|
--Ben        |Harris     |   23|
--Tim        |Hackman    |   23|
--Jessica    |Bailey     |   23|
--Lisa       |Monroe     |   23|
--Burt       |Temple     |   23|
--Frances    |Tomei      |   23|
--Gene       |Willis     |   23|
--Cary       |Mcconaughey|   24|
--Burt       |Posey      |   24|
--Cuba       |Birch      |   24|
--Milla      |Peck       |   24|
--Lucille    |Dee        |   24|
--Michael    |Bening     |   24|
--Spencer    |Depp       |   24|
--Debbie     |Akroyd     |   24|
--Cameron    |Streep     |   24|
--Charlize   |Dench      |   24|
--Julia      |Barrymore  |   24|
--Mena       |Hopper     |   24|
--Parker     |Goldberg   |   24|
--Dan        |Streep     |   24|
--Zero       |Cage       |   25|
--Christian  |Neeson     |   25|
--Bob        |Fawcett    |   25|
--Groucho    |Williams   |   25|
--Salma      |Nolte      |   25|
--Joe        |Swank      |   25|
--Russell    |Bacall     |   25|
--Liza       |Bergman    |   25|
--Jeff       |Silverstone|   25|
--Gary       |Phoenix    |   25|
--Cuba       |Allen      |   25|
--Tom        |Mckellen   |   25|
--Penelope   |Pinkett    |   25|
--Nick       |Wahlberg   |   25|
--Morgan     |Mcdormand  |   25|
--Oprah      |Kilmer     |   25|
--Jane       |Jackman    |   25|
--Audrey     |Olivier    |   25|
--Ellen      |Presley    |   25|




