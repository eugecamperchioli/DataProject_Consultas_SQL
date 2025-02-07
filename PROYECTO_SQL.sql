-- Muestra los nombres de todas las películas con una clasificación por edades de ‘R'.
select title as "nombre_pelicula" , rating 
from film f 
where rating = 'R';

--  Encuentra los nombres de los actores que tengan un “actor_id entre 30 y 40.
select concat(first_name, ' ', last_name) as nombre_actores , actor_id 
from actor a 
where actor_id between 30 and 40;

-- Obtén las películas cuyo idioma coincide con el idioma original.
select title as nombre_peliculas
from film f 
where language_id = original_language_id ;

-- Ordena las películas por duración de forma ascendente.
select title as nombre_peliculas , rental_duration 
from film f 
order by rental_duration asc ;

-- Encuentra el nombre y apellido de los actores que tengan ‘Allen en su apellido
select first_name as nombre , last_name as apellido 
from actor a 
where last_name like 'ALLEN';

--  Encuentra la cantidad total de películas en cada clasificación de la tabla “film y muestra la clasificación junto con el recuento.
select rating as clasificacion , count(film_id) as recuento_peliculas  
from film f 
group by rating ;

--  Encuentra el título de todas las películas que son ‘PG13 o tienen una duración mayor a 3 horas en la tabla film.
select title as titulo_peliculas , length as duracion , rating as clasificacion 
from film f 
where rating = 'PG-13' or length > 180
order by length ;

-- Encuentra la variabilidad de lo que costaría reemplazar las películas.
select stddev(replacement_cost) as desviacion_estandar 
from film f ;

-- Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT min(length) as menor_duracion,
       max(length)  as mayor_duracion
FROM film ;

-- Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
select sum(amount), payment_date 
from payment p 
group by payment_date 
order by payment_date desc ;

-- Encuentra el título de las películas en la tabla “film que no sean ni ‘NC17 ni ‘G en cuanto a su clasificación.
select title , rating 
from film f
where rating not IN ('NC-17' ,'G'); 

-- Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
select avg(length) , rating
from film f 
group by rating ;

-- Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
select title , length 
from film f 
where length > 180;

-- ¿Cuánto dinero ha generado en total la empresa?
select sum(amount)
from payment p ;

-- Muestra los 10 clientes con mayor valor de id.
select customer_id , first_name 
from customer c 
order BY customer_id DESC
limit 10;

-- Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby.
select f.title , a.first_name , a.last_name 
from film as f 
join film_actor as fa ON f.film_id = fa.film_id 
join actor as a on a.actor_id = fa.actor_id 
where title like 'EGG IGBY'; 

--  Selecciona todos los nombres de las películas únicos.
select distinct title 
from film f ;

-- Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film.
select f.title as nombre_pelicula , f.length as duracion , c2.name as categoria_pelicula 
from film as f 
join film_category as fc on f.film_id = fc.film_id 
join category as c2 on c2.category_id = fc.category_id 
where c2."name" = 'Comedy' and f.length > 180;

-- Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
select avg(f.length) as promedio_duracion , c."name" as nombre_categoria  
from film as f 
join film_category as fc on f.film_id = fc.film_id 
join category as c on fc.category_id = c.category_id 
group by c."name" 
having avg(f.length) > 110
;  

-- ¿Cuál es la media de duración del alquiler de las películas?
select avg(rental_duration) as media_duracion 
from film f ;

-- Crea una columna con el nombre y apellidos de todos los actores y actrices.
select concat(first_name, ' ', last_name) as nombre_completo 
from actor a ;

-- Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
select to_char(rental_date, 'YYYY-MM-DD') as dia ,  COUNT(*) as numero_alquileres 
from rental r 
group by to_char(rental_date, 'YYYY-MM-DD')
order by numero_alquileres desc ;

-- Encuentra las películas con una duración superior al promedio.
select title , length 
from film f 
where length > (select avg(length) from film f) ;

--- control del promedio
select avg(length) 
from film f ;

-- Averigua el número de alquileres registrados por mes.
select to_char(rental_date, 'YYYY-MM') as mes ,  COUNT(*) as numero_alquileres 
from rental r 
group by to_char(rental_date, 'YYYY-MM') ;

-- Encuentra el promedio, la desviación estándar y varianza del total pagado.
select avg(amount) as promedio , stddev(amount) as desviacion_estandar , variance(amount) as varianza 
from payment p ;

-- ¿Qué películas se alquilan por encima del precio medio?
select f.title , p.amount 
from payment as p 
join rental r on p.rental_id = r.rental_id 
join inventory as i on r.inventory_id = i.inventory_id
join film as f on f.film_id = i.film_id 
where p.amount > ( select avg(p.amount) from payment p )
order by p.amount ASC ;


-- Muestra el id de los actores que hayan participado en más de 40 películas.
select actor_id , count(fa.film_id)
from film_actor fa
group by actor_id 
having count(fa.film_id) > 40 ; 
 

-- Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
select F.title ,  count(I.inventory_id) as cantidad_disponible 
from film as f 
inner join inventory as i on I.film_id = F.film_id 
group by f.title ; 

-- Obtener los actores y el número de películas en las que ha actuado.
select concat(a.first_name, ' ', a.last_name) as nombre_actor , count(fa.film_id) as numero_peliculas 
from film_actor as fa
inner join actor as a on fa.actor_id = a.actor_id 
group by concat(a.first_name, ' ', a.last_name) 
order by numero_peliculas asc ; 

-- Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
select f.title as nombre_pelicula , concat(a.first_name, ' ', a.last_name) as actores 
from film as f
right join film_actor as fa on f.film_id = fa.film_id
right join actor as a on fa.actor_id = a.actor_id
order by f.title asc ; 

-- Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
select a.first_name as nombre , a.last_name as apellido, f.title as nombre_pelicula
from film as f
left join film_actor as fa on f.film_id = fa.film_id
left join actor as a on fa.actor_id = a.actor_id 
order by f.title ;

-- Obtener todas las películas que tenemos y todos los registros de alquiler.
select f.title as nombre_peliculas , r.rental_id as registros_alquiler
FROM film as f 
left join inventory as i on f.film_id = i.film_id 
left join rental as r on i.inventory_id = r.inventory_id
order by f.title ;

-- Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
select c.customer_id , c.first_name , c.last_name , sum(p.amount) as total_gastado
from customer as c 
inner join rental as r on c.customer_id = r.customer_id
inner join payment as p on r.rental_id = p.rental_id
group by c.customer_id 
order by sum(p.amount)
limit 5;

-- Selecciona todos los actores cuyo primer nombre es 'Johnny'.
select first_name , last_name 
from actor a
where first_name like 'JOHNNY';

-- Renombra la columna “first_name como Nombre y “last_name como Apellido.
select first_name as Nombre , last_name as Apellido 
from actor a ;

-- Encuentra el ID del actor más bajo y más alto en la tabla actor.
select min(actor_id) , max(actor_id)
from actor a ;

-- Cuenta cuántos actores hay en la tabla “actor.
select count(actor_id)
from actor a ;

-- Selecciona todos los actores y ordénalos por apellido en orden ascendente.
select first_name as nombre , last_name as apellido
from actor a 
order by last_name asc ;

-- Selecciona las primeras 5 películas de la tabla “film.
select title 
from film f 
order by title
limit 5 ;

-- Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
select first_name , count(*) as name_count
from actor a 
group by first_name
order by name_count desc ;

-- Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
select r.rental_id , c.first_name , c.last_name 
from rental as r 
inner join customer as c on r.customer_id = c.customer_id ;

-- Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
select c.customer_id, c.first_name, c.last_name, r.rental_id, r.rental_date
from customer c
left join rental r ON c.customer_id = r.customer_id
order by c.customer_id;

-- Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
select *
from film f 
cross join category c ;
-- no, no aporta valor porque empareja cada fila de la primera con la cada fila de la segunda tabla, sin ninguna condicion. 

-- Encuentra los actores que han participado en películas de la categoría 'Action'.
select a.first_name , a.last_name , c."name" 
from category as c 
join film_category as fc ON c.category_id = fc.category_id 
join film_actor as fa on fa.film_id = fc.film_id 
join actor as a on fa.actor_id = a.actor_id
where c."name" = 'Action';

-- Encuentra todos los actores que no han participado en películas.
select a.actor_id , a.first_name , a.last_name 
from actor as a 
left join film_actor as fa ON a.actor_id =fa.actor_id 
where fa.film_id IS NULL
order by a.actor_id ;

-- Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
select a.first_name , count(fa.film_id) as cantidad_peliculas
from actor as a
inner join film_actor as fa on a.actor_id = fa.actor_id
group by a.first_name ;

-- Crea una vista llamada “actor_num_peliculas que muestre los nombres de los actores y el número de películas en las que han participado.
create view actor_num_peliculas as 
select a.first_name, a.last_name, count(fa.film_id) as recuento_peliculas
from actor as a 
left join film_actor as fa on a.actor_id = fa.actor_id
group by a.actor_id;

SELECT * FROM actor_num_peliculas;

-- Calcula el número total de alquileres realizados por cada cliente.
select c.customer_id , count(r.rental_id) as total_alquileres
from rental as r 
left join customer as c on r.customer_id = c.customer_id 
group by c.customer_id ;

-- Calcula la duración total de las películas en la categoría 'Action'.
select sum(f.length)
from category as c
join film_category as fc on c.category_id = fc.category_id
join film as f on fc.film_id = f.film_id
where c."name" = 'Action';

-- Crea una tabla temporal llamada “cliente_rentas_temporal para almacenar el total de alquileres por cliente.
create temporary table clientes_rentas_temporal as 
select c.customer_id , c.first_name , count(r.rental_id) as total_alquileres
from customer as c
left join rental as r on c.customer_id = r.customer_id 
group by c.customer_id ; 

select * from clientes_rentas_temporal;

-- Crea una tabla temporal llamada “peliculas_alquiladas que almacene las películas que han sido alquiladas al menos 10 veces.
create temporary table peliculas_alquiladas as
select f.film_id, f.title , count(r.rental_id) as total_alquiler
from film as f 
join inventory as i on f.film_id = i.film_id
join rental as r on i.inventory_id = r.inventory_id  
group by f.film_id, f.title 
having count(r.rental_id) >= 10;

select * from peliculas_alquiladas;

-- Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders y que aún no se han devuelto. 
select f.title as nombre_peliculas , c.first_name , c.last_name 
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
join customer c on r.customer_id = c.customer_id 
where c.first_name = 'TAMMY' and C.last_name = 'SANDERS'and r.return_date is null ;

-- Ordena los resultados alfabéticamente por título de película.
select f.title as nombre_peliculas , c.first_name , c.last_name 
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
join customer c on r.customer_id = c.customer_id 
where c.first_name = 'TAMMY' and C.last_name = 'SANDERS'and r.return_date is null 
order by f.title asc ;

-- Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi. 
select a.first_name , a.last_name , c."name" as categoria 
from actor a  
join film_actor fa on a.actor_id = fa.actor_id 
join film_category fc on fa.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Sci-Fi' ;

--Ordena los resultados alfabéticamente por apellido.
select a.first_name , a.last_name , c."name" as categoria 
from actor a  
join film_actor fa on a.actor_id = fa.actor_id 
join film_category fc on fa.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Sci-Fi' 
order by a.last_name asc ;

-- Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper se alquilara por primera vez.
with spartacus_rental_date as (
select min(r.rental_date) as primer_alquiler 
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
where f.title = 'SPARTACUS CHEAPER'
)
select a.first_name as nombre , a.last_name as apellido
from actor as a 
join film_actor as fa on a.actor_id = fa.actor_id
join film as f on fa.film_id = f.film_id
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
where r.rental_date > (select primer_alquiler from spartacus_rental_date);

-- Ordena los resultados alfabéticamente por apellido.
with spartacus_rental_date as (
select min(r.rental_date) as primer_alquiler 
from film f 
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
where f.title = 'SPARTACUS CHEAPER'
)
select a.first_name as nombre , a.last_name as apellido
from actor as a 
join film_actor as fa on a.actor_id = fa.actor_id
join film as f on fa.film_id = f.film_id
join inventory i on f.film_id = i.film_id 
join rental r on i.inventory_id = r.inventory_id 
where r.rental_date > (select primer_alquiler from spartacus_rental_date)
order by a.last_name asc;

-- Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music.
select a.first_name , a.last_name 
from actor as a 
where a.actor_id not in (
select A.actor_id 
from actor as a2 
join film_actor as fa on a2.actor_id = fa.actor_id 
join film as f on fa.film_id = f.film_id 
join film_category as fc on fc.film_id = f.film_id
join category as c on fc.category_id = c.category_id
where c.name = 'Music'
);

-- Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
select f.title , extract(day from(return_date - rental_date)) as tiempo_alquiler
from rental as r 
join inventory as i on i.inventory_id = r.inventory_id 
join film as f on i.film_id = f.film_id 
where extract(day from(return_date - rental_date)) > 8;

-- Encuentra el título de todas las películas que son de la misma categoría que ‘Animation.
select f.title as titulo_peliculas , c.name as categoria_peliculas
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id 
where c."name" = 'Animation';

-- Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever. 
select f.title as nombre_pelicula , f.length as duracion_pelicula
from film as f
where f.length =
(select f.length from film f where f.title = 'DANCING FEVER');

-- Ordena los resultados alfabéticamente por título de película.
select f.title as nombre_pelicula , f.length as duracion_pelicula
from film as f
where f.length =
(select f.length from film f where f.title = 'DANCING FEVER')
order by F.title ASC;

-- Encuentra los nombres de los clientes que han alquilado al menos 7películas distintas. 
select c.customer_id , C.first_name , C.last_name 
from customer as c 
join rental as r on c.customer_id = r.customer_id 
join inventory as i on r.inventory_id = i.inventory_id 
group by c.customer_id 
having count(distinct i.film_id) >= 7; 

-- Ordena los resultados alfabéticamente por apellido.
select c.customer_id , C.first_name , C.last_name 
from customer as c 
join rental as r on c.customer_id = r.customer_id 
join inventory as i on r.inventory_id = i.inventory_id 
group by c.customer_id 
having count(distinct i.film_id) >= 7
order by c.last_name asc ;

-- Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
select count(r.rental_id) as total_alquiladas , c."name" as categoria
from rental r 
join inventory i on r.inventory_id = i.inventory_id 
join film_category as fc on i.film_id = fc.film_id  
join category c on fc.category_id = c.category_id 
group by c."name" ;

-- Encuentra el número de películas por categoría estrenadas en 2006.
select count(f.film_id) as numero_peliculas , c."name"  as categoria , f.release_year as ano_estreno 
from film f 
join film_category fc on f.film_id = fc.film_id 
join category c on fc.category_id = c.category_id
where f.release_year = 2006
group by c."name" , f.release_year ;

-- Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
select *
from staff s
cross join store s2 ;

-- Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
select c.customer_id , c.first_name as nombre , c.last_name as apellido , count(r.rental_id) as total_alquiler
from customer as c 
join rental r on c.customer_id = r.customer_id
group by c.first_name , c.last_name , c.customer_id ;



