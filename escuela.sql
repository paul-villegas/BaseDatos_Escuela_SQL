-- ===========================================
-- BASE DE DATOS: ESCUELA
-- Autor: Paul Villegas Martínez
-- Actividad: 2.3 Restricciones SQL
-- ===========================================

-- Crear la base de datos
CREATE DATABASE escuela;
USE escuela;

-- ===========================================
-- TABLA: Carreras
-- ===========================================
CREATE TABLE Carreras (
  id_carrera INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
);

-- ===========================================
-- TABLA: Estudiantes
-- ===========================================
CREATE TABLE Estudiantes (
  id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE CHECK (fecha_nacimiento <= CURDATE()),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- ===========================================
-- TABLA: Materias
-- ===========================================
CREATE TABLE Materias (
  id_materia INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  creditos INT CHECK (creditos BETWEEN 1 AND 10),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- ===========================================
-- INSERCIÓN DE DATOS
-- ===========================================
INSERT INTO Carreras (nombre)
VALUES ('Ingeniería en Sistemas'), ('Administración'), ('Diseño Gráfico');

INSERT INTO Estudiantes (nombre, apellido, fecha_nacimiento, id_carrera)
VALUES
('María', 'González', '2000-05-12', 1),
('Carlos', 'Ruiz', '1999-11-02', 2),
('Laura', 'Pérez', '2001-01-15', 3);

INSERT INTO Materias (nombre, creditos, id_carrera)
VALUES
('Bases de Datos', 8, 1),
('Contabilidad', 6, 2),
('Diseño Digital', 9, 3);

-- ===========================================
-- PRUEBAS DE VALIDACIÓN
-- ===========================================
-- 1. Fecha futura (debe fallar)
-- INSERT INTO Estudiantes (nombre, apellido, fecha_nacimiento, id_carrera)
-- VALUES ('Juan', 'Morales', '2030-01-01', 1);

-- 2. Créditos fuera de rango (debe fallar)
-- INSERT INTO Materias (nombre, creditos, id_carrera)
-- VALUES ('Materia Inválida', 0, 1);

-- 3. Carrera duplicada (debe fallar)
-- INSERT INTO Carreras (nombre) VALUES ('Administración');

-- ===========================================
-- CONSULTAS CON OPERADORES
-- ===========================================
-- 1. Materias con más de 6 créditos
SELECT nombre, creditos FROM Materias WHERE creditos > 6;

-- 2. Estudiantes de Ingeniería en Sistemas o Diseño Gráfico
SELECT e.nombre, e.apellido, c.nombre AS carrera
FROM Estudiantes e
JOIN Carreras c ON e.id_carrera = c.id_carrera
WHERE c.nombre = 'Ingeniería en Sistemas' OR c.nombre = 'Diseño Gráfico';

-- 3. Estudiantes cuyo apellido empieza con “P”
SELECT * FROM Estudiantes WHERE apellido LIKE 'P%';

-- 4. Materias con créditos entre 5 y 9
SELECT nombre, creditos FROM Materias WHERE creditos BETWEEN 5 AND 9;

-- 5. Carreras específicas (IN)
SELECT * FROM Carreras WHERE nombre IN ('Administración', 'Diseño Gráfico');

-- 6. Promedio de créditos
SELECT AVG(creditos) AS Promedio_Creditos FROM Materias;

-- ===========================================
-- NUEVA TABLA: Profesores
-- ===========================================
CREATE TABLE Profesores (
  id_profesor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  especialidad VARCHAR(80),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

-- ===========================================
-- CONCAT y ORDER BY
-- ===========================================
SELECT CONCAT(e.nombre, ' ', e.apellido) AS Estudiante, c.nombre AS Carrera
FROM Estudiantes e
JOIN Carreras c ON e.id_carrera = c.id_carrera
ORDER BY e.apellido ASC;

-- ===========================================
-- UPDATE y ROUND
-- ===========================================
ALTER TABLE Estudiantes ADD COLUMN promedio_general DECIMAL(5,2);
UPDATE Estudiantes SET promedio_general = ROUND(70 + (RAND() * 30), 2);

-- ===========================================
-- FIN DEL SCRIPT
-- ===========================================
