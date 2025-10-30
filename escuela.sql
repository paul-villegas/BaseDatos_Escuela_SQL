CREATE DATABASE escuela;
USE escuela;


CREATE TABLE Carreras (
  id_carrera INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL UNIQUE
);


CREATE TABLE Estudiantes (
  id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  fecha_nacimiento DATE CHECK (fecha_nacimiento <= CURDATE()),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);


CREATE TABLE Materias (
  id_materia INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  creditos INT CHECK (creditos BETWEEN 1 AND 10),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);


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

SELECT nombre, creditos FROM Materias WHERE creditos > 6;

SELECT e.nombre, e.apellido, c.nombre AS carrera
FROM Estudiantes e
JOIN Carreras c ON e.id_carrera = c.id_carrera
WHERE c.nombre = 'Ingeniería en Sistemas' OR c.nombre = 'Diseño Gráfico';

SELECT * FROM Estudiantes WHERE apellido LIKE 'P%';

SELECT nombre, creditos FROM Materias WHERE creditos BETWEEN 5 AND 9;

SELECT * FROM Carreras WHERE nombre IN ('Administración', 'Diseño Gráfico');

SELECT AVG(creditos) AS Promedio_Creditos FROM Materias;

CREATE TABLE Profesores (
  id_profesor INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(50) NOT NULL,
  apellido VARCHAR(50) NOT NULL,
  especialidad VARCHAR(80),
  id_carrera INT,
  FOREIGN KEY (id_carrera) REFERENCES Carreras(id_carrera)
);

SELECT CONCAT(e.nombre, ' ', e.apellido) AS Estudiante, c.nombre AS Carrera
FROM Estudiantes e
JOIN Carreras c ON e.id_carrera = c.id_carrera
ORDER BY e.apellido ASC;

ALTER TABLE Estudiantes ADD COLUMN promedio_general DECIMAL(5,2);
UPDATE Estudiantes SET promedio_general = ROUND(70 + (RAND() * 30), 2);
