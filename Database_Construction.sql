-- Table Creation --

CREATE TABLE Customer (
  customer_id SERIAL,
  first_name VARCHAR(60),
  last_name VARCHAR(60),
  PRIMARY KEY (customer_id)
);

CREATE TABLE Salesman (
  salesman_id SERIAL,
  first_name VARCHAR(60),
  last_name VARCHAR(60),
  PRIMARY KEY (salesman_id)
);

CREATE TABLE Inventory (
  car_id SERIAL,
  make VARCHAR(60),
  model VARCHAR(60),
  year_ INTEGER,
  cost_ NUMERIC(10,2),
  car_type INTEGER,
  PRIMARY KEY (car_id)
);

CREATE TABLE Invoice (
  invoice_id SERIAL,
  customer_id INTEGER,
  salesman_id INTEGER,
  car_id INTEGER,
  total_cost NUMERIC(10,2),
  PRIMARY KEY (invoice_id),
  CONSTRAINT "FK_Invoice.customer_id"
    FOREIGN KEY (customer_id)
      REFERENCES Customer(customer_id),
  CONSTRAINT "FK_Invoice.salesman_id"
    FOREIGN KEY (salesman_id)
      REFERENCES Salesman(salesman_id),
  CONSTRAINT "FK_Invoice.car_id"
    FOREIGN KEY (car_id)
      REFERENCES Inventory(car_id)
);

CREATE TABLE Mechanic (
  mechanic_id SERIAL,
  first_name VARCHAR(60),
  last_name VARCHAR(60),
  PRIMARY KEY (mechanic_id)
);

CREATE TABLE Parts (
  part_id SERIAL,
  part_name VARCHAR(60),
  amount NUMERIC(6,2),
  instock INTEGER,
  PRIMARY KEY (part_id)
);

CREATE TABLE Service_Ticket (
  repair_id SERIAL,
  customer_id INTEGER,
  mechanic_id INTEGER,
  part_id INTEGER,
  car_id INTEGER,
  repair_cost NUMERIC(8,2),
  PRIMARY KEY (repair_id),
  CONSTRAINT "FK_Service_Ticket.customer_id"
    FOREIGN KEY (customer_id)
      REFERENCES Customer(customer_id),
  CONSTRAINT "FK_Service_Ticket.mechanic_id"
    FOREIGN KEY (mechanic_id)
      REFERENCES Mechanic(mechanic_id),
  CONSTRAINT "FK_Service_Ticket.part_id"
    FOREIGN KEY (part_id)
      REFERENCES Parts(part_id),
  CONSTRAINT "FK_Service_Ticket.car_id"
    FOREIGN KEY (car_id)
      REFERENCES Inventory(car_id)
);

CREATE TABLE Service_History (
  history_id SERIAL,
  repair_id INTEGER,
  car_id INTEGER,
  history_info VARCHAR(200),
  PRIMARY KEY (history_id),
  CONSTRAINT "FK_Service_History.repair_id"
    FOREIGN KEY (repair_id)
      REFERENCES Service_Ticket(repair_id),
  CONSTRAINT "FK_Service_History.car_id"
    FOREIGN KEY (car_id)
      REFERENCES Inventory(car_id)
);

-- Initial Value Insertion --
INSERT INTO Customer(
	customer_id,
	first_name,
	last_name
)
VALUES(
	1,
	'Dylan',
	'Moore'
);

INSERT INTO inventory(
	car_id,
	make,
	model,
	year_,
	cost_,
	car_type
)
VALUES(
	1,
	'Toyota',
	'Prius',
	2017,
	17,685
);

Select *
FROM inventory;

UPDATE inventory
SET cost_ = 17685.00
WHERE car_id = 1;

INSERT INTO salesman(
	salesman_id,
	first_name,
	last_name
)
VALUES(
	1,
	'John',
	'Papalooga'
);

SELECT *
FROM salesman;

INSERT INTO mechanic(
	mechanic_id,
	first_name,
	last_name
					
)
VALUES(
	1,
	'James',
	'Ford'
);


INSERT INTO invoice(
	invoice_id,
	customer_id,
	salesman_id,
	car_id,
	total_cost
)
VALUES(
	1,
	1,
	1,
	1,
	17685.00
);

INSERT INTO parts(
	part_id,
	part_name,
	amount,
	instock
)

VALUES(
	1,
	'Fender',
	800.00,
	1
);

INSERT INTO service_ticket(
	repair_id,
	customer_id,
	mechanic_id,
	part_id,
	car_id,
	repair_cost
)
VALUES(
	1,
	1,
	1,
	1,
	1,
	1300.00
);

INSERT INTO service_history(
	history_id,
	repair_id,
	car_id,
	history_info
)

VALUES(
	1,
	1,
	1,
	'Replaced a damaged fender'
);

-- Creating a Function Then Inserting Values With Those Functions --

CREATE OR REPLACE FUNCTION add_salesman(
		_salesman_id INTEGER, 
		_first_name VARCHAR, 
		_last_name VARCHAR 
)
RETURNS void
LANGUAGE plpgsql 
AS $MAIN$ 
BEGIN
		INSERT INTO salesman
		VALUES(_salesman_id, _first_name, _last_name);
		
END;
$MAIN$

SELECT add_customer(2, 'Bob', 'Podingus');


SELECT add_salesman(2,'Vin', 'Diesel');


CREATE OR REPLACE FUNCTION add_car(
	_car_id INTEGER,
	_make VARCHAR,
	_model VARCHAR,
	_year_ INTEGER,
	_cost_ NUMERIC(10,2)
)
returns void
LANGUAGE plpgsql
AS $MAIN$
BEGIN
	INSERT INTO inventory
	VALUES(_car_id, _make, _model, _year_, _cost_);
END;
$MAIN$

SELECT add_car(2, 'Subaru', 'Baja', 2006, 5000.00);


CREATE OR REPLACE FUNCTION add_invoice(
	_invoice_id INTEGER,
	_customer_id INTEGER,
	_salesman_id INTEGER,
	_car_id INTEGER,
	_total_cost NUMERIC(10,2)
)
returns void
LANGUAGE plpgsql
AS $MAIN$
BEGIN
	INSERT INTO invoice
	VALUES(_invoice_id, _customer_id, _salesman_id, _car_id, _total_cost);
END;
$MAIN$

SELECT add_invoice(2,2,2,2, 6000);


INSERT INTO service_ticket(
	repair_id,
	customer_id,
	mechanic_id,
	part_id,
	car_id,
	repair_cost
)

VALUES(
	2,
	2,
	1,
	NULL,
	2,
	500.00
);


INSERT INTO service_history(
	history_id,
	repair_id,
	car_id,
	history_info
)
VALUES(
	2,
	2,
	2,
	'Changed the tires out'
);


INSERT INTO mechanic(					
	mechanic_id,
	first_name,
	last_name
)

VALUES(
	2,
	'Etienne',
	'Lenoir'
);

SELECT *
FROM parts;

INSERT INTO parts(
	part_id,
	part_name,
	amount,
	instock
)
VALUES(
	2,
	'spark plug',
	10.00,
	20
);

UPDATE inventory
SET make = 'Toyota', model = 'Prius'
WHERE car_id = 1;

SELECT *
FROM inventory;
