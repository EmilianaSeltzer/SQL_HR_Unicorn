# Calculate the Media salary of the HR company: '6461.83'

SELECT ROUND(AVG(salario),2) FROM hr_unicorn.empleados;

# Employees who salary is over the media, bringing the full name and salary
-- from the "Empleados" table, and the rest of columns with Left Joins, work title,
-- work area, starting and finishind work dates, State.

SELECT
CONCAT(E.nombre_empleado,' ', E.apellido_empleado) AS Empleado,
E.salario,
T.titulo_trabajo,
D.nombre_departamento,
HR.fecha_inicio, HR.fecha_fin,
U.estado_provincia,
NOW() AS fecha_actualizacion
FROM hr_unicorn.empleados E
LEFT JOIN hr_unicorn.trabajos T ON E.id_trabajo=T.id_trabajo
LEFT JOIN hr_unicorn.departamentos D ON D.id_departamento=E.id_departamento
LEFT JOIN hr_unicorn.historial_trabajos HR ON HR.id_empleado=E.id_empleado
LEFT JOIN hr_unicorn.ubicaciones U ON U.id_ubicacion=D.id_ubicacion
WHERE salario > (SELECT AVG(salario) FROM hr_unicorn.empleados)
ORDER BY salario DESC;

# Create View with the last query

CREATE VIEW Reporting_salario_medio
AS
SELECT
CONCAT(E.nombre_empleado,' ', E.apellido_empleado) AS Empleado,
E.salario,
T.titulo_trabajo,
D.nombre_departamento,
HR.fecha_inicio, HR.fecha_fin,
U.estado_provincia,
NOW() AS fecha_actualizacion
FROM hr_unicorn.empleados E
LEFT JOIN hr_unicorn.trabajos T ON E.id_trabajo=T.id_trabajo
LEFT JOIN hr_unicorn.departamentos D ON D.id_departamento=E.id_departamento
LEFT JOIN hr_unicorn.historial_trabajos HR ON HR.id_empleado=E.id_empleado
LEFT JOIN hr_unicorn.ubicaciones U ON U.id_ubicacion=D.id_ubicacion
WHERE salario > (SELECT AVG(salario) FROM hr_unicorn.empleados)
ORDER BY salario DESC;

# CREATE SP FROM A VIEW

-- CREATE PROCEDURE `SP_VISTA_REPORTE_SALARIOS` ()
-- BEGIN
-- SELECT * FROM hr_unicorn.reporting_salario_medio;
-- END

# Finally, we can invoke the stored procedure

CALL SP_VISTA_REPORTE_SALARIOS;

