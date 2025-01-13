-- Connect to the database
\c dashboard;
 
-- Create the schema
CREATE SCHEMA IF NOT EXISTS model;
 
-- Create the Dim_Date table in PostgreSQL
CREATE TABLE model.Dim_Date (
    date DATE PRIMARY KEY,
    day_of_week VARCHAR(10),
    week_of_year INT,
    month INT,
    quarter INT,
    year INT
);
 
-- Populate the Dim_Date table with dates from 2020-01-01 to 2030-12-31
INSERT INTO model.Dim_Date (date, day_of_week, week_of_year, month, quarter, year)
SELECT
    d::DATE AS date,
    TO_CHAR(d, 'Day') AS day_of_week,
    EXTRACT(WEEK FROM d)::INT AS week_of_year,
    EXTRACT(MONTH FROM d)::INT AS month,
    EXTRACT(QUARTER FROM d)::INT AS quarter,
    EXTRACT(YEAR FROM d)::INT AS year
FROM generate_series('2020-01-01'::DATE, '2030-12-31'::DATE, INTERVAL '1 day') AS d;
 
 
 
CREATE TABLE model.Dim_Practitioner (
    practitioner_dim_id SERIAL PRIMARY KEY,
    practitioner_id INT NOT NULL,
    practitioner_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    contract_type VARCHAR(50),
    manager_name VARCHAR(100),
	location_id INT,
	location_name VARCHAR(100),
    effective_start_date DATE,
    effective_end_date DATE,
    is_current BOOLEAN DEFAULT TRUE
);
 
 
 
CREATE TABLE model.Dim_Item (
    item_id SERIAL PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    department VARCHAR(100),
    category VARCHAR(100)
);
 
 
-- Create the Dim_Location table in PostgreSQL
CREATE TABLE model.Dim_Location (
    location_id SERIAL PRIMARY KEY,
    location_name VARCHAR(100) NOT NULL,
    address VARCHAR(255)
);
 
 
CREATE TABLE model.Fact_Performance (
    date DATE NOT NULL,
    practitioner_dim_id INT NOT NULL,
    location_id INT NOT NULL,
    target_hour DECIMAL(5, 1),
    actual_hour DECIMAL(5, 1),
    total_billing DECIMAL(10, 1)
);
 
 
CREATE TABLE model.Fact_Appointments (
    date DATE NOT NULL,
    practitioner_dim_id INT NOT NULL,
    location_id INT NOT NULL,
	item_id INT,
	number_appoiments INT,
    actual_hour DECIMAL(5, 1),
    total_billing DECIMAL(10, 1)
);
