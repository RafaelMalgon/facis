create or replace 
TRIGGER TR_UPDATE_SALDO_CREDITO 
BEFORE INSERT ON PAGO FOR EACH ROW
BEGIN
  pr_update_saldo_credito(:NEW.K_NUMCONSIGNACION);
END;
/