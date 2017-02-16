create table trabajador(seguro integer primary key, nombre varchar2(25), edad integer);
create table nomina(id_nomina integer, seguro integer, sueldo_base float, horas_laboradas integer, fecha_pago date, constraint pk_id_nomina primary key(id_nomina), 
constraint fk_seguro foreign key(seguro) references trabajador(seguro));

create sequence sec_nomina
start with 1
increment by 1
nomaxvalue;

CREATE OR REPLACE PROCEDURE GUARDAR_NOMINA(MY_ID_NOMINA OUT INTEGER, MY_SEGURO IN INTEGER, MY_SUELDO_BASE IN INTEGER)
AS 
BEGIN
SELECT SEC_NOMINA.NEXTVAL INTO MY_ID_NOMINA FROM DUAL;
INSERT INTO NOMINA(ID_NOMINA, SEGURO,SUELDO_BASE) VALUES(MY_ID_NOMINA, MY_SEGURO, MY_SUELDO_BASE);
END;
/

CREATE OR REPLACE PROCEDURE GENERAR_TRABAJADOR(MY_SEGURO IN INTEGER, MY_NOMBRE IN VARCHAR2, MY_EDAD IN INTEGER, MY_ID_NOMINA OUT INTEGER, MY_SUELDO_BASE IN FLOAT)
AS 
BEGIN
INSERT INTO TRABAJADOR VALUES(MY_SEGURO, MY_NOMBRE,MY_EDAD);
GUARDAR_NOMINA(MY_ID_NOMINA, MY_SEGURO, MY_SUELDO_BASE);
END;
/

DECLARE 
VALOR INTEGER;
BEGIN
GENERAR_TRABAJADOR(2,'Pedro',40,VALOR,8000);
END;
/
SELECT * FROM TRABAJADOR;
SELECT * FROM NOMINA;

CREATE OR REPLACE PROCEDURE HORAS_LABORADAS
(SEGURO IN)
UPDATE NOMINA
SET horas_laboradas = 40 WHERE SEGURO = 1;

