/*--------------------------------------------------------------------------
    Proyecto: Fondo de ahorros y creditos para ingenieros de sistemas FACIS
    Descripción: Este paquete lista las funciones y los procedimientos
                 correspondientes al manejo de los rendimientos del fondo.
    Autor: Nicolás Mauricio García Garzón
    Fecha: 2013/11/24
--------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY pk_rendimientos AS

/*-------------------------------------------------------------------------
    Distribuye los rendimientos del fondo a los socios. La dis-
    tribución de los rendimientos se hará con la siguiente dinámica:
    Los intereses por concepto de crédito serán divididos en partes iguales
    para los socios que estén al día con el pago de sus aportes.
    

    Parámetros de salida: 
        pc_error        Código de error
        pm_error        Mensaje de error
--------------------------------------------------------------------------*/

PROCEDURE pr_dividir_rendimientos_socios(pc_error OUT NUMBER, 
                                            pm_error OUT VARCHAR) IS

v_rendimiento_anual rendimiento.v_rendimientos_financieros%TYPE;
c_n_socios_al_dia NUMBER DEFAULT 0;

CURSOR c_socios IS
    SELECT k_identificacion
    FROM socio 
    WHERE pk_creditos.fu_socio_al_dia(k_identificacion) IN ('T','N') 
    AND pk_aportes.fu_socio_al_dia(k_identificacion) IN ('T','N');

CURSOR c_cuenta_socios IS
    SELECT COUNT(*) AS cuenta
    FROM socio 
    WHERE pk_creditos.fu_socio_al_dia(k_identificacion) IN ('T','N') 
    AND pk_aportes.fu_socio_al_dia(k_identificacion) IN ('T','N');

BEGIN
    
    SELECT v_rendimientos_financieros 
    INTO v_rendimiento_anual
    FROM rendimiento
    WHERE f_rendimiento = TO_DATE(TO_CHAR(ADD_MONTHS(sysdate,-12),'yyyy'),'yyyy');
    
    FOR r_c_cuenta_socios IN c_cuenta_socios LOOP
        c_n_socios_al_dia := r_c_cuenta_socios.cuenta;
    END LOOP;

    FOR r_c_socios IN c_socios LOOP
        NULL;
    END LOOP;

EXCEPTION
    WHEN OTHERS THEN
        pc_error := sqlcode;
        pm_error := sqlerrm;

END pr_dividir_rendimientos_socios;

/*-------------------------------------------------------------------------
    
    Calcula el capital disponible del fondo

    Parámetros de salida: 
        pc_error        Código de error
        pm_error        Mensaje de error
--------------------------------------------------------------------------*/

PROCEDURE pr_calcular_capital_disponible(pc_error OUT NUMBER,
                                             pm_error OUT VARCHAR
                                          ) IS

BEGIN
    NULL;
EXCEPTION
    WHEN OTHERS THEN
        pc_error := sqlcode;
        pm_error := sqlerrm;

END pr_calcular_capital_disponible;

/*-------------------------------------------------------------------------
    
    Calcula el capital total del fondo

    Parámetros de salida: 
        pc_error        Código de error
        pm_error        Mensaje de error
--------------------------------------------------------------------------*/

PROCEDURE pr_calcular_capital_total(pc_error OUT NUMBER,
                                             pm_error OUT VARCHAR
                                          ) IS

BEGIN
    NULL;
EXCEPTION
    WHEN OTHERS THEN
        pc_error := sqlcode;
        pm_error := sqlerrm;

END pr_calcular_capital_total;

/*-------------------------------------------------------------------------
    
    Crea registro en la base de datos de un nuevo rendimiento anual

    Parámetros de salida: 
        pc_error        Código de error
        pm_error        Mensaje de error
--------------------------------------------------------------------------*/

PROCEDURE pr_crear_nuevo_rendimiento(pc_error OUT NUMBER,
                                             pm_error OUT VARCHAR
                                          ) IS

BEGIN

    INSERT INTO rendimiento VALUES
        (0,0,0,0,TO_DATE(TO_CHAR(sysdate,'yyyy'),'yyyy'),seq_rendimiento.nextval);

EXCEPTION
    WHEN OTHERS THEN
        pc_error := sqlcode;
        pm_error := sqlerrm;

END pr_crear_nuevo_rendimiento;

END pk_rendimientos;
/
/*
declare

l_cuenta number;

begin

SELECT COUNT(*) AS cuenta into l_cuenta
    FROM socio 
    WHERE --pk_creditos.fu_socio_al_dia(k_identificacion) IN ('T','N');
 pk_aportes.fu_socio_al_dia(k_identificacion) IN ('T','N');
--AND
dbms_output.put_line(l_cuenta);

end;
*/