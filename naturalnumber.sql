declare
    n integer;
    s integer := 0;
    i integer;
begin
    n := &n;
    if n > 0 then
        for i in 1..n loop
            s := s + i;
        end loop;
      dbms_output.put_line('The sum of natural numbers up to ' || n || ' is: ' || s);
      end if;
end;
/
