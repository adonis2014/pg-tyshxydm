----------------------------随机9位代码---------------------------------------------------------------------------  
CREATE OR REPLACE FUNCTION "public"."random_tyshxydm_9"()
  RETURNS "pg_catalog"."varchar" AS $BODY$
DECLARE
-- 		is_correct      BOOLEAN;
		ysgx_18         JSON;--18位的映射关系
		jqyz_18         JSON;--18位的加权因子
		ysgx_9          JSON;--9位的映射关系
		ysdm_9          JSON;
		ysdm_18         JSON;
		jqyz_9          JSON;--9位的加权因子
		btdm            VARCHAR; -- 9位的本体代码
		random_dm       VARCHAR;
		validate_dm     INTEGER;
		i 							INTEGER;
		total 					INTEGER;
		
BEGIN
		i :=0;
		total :=0;
		ysgx_18 :='{"0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, "8": 8, 
							"9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, "H": 17, 
							"J": 18, "K": 19, "L": 20, "M": 21, "N": 22, "P": 23, "Q": 24, "R": 25, "T": 26, 
							"U": 27, "W": 28, "X": 29, "Y": 30}'::json;
		ysgx_9 :='{ "0": 0, "1": 1, "2": 2, "3": 3, "4": 4, "5": 5, "6": 6, "7": 7, 
						"8": 8, "9": 9, "A": 10, "B": 11, "C": 12, "D": 13, "E": 14, "F": 15, "G": 16, 
						"H": 17, "I": 18, "J": 19, "K": 20, "L": 21, "M": 22, "N": 23, "O": 24, "P": 25,
						"Q": 26,"R": 27, "S": 28, "T": 29, "U": 30, "V": 31, "W": 32, "X": 33, "Y": 34,
						"Z": 35}'::json;
		ysdm_9 := '["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
							"A", "B", "C", "D", "E", "F", "G", "H",  "J", 
							"K", "L", "M", "N",  "P","Q","R",  "T", 
							"U",  "W", "X", "Y"]'::json;
		ysdm_18 := '["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", 
								"A", "B", "C", "D", "E", "F", "G", "H", "J", 
								"K", "L", "M", "N",  "P","Q","R",  "T", 
								"U",  "W", "X","Y"]'::json;
		jqyz_18 :='[1, 3, 9, 27, 19, 26, 16, 17, 20, 29, 25, 13, 8, 24, 10, 30, 28]'::json;
		jqyz_9 :='[3, 7, 9, 10, 5, 8, 4, 2]'::json;
		--本体代码
		btdm := '';
		random_dm := '';
		WHILE i < 8 LOOP
			random_dm :=  ysdm_9->floor(random()*31)::integer;
			btdm := btdm || random_dm :: VARCHAR;
-- 			raise notice 'btdm 为： % ',btdm;
			total := total + (jqyz_9 -> i)::text::INTEGER	* ((ysgx_9->replace(random_dm,'"',''))::text::INTEGER);
			i := i + 1;
		END LOOP;
		i := 0;
		validate_dm := 11 -  total % 11;
		if validate_dm = 10 THEN
			btdm := btdm || 'X';
		ELSIF validate_dm = 0 then
			btdm := btdm || '0';
		else 
			btdm := btdm || (ysdm_18 -> validate_dm);
		end if;
		return replace(btdm,'"','');
END;
 $BODY$
  LANGUAGE plpgsql VOLATILE
  COST 100;