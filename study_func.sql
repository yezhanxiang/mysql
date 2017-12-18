 
#mysql存储过程基本函数

# 一.数学函数
-- ABS(x) //返回x的绝对值
SELECT ABS(-1);
-- CEIL(x),CEILING(x) //返回大于或等于x的最小整数　
SELECT CEIL(1.5);
SELECT CEILING(1.5);
-- FLOOR(x) //返回小于或等于x的最大整数　
SELECT FLOOR(1.5);
-- RAND() //返回0->1的随机数
SELECT RAND();
-- RAND(x) //返回0->1的随机数，x值相同时返回的随机数相同　　
SELECT RAND(2);
-- SIGN(x) //返回x的符号，x是负数、0、正数分别返回-1、0和1　　
SELECT SIGN(-10);
SELECT SIGN(0);
SELECT SIGN(10);
-- PI() //返回圆周率(3.141593）
SELECT PI();
-- TRUNCATE(x,y) //返回数值x保留到小数点后y位的值（与ROUND最大的区别是不会进行四舍五入）
SELECT TRUNCATE(1.2385,2);
-- ROUND(x) //返回离x最近的整数
SELECT ROUND(1.2456);
-- ROUND(x,y) //保留x小数点后y位的值，但截断时要进行四舍五入　　
SELECT ROUND(1.25278,3);
-- POW(x,y).POWER(x,y) //返回x的y次方　
SELECT POW(2,3);
SELECT POWER(2,2);
-- SQRT(x) //返回x的平方根　
SELECT SQRT(4);
-- EXP(x) //返回e的x次方
SELECT EXP(1);
-- MOD(x,y) //返回x除以y以后的余数
SELECT MOD(5,2);
SELECT 5%2;
-- LOG(x) //返回自然对数(以e为底的对数)
SELECT LOG(3,4);
-- LOG10(x) //返回以10为底的对数　
SELECT LOG10(100);
-- RADIANS(x) //将角度转换为弧度
SELECT RADIANS(180);
-- DEGREES(x) //将弧度转换为角度　
SELECT DEGREES(3.141592653589793);
-- SIN(x) //求正弦值(参数是弧度)
SELECT SIN(RADIANS(180));
-- ASIN(x) //求反正弦值(参数是弧度)
SELECT ASIN(SIN(RADIANS(180)));
-- COS(x) //求余弦值(参数是弧度)
-- ACOS(x) //求反余弦值(参数是弧度)
-- TAN(x) //求正切值(参数是弧度)
-- ATAN(x) ATAN2(x) //求反正切值(参数是弧度)
-- COT(x) //求余切值(参数是弧度)


# 二.字符串函数 
-- CHAR_LENGTH(s) //返回字符串s的字符数
SELECT CHAR_LENGTH('你好123');
-- LENGTH(s) //返回字符串s的长度
SELECT LENGTH('你好123');
-- CONCAT (string2  [,... ]) //连接字串
SELECT CONCAT('hello ','world');
-- CONCAT_WS(x,s1,s2,...) //同CONCAT(s1,s2,...)函数，但是每个字符串直接要加上x
SELECT CONCAT_WS('@','helo','qq.com');
-- INSERT(s1,x,len,s2) //将字符串s2替换s1的x位置开始长度为len的字符串
SELECT INSERT('12345',1,3,'abc');
-- UPPER(s),UCAASE(S) //将字符串s的所有字母变成大写字母
SELECT UPPER('abc');
-- LOWER(s),LCASE(s) //将字符串s的所有字母变成小写字母
SELECT LOWER('ABC');
-- LEFT(s,n) //返回字符串s的前n个字符
SELECT LEFT('acd',2);
-- RIGHT(s,n) //返回字符串s的后n个字符
SELECT RIGHT('你好啊',2);
-- LPAD(s1,len,s2) //字符串s2来填充s1的开始处，使字符串长度达到len
SELECT LPAD('123456',10,'0');
-- RPAD(s1,len,s2) //字符串s2来填充s1的结尾处，使字符串的长度达到len
SELECT RPAD('123',6,'x');
-- LTRIM(s) //去掉字符串s开始处的空格
SELECT LTRIM('    hello world');
-- RTRIM(s) //去掉字符串s结尾处的空格
SELECT RTRIM('hello world    ');
-- TRIM(s) //去掉字符串s开始和结尾处的空格
SELECT TRIM(' hello world ');
SELECT TRIM('@' FROM '@@hello@world@@');
SELECT TRIM(',' FROM REPEAT('acb,',3));
-- REPEAT(s,n) // 将字符串s重复n次
SELECT REPEAT('acb,',3);
-- SPACE(n) //返回n个空格
SELECT SPACE(3);
SELECT CONCAT('a',SPACE(3),'b')
-- REPLACE(s,s1,s2) //将字符串s2替代字符串s中的字符串s1
SELECT REPLACE('hello world','world','mysql');
-- STRCMP(s1,s2) //比较字符串s1和s2
SELECT STRCMP('aa','bb');
-- SUBSTRING(s,n,len) //获取从字符串s中的第n个位置开始长度为len的字符串
SELECT SUBSTRING('hello world' FROM 3 FOR 5);
-- MID(s,n,len) //同SUBSTRING(s,n,len)
SELECT MID('hello world',3,5);
-- LOCATE(s1,s),POSITION(s1 IN s) //从字符串s中获取s1的开始位置
SELECT POSITION('world' in 'hello world');
SELECT POSITION('world' in 'hello mysql');
SELECT LOCATE('world','hello world');
-- INSTR(s,s1) //从字符串s中获取s1的开始位置
SELECT INSTR('hello','l');
-- REVERSE(s) //将字符串s的顺序反过来
SELECT REVERSE('abc');
-- ELT(n,s1,s2,...) //返回第n个字符串
SELECT ELT(4,'a','b','c','d');
-- EXPORT_SET(x,s1,s2) 
-- 返回一个字符串，在这里对于在“bits”中设定每一位，你得到一个“on”字符串，并且对于每个复位(reset)的位，你得到一个 “off”字符串。每个字符串用“separator”分隔(缺省“,”)，并且只有“bits”的“number_of_bits” (缺省64)位被使用
SELECT EXPORT_SET(4,'Y','N',',',4);
-- FIELD(s,s1,s2...) //返回第一个与字符串s匹配的字符串位置
SELECT FIELD('c','a','b','c');
-- FIND_IN_SET(s1,s2) //返回在字符串s2中与s1匹配的字符串的位置
SELECT FIND_IN_SET('c','a,c,b');
-- MAKE_SET(x,s1,s2) //返回一个集合 (包含由“,”字符分隔的子串组成的一个 字符串)，由相应的位在bits集合中的的字符串组成。str1对应于位0，str2对 应位1，等等。
-- 1|4 = 0001 | 0100 = 0101 ,倒过来排序，为1010
-- 1|5 = 0001 | 0101 = 0101, 取反1010
SELECT MAKE_SET(1|5,'a','b','c','d');
/**
SUBSTRING_INDEX 
返回从字符串str的第count个出现的分隔符delim之后的子串。
如果count是正数，返回第count个字符左边的字符串。
如果count是负数，返回第(count的绝对值(从右边数))个字符右边的字符串。
*/
SELECT SUBSTRING_INDEX('a,b,c@d','@',-1);
SELECT SUBSTRING_INDEX(SUBSTRING_INDEX('a*b*c*d*e','*',3),'*',-1)
/**
LOAD_FILE(file_name)
读入文件并且作为一个字符串返回文件内容。文件必须在服务器上，你必须指定到文件的完整路径名，而且你必须有file权 限。
文件必须所有内容都是可读的并且小于max_allowed_packet。 如果文件不存在或由于上面原因之一不能被读出，函数返回NULL。
*/
LOAD_FILE('http://10.1.1.98/MagicLink/dist/magiclink-tool.js');


#三.日期时间函数
-- CURDATE(),CURRENT_DATE() //返回当前日期
SELECT CURDATE();
-- CURTIME(),CURRENT_TIME //返回当前时间
SELECT CURTIME();
-- NOW(),CURRENT_TIMESTAMP(),LOCALTIME(),SYSDATE(),LOCALTIMESTAMP() //返回当前日期和时间
SELECT NOW();
SELECT CURRENT_TIME();
-- UNIX_TIMESTAMP() //以UNIX时间戳的形式返回当前时间
SELECT UNIX_TIMESTAMP();
-- UNIX_TIMESTAMP(d) //将时间d以UNIX时间戳的形式返回
SELECT UNIX_TIMESTAMP('2017-12-15 12:10:20');
-- FROM_UNIXTIME(d) //将UNIX时间戳的时间转换为普通格式的时间
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP('2017-12-15 12:10:20'));
-- UTC_DATE() //返回UTC日期
SELECT UTC_DATE();
-- UTC_TIME() //返回UTC时间
SELECT UTC_TIME();
-- MONTH(d) //返回日期d中的月份值，1->12
SELECT MONTH('2017-10-11');
-- MONTHNAME(d) //返回日期当中的月份名称，如Janyary
SELECT MONTHNAME('2017-12-01');
-- DAYNAME(d) //返回日期d是星期几，如Monday,Tuesday
SELECT DAYNAME('2017-12-01');
-- DAYOFWEEK(d) //日期d今天是星期几，1星期日，2星期一
SELECT DAYOFWEEK('2017-12-01');
-- WEEKDAY(d) //日期d今天是星期几,0表示星期一，1表示星期二
SELECT WEEKDAY('2017-12-01');
-- WEEK(d)，WEEKOFYEAR(d) //计算日期d是本年的第几个星期，范围是0->53
SELECT WEEK('2017-11-11 11:11:11')
-- DAYOFYEAR(d) //计算日期d是本年的第几天
SELECT DAYOFYEAR('2017-12-01');
-- DAYOFMONTH(d) //计算日期d是本月的第几天
SELECT DAYOFMONTH('2017-12-01');
-- QUARTER(d) //返回日期d是第几季节，返回1->4
SELECT QUARTER('2017-12-01');
-- HOUR(t) //返回t中的小时值
SELECT HOUR('12:35:22');
-- MINUTE(t) //返回t中的分钟值
SELECT MINUTE('12:35:22');
-- SECOND(t) //返回t中的秒钟值
SELECT SECOND('12:45:20');
-- EXTRACT(type FROM d) //从日期d中获取指定的值，type指定返回的值
SELECT EXTRACT(MINUTE FROM '2017-11-11 11:11:11');
SELECT EXTRACT(DAY FROM '2017-11-22 12:11:11');
-- TIME_TO_SEC(t) //将时间t转换为秒
SELECT TIME_TO_SEC('2:12:00');
-- SEC_TO_TIME(s) //将以秒为单位的时间s转换为时分秒的格式
SELECT SEC_TO_TIME(TIME_TO_SEC('1:20:00'));
-- TO_DAYS(d) //计算日期d距离0000年1月1日的天数
SELECT TO_DAYS('2017-12-15');
-- FROM_DAYS(n) //计算从0000年1月1日开始n天后的日期
SELECT FROM_DAYS(TO_DAYS('2017-12-15'));
-- DATEDIFF(d1,d2) //计算日期d1->d2之间相隔的天数
SELECT DATEDIFF('2017-12-15','2017-12-17');
-- ADDDATE(d,n) //计算其实日期d加上n天的日期
SELECT ADDDATE('2017-12-15',12);
-- ADDDATE(d，INTERVAL expr type) //计算起始日期d加上一个时间段后的日期
SELECT ADDDATE('2017-12-15 12:14:00',INTERVAL 6 MINUTE);
-- DATE_ADD(d,INTERVAL expr type) //
SELECT DATE_ADD('2017-12-15 12:14:00',INTERVAL 6 MINUTE);
-- SUBDATE(d,n) //日期d减去n天后的日期
SELECT SUBDATE('2017-12-15',INTERVAL 2 DAY);
-- ADDTIME(t,n) //时间t加上n秒的时间
SELECT ADDTIME('1:12:00',5);
-- SUBTIME(t,n) //时间t减去n秒的时间
SELECT SUBTIME('1:12:00',5);
-- DATE_FORMAT(d,f) //按表达式f的要求显示日期d
SELECT DATE_FORMAT(NOW(),'%Y-%m-%d %r');
-- TIME_FORMAT(t,f) //按表达式f的要求显示时间t
SELECT TIME_FORMAT(TIME(NOW()),'%r');
-- GET_FORMAT(type,s) //获得国家地区时间格式函数
SELECT GET_FORMAT('%m.%d.%Y', 'USA');
-- //
-- //
-- //
-- //
-- //
