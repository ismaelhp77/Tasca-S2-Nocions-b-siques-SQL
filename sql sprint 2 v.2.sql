
-- NIVELL 1--


-- Ejercicio 1
 DESC company ;
 DESC transaction ;
SELECT *FROM transaction ; 
SELECT *FROM company ; 
-- Ejercicio 2

SELECT DISTINCT country
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
WHERE t.declined = 0;

SELECT  COUNT(DISTINCT country)
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
WHERE t.declined = 0 ;

SELECT company_name, AVG(amount)
FROM company AS c
JOIN transaction AS t
ON c.id = t.company_id
GROUP BY c.id
ORDER BY AVG(amount) DESC
LIMIT 1;

-- Ejercicio 3

SELECT *
FROM transaction
WHERE company_id IN (SELECT id
                      FROM company
                      WHERE country = "Germany");
-- Me salen las 100 empresas me parece extraño--
SELECT DISTINCT (SELECT c.company_name
                 FROM company c
                 WHERE c.id = t.company_id) AS Company 
FROM transaction t
WHERE t.amount > (SELECT AVG(amount)
				  FROM transaction)
;


SELECT company_name
FROM company
WHERE id NOT IN(SELECT DISTINCT company_id
                FROM transaction)
;	
-- no me sale ninguna,entiendo que es porque no hay--


-- NIVELL 2--


-- Ejercicio 1
SELECT SUM(amount),DATE(timestamp) AS fecha
FROM transaction
GROUP BY DATE(timestamp)
ORDER BY SUM(amount) DESC
LIMIT 5    ;

-- Ejercicio 2
-- version de media de dinero en las ventas--
SELECT c.country, AVG(amount) AS "Media de las ventas"
FROM company c
JOIN  transaction AS t
ON c.id = t.company_id
GROUP BY c.country
ORDER BY AVG(amount) DESC ;
-- version de media de numero ventas por pais--
SELECT c.country, COUNT(amount) AS "número de transacciones"
FROM company c
JOIN  transaction AS t
ON c.id = t.company_id
GROUP BY c.country
ORDER BY COUNT(amount) DESC ;


-- Ejercicio 3

-- Versión con JOIN  y subconsultas--
SELECT *
FROM company c
JOIN transaction t
ON c.id = t.company_id
WHERE c.country = (SELECT country
				   FROM company
                   WHERE company_name = "Non Institute");
                    
-- Versión sin join--
SELECT *
FROM transaction t
WHERE company_id IN (SELECT id
					FROM company
                    WHERE country =(SELECT country
				   FROM company
                   WHERE company_name = "Non Institute"))
;


-- NIVELL 3--


-- Ejercicio 1--

SELECT c.company_name,c.phone ,c.country, CAST(timestamp AS DATE) AS fecha, amount
FROM company c
JOIN transaction t
ON c.id = t.company_id  
WHERE CAST(timestamp AS DATE)  IN  ("2015-04-29","2018-06-20","2024-03-13") AND t.amount BETWEEN 350 AND 400
ORDER BY amount DESC
;

 -- Ejercicio 2 --
 -- Lo he ordenado por nombre porque me parece mas practico para enconotrar alguna empresa en concreto--
 
 SELECT c.company_name,COUNT(t.id),
 CASE
     WHEN COUNT(t.id) < 400 THEN 'No'
     WHEN COUNT(t.id) > 400 THEN 'Yes'
     
END AS 400_transacciones_o_mas
 FROM transaction t
 JOIN company c
 ON t.company_id = c.id
 GROUP BY c.id
 ORDER BY c.company_name 
 
 
 
 
 
 
                   



                      
                              
