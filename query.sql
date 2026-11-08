DROP TABLE people;

CREATE TABLE IF NOT EXISTS people (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(255) NOT NULL,
	last_name VARCHAR(255),
	age INT NOT NULL,
	job VARCHAR(255),
	employed BOOL NOT NULL
);
--  TRUNCATE is used to remove all the data from the table
TRUNCATE TABLE people;

INSERT INTO people (first_name, age, job, employed)VALUES ('Mike', 30, 'Artist', true);
INSERT INTO people (first_name, age, job, employed) VALUES ('Jack', 10, 'Drawer', true);
INSERT INTO people (first_name, age, job, employed) VALUES ('Test', 40, 'Engineer', true);

INSERT INTO people (first_name, last_name, age, job, employed) VALUES
('Mike', 'Smith', 30, 'Programmer', true),
('Lisa', 'Woods', 41, 'Accountant', true),
('Chris', 'Stones', 80, 'Programmer', true),
('John', 'Stones', 80, 'Programmer', true),
('Susan', 'Stones', 32, 'Programmer', true),
('Bob', 'Gates', 32, 'Designer', true);

INSERT INTO people(first_name, last_name, age, job, employed) VALUES ('test123', '123', 30, 'teacher', true);

-- DISTINCT is used to get non duplicate values 
SELECT DISTINCT job FROM people WHERE last_name IS NOT NULL;

-- BETWEEN is like a control command to check that where the age lies !
SELECT * FROM people WHERE age BETWEEN 10 AND 30;

-- IN is used to get the values from the array or a set of vaues
SELECT id, job, first_name, age FROM people WHERE job IN ('teacher', 'Engineer');

UPDATE people SET job = 'nojob' WHERE first_name =  'Mike';
SELECT * FROM people where first_name = 'Mike';

-- DELETE
DELETE FROM people WHERE id = 6;

-- Get all
SELECT * FROM people;

--  ORDER BY
SELECT * FROM people WHERE last_name IS NULL ORDER BY age DESC;


-- GROUP BY IT combines the duplicate values into one select argumenets matters here
SELECT job, last_name, AVG(age) FROM people GROUP BY job, last_name HAVING COUNT(*) > 1;	


-- LIMIT is used to control the number of output lines eg: rows in the table
SELECT * FROM people ORDER BY age DESC LIMIT 3;

-- It is used to add or drop a colum in the data table
ALTER TABLE people ADD COLUMN height DECIMAL(10, 2);
ALTER TABLE people DROP COLUMN employed;


-- m -> 1 relationship
-- One owner many things 

CREATE TABLE IF NOT EXISTS things(
	id SERIAL PRIMARY KEY,
	inv_num VARCHAR(255) UNIQUE,
	thing_name VARCHAR(255) NOT NULL,
	description VARCHAR(255),
	price DECIMAL(10, 2) CHECK (price >= 0)
);

-- REFERENCES IS used to refer the table (foreign key)
CREATE TABLE IF NOT EXISTS ownership(
	item_owner INT REFERENCES people(id),
	item INT REFERENCES things(id),
	PRIMARY KEY (item_owner, item)
);

INSERT INTO things (inv_num, thing_name, price) VALUES
('A1', 'Laptop', 900), ('A2', 'Book', 750), ('B1', 'Pen', 4100);

INSERT INTO ownership VALUES (15, 1), (16, 1), (17, 3), (18,2);

SELECT * FROM things;
SELECT * FROM people;

SELECT * FROM people FULL JOIN things ON people.id = things.item_owner;



SELECT p.first_name, p.last_name, t.thing_name, t.price
FROM ownership
JOIN people p ON p.id = ownership.item_owner
JOIN things t ON t.id = ownership.item;