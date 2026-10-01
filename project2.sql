USE sakila;


#Q2

DESCRIBE customer;
DESCRIBE inventory;
DESCRIBE payment;
DESCRIBE rental;
DESCRIBE staff;


#Q3


-- Sakila Database Schema Modification
-- Version 1.1


--
-- Dropping table 'store'
-- First modify its child tables:
--   Table 'inventory'
--   Table 'staff'
--   Table 'customer'
-- Modify table 'store' before dropping it
--

ALTER TABLE INVENTORY DROP FOREIGN KEY fk_inventory_store;
ALTER TABLE STAFF DROP FOREIGN KEY fk_staff_store;
ALTER TABLE CUSTOMER DROP FOREIGN KEY fk_customer_store;

ALTER TABLE STORE DROP FOREIGN KEY fk_store_staff;

DROP TABLE STORE;


--
-- Dropping table 'staff'
-- First modify its child tables:
--   Table 'payment'
--   Table 'rental'
--   Table 'store' (done above, before dropping it)
--

ALTER TABLE PAYMENT DROP FOREIGN KEY fk_payment_staff;
ALTER TABLE RENTAL DROP FOREIGN KEY fk_rental_staff;
--  ALTER TABLE STORE DROP FOREIGN KEY fk_store_staff;

DROP TABLE STAFF;


--
-- Dropping table 'inventory'
-- First modify its child table:
--   Table 'rental'
--

ALTER TABLE rental DROP FOREIGN KEY fk_rental_inventory;
DROP TABLE inventory;

--
-- Dropping table 'rental'
-- First modify its child table:
--   Table 'payment'
--

ALTER TABLE PAYMENT DROP FOREIGN KEY fk_payment_rental;
DROP TABLE RENTAL;

#Q5

#INNER JOINS
#finding cities corresponding countries, showing only US cities
SELECT city.city_id, city.city, city.country_id, country.country FROM CITY
    INNER JOIN country ON city.country_id = country.country_id
        WHERE country.country = 'United States' ORDER BY city.city LIMIT 8;

#finding addresses corresponding cities, showing results based on city_id
SELECT address.address_id, address.address, address.district, address.city_id, city.city FROM address
    INNER JOIN city ON city.city_id = address.city_id
        WHERE address.city_id > 99 ORDER BY city_id LIMIT 8;

#finding films corresponding language, showing films with a language that starts with 'E'
SELECT film.title, film.film_id, film.language_id, language.name FROM film
    INNER JOIN language ON language.language_id = film.language_id
        WHERE language.name LIKE 'E%' ORDER BY film_id LIMIT 8;

#OUTER JOINS

#finding cities corresponding countries, showing only Indian cities
SELECT city.city_id, city.city, city.country_id, country.country FROM CITY
    LEFT OUTER JOIN country ON city.country_id = country.country_id
        WHERE country.country = 'India' ORDER BY city.city LIMIT 8;

#finding addresses corresponding cities, showing results based on city_id
SELECT address.address_id, address.address, address.district, address.city_id, city.city FROM address
    LEFT OUTER JOIN city ON city.city_id = address.city_id
        WHERE address.city_id > 299 ORDER BY city_id LIMIT 8;

#finding films corresponding language, showing films with a title that starts with 'T'
SELECT film.title, film.film_id, film.language_id, language.name FROM film
    LEFT OUTER JOIN language ON language.language_id = film.language_id
        WHERE film.title LIKE 'T%' ORDER BY film_id LIMIT 8;

#SELF JOINS

#finding cities that share a country
SELECT cityA.city_id, cityA.city AS CityA, cityB.city_id, cityB.city AS CityB, country.country FROM city cityA
    LEFT OUTER JOIN city cityB ON cityA.country_id = cityB.country_id AND cityA.city_id < cityB.city_id
    LEFT OUTER JOIN country ON cityA.country_id = country.country_id
        WHERE cityB.city IS NOT NULL ORDER BY country.country LIMIT 8;

#Finding addresses that share a city
SELECT addressA.address_id, addressA.address AS AddressA, addressB.address_id, addressB.address AS AddressB, addressA.city_id, city.city FROM address addressA
    LEFT OUTER JOIN address addressB ON addressA.city_id = addressB.city_id AND addressA.address_id < addressB.address_id
    LEFT OUTER JOIN city ON addressA.city_id = city.city_id
        WHERE addressB.address IS NOT NULL ORDER BY city.city LIMIT 8;
