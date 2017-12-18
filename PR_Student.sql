DROP PROCEDURE
IF
	EXISTS `PR_Student`;
CREATE PROCEDURE `PR_Student` ( OUT sum INT ) BEGIN
SELECT
	COUNT( * ) INTO sum 
FROM
	student;

END

-- IN参数例子
DROP PROCEDURE
IF
	EXISTS `PR_IN`;
CREATE PROCEDURE `PR_IN` ( IN p_in INT ) BEGIN
	SELECT
		p_in;
	
	SET p_in = 2;
	SELECT
		p_in;
	
	END 
	
	
	
	SET @P_IN = 1;
	CALL PR_IN ( @P_IN );
	SELECT
		@P_IN;
	
	
	-- OUT参数例子
DROP PROCEDURE
IF
	EXISTS `PR_OUT`;
CREATE PROCEDURE `PR_OUT` ( OUT p_out INT ) BEGIN
	SELECT
		p_out;
	
	SET p_out = 2;
	SELECT
		p_out;
	
	END 
	
	#调用
	SET @p_out = 1;
	CALL PR_OUT ( @p_out );
	SELECT
		@p_out;
		
		
		
-- INOUT参数例子
DROP PROCEDURE
IF
	EXISTS `PR_INOUT`;
CREATE PROCEDURE `PR_INOUT` ( INOUT p_inout INT ) BEGIN
	SELECT
		p_inout;
	
	SET p_inout = 2;
	SELECT
		p_inout;
	
	END 
	
	#调用
	SET @p_inout = 1;
	CALL PR_INOUT ( @p_inout );
	SELECT
		@p_inout;
		

#在MySQL客户端使用用户变量
SELECT
	'hello world' INTO @x;
SELECT
	@x;
SET @y = 'goodbye';
SELECT
	@y;

SET @z = 1+2+3;
SELECT
	@z;


#在存储过程中使用用户变量
DROP PROCEDURE
IF
	EXISTS `PR_VAR`;
CREATE PROCEDURE `PR_VAR` ( ) BEGIN
SELECT
	CONCAT( @greeting, 'world' );

END

SET @greeting = 'hello';
CALL PR_VAR ( );


#在存储过程间传递全局范围的用户变量
CREATE PROCEDURE p1()
SET @last_proc = 'p1';
CREATE PROCEDURE p2()
SELECT CONCAT('Last procedure was ',@last_proc);
CALL p1();
CALL p2();


#查询存储过程
SELECT name FROM mysql.proc WHERE db='Test';
SELECT routine_name FROM information_schema.routines WHERE routine_schema='Test';
SHOW PROCEDURE STATUS WHERE db='Test';


#MySQL存储过程的修改
/**
ALTER {PROCEDURE | FUNCTION} sp_name [characteristic ...]
characteristic:
{ CONTAINS SQL | NO SQL | READS SQL DATA | MODIFIES SQL DATA }
| SQL SECURITY { DEFINER | INVOKER }
| COMMENT 'string'

sp_name参数表示存储过程或函数的名称；
characteristic参数指定存储函数的特性。
CONTAINS SQL表示子程序包含SQL语句，但不包含读或写数据的语句；
NO SQL表示子程序中不包含SQL语句；
READS SQL DATA表示子程序中包含读数据的语句；
MODIFIES SQL DATA表示子程序中包含写数据的语句。
SQL SECURITY { DEFINER | INVOKER }指明谁有权限来执行，DEFINER表示只有定义者自己才能够执行；INVOKER表示调用者可以执行。
COMMENT 'string'是注释信息。
*/

#例子
#将读写权限改为MODIFIES SQL DATA，并指明调用者可以执行。
ALTER PROCEDURE PR_ADD MODIFIES SQL DATA SQL SECURITY INVOKER;
#将读写权限改为READS SQL DATA，并加上注释信息'FIND NAME'。
ALTER PROCEDURE PR_ADD READS SQL DATA COMMENT 'Find Name';



#变量作用域
DROP PROCEDURE
IF
	EXISTS `PR_SCOPE`;
CREATE PROCEDURE `PR_SCOPE` ( ) 
BEGIN
	DECLARE x1 VARCHAR ( 5 ) DEFAULT 'outer';
	
	BEGIN
		DECLARE x1 VARCHAR ( 5 ) DEFAULT 'inner';
		SELECT x1;
	END; #记得加;号
	
	SELECT x1;
END

#调用
CALL PR_SCOPE();

			
#条件语句IF-THEN-ELSE
DROP PROCEDURE IF EXISTS `PR_IFELSE`;
CREATE PROCEDURE `PR_IFELSE`(IN parameter int)
BEGIN
	DECLARE var INT;
	SET var = parameter + 1;
	IF var > 0 THEN
		INSERT INTO student(`name`, age) VALUES ('里斯',18);
	END IF;
	
	IF parameter <= 0 THEN
		UPDATE student SET age = 19;
	ELSE
		UPDATE student SET age = age + parameter;
	END IF;

END

#调用
SET @parameter = 1;
CALL PR_IFELSE(@parameter)



#CASE-WHEN-THEN-ELSE语句
DROP PROCEDURE IF EXISTS `PR_CASE`;

CREATE PROCEDURE `PR_CASE`(IN parameter INT)
BEGIN
	DECLARE var INT;
	SET var = parameter + 1;
	CASE var
		WHEN 0 THEN
			UPDATE student SET `name` = 'Joker' WHERE id = 5;
		ELSE
			UPDATE student SET `name` = 'Sam' WHERE id = 5;
	END CASE;
END

#调用
SET @parameter = 0;
CALL PR_CASE(@parameter);



#WHILE-DO…END-WHILE
DROP PROCEDURE IF EXISTS `PR_WHILE`;

CREATE PROCEDURE `PR_WHILE`()
BEGIN
	DECLARE var INT;
	SET var = 0;
	
	WHILE var < 2 DO
		-- 循环里面想使用变量，必需要begin/end
		BEGIN
			DECLARE stuName VARCHAR(40);
			SET stuName = CONCAT('小明',var);
			INSERT INTO student(`name`,age) VALUES (stuName, 18);
			SET var = var + 1;
		END;
	END WHILE;

END

#调用
CALL PR_WHILE();



#REPEAT...END REPEAT
#此语句的特点是执行操作后检查结果
DROP PROCEDURE IF EXISTS `PR_REPEAT`;

CREATE PROCEDURE `PR_REPEAT`()
BEGIN
	DECLARE v INT;
	SET v = 0;
	REPEAT
		INSERT INTO student (`name`, age) VALUES ('小红',33);
		SET v = v + 1;
	UNTIL v > 2 END REPEAT;

END

#调用
CALL PR_REPEAT();


#LOOP...END LOOP
DROP PROCEDURE IF EXISTS `PR_LOOP`;

CREATE PROCEDURE `PR_LOOP`()
BEGIN
	DECLARE v INT;
	SET v = 0;
	LOOP_LABLE: LOOP
	
		INSERT INTO student(`name`,age) VALUES('小光',22);
		SET v = v + 1;

		IF v > 2 THEN
			LEAVE LOOP_LABLE; 
		END IF; 
	END LOOP LOOP_LABLE;

END


CALL PR_LOOP();

/**
LABLES标号
标号可以用在begin repeat while 或者loop 语句前，语句标号只能在合法的语句前面使用。可以跳出循环，使运行指令达到复合语句的最后一步。

ITERATE迭代
通过引用复合语句的标号,来从新开始复合语句
*/

DROP PROCEDURE IF EXISTS `PR_ITERATE`;

CREATE PROCEDURE `PR_ITERATE`()
BEGIN
	DECLARE v INT;
	SET v = 0;
	LOOP_LABLE: LOOP
		IF v < 3 THEN
			SET v = v + 1;
			ITERATE LOOP_LABLE;  -- 个人感觉ITERATE类似循环中的continue
		END IF;
		INSERT INTO student(`name`,age) VALUES('小志',12);
		SET v = v + 1;

		IF v > 4 THEN
			LEAVE LOOP_LABLE; 
		END IF; 
	END LOOP LOOP_LABLE;

END

#调用
CALL PR_ITERATE();

SELECT * from student;

SET @sn = '小志';
DELETE from  student WHERE `name` = @sn;


#函数
SELECT LEFT('1222222222',3);

DROP FUNCTION IF EXISTS sayHello;

CREATE FUNCTION sayHello ( ) RETURNS VARCHAR ( 50 ) BEGIN
	RETURN 'hello mysql function';
	
	END $$

	
SELECT sayHello();


DROP FUNCTION
IF
	EXISTS Test.formatDate;
CREATE FUNCTION Test.formatDate ( fdate datetime ) RETURNS VARCHAR ( 255 ) BEGIN
	DECLARE
		x VARCHAR ( 255 ) DEFAULT '';
	
	SET x = DATE_FORMAT( fdate, '%Y年%m月%d日%h时%i分%s秒' );
	RETURN x;
	
	END

SELECT formatDate(NOW());


#查看函数
SHOW FUNCTION STATUS LIKE '%hello%';



DECLARE arr VARCHAR(255);
select concat_ws(',','11','22',NULL,'44') INTO arr;

SELECT age,GROUP_CONCAT(name) FROM student GROUP BY age;

SELECT age,GROUP_CONCAT(name ORDER BY name desc) FROM student GROUP BY age;




























