CREATE TABLE `brand` (
  `brand_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `logo_url` varchar(255),
  `description` text
);

CREATE TABLE `product_category` (
  `category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` text,
  `parent_category_id` integer
);

CREATE TABLE `color` (
  `color_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `hex_code` varchar(255) NOT NULL
);

CREATE TABLE `size_category` (
  `size_category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` varchar(255)
);

CREATE TABLE `size_option` (
  `size_id` integer PRIMARY KEY,
  `size_category_id` integer NOT NULL,
  `name` varchar(255) NOT NULL,
  `measurement` varchar(255)
);

CREATE TABLE `attribute_category` (
  `attribute_category_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `description` varchar(255)
);

CREATE TABLE `attribute_type` (
  `attribute_type_id` integer PRIMARY KEY,
  `name` varchar(255) NOT NULL,
  `data_type` varchar(255) NOT NULL
);

CREATE TABLE `product` (
  `product_id` integer PRIMARY KEY,
  `category_id` integer NOT NULL,
  `brand_id` integer NOT NULL,
  `name` varchar(255) NOT NULL,
  `base_price` decimal NOT NULL,
  `description` text,
  `created_at` timestamp,
  `updated_at` timestamp
);

CREATE TABLE `product_item` (
  `item_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `price` decimal NOT NULL,
  `SKU` varchar(255) UNIQUE NOT NULL,
  `quantity_in_stock` integer NOT NULL DEFAULT 0
);

CREATE TABLE `product_attribute` (
  `attribute_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `attribute_category_id` integer NOT NULL,
  `attribute_type_id` integer NOT NULL,
  `attribute_value` text NOT NULL
);

CREATE TABLE `product_variation` (
  `variation_id` integer PRIMARY KEY,
  `product_id` integer NOT NULL,
  `item_id` integer NOT NULL,
  `size_id` integer,
  `color_id` integer
);

CREATE TABLE `product_image` (
  `image_id` integer PRIMARY KEY,
  `product_id` integer,
  `item_id` integer,
  `url` varchar(255) NOT NULL,
  `alt_text` varchar(255),
  `display_order` integer DEFAULT 0
);

ALTER TABLE `product_category` ADD FOREIGN KEY (`parent_category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`category_id`) REFERENCES `product_category` (`category_id`);

ALTER TABLE `product` ADD FOREIGN KEY (`brand_id`) REFERENCES `brand` (`brand_id`);

ALTER TABLE `product_item` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `size_option` ADD FOREIGN KEY (`size_category_id`) REFERENCES `size_category` (`size_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_category_id`) REFERENCES `attribute_category` (`attribute_category_id`);

ALTER TABLE `product_attribute` ADD FOREIGN KEY (`attribute_type_id`) REFERENCES `attribute_type` (`attribute_type_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`item_id`) REFERENCES `product_item` (`item_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`size_id`) REFERENCES `size_option` (`size_id`);

ALTER TABLE `product_variation` ADD FOREIGN KEY (`color_id`) REFERENCES `color` (`color_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`);

ALTER TABLE `product_image` ADD FOREIGN KEY (`item_id`) REFERENCES `product_item` (`item_id`);
