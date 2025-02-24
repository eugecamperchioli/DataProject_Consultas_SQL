-- 2. Muestra los nombres de todas las películas con una clasificación por edades de ‘R'.
SELECT "title" AS "nombre_pelicula" , 
       "rating" AS "clasificacion" 
FROM "film" f 
WHERE "rating" = 'R';

--  3. Encuentra los nombres de los actores que tengan un “actor_id entre 30 y 40.
SELECT concat("first_name", ' ', "last_name") AS "nombre_actores" , "actor_id"
FROM "actor" a 
WHERE "actor_id" BETWEEN 30 AND 40;

-- 4. Obtén las películas cuyo idioma coincide con el idioma original.
SELECT "title" AS "nombre_peliculas"
FROM "film" f 
WHERE "language_id" = "original_language_id" ;

-- 5. Ordena las películas por duración de forma ascendente.
SELECT "title" AS "nombre_peliculas" , 
       "rental_duration" AS "duracion" 
FROM "film" f 
ORDER BY "rental_duration" ASC ;

-- 6. Encuentra el nombre y apellido de los actores que tengan ‘Allen en su apellido
SELECT "first_name" AS "nombre" , "last_name" as "apellido"
FROM "actor" a 
WHERE "last_name" LIKE 'ALLEN';

--  7. Encuentra la cantidad total de películas en cada clasificación de la tabla “film y muestra la clasificación junto con el recuento.
SELECT "rating" AS "clasificacion" , count("film_id") AS "recuento_peliculas"
FROM "film" f 
GROUP BY "rating" ;

--  8. Encuentra el título de todas las películas que son ‘PG13 o tienen una duración mayor a 3 horas en la tabla film.
SELECT "title" AS "titulo_peliculas" , "length" AS "duracion" , "rating" as "clasificacion"
FROM "film" f 
WHERE "rating" = 'PG-13' OR "length" > 180
ORDER BY "length" ;

-- 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.
SELECT ROUND(STDDEV("replacement_cost"),2) AS "desviacion_estandar"
FROM "film" f ;

-- 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.
SELECT min("length") AS "menor_duracion",
       max("length") AS "mayor_duracion"
FROM "film" ;

-- 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.
SELECT sum("amount") AS "costo_total",
       "payment_date" AS "fecha_pago"
FROM "payment" p 
GROUP BY "payment_date" 
ORDER BY "payment_date" DESC 
LIMIT 1 OFFSET 1;

-- 12. Encuentra el título de las películas en la tabla “film que no sean ni ‘NC17 ni ‘G en cuanto a su clasificación.
SELECT "title" AS "titulo_pelicula", 
       "rating" AS "clasificacion"
FROM "film" f
WHERE "rating" NOT IN ('NC-17' ,'G'); 

-- 13. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración.
SELECT ROUND(AVG("length"),2) AS "promedio_duracion", 
       "rating" AS "clasificacion"
FROM "film" f 
GROUP BY "rating" ;

-- 14. Encuentra el título de todas las películas que tengan una duración mayor a 180 minutos.
SELECT "title" , "length" 
FROM "film" f 
WHERE "length" > 180;

-- 15. ¿Cuánto dinero ha generado en total la empresa?
SELECT sum("amount") as "total_generado"
FROM "payment" p ;

-- 16. Muestra los 10 clientes con mayor valor de id.
SELECT "customer_id" , "first_name"
FROM "customer" c 
ORDER BY "customer_id" DESC
LIMIT 10;

-- 17. Encuentra el nombre y apellido de los actores que aparecen en la película con título ‘Egg Igby.
SELECT f."title" , a."first_name" , a."last_name"
FROM "film" AS f 
JOIN "film_actor" AS fa ON f."film_id" = fa."film_id"
JOIN "actor" AS a ON a."actor_id" = fa."actor_id" 
WHERE f."title" LIKE 'EGG IGBY'; 

--  18. Selecciona todos los nombres de las películas únicos.
SELECT DISTINCT "title"
FROM "film" f ;

-- 19. Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en la tabla “film.
SELECT f."title" AS "nombre_pelicula" , f."length" AS "duracion" , c2."name" AS "categoria_pelicula"
FROM "film" AS f 
JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
JOIN "category" AS c2 ON c2."category_id" = fc."category_id"
WHERE c2."name" = 'Comedy' AND f."length" > 180;

-- 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 110 minutos y muestra el nombre de la categoría junto con el promedio de duración.
SELECT ROUND(AVG(f."length"),2) AS "promedio_duracion" , c."name" AS "nombre_categoria"
FROM "film" AS f 
JOIN "film_category" AS fc ON f."film_id" = fc."film_id"
JOIN "category" AS c ON fc."category_id" = c."category_id"
GROUP BY c."name" 
HAVING avg(f."length") > 110;  

-- 21. ¿Cuál es la media de duración del alquiler de las películas?
SELECT ROUND(AVG("rental_duration"),2) AS "media_duracion"
FROM "film" f ;

-- 22. Crea una columna con el nombre y apellidos de todos los actores y actrices.
SELECT concat("first_name", ' ', "last_name") AS "nombre_completo"
FROM "actor" a ;

-- 23. Números de alquiler por día, ordenados por cantidad de alquiler de forma descendente.
SELECT to_char("rental_date", 'YYYY-MM-DD') AS "dia" , COUNT(*) AS "numero_alquileres"
FROM "rental" r 
GROUP BY to_char("rental_date", 'YYYY-MM-DD')
ORDER BY "numero_alquileres" DESC ;

-- 24. Encuentra las películas con una duración superior al promedio.
SELECT "title" , "length"
FROM "film" f 
WHERE "length" > (SELECT avg("length") FROM "film" f) ;

--control del promedio
SELECT avg("length") 
FROM "film" f ;

-- 25. Averigua el número de alquileres registrados por mes.
SELECT to_char("rental_date", 'YYYY-MM') AS "mes" ,  
       COUNT(*) AS "numero_alquileres"
FROM "rental" r 
GROUP BY to_char("rental_date", 'YYYY-MM') ;

-- 26. Encuentra el promedio, la desviación estándar y varianza del total pagado.
SELECT ROUND(AVG("amount"),2) AS "promedio" , 
       ROUND(STDDEV("amount"),2) AS "desviacion_estandar" , 
       ROUND(VARIANCE("amount"),2) AS "varianza"
FROM "payment" p ;

-- 27. ¿Qué películas se alquilan por encima del precio medio?
SELECT f."title" , p."amount"
FROM "payment" AS p 
JOIN "rental" r ON p."rental_id"= r."rental_id"
JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id"
JOIN "film" AS f ON f."film_id" = i."film_id"
WHERE p."amount" > ( SELECT avg(p."amount") FROM "payment" AS p )
ORDER BY p."amount" ASC ;


-- 28. Muestra el id de los actores que hayan participado en más de 40 películas.
SELECT "actor_id" , count(fa."film_id")
FROM "film_actor" fa
GROUP BY "actor_id "
HAVING count(fa."film_id") > 40 ; 
 

-- 29. Obtener todas las películas y, si están disponibles en el inventario, mostrar la cantidad disponible.
SELECT f."title" ,  
       count(i."inventory_id") AS "cantidad_disponible"
FROM "film" AS f 
INNER JOIN "inventory" AS i ON i."film_id" = f."film_id"
GROUP BY f."title" ; 

-- 30. Obtener los actores y el número de películas en las que ha actuado.
SELECT concat(a."first_name", ' ', a."last_name") AS "nombre_actor",
       count(fa."film_id") AS "numero_peliculas"
FROM "film_actor" AS fa
INNER JOIN "actor" AS a ON fa."actor_id" = a."actor_id"
GROUP BY concat(a."first_name", ' ', a."last_name") 
ORDER BY "numero_peliculas" ASC ; 

-- 31. Obtener todas las películas y mostrar los actores que han actuado en ellas, incluso si algunas películas no tienen actores asociados.
SELECT f."title" AS "nombre_pelicula" , 
       concat(a."first_name", ' ', a."last_name") AS "actores"
FROM "film" AS f
RIGHT JOIN "film_actor" AS fa ON f."film_id" = fa."film_id"
RIGHT JOIN "actor" AS a ON fa."actor_id" = a."actor_id"
ORDER BY f."title" ASC ; 

-- 32. Obtener todos los actores y mostrar las películas en las que han actuado, incluso si algunos actores no han actuado en ninguna película.
SELECT a."first_name" AS "nombre" , 
       a."last_name" AS "apellido", 
       f."title" AS "nombre_pelicula"
FROM "film" AS f
LEFT JOIN "film_actor" AS fa ON f."film_id" = fa."film_id"
LEFT JOIN "actor" AS a ON fa."actor_id" = a."actor_id" 
ORDER BY f."title" ;

-- 33. Obtener todas las películas que tenemos y todos los registros de alquiler.
SELECT f."title" AS "nombre_peliculas" , 
       r."rental_id" AS "registros_alquiler"
FROM "film" AS f 
LEFT JOIN "inventory" AS i ON f."film_id" = i."film_id"
LEFT JOIN "rental" AS r ON i."inventory_id" = r."inventory_id"
ORDER BY f."title" ;

-- 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.
SELECT c."customer_id" , 
       c."first_name" AS "nombre" ,
       c."last_name" AS "apellido",
       sum(p."amount") AS "total_gastado"
FROM "customer"AS c 
INNER JOIN "rental" AS r ON c."customer_id" = r."customer_id"
INNER JOIN "payment" AS p ON r."rental_id" = p."rental_id"
GROUP BY c."customer_id" 
ORDER BY sum(p."amount") DESC
LIMIT 5;

-- 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.
SELECT "first_name" , "last_name" 
FROM "actor" a
WHERE "first_name" like 'JOHNNY';

-- 36. Renombra la columna “first_name como Nombre y “last_name como Apellido.
SELECT "first_name" AS "Nombre" , 
       "last_name" AS "Apellido" 
FROM "actor" a ;

-- 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.
SELECT min("actor_id") , max("actor_id")
FROM "actor" a ;

-- 38. Cuenta cuántos actores hay en la tabla “actor.
SELECT count("actor_id")
FROM "actor" a ;

-- 39. Selecciona todos los actores y ordénalos por apellido en orden ascendente.
SELECT "first_name" AS "nombre" ,
       "last_name" AS "apellido"
FROM "actor" a 
ORDER BY "last_name" ASC ;

-- 40. Selecciona las primeras 5 películas de la tabla “film.
SELECT "title"
FROM "film" f 
ORDER BY "title"
LIMIT 5 ;

-- 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el mismo nombre. ¿Cuál es el nombre más repetido?
SELECT "first_name" AS "nombre", 
       count(*) AS "cuenta_nombre"
FROM "actor" a 
GROUP BY "first_name"
ORDER BY "cuenta_nombre" DESC ;
-- LOS NOMBRES MAS REPETIDOS SON KENNETH, PENELOPE Y JULIA CON 4 REPETICIONES CADA UNO.

-- 42. Encuentra todos los alquileres y los nombres de los clientes que los realizaron.
SELECT r."rental_id" , c."first_name" , c."last_name"
FROM "rental" AS r 
INNER JOIN "customer" AS c ON r."customer_id" = c."customer_id" ;

-- 43. Muestra todos los clientes y sus alquileres si existen, incluyendo aquellos que no tienen alquileres.
SELECT c."customer_id", c."first_name", c."last_name", r."rental_id", r."rental_date"
FROM "customer" c
LEFT JOIN "rental" r ON c."customer_id" = r."customer_id"
ORDER BY c."customer_id";

-- 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor esta consulta? ¿Por qué? Deja después de la consulta la contestación.
SELECT *
FROM "film" AS f 
CROSS JOIN "category" AS c ;
-- no, no aporta valor porque empareja cada fila de la primera con la cada fila de la segunda tabla, sin ninguna condicion. 

-- 45. Encuentra los actores que han participado en películas de la categoría 'Action'.
SELECT a."first_name" , a."last_name" , c."name" 
FROM "category" AS c 
JOIN "film_category" AS fc ON c."category_id" = fc."category_id"
JOIN "film_actor" AS fa ON fa."film_id" = fc."film_id"
JOIN "actor" AS a ON fa."actor_id" = a."actor_id"
WHERE c."name" = 'Action';

-- 46. Encuentra todos los actores que no han participado en películas.
SELECT a."actor_id" , a."first_name" , a."last_name" 
FROM "actor" AS a 
LEFT JOIN "film_actor" AS fa ON a."actor_id" =fa."actor_id" 
WHERE fa."film_id" IS NULL
ORDER BY a."actor_id" ;

-- 47. Selecciona el nombre de los actores y la cantidad de películas en las que han participado.
SELECT a."first_name" , count(fa."film_id") AS "cantidad_peliculas"
FROM "actor" AS a
INNER JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."first_name" ;

-- 48. Crea una vista llamada “actor_num_peliculas que muestre los nombres de los actores y el número de películas en las que han participado.
CREATE VIEW "actor_num_peliculas" AS
SELECT a."first_name", a."last_name", 
       count(fa."film_id") as "recuento_peliculas"
FROM actor AS a 
LEFT JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
GROUP BY a."actor_id";

SELECT * FROM "actor_num_peliculas";

-- 49. Calcula el número total de alquileres realizados por cada cliente.
SELECT c."customer_id" , count(r."rental_id") AS "total_alquileres"
FROM "rental" AS r 
LEFT JOIN "customer" AS c ON r."customer_id" = c."customer_id"
GROUP BY c."customer_id" ;

-- 50. Calcula la duración total de las películas en la categoría 'Action'.
SELECT sum(f."length")
FROM "category" AS c
JOIN "film_category" AS fc ON c."category_id" = fc."category_id"
JOIN "film" AS f ON fc."film_id" = f."film_id"
WHERE c."name" = 'Action';

-- 51. Crea una tabla temporal llamada “cliente_rentas_temporal para almacenar el total de alquileres por cliente.
CREATE TEMPORARY TABLE "clientes_rentas_temporal" AS
SELECT c."customer_id" , c."first_name" , count(r."rental_id") AS "total_alquileres"
FROM "customer" AS c
LEFT JOIN "rental" AS r ON c."customer_id" = r."customer_id" 
GROUP BY c."customer_id" ; 

SELECT * FROM "clientes_rentas_temporal";

-- 52. Crea una tabla temporal llamada “peliculas_alquiladas que almacene las películas que han sido alquiladas al menos 10 veces.
CREATE TEMPORARY TABLE "peliculas_alquiladas" AS
select f."film_id", f."title" , count(r."rental_id") AS "total_alquiler"
FROM "film" AS f 
JOIN "inventory" AS i ON f."film_id" = i."film_id"
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
GROUP BY f."film_id", f."title" 
HAVING count(r."rental_id") >= 10;

SELECT * FROM "peliculas_alquiladas";

-- 53. Encuentra el título de las películas que han sido alquiladas por el cliente con el nombre ‘Tammy Sanders y que aún no se han devuelto. 
SELECT f."title" AS "nombre_peliculas" , c."first_name" , c."last_name" 
FROM "film" AS f 
JOIN "inventory" AS i ON f."film_id" = i."film_id" 
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
JOIN "customer" AS c ON r."customer_id" = c."customer_id" 
WHERE c."first_name" = 'TAMMY' AND C."last_name" = 'SANDERS' AND r."return_date" IS NULL ;

-- Ordena los resultados alfabéticamente por título de película.
SELECT f."title" AS "nombre_peliculas" , c."first_name" , c."last_name" 
FROM "film" AS f 
JOIN "inventory" AS i ON f."film_id" = i."film_id" 
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
JOIN "customer" AS c ON r."customer_id" = c."customer_id"
WHERE c."first_name" = 'TAMMY' AND C."last_name" = 'SANDERS' AND r."return_date" IS NULL
ORDER BY f."title" ASC ;

-- 54. Encuentra los nombres de los actores que han actuado en al menos una película que pertenece a la categoría ‘Sci-Fi. 
SELECT a."first_name" , a."last_name" , c."name" AS "categoria"
FROM "actor" AS a  
JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id" 
JOIN "film_category" AS fc ON fa."film_id" = fc."film_id"
JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi' ;

-- Ordena los resultados alfabéticamente por apellido.
SELECT a."first_name" , a."last_name" , c."name" AS "categoria"
FROM "actor" AS a  
JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
JOIN "film_category" AS fc ON fa."film_id" = fc."film_id" 
JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Sci-Fi' 
ORDER BY a."last_name" ASC ;

-- 55. Encuentra el nombre y apellido de los actores que han actuado en películas que se alquilaron después de que la película ‘Spartacus Cheaper se alquilara por primera vez.
WITH "spartacus_rental_date" AS (
SELECT min(r."rental_date") AS "primer_alquiler"
FROM "film" AS f 
JOIN "inventory" AS i ON f."film_id" = i."film_id" 
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
WHERE f."title" = 'SPARTACUS CHEAPER'
)
SELECT a."first_name" AS "nombre" , 
       a."last_name" AS "apellido"
FROM "actor" AS a 
JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
JOIN "film" AS f ON fa."film_id" = f."film_id"
JOIN "inventory" AS i ON f."film_id" = i."film_id"
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
WHERE r."rental_date" > (SELECT "primer_alquiler" FROM "spartacus_rental_date");

-- Ordena los resultados alfabéticamente por apellido.
WITH "spartacus_rental_date" AS (
SELECT min(r."rental_date") AS "primer_alquiler"
FROM "film" AS f 
JOIN "inventory" AS i ON f."film_id" = i."film_id" 
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
WHERE f."title" = 'SPARTACUS CHEAPER'
)
SELECT a."first_name" AS "nombre" , 
       a."last_name" AS "apellido"
FROM "actor" AS a 
JOIN "film_actor" AS fa ON a."actor_id" = fa."actor_id"
JOIN "film" AS f ON fa."film_id" = f."film_id"
JOIN "inventory" AS i ON f."film_id" = i."film_id" 
JOIN "rental" AS r ON i."inventory_id" = r."inventory_id" 
WHERE r."rental_date" > (SELECT "primer_alquiler" FROM "spartacus_rental_date")
ORDER BY a."last_name" ASC;

-- 56. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría ‘Music.
SELECT a."first_name" , a."last_name" 
FROM "actor" AS a 
WHERE a."actor_id" NOT IN (
SELECT A."actor_id" 
FROM "actor" AS a2 
JOIN "film_actor" AS fa ON a2."actor_id" = fa."actor_id" 
JOIN "film" AS f ON fa."film_id" = f."film_id"
JOIN "film_category" AS fc ON fc."film_id" = f."film_id"
JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE c."name" = 'Music'
);

-- 57. Encuentra el título de todas las películas que fueron alquiladas por más de 8 días.
SELECT f."title" , extract(day from("return_date" - "rental_date")) AS "tiempo_alquiler"
FROM "rental" AS r 
JOIN "inventory" AS i ON i."inventory_id" = r."inventory_id" 
JOIN "film" AS f ON i."film_id" = f."film_id" 
WHERE extract(day from("return_date" - "rental_date")) > 8;

-- 58. Encuentra el título de todas las películas que son de la misma categoría que ‘Animation.
SELECT f."title" AS "titulo_peliculas" , 
       c."name" AS "categoria_peliculas"
FROM "film" AS f 
JOIN "film_category" AS fc ON f."film_id" = fc."film_id" 
JOIN "category" AS c ON fc."category_id" = c."category_id" 
WHERE c."name" = 'Animation';

-- 59. Encuentra los nombres de las películas que tienen la misma duración que la película con el título ‘Dancing Fever. 
SELECT f."title" AS "nombre_pelicula" ,
       f."length" AS "duracion_pelicula"
FROM "film" AS f
WHERE f."length" =
(SELECT f."length" FROM "film" AS f WHERE f."title" = 'DANCING FEVER');

-- Ordena los resultados alfabéticamente por título de película.
SELECT f."title" AS "nombre_pelicula" , 
       f."length" AS "duracion_pelicula"
FROM "film" AS f
WHERE f."length" =
(SELECT f."length" FROM "film" AS f WHERE f."title" = 'DANCING FEVER')
ORDER BY F."title" ASC;

-- 60. Encuentra los nombres de los clientes que han alquilado al menos 7películas distintas. 
SELECT c."customer_id" , C."first_name" , C."last_name"
FROM "customer" AS c 
JOIN "rental" AS r ON c."customer_id" = r."customer_id" 
JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id" 
GROUP BY c."customer_id" 
HAVING count(distinct i."film_id") >= 7; 

-- Ordena los resultados alfabéticamente por apellido.
SELECT c."customer_id" , C."first_name" , C."last_name" 
FROM "customer" AS c 
JOIN "rental" AS r ON c."customer_id" = r."customer_id" 
JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id" 
GROUP BY c."customer_id" 
HAVING count(distinct i."film_id") >= 7
ORDER BY c."last_name" ASC ;

-- 61. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres.
SELECT count(r."rental_id") AS "total_alquiladas" , 
       c."name" AS "categoria"
FROM "rental" AS r 
JOIN "inventory" AS i ON r."inventory_id" = i."inventory_id" 
JOIN "film_category" AS fc ON i."film_id" = fc."film_id"  
JOIN "category" AS c ON fc."category_id" = c."category_id" 
GROUP BY c."name" ;

-- 62. Encuentra el número de películas por categoría estrenadas en 2006.
SELECT count(f."film_id") AS "numero_peliculas" , 
       c."name"  AS "categoria" , 
       f."release_year" AS "ano_estreno"
FROM "film" AS f 
JOIN "film_category" AS fc ON f."film_id" = fc."film_id" 
JOIN "category" AS c ON fc."category_id" = c."category_id"
WHERE f."release_year" = 2006
GROUP BY c."name" , f."release_year" ;

-- 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas que tenemos.
SELECT *
FROM "staff" AS s
CROSS JOIN "store" AS s2 ;

-- 64. Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas.
SELECT c."customer_id" , 
       c."first_name" AS "nombre" , 
       c."last_name" AS "apellido" , 
       count(r."rental_id") AS "total_alquiler"
FROM "customer" AS c 
JOIN "rental" r ON c."customer_id" = r."customer_id"
GROUP BY c."first_name" , c."last_name" , c."customer_id" ;



