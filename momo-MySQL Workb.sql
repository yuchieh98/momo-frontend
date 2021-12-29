-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema moshop
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema moshop
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `moshop` DEFAULT CHARACTER SET utf8 ;
USE `moshop` ;

-- -----------------------------------------------------
-- Table `moshop`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moshop`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `account` VARCHAR(40) NULL COMMENT '帳號\n',
  `password` VARCHAR(45) NULL COMMENT '密碼\n',
  `gender` VARCHAR(20) NULL COMMENT '性別\n',
  `email` VARCHAR(50) NULL,
  `birthday` DATE NULL COMMENT '生日',
  `phone` INT NULL COMMENT '電話',
  `address` VARCHAR(80) NULL COMMENT '通訊地址',
  `username` VARCHAR(45) NULL COMMENT '使用者名稱',
  `userphoto` VARCHAR(45) NULL COMMENT '使用者照片',
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moshop`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moshop`.`orders` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `total` INT NULL COMMENT '總金額',
  `shipping` VARCHAR(100) NULL COMMENT '運送方式',
  `payment` VARCHAR(20) NULL COMMENT '付款方式',
  `status` VARCHAR(20) NULL COMMENT '訂單狀態',
  `shippingadd` VARCHAR(45) NULL COMMENT '運送地址',
  `setuptime` DATETIME NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
  `userid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_orders_user1_idx` (`userid` ASC),
  CONSTRAINT `fk_orders_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `moshop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moshop`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moshop`.`products` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL COMMENT '名稱',
  `price` INT NULL COMMENT '金額',
  `stock` INT NULL COMMENT '庫存',
  `description` TEXT NULL COMMENT '商品描述',
  `category` VARCHAR(50) NULL COMMENT '分類',
  `userid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_products_user1_idx` (`userid` ASC),
  CONSTRAINT `fk_products_user1`
    FOREIGN KEY (`userid`)
    REFERENCES `moshop`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moshop`.`productpic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moshop`.`productpic` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `picname` BLOB NULL COMMENT '產品相片',
  `productsid` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_productpic_products1_idx` (`productsid` ASC),
  CONSTRAINT `fk_productpic_products1`
    FOREIGN KEY (`productsid`)
    REFERENCES `moshop`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `moshop`.`products_has_orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `moshop`.`products_has_orders` (
  `productsid` INT NOT NULL,
  `ordersid` INT NOT NULL,
  PRIMARY KEY (`productsid`, `ordersid`),
  INDEX `fk_products_has_orders_orders1_idx` (`ordersid` ASC),
  INDEX `fk_products_has_orders_products1_idx` (`productsid` ASC),
  CONSTRAINT `fk_products_has_orders_products1`
    FOREIGN KEY (`productsid`)
    REFERENCES `moshop`.`products` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_products_has_orders_orders1`
    FOREIGN KEY (`ordersid`)
    REFERENCES `moshop`.`orders` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;