-- =====================================================
-- [Thực hành] Truyền tham số vào Store Procedure
-- CSDL: classicmodels
-- =====================================================
USE classicmodels;

-- -----------------------------------------------------
-- PHẦN 1: Tham số loại IN (mặc định)
-- Lấy thông tin khách hàng theo customerNumber
-- -----------------------------------------------------
DELIMITER //

CREATE PROCEDURE getCusById(IN cusNum INT)
BEGIN
    SELECT * FROM customers
    WHERE customerNumber = cusNum;
END //

DELIMITER ;

-- Gọi procedure với tham số IN
CALL getCusById(175);

-- -----------------------------------------------------
-- PHẦN 2: Tham số loại OUT
-- Đếm số khách hàng theo thành phố, trả kết quả ra biến @total
-- -----------------------------------------------------
DELIMITER //

CREATE PROCEDURE GetCustomersCountByCity(
    IN  in_city VARCHAR(50),
    OUT total   INT
)
BEGIN
    SELECT COUNT(customerNumber)
    INTO total
    FROM customers
    WHERE city = in_city;
END //

DELIMITER ;

-- Gọi procedure với tham số IN và OUT
CALL GetCustomersCountByCity('Lyon', @total);
SELECT @total;

-- -----------------------------------------------------
-- PHẦN 3: Tham số loại INOUT
-- Cộng dồn giá trị counter
-- -----------------------------------------------------
DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN    inc     INT
)
BEGIN
    SET counter = counter + inc;
END //

DELIMITER ;

-- Gọi procedure với tham số INOUT
SET @counter = 1;
CALL SetCounter(@counter, 1);   -- 2
CALL SetCounter(@counter, 1);   -- 3
CALL SetCounter(@counter, 5);   -- 8
SELECT @counter;                -- 8

-- -----------------------------------------------------
-- Dọn dẹp (tùy chọn)
-- -----------------------------------------------------
DROP PROCEDURE IF EXISTS getCusById;
DROP PROCEDURE IF EXISTS GetCustomersCountByCity;
DROP PROCEDURE IF EXISTS SetCounter;
