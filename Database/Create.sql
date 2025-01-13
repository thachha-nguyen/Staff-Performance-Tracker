-- Create the database
CREATE DATABASE dashboard;
 
-- Connect to the database
\c dashboard;
 
-- Create the schema
CREATE SCHEMA IF NOT EXISTS planning1;
 
-- Create the practitioner table
CREATE TABLE IF NOT EXISTS planning1.practitioner (
    practitioner_id INTEGER NOT NULL,
    practitioner_name CHARACTER VARYING(255),
    employee_type CHARACTER VARYING(255),
    clinic_location CHARACTER VARYING,
    bill_rate_standard INTEGER,
    bill_rate_special INTEGER,
    manager_name CHARACTER VARYING(50),
    CONSTRAINT practitioner_pkey PRIMARY KEY (practitioner_id)
);
 
-- Create the statutory_holidays table
CREATE TABLE IF NOT EXISTS planning1.statutory_holidays (
    holiday_date DATE NOT NULL,
    holiday_name CHARACTER VARYING(100),
    CONSTRAINT statutory_holidays_pkey PRIMARY KEY (holiday_date)
);
 
-- Create the target_update table
CREATE TABLE IF NOT EXISTS planning1.target_update (
    practitioner_id INTEGER,
    practitioner_name CHARACTER VARYING(255),
    target_date TIMESTAMP,
    target_hour DOUBLE PRECISION,
    updated_at TIMESTAMP,
    CONSTRAINT unique_practitioner_date UNIQUE (practitioner_id, target_date)
);
