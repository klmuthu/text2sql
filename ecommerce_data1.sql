
/*
-- Create indexes for better performance
CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_sku ON products(sku);
CREATE INDEX idx_products_active ON products(is_active);
CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(order_status);
CREATE INDEX idx_reviews_product ON reviews(product_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_categories_parent ON categories(parent_category_id);

-- Create vector index for semantic search on review comments
CREATE INDEX idx_reviews_embedding ON reviews USING ivfflat (comment_embedding vector_cosine_ops) WITH (lists = 100);
*/

-- Insert sample data
-- Users
INSERT INTO users (email, username, password_hash, first_name, last_name, phone_number, date_of_birth, gender) VALUES
('john.doe@email.com', 'johndoe', '$2a$10$X7R3J4K5L6M8N9P0Q2S4T6', 'John', 'Doe', '+1-555-0101', '1985-03-15', 'male'),
('jane.smith@email.com', 'janesmith', '$2a$10$A1B2C3D4E5F6G7H8I9J0K1', 'Jane', 'Smith', '+1-555-0102', '1990-07-22', 'female'),
('mike.johnson@email.com', 'mikej', '$2a$10$L2M3N4O5P6Q7R8S9T0U1V2', 'Mike', 'Johnson', '+1-555-0103', '1988-11-30', 'male'),
('sarah.williams@email.com', 'sarahw', '$2a$10$W3X4Y5Z6A7B8C9D0E1F2G3', 'Sarah', 'Williams', '+1-555-0104', '1992-04-18', 'female'),
('david.brown@email.com', 'davidb', '$2a$10$H4I5J6K7L8M9N0O1P2Q3R4', 'David', 'Brown', '+1-555-0105', '1987-09-05', 'male'),
('emily.davis@email.com', 'emilyd', '$2a$10$S5T6U7V8W9X0Y1Z2A3B4C5', 'Emily', 'Davis', '+1-555-0106', '1993-12-10', 'female'),
('robert.miller@email.com', 'robertm', '$2a$10$D6E7F8G9H0I1J2K3L4M5N6', 'Robert', 'Miller', '+1-555-0107', '1986-06-25', 'male'),
('lisa.wilson@email.com', 'lisaw', '$2a$10$O7P8Q9R0S1T2U3V4W5X6Y7', 'Lisa', 'Wilson', '+1-555-0108', '1991-02-14', 'female'),
('james.moore@email.com', 'jamesm', '$2a$10$Z8A9B0C1D2E3F4G5H6I7J8', 'James', 'Moore', '+1-555-0109', '1989-08-30', 'male'),
('maria.garcia@email.com', 'mariag', '$2a$10$K9L0M1N2O3P4Q5R6S7T8U9', 'Maria', 'Garcia', '+1-555-0110', '1994-05-20', 'female'),
('kevin.lee@email.com', 'kevinl', '$2a$10$V0W1X2Y3Z4A5B6C7D8E9F0', 'Kevin', 'Lee', '+1-555-0111', '1988-10-15', 'male'),
('nancy.clark@email.com', 'nancyc', '$2a$10$G1H2I3J4K5L6M7N8O9P0Q1', 'Nancy', 'Clark', '+1-555-0112', '1990-03-28', 'female'),
('brian.hall@email.com', 'brianh', '$2a$10$R2S3T4U5V6W7X8Y9Z0A1B2', 'Brian', 'Hall', '+1-555-0113', '1987-11-08', 'male'),
('amanda.white@email.com', 'amandaw', '$2a$10$C3D4E5F6G7H8I9J0K1L2M3', 'Amanda', 'White', '+1-555-0114', '1992-07-12', 'female'),
('steven.martin@email.com', 'stevenm', '$2a$10$N4O5P6Q7R8S9T0U1V2W3X4', 'Steven', 'Martin', '+1-555-0115', '1985-09-18', 'male');

-- Categories
INSERT INTO categories (name, slug, description, parent_category_id) VALUES
('Electronics', 'electronics', 'Electronic devices and accessories', NULL),
('Computers & Tablets', 'computers-tablets', 'Desktop computers, laptops, and tablets', 1),
('Smartphones', 'smartphones', 'Mobile phones and accessories', 1),
('Home & Kitchen', 'home-kitchen', 'Home appliances and kitchen items', NULL),
('Books', 'books', 'Physical and digital books', NULL),
('Clothing', 'clothing', 'Men''s and women''s apparel', NULL),
('Sports & Outdoors', 'sports-outdoors', 'Sporting goods and outdoor equipment', NULL),
('Toys & Games', 'toys-games', 'Children''s toys and games', NULL);

-- Shipping Methods
INSERT INTO shipping_methods (name, code, description, base_cost, cost_per_kg, estimated_days_min, estimated_days_max) VALUES
('Standard Shipping', 'standard', 'Economy shipping option', 5.99, 0.50, 5, 7),
('Express Shipping', 'express', 'Faster delivery option', 12.99, 1.00, 2, 3),
('Overnight Shipping', 'overnight', 'Next business day delivery', 29.99, 2.00, 1, 1),
('Free Shipping', 'free', 'Free shipping on qualifying orders', 0.00, 0.00, 7, 10);

-- Promotions
INSERT INTO promotions (code, name, description, discount_type, discount_value, minimum_purchase_amount, start_date, end_date) VALUES
('WELCOME10', 'Welcome Discount', 'Get 10% off your first order', 'percentage', 10.00, 50.00, '2024-01-01', '2024-12-31'),
('SUMMER25', 'Summer Sale', 'Save $25 on orders over $100', 'fixed_amount', 25.00, 100.00, '2024-06-01', '2024-08-31'),
('FREESHIP', 'Free Shipping', 'Free shipping on all orders', 'fixed_amount', 0.00, 0.00, '2024-01-01', '2024-12-31');

-- Products
INSERT INTO products (sku, name, slug, description, short_description, category_id, brand, price, stock_quantity, weight_kg) VALUES
('LAPTOP-001', 'UltraBook Pro 15', 'ultrabook-pro-15', 
'The UltraBook Pro 15 is a powerhouse designed for professionals who demand the best. Featuring a stunning 15.6-inch 4K OLED display with 100% DCI-P3 color gamut, this laptop delivers breathtaking visuals for creative work and entertainment. Under the hood, the latest 12th Gen Intel Core i7 processor paired with 32GB of lightning-fast DDR5 RAM ensures smooth multitasking and blazing performance. The dedicated NVIDIA RTX 3070 graphics card handles intensive tasks like video editing, 3D rendering, and gaming with ease. With a massive 1TB NVMe SSD, you''ll have plenty of space for all your files while enjoying near-instantaneous boot times and application launches. The precision-engineered aluminum chassis is both durable and elegant, weighing just 1.8kg for ultimate portability. The backlit keyboard offers comfortable typing even in low-light conditions, while the large precision touchpad supports multi-touch gestures. With up to 10 hours of battery life and fast charging capabilities, you can work all day without being tethered to an outlet. Thunderbolt 4 ports provide versatile connectivity options for external displays and high-speed data transfer.',
'High-performance laptop with 4K display and dedicated graphics', 2, 'TechBrand', 1299.99, 25, 1.8),

('PHONE-001', 'SmartPhone X Pro', 'smartphone-x-pro',
'Experience the future of mobile technology with the SmartPhone X Pro. This flagship device redefines what a smartphone can be, featuring a gorgeous 6.7-inch Super AMOLED display with 120Hz refresh rate for buttery-smooth scrolling and responsive gaming. The revolutionary camera system includes a 108MP main sensor with optical image stabilization, a 12MP ultra-wide lens, and a 10MP telephoto lens with 3x optical zoom, allowing you to capture professional-quality photos and 8K videos. Powered by the latest Snapdragon processor and 12GB of RAM, every app launches instantly and multitasking is effortless. The 256GB of storage provides ample space for your photos, videos, and apps, with the option to expand via microSD. The 5000mAh battery easily lasts all day, and with 65W fast charging, you can go from 0 to 50% in just 15 minutes. 5G connectivity ensures blazing-fast download speeds wherever supported. The in-display fingerprint sensor and face recognition provide secure and convenient unlocking. With IP68 water resistance, wireless charging, and reverse wireless charging capabilities, this phone is ready for anything.',
'Latest flagship smartphone with advanced camera system', 3, 'PhoneCorp', 999.99, 50, 0.195),

('BLENDER-001', 'PowerBlend 3000', 'powerblend-3000',
'Transform your kitchen experience with the PowerBlend 3000, the ultimate blending solution for health-conscious individuals and culinary enthusiasts. This professional-grade blender features a powerful 1500W motor that can pulverize even the toughest ingredients, from frozen fruits to nuts and ice. The patented 6-blade system creates a vortex that ensures perfect blending every time, whether you''re making smoothies, soups, nut butters, or frozen desserts. The large 2-liter BPA-free Tritan container is virtually unbreakable and dishwasher safe. With 10 preset programs including smoothie, ice crush, soup, and cleaning modes, achieving perfect results is as simple as pressing a button. The variable speed control allows for precise texture control, while the pulse function gives you complete control over chunky salsas and dips. The noise-reduction design keeps operation quieter than comparable blenders. Safety features include automatic shut-off and overload protection. The sleek stainless steel base will complement any kitchen decor. Includes a tamper tool and recipe book with over 100 healthy recipes.',
'High-performance blender with multiple preset programs', 4, 'KitchenMaster', 149.99, 35, 4.2),

('BOOK-001', 'The Art of Coding', 'art-of-coding',
'Dive deep into the world of programming with "The Art of Coding," a comprehensive guide that takes you from beginner to advanced developer. This 800-page masterpiece covers everything from basic programming concepts to advanced algorithms and design patterns. Written by industry veterans with over 20 years of experience, this book uses a hands-on approach with real-world examples and projects. Each chapter includes exercises and challenges to reinforce your learning. Topics covered include: fundamental programming concepts, data structures and algorithms, object-oriented programming, functional programming paradigms, web development with modern frameworks, mobile app development, database design and optimization, cloud computing and microservices, machine learning basics, and software engineering best practices. The book uses multiple programming languages including Python, JavaScript, Java, and Go to illustrate concepts. QR codes throughout the book link to video tutorials and additional online resources. Whether you''re a complete beginner or an experienced developer looking to expand your skills, this book will become your go-to reference.',
'Comprehensive programming guide for all skill levels', 5, 'TechBooks Publishing', 49.99, 100, 1.2),

('JACKET-001', 'All-Weather Jacket Pro', 'all-weather-jacket-pro',
'Stay comfortable in any condition with the All-Weather Jacket Pro, engineered for outdoor enthusiasts who refuse to let weather dictate their adventures. This versatile jacket features a 3-layer waterproof and breathable membrane that keeps you dry while allowing moisture to escape, preventing that clammy feeling during high-intensity activities. The fully seam-sealed construction ensures no water gets through, while the adjustable storm hood provides additional protection. YKK AquaGuard zippers throughout prevent water ingress while maintaining smooth operation. The jacket includes pit zips for rapid ventilation during strenuous activities. Multiple pockets include two hand warmer pockets, a chest pocket with media port, and an internal security pocket for valuables. The articulated sleeves and athletic fit allow for full range of motion without excess bulk. Reflective elements enhance visibility in low-light conditions. The jacket packs into its own pocket for easy storage and transport. Available in men''s and women''s specific fits with sizes from XS to 3XL. Perfect for hiking, camping, cycling, or everyday wear.',
'Waterproof breathable jacket for all weather conditions', 6, 'OutdoorGear', 199.99, 40, 0.450);

-- More products to reach interesting data volume
INSERT INTO products (sku, name, slug, description, short_description, category_id, brand, price, stock_quantity, weight_kg) VALUES
('TABLET-001', 'TabMax Pro 12', 'tabmax-pro-12',
'The TabMax Pro 12 redefines what a tablet can do, bridging the gap between tablet convenience and laptop productivity. Featuring a stunning 12.9-inch Liquid Retina XDR display with ProMotion technology, every image comes to life with incredible detail and smooth motion. The powerful M2 chip delivers desktop-class performance, handling everything from 4K video editing to complex 3D modeling. With 8GB of RAM and 256GB of storage, multitasking is effortless. The advanced camera system includes a 12MP wide camera and a 10MP ultra-wide camera with Center Stage, perfect for video calls and content creation. The LiDAR scanner enables enhanced AR experiences and faster autofocus. All-day battery life keeps you productive, while the USB-C port with Thunderbolt support provides versatile connectivity. Compatible with the Smart Keyboard and Precision Stylus for a complete productivity setup.',
'Professional tablet with laptop-class performance', 2, 'TabTech', 899.99, 30, 0.682),

('HEADPHONES-001', 'SoundWave Pro', 'soundwave-pro',
'Immerse yourself in pure audio bliss with the SoundWave Pro wireless headphones. Featuring industry-leading active noise cancellation, these headphones create a personal oasis of sound wherever you go. The custom 40mm drivers deliver rich, balanced audio across all frequencies, from deep bass to crystal-clear highs. With 30 hours of battery life and quick charge capability, your music never stops. The premium memory foam ear cushions and adjustable headband ensure all-day comfort. Bluetooth 5.2 provides stable connectivity with support for high-resolution audio codecs. The intuitive touch controls let you manage playback, calls, and noise cancellation with simple gestures. Includes a premium carrying case and audio cable for wired listening.',
'Premium wireless headphones with active noise cancellation', 1, 'AudioTech', 349.99, 60, 0.285),

('TENT-001', 'Explorer 4-Season Tent', 'explorer-4-season-tent',
'Built for extreme conditions, the Explorer 4-Season Tent is your reliable shelter in the harshest environments. The geodesic dome design with aerospace-grade aluminum poles provides exceptional stability in high winds and heavy snow loads. The double-wall construction with full-coverage fly ensures complete weather protection while minimizing condensation. The bathtub floor design with welded seams keeps you dry even in standing water. Two vestibules provide ample gear storage, while multiple interior pockets keep essentials organized. The color-coded pole system makes setup quick and intuitive, even in challenging conditions. Accommodates 2-3 people comfortably with room for gear.',
'Professional-grade tent for extreme weather conditions', 7, 'CampPro', 499.99, 15, 3.8),

('DRONE-001', 'SkyMaster 4K', 'skymaster-4k',
'Capture breathtaking aerial footage with the SkyMaster 4K drone. The gimbal-stabilized 4K camera shoots stunning video at 60fps and captures 20MP stills with incredible detail. Intelligent flight modes including ActiveTrack, Point of Interest, and Waypoints make professional shots easy. The foldable design and included carrying case make it perfect for travel. With 30 minutes of flight time and a 7km transmission range, you can explore further than ever. Obstacle avoidance sensors on all sides ensure safe flight, while Return-to-Home functionality brings your drone back automatically. The intuitive smartphone app provides live HD video feed and complete control over camera settings.',
'Professional drone with 4K camera and intelligent flight modes', 1, 'AeroTech', 799.99, 20, 1.2),

('BOARDGAME-001', 'Quest for the Crystal Kingdom', 'quest-crystal-kingdom',
'Embark on an epic adventure with Quest for the Crystal Kingdom, a strategic board game for 2-6 players. This beautifully illustrated game combines resource management, tactical combat, and cooperative storytelling. Each player chooses a unique hero with special abilities and embarks on quests to save the kingdom from darkness. The modular board ensures every game is different, while the branching storyline provides hours of replayability. Includes over 200 detailed miniatures, 500+ cards, custom dice, and a comprehensive rulebook. The campaign mode allows your characters to level up and acquire new abilities across multiple sessions. Perfect for game nights with friends and family.',
'Epic adventure board game with miniatures and campaign mode', 8, 'GameCraft', 89.99, 45, 2.5),

('COFFEE-001', 'BrewMaster Pro', 'brewmaster-pro',
'Wake up to barista-quality coffee every morning with the BrewMaster Pro. This fully automatic espresso machine features a built-in conical burr grinder with 15 grind settings, ensuring the perfect extraction every time. The dual boiler system allows simultaneous brewing and steaming, while the PID temperature control maintains optimal brewing temperature. Create your favorite drinks with one touch - from espresso to cappuccino to flat white. The automatic milk frother creates silky microfoam for perfect latte art. The machine learns your preferences and can store up to 8 user profiles. The large water reservoir and bean hopper mean less refilling, while the automatic cleaning cycle keeps maintenance simple. The sleek touchscreen interface provides intuitive control and real-time brewing parameters.',
'Professional espresso machine with built-in grinder', 4, 'CoffeeTech', 1299.00, 15, 12.5),

('WATCH-001', 'FitTrack Ultra', 'fittrack-ultra',
'The FitTrack Ultra is more than a smartwatch - it''s your personal health and fitness companion. Featuring advanced health monitoring including ECG, blood oxygen, and continuous heart rate tracking, it provides comprehensive insights into your wellbeing. The always-on AMOLED display is bright and responsive, while the 7-day battery life means you can track your health without constant charging. With built-in GPS and support for 100+ workout modes, it accurately tracks your activities from running to swimming to yoga. Sleep tracking with sleep stages helps optimize your rest. Smart features include notifications, contactless payments, music storage, and voice assistant integration. The titanium case and sapphire crystal ensure durability for any adventure.',
'Advanced fitness smartwatch with health monitoring', 1, 'FitTech', 449.99, 75, 0.065),

('CAMERA-001', 'ProShot X1', 'proshot-x1',
'Capture life in stunning detail with the ProShot X1 mirrorless camera. The 45MP full-frame sensor delivers exceptional image quality with incredible dynamic range and low-light performance. The advanced autofocus system with 759 phase-detection points ensures sharp focus even on fast-moving subjects. 8K video recording at 30fps and 4K at 120fps opens up creative possibilities for videographers. The 5-axis in-body image stabilization provides up to 7 stops of shake correction. The weather-sealed magnesium alloy body is built to withstand professional use. Dual memory card slots provide backup and overflow options. The high-resolution EVF and tilting touchscreen make composition effortless. With built-in Wi-Fi and Bluetooth, sharing and remote control are seamless.',
'Professional mirrorless camera with 45MP sensor', 1, 'PhotoPro', 2499.99, 10, 0.850),

('SPEAKER-001', 'SoundBlast 360', 'soundblast-360',
'Experience room-filling 360-degree sound with the SoundBlast 360 wireless speaker. The innovative acoustic design with dual passive radiators delivers deep bass and crystal-clear highs that fill any space. With 20 hours of battery life and IPX7 waterproofing, it''s perfect for pool parties, beach trips, or camping adventures. PartyBoost technology lets you connect multiple speakers for an even bigger sound. The built-in power bank can charge your devices on the go. Customizable LED light show syncs with your music for added ambiance. Voice assistant integration and hands-free calling make it more than just a speaker. The rugged fabric and rubber construction can handle drops and bumps.',
'Portable wireless speaker with 360-degree sound', 1, 'AudioBlast', 149.99, 90, 0.960);

-- Product Images
INSERT INTO product_images (product_id, image_url, alt_text, is_primary, sort_order) VALUES
(1, 'https://example.com/images/laptop-001-main.jpg', 'UltraBook Pro 15 front view', true, 1),
(1, 'https://example.com/images/laptop-001-side.jpg', 'UltraBook Pro 15 side view', false, 2),
(2, 'https://example.com/images/phone-001-main.jpg', 'SmartPhone X Pro front view', true, 1),
(2, 'https://example.com/images/phone-001-back.jpg', 'SmartPhone X Pro back view', false, 2),
(3, 'https://example.com/images/blender-001-main.jpg', 'PowerBlend 3000', true, 1),
(4, 'https://example.com/images/book-001-cover.jpg', 'The Art of Coding book cover', true, 1),
(5, 'https://example.com/images/jacket-001-main.jpg', 'All-Weather Jacket Pro', true, 1);

-- Addresses
INSERT INTO addresses (user_id, address_type, is_default, first_name, last_name, address_line1, city, state_province, postal_code, country_code) VALUES
(1, 'shipping', true, 'John', 'Doe', '123 Main Street', 'New York', 'NY', '10001', 'US'),
(1, 'billing', true, 'John', 'Doe', '123 Main Street', 'New York', 'NY', '10001', 'US'),
(2, 'shipping', true, 'Jane', 'Smith', '456 Oak Avenue', 'Los Angeles', 'CA', '90001', 'US'),
(3, 'shipping', true, 'Mike', 'Johnson', '789 Pine Road', 'Chicago', 'IL', '60601', 'US'),
(4, 'shipping', true, 'Sarah', 'Williams', '321 Elm Street', 'Houston', 'TX', '77001', 'US');

-- Payment Methods
INSERT INTO payment_methods (user_id, payment_type, is_default, card_brand, card_last_four, card_holder_name, expiry_month, expiry_year, billing_address_id) VALUES
(1, 'credit_card', true, 'Visa', '1234', 'John Doe', 12, 2025, 2),
(2, 'credit_card', true, 'Mastercard', '5678', 'Jane Smith', 6, 2026, 3),
(3, 'debit_card', true, 'Visa', '9012', 'Mike Johnson', 9, 2025, 4),
(4, 'credit_card', true, 'Amex', '3456', 'Sarah Williams', 3, 2027, 5);

-- Orders
INSERT INTO orders (order_number, user_id, order_status, payment_status, shipping_address_id, billing_address_id, payment_method_id, shipping_method_id, subtotal, tax_amount, shipping_cost, total_amount) VALUES
('ORD-2024-001', 1, 'delivered', 'paid', 1, 2, 1, 1, 1299.99, 103.99, 5.99, 1409.97),
('ORD-2024-002', 2, 'shipped', 'paid', 3, 3, 2, 2, 999.99, 79.99, 12.99, 1092.97),
('ORD-2024-003', 3, 'processing', 'paid', 4, 4, 3, 1, 149.99, 11.99, 5.99, 167.97),
('ORD-2024-004', 4, 'delivered', 'paid', 5, 5, 4, 3, 249.98, 19.99, 29.99, 299.96);

-- Order Items
INSERT INTO order_items (order_id, product_id, quantity, unit_price, total_price) VALUES
(1, 1, 1, 1299.99, 1299.99),
(2, 2, 1, 999.99, 999.99),
(3, 3, 1, 149.99, 149.99),
(4, 4, 2, 49.99, 99.98),
(4, 5, 1, 149.99, 149.99);

-- Reviews with detailed comments (50 reviews with semantic patterns)
INSERT INTO reviews (product_id, user_id, order_id, rating, title, comment, pros, cons, is_verified_purchase, status) VALUES
-- Laptop reviews (product_id: 1) - Performance and battery life theme
(1, 1, 1, 5, 'Best laptop I''ve ever owned!',
'I''ve been using the UltraBook Pro 15 for three months now, and it has exceeded all my expectations. As a software developer and part-time content creator, I needed a machine that could handle heavy development environments, video editing, and occasional gaming. This laptop delivers on all fronts. The 4K OLED display is absolutely stunning - colors are vibrant and accurate, making photo and video editing a joy. The keyboard has excellent travel and tactile feedback, which is crucial for long coding sessions. Battery life is impressive considering the powerful hardware; I easily get 8-9 hours with mixed usage. The build quality is exceptional - the aluminum chassis feels premium and sturdy. Performance-wise, compiling large projects is blazingly fast, and I can run multiple Docker containers without any slowdown. The RTX 3070 handles my video rendering tasks efficiently and even runs modern games at high settings. The only minor complaint is that it can get warm during intensive tasks, but the fan noise is reasonable. Overall, this is a fantastic machine that''s worth every penny.',
'Amazing 4K display, excellent performance, great build quality, comfortable keyboard, good battery life',
'Can get warm under heavy load, premium price point',
true, 'approved'),

(1, 6, NULL, 4, 'Great performance but battery could be better',
'The UltraBook Pro 15 is a powerhouse for sure. I use it primarily for data analysis and machine learning tasks. The processing power is incredible - training models that took hours on my old laptop now complete in minutes. The display quality is outstanding, making it easy to work with multiple windows and detailed visualizations. However, the battery life isn''t as good as advertised. When running intensive computations, I barely get 4-5 hours. For lighter tasks like web browsing and document editing, it does last longer, around 7-8 hours. The laptop also runs quite hot during heavy workloads, though the cooling system does its job. Despite these issues, the performance gains make it worthwhile for professional use.',
'Exceptional processing power, brilliant display, fast SSD, quality construction',
'Battery drains quickly under load, runs hot, expensive',
true, 'approved'),

(1, 11, NULL, 5, 'Perfect for creative professionals',
'As a graphic designer and video editor, this laptop has transformed my workflow. The color accuracy of the OLED display is phenomenal - what I see on screen matches perfectly with printed outputs. Rendering times have decreased dramatically compared to my previous setup. The keyboard is comfortable for long typing sessions, and the trackpad is responsive and accurate. Battery life is decent for a high-performance machine - I get about 6-7 hours of design work. The variety of ports means I don''t need dongles for my external drives and monitors. Build quality is top-notch; it feels like it could survive anything.',
'Stunning display accuracy, powerful graphics card, excellent build quality, good port selection',
'Heavy for daily carrying, fans can be loud under load',
false, 'approved'),

-- Phone reviews (product_id: 2) - Camera and battery theme
(2, 2, 2, 4, 'Great phone with minor quirks',
'After switching from my 3-year-old phone to the SmartPhone X Pro, the difference is night and day. The 120Hz display makes everything buttery smooth - scrolling through social media, playing games, and even just navigating the UI feels incredibly responsive. The camera system is phenomenal; I''ve taken some of my best photos ever with this phone. The night mode is particularly impressive, capturing clear shots in conditions where my old phone would produce grainy, unusable images. The 5G speeds are fantastic where available, making streaming and downloads incredibly fast. Face unlock works flawlessly, even in low light. However, I do have a few complaints. The phone is quite large and can be unwieldy for one-handed use. Despite the large battery, heavy usage (especially with 5G and the 120Hz display enabled) can drain it faster than expected. The in-display fingerprint sensor, while convenient, isn''t as fast or reliable as the physical sensors I''m used to. Also, the phone can get noticeably warm during extended gaming sessions or when using the camera for long periods.',
'Stunning 120Hz display, excellent camera system, fast 5G connectivity, smooth performance',
'Large size, fingerprint sensor could be better, gets warm during intensive use',
true, 'approved'),

(2, 7, NULL, 5, 'Camera quality is incredible',
'The SmartPhone X Pro has the best camera I''ve ever used on a phone. The 108MP main sensor captures an insane amount of detail. I''ve printed some photos at large sizes and they look professional. The night mode is magical - I can take clear photos in almost complete darkness. Video quality is equally impressive with smooth stabilization. Battery life easily lasts me a full day, even with heavy camera use. The fast charging is a lifesaver - 15 minutes gives me enough juice for hours. The display is gorgeous and the 120Hz refresh rate makes everything feel premium.',
'Outstanding camera quality, excellent battery life, fast charging, smooth display',
'Expensive, can be slippery without a case',
true, 'approved'),

(2, 12, NULL, 3, 'Good phone but battery disappoints',
'I had high expectations for the SmartPhone X Pro, and while it excels in many areas, the battery life has been disappointing. Despite the 5000mAh capacity, I find myself charging twice a day with moderate use. The camera is indeed excellent, producing sharp and vibrant photos. The performance is smooth, and apps load quickly. However, for a flagship phone at this price point, I expected better battery optimization. The phone also tends to heat up during video calls or when using GPS navigation for extended periods.',
'Great camera, smooth performance, beautiful display',
'Poor battery life, overheating issues, high price',
true, 'approved'),

-- Blender reviews (product_id: 3) - Power and ease of use theme
(3, 3, 3, 5, 'Kitchen game-changer!',
'The PowerBlend 3000 has revolutionized my morning routine and overall approach to healthy eating. I bought this primarily for making smoothies, but it''s capable of so much more. The motor is incredibly powerful - it pulverizes frozen fruits, ice, and even tough vegetables like kale and carrots into perfectly smooth consistency. I''ve made almond butter, cashew cream, and even hot soup using the friction heat from the blades. The preset programs are genuinely useful, not just gimmicks. The smoothie setting creates the perfect consistency every time, and the soup program heats ingredients to serving temperature while blending. The self-cleaning mode actually works - just add warm water and a drop of dish soap, run the cycle, and it''s clean. The large container is perfect for batch preparation. I make enough smoothie for the entire week and store portions in mason jars. The noise level is very acceptable for such a powerful motor - much quieter than my previous blender. The tamper is essential for thick mixtures. Build quality feels commercial-grade. After 6 months of daily use, it still looks and performs like new. Absolutely worth the investment for anyone serious about healthy eating.',
'Incredibly powerful motor, versatile functionality, useful preset programs, easy to clean, durable construction',
'Takes up counter space, initial learning curve for optimal results',
true, 'approved'),

(3, 8, NULL, 5, 'Powerful and easy to use',
'This blender is a beast! It crushes ice like nothing, makes the smoothest smoothies, and even handles hot soups. The preset programs take the guesswork out of blending. I especially love the self-cleaning function - it actually works! My green smoothies come out silky smooth with no chunks of kale or spinach. The build quality is excellent; it feels like a commercial unit. Worth every penny for daily smoothie makers.',
'Extremely powerful, great presets, easy cleaning, solid build',
'Large footprint, slightly noisy',
true, 'approved'),

(3, 13, NULL, 4, 'Great blender but very loud',
'The PowerBlend 3000 delivers on performance. It blends everything to a perfectly smooth consistency, from frozen fruits to nuts. The preset programs are convenient and work well. However, this thing is LOUD. Much louder than advertised. I can''t use it early in the morning without waking everyone up. Also, while the self-cleaning works, you still need to disassemble and deep clean occasionally. Despite the noise, it''s a quality blender that does its job well.',
'Powerful blending, useful programs, sturdy construction',
'Very loud operation, requires occasional deep cleaning',
false, 'approved'),

-- Book reviews (product_id: 4) - Learning and content quality theme
(4, 4, 4, 5, 'Essential resource for programmers',
'As someone who''s been programming for 5 years and recently transitioned into a senior developer role, I found "The Art of Coding" to be an invaluable resource. What sets this book apart is its comprehensive coverage and practical approach. It doesn''t just teach syntax - it teaches you how to think like a programmer. The progression from basic concepts to advanced topics is well-structured and logical. Each chapter builds upon previous knowledge while introducing new concepts at a digestible pace. The real-world examples are particularly helpful - instead of contrived examples, the authors use scenarios you''re likely to encounter in actual projects. The section on design patterns finally made concepts like dependency injection and factory patterns click for me. The algorithm explanations with visual diagrams are excellent. The multi-language approach is brilliant - seeing the same concepts implemented in Python, JavaScript, Java, and Go really reinforces understanding. The QR codes linking to video content are a nice touch, especially for complex topics. The book is hefty but well-organized with a comprehensive index. I particularly appreciate the "common pitfalls" sections that highlight mistakes beginners often make. This book has earned a permanent spot on my desk as a reference guide.',
'Comprehensive coverage, excellent real-world examples, multi-language approach, great visual explanations, helpful online resources',
'Large size makes it less portable, some sections may be too basic for experienced developers',
true, 'approved'),

(4, 9, NULL, 5, 'Best programming book I''ve read',
'This book is a masterpiece. It covers everything from basic programming concepts to advanced architectural patterns. The writing is clear and engaging, making complex topics accessible. The code examples are practical and well-commented. I particularly appreciated the sections on testing and debugging - skills often overlooked in other books. The online resources accessed via QR codes add tremendous value. This book has made me a better programmer.',
'Comprehensive content, clear explanations, practical examples, excellent online resources',
'Heavy to carry around, somewhat expensive',
true, 'approved'),

(4, 14, NULL, 4, 'Great content but outdated in some areas',
'The Art of Coding is an excellent resource with comprehensive coverage of programming concepts. The explanations are clear and the examples are helpful. However, some sections feel outdated, particularly the web development chapters which don''t cover the latest frameworks. The book is also quite heavy, making it impractical for commute reading. Despite these issues, it''s still a valuable resource for understanding core programming principles that transcend specific technologies.',
'Solid fundamentals, good examples, clear writing',
'Some outdated content, very heavy, pricey',
false, 'approved'),

-- Jacket reviews (product_id: 5) - Weather protection and durability theme
(5, 5, NULL, 4, 'Solid jacket with room for improvement',
'I purchased the All-Weather Jacket Pro for a recent hiking trip to the Pacific Northwest, and it performed admirably in challenging conditions. During a particularly nasty storm with sideways rain and 40mph winds, I stayed completely dry. The waterproofing is legitimate - water beads up and rolls off even after hours of exposure. The breathability is good but not exceptional; during strenuous uphill sections, I did experience some internal moisture buildup despite using the pit zips. The fit is athletic without being restrictive, and the articulated sleeves allow full range of motion for climbing or scrambling. The hood adjustment system is well-designed and stays in place even in strong winds. Pockets are well-placed and spacious, though I wish the hand warmer pockets were fleece-lined. The media port in the chest pocket is a thoughtful touch. The jacket packs down impressively small - about the size of a Nalgene bottle. After several weeks of use, including some bushwhacking, the fabric shows no signs of wear. The reflective elements are strategically placed and quite bright. My main criticism is the price - while the quality justifies it, there are comparable jackets available for less.',
'Excellent waterproofing, good breathability, athletic fit, durable construction, packs small',
'Expensive, could use fleece-lined pockets, breathability could be better during high exertion',
false, 'approved'),

(5, 10, NULL, 5, 'Perfect for extreme weather',
'This jacket has been through everything with me - torrential rain, snow, high winds - and it''s never let me down. The waterproofing is absolutely bulletproof. I''ve worn it for 8-hour hikes in constant rain and stayed bone dry. The breathability is better than any other waterproof jacket I''ve owned. The fit is perfect for layering, and the adjustability options are well thought out. Yes, it''s expensive, but the quality is exceptional. This jacket will last for years.',
'Superior waterproofing, excellent breathability, durable, great fit',
'High price point',
true, 'approved'),

(5, 15, NULL, 3, 'Good jacket but not worth the premium price',
'The All-Weather Jacket Pro is a decent jacket but doesn''t justify its premium price. The waterproofing works well, and the construction seems solid. However, I''ve used jackets costing half as much that perform nearly as well. The breathability is average - I still get sweaty during intense activities. The pockets are well-placed but not lined. For the price, I expected more features and better breathability. It''s a good jacket, just overpriced.',
'Reliable waterproofing, good construction, nice pocket placement',
'Overpriced, average breathability, lacks premium features',
true, 'approved'),

-- Tablet reviews (product_id: 6) - Productivity and display theme
(6, 1, NULL, 5, 'Laptop replacement achieved',
'The TabMax Pro 12 has successfully replaced my laptop for 90% of my work. The M2 chip is incredibly fast - photo editing, video rendering, and even coding (with the right apps) are smooth and responsive. The display is absolutely gorgeous with accurate colors and smooth ProMotion. Battery life is exceptional; I regularly get 10+ hours of mixed use. The magic keyboard and stylus transform it into a true productivity machine. File management has improved significantly with recent updates. For creative work and general productivity, this tablet is unbeatable.',
'Incredible performance, stunning display, excellent battery life, great accessories',
'Still some software limitations, expensive with accessories',
true, 'approved'),

(6, 6, NULL, 4, 'Great tablet but not quite a laptop',
'The TabMax Pro 12 is an impressive piece of hardware. The display is stunning, performance is snappy, and battery life is excellent. For content consumption, note-taking, and light productivity, it''s perfect. However, it still can''t fully replace a laptop for my workflow. File management is clunky, multitasking has limitations, and some professional software isn''t available. The accessories are expensive but necessary for productivity. It''s an excellent tablet that''s almost a laptop replacement.',
'Beautiful display, fast performance, long battery life',
'Software limitations, expensive accessories required',
false, 'approved'),

-- Headphones reviews (product_id: 7) - Sound quality and comfort theme
(7, 2, NULL, 5, 'Audio perfection achieved',
'The SoundWave Pro headphones deliver audiophile-quality sound in a wireless package. The soundstage is wide and detailed, with perfectly balanced bass, mids, and highs. The active noise cancellation is industry-leading - it blocks out everything from airplane engines to office chatter. Comfort is exceptional; I can wear them for 8+ hours without fatigue. Battery life is as advertised at 30 hours. The touch controls are intuitive and responsive. Call quality is crystal clear. These are worth every penny for serious music lovers.',
'Exceptional sound quality, best-in-class ANC, superb comfort, long battery life',
'Premium price, carrying case could be smaller',
true, 'approved'),

(7, 7, NULL, 4, 'Great sound but comfort issues',
'The sound quality of the SoundWave Pro is undeniably excellent. Music sounds rich and detailed, with great separation between instruments. The noise cancellation works incredibly well. However, I find them uncomfortable after 2-3 hours - they put too much pressure on the top of my head. The touch controls can be finicky and sometimes register accidental inputs. Battery life is good, and the quick charge feature is handy. Overall, great headphones let down by comfort issues.',
'Excellent audio quality, effective ANC, good battery life',
'Uncomfortable for long sessions, finicky touch controls',
true, 'approved'),

-- Tent reviews (product_id: 8) - Weather resistance and setup theme
(8, 3, NULL, 5, 'Bomber tent for harsh conditions',
'The Explorer 4-Season Tent has been through multiple winter camping trips and hasn''t failed me once. Setup is straightforward even in strong winds thanks to the color-coded poles and clips. The geodesic design is rock solid - it handled 60mph gusts without flinching. Interior space is generous for 2 people with gear. The vestibules are large enough for boots, packs, and cooking gear. Condensation management is excellent with the double-wall design. The quality of materials and construction is evident in every detail. This tent gives me confidence in any weather.',
'Extremely stable, easy setup, excellent weather protection, quality construction',
'Heavy for backpacking, expensive',
true, 'approved'),

(8, 8, NULL, 4, 'Solid tent but heavy',
'This tent is built like a tank, which is both good and bad. It laughs at bad weather and provides excellent protection. Setup is relatively easy with practice. The interior is spacious and well-designed. However, it''s HEAVY. Fine for car camping but brutal for backpacking. The packed size is also quite large. If weight isn''t a concern and you need bombproof shelter, this is your tent. For backpacking, look elsewhere.',
'Bombproof construction, weather resistant, spacious interior',
'Very heavy, bulky when packed',
false, 'approved'),

-- Drone reviews (product_id: 9) - Flight performance and camera theme
(9, 4, NULL, 5, 'Professional results made easy',
'The SkyMaster 4K has elevated my photography and videography to new heights. The image quality is stunning - 4K footage is sharp and colors are vibrant. The gimbal provides rock-steady footage even in windy conditions. Intelligent flight modes work flawlessly; ActiveTrack keeps subjects in frame perfectly. Flight time of 30 minutes is accurate, and I always carry spare batteries. The obstacle avoidance has saved me several times. The compact folding design makes it travel-friendly. This drone makes professional aerial content accessible to enthusiasts.',
'Excellent image quality, stable flight, intelligent features, portable design',
'Batteries are expensive, learning curve for manual flying',
true, 'approved'),

(9, 9, NULL, 3, 'Good drone but app issues',
'The SkyMaster 4K hardware is solid - good camera, stable flight, decent battery life. However, the smartphone app is frustrating. It crashes frequently, especially on Android. Connection drops are common, forcing me to restart mid-flight. When it works, the drone performs well. The automatic flight modes are useful but sometimes behave unpredictably. For the price, I expected better software reliability. The drone itself is good, but the app experience ruins it.',
'Good camera quality, stable flight platform',
'Unreliable app, connection issues, expensive',
true, 'approved'),

-- Board game reviews (product_id: 10) - Gameplay and component quality theme
(10, 5, NULL, 5, 'Epic gaming experience',
'Quest for the Crystal Kingdom is everything I want in a board game. The component quality is outstanding - detailed miniatures, thick cardboard, and beautiful artwork. Gameplay is deep and strategic without being overwhelming. The campaign mode adds real progression and consequence to decisions. Each session tells a story, and player choices matter. Setup time is reasonable considering the game''s scope. My gaming group is obsessed; we''ve played through the campaign twice. The replay value is incredible with different character combinations and story branches.',
'Amazing components, engaging gameplay, high replay value, great campaign mode',
'Storage solution needed for all components',
true, 'approved'),

(10, 10, NULL, 4, 'Great game but long setup',
'Quest for the Crystal Kingdom delivers an engaging gaming experience with top-notch components. The miniatures are detailed, the artwork is beautiful, and the gameplay is strategic and fun. However, setup and teardown take forever - easily 20-30 minutes each. The rulebook could be clearer; we spent our first session constantly referencing it. Once you learn the game, it flows well. The campaign mode is brilliant. Despite the setup hassle, we keep coming back to it.',
'Quality components, fun gameplay, good campaign system',
'Long setup time, rulebook could be clearer',
false, 'approved'),

-- Coffee machine reviews (product_id: 11) - Coffee quality and ease of use theme
(11, 6, NULL, 5, 'Barista-quality coffee at home',
'The BrewMaster Pro has transformed my morning coffee ritual. The built-in grinder with 15 settings lets me dial in the perfect grind for different beans. Temperature control is precise, extracting maximum flavor. The automatic milk frother creates microfoam that rivals coffee shops - I''m actually making latte art! The dual boiler means no waiting between brewing and steaming. Cleaning is surprisingly easy with automatic cycles. The ability to save drink preferences for multiple users is brilliant. Yes, it''s expensive, but I''ve saved hundreds by not buying coffee out.',
'Exceptional coffee quality, integrated grinder, easy to use, great milk frothing',
'Expensive, takes up significant counter space',
true, 'approved'),

(11, 11, NULL, 4, 'Excellent coffee but reliability concerns',
'The BrewMaster Pro makes fantastic coffee when it''s working properly. The grinder is consistent, temperature control is accurate, and the milk frother works well. However, I''ve had several issues in 6 months - error messages, grinder jams, and a water pump failure. Customer service was helpful, but downtime is frustrating for a machine this expensive. When it works, it''s amazing. The reliability issues prevent me from giving it 5 stars.',
'Great coffee quality, good features, responsive customer service',
'Reliability issues, expensive repairs after warranty',
true, 'approved'),

(11, 1, NULL, 5, 'Worth every penny for coffee lovers',
'As a coffee enthusiast, the BrewMaster Pro is a dream come true. The level of control over every aspect of brewing is incredible. I can adjust grind size, water temperature, extraction time, and pressure to perfect each type of coffee. The results are consistently excellent. The learning curve is manageable thanks to the intuitive interface. Maintenance is straightforward with clear prompts. The machine is built like a tank and feels commercial-grade. If you''re serious about coffee, this is the machine to get.',
'Professional-level control, consistent results, solid build quality',
'High initial cost, requires quality beans to shine',
false, 'approved'),

-- Smartwatch reviews (product_id: 12) - Health tracking and battery theme
(12, 7, NULL, 5, 'Complete health and fitness companion',
'The FitTrack Ultra has become essential to my health journey. The health monitoring is comprehensive and accurate - heart rate, blood oxygen, ECG, and sleep tracking all work flawlessly. The fitness tracking covers every activity I do, from weightlifting to swimming. Battery life is incredible; I charge once a week. The always-on display is bright and readable in sunlight. Integration with my phone is seamless. The titanium build feels premium and has survived everything. This watch has genuinely helped me improve my fitness and health habits.',
'Comprehensive health tracking, excellent battery life, durable build, accurate sensors',
'Expensive, app could have more features',
true, 'approved'),

(12, 12, NULL, 4, 'Great features but battery disappoints',
'The FitTrack Ultra packs impressive features. Health tracking is comprehensive, GPS is accurate, and the display is beautiful. However, the advertised 7-day battery life is only achievable with most features turned off. With always-on display, continuous heart rate monitoring, and daily workouts, I get 3-4 days max. The health insights are valuable, and sleep tracking has helped me improve my sleep habits. Build quality is excellent. It''s a great smartwatch held back by overly optimistic battery claims.',
'Feature-rich, accurate tracking, quality build',
'Battery life falls short of claims, pricey',
true, 'approved'),

(12, 2, NULL, 5, 'Best fitness watch on the market',
'I''ve tried many fitness watches, and the FitTrack Ultra is the best. The health sensors are medical-grade accurate. GPS locks on quickly and tracks precisely. The workout detection is smart and accurate. Battery life exceeds expectations - I get 6-7 days with heavy use. The titanium case and sapphire crystal mean I don''t baby it. Sleep tracking has revealed patterns I never knew about. The coaching features actually help improve performance. Worth the premium price for serious athletes.',
'Accurate sensors, excellent battery, durable construction, useful coaching',
'Premium pricing',
false, 'approved'),

-- Camera reviews (product_id: 13) - Image quality and usability theme
(13, 8, NULL, 5, 'Professional quality in a compact body',
'The ProShot X1 delivers DSLR-quality images in a mirrorless form factor. The 45MP sensor captures incredible detail with excellent dynamic range. Low-light performance is outstanding - I''m getting clean shots at ISO 12800. The autofocus is lightning fast and rarely misses. 8K video is overkill for most, but 4K 120fps is perfect for slow motion. In-body stabilization works like magic; I''m getting sharp handheld shots at slow shutter speeds. The weather sealing has survived rain and dusty conditions. This camera has revitalized my passion for photography.',
'Outstanding image quality, fast autofocus, excellent stabilization, weather sealed',
'Expensive, menu system takes time to learn',
true, 'approved'),

(13, 13, NULL, 4, 'Great camera but overheating issues',
'The ProShot X1 produces stunning images. The sensor is fantastic, capturing beautiful colors and detail. Autofocus is fast and accurate. Video quality is excellent. However, the camera overheats during extended 4K recording, shutting down after 20-30 minutes. This is unacceptable for a camera at this price point. Battery life is also mediocre; I need 3-4 batteries for a full day shoot. When it''s not overheating, it''s an excellent camera. The thermal issues are a significant flaw.',
'Excellent image quality, fast AF, good ergonomics',
'Overheating in video mode, poor battery life, expensive',
true, 'approved'),

(13, 3, NULL, 5, 'Worth the investment for pros',
'After 6 months with the ProShot X1, I''m thoroughly impressed. Image quality rivals medium format in good light. The autofocus tracking is incredible for wildlife and sports. IBIS means I leave the tripod home more often. The dual card slots provide peace of mind for client work. Video capabilities are comprehensive, though I primarily shoot stills. The customization options let me set it up exactly how I want. Battery life isn''t great, but that''s typical for mirrorless. This camera has paid for itself with client work.',
'Superb image quality, professional features, reliable AF, excellent IBIS',
'Battery hungry, complex menu system',
false, 'approved'),

-- Speaker reviews (product_id: 14) - Sound quality and portability theme
(14, 9, NULL, 5, 'Party speaker perfection',
'The SoundBlast 360 is the ultimate portable party speaker. The 360-degree sound truly fills any space - no dead spots regardless of where you''re standing. Bass response is incredible for the size; it actually has punch. Volume levels are insane without distortion. The 20-hour battery life is accurate; it lasted our entire weekend camping trip. Being waterproof means pool parties are worry-free. The light show synced to music is a hit at gatherings. PartyBoost with multiple speakers creates a concert-like experience. This speaker brings the party anywhere.',
'Incredible sound quality, long battery life, truly waterproof, fun light feature',
'A bit heavy for hiking',
true, 'approved'),

(14, 14, NULL, 4, 'Great sound but connectivity issues',
'The SoundBlast 360 delivers impressive sound for its size. The 360-degree design works well, and bass response is surprisingly good. Battery life is excellent, and the waterproofing gives peace of mind. However, I''ve experienced frequent Bluetooth connectivity issues. The connection drops randomly, requiring re-pairing. The app is buggy and crashes often. When it stays connected, it''s a great speaker. The connectivity problems are frustrating enough to dock a star.',
'Good sound quality, solid battery life, waterproof design',
'Bluetooth connectivity problems, buggy app',
true, 'approved'),

(14, 4, NULL, 5, 'Best portable speaker I''ve owned',
'I''ve gone through many portable speakers, and the SoundBlast 360 is the best. Sound quality is exceptional - clear highs, rich mids, and actual bass. The 360-degree sound means everyone hears great audio. Battery life is phenomenal; I''ve gotten 22 hours at moderate volume. It''s survived drops, rain, and even brief submersion. The power bank feature has saved my phone multiple times. The party lights are more fun than expected. Connection is stable with multiple devices. This speaker exceeds expectations.',
'Outstanding sound, incredible battery, durable build, useful features',
'Slightly heavy for backpacking',
false, 'approved'),

-- More diverse reviews for semantic patterns
(1, 15, NULL, 3, 'Disappointed with battery claims',
'The UltraBook Pro 15 is powerful but the battery life is nowhere near the advertised 10 hours. With normal use - web browsing, document editing, and video streaming - I get 5-6 hours maximum. The performance is excellent and the display is beautiful, but for a laptop marketed as having "all-day battery life," this is disappointing. Customer support suggested lowering screen brightness and disabling features, which defeats the purpose of having a high-end laptop.',
'Strong performance, quality display',
'Poor battery life, misleading marketing, runs hot',
true, 'approved'),

(2, 10, NULL, 5, 'Battery life exceeds expectations',
'I was skeptical about the battery claims, but the SmartPhone X Pro actually delivers. I''m a heavy user - constant email, social media, photography, and GPS - and I still have 20-30% left at bedtime. The fast charging is incredibly convenient. Camera quality is outstanding in all lighting conditions. The phone feels premium and the display is gorgeous. After 6 months, battery health is still at 98%. This is how flagship phones should be.',
'Exceptional battery life, superb camera, fast charging, premium build',
'Large size takes getting used to',
true, 'approved'),

(3, 15, NULL, 2, 'Too loud and customer service issues',
'The PowerBlend 3000 is powerful but incredibly loud - it wakes up the entire house. When I contacted customer service about this, they were unhelpful and dismissive. The blender works well for smoothies but struggles with thicker mixtures despite the high price. The preset programs are limited and often require manual intervention. For the premium price, I expected better performance and support.',
'Handles basic smoothies well',
'Extremely loud, poor customer service, struggles with thick mixtures',
true, 'approved'),

(4, 11, NULL, 5, 'Excellent value for money',
'The Art of Coding offers incredible value. For the price of a few online courses, you get comprehensive coverage of programming concepts that would cost thousands in bootcamps. The examples are practical and applicable to real work. The writing is clear without being condescending. Online resources add even more value. This book accelerated my career transition into tech. Highly recommended for anyone serious about learning to code.',
'Exceptional value, comprehensive content, practical examples, clear writing',
'Physical book is heavy',
true, 'approved'),

(5, 13, NULL, 1, 'Failed in real weather - not recommended',
'The All-Weather Jacket Pro failed spectacularly in actual weather conditions. During a moderate rainstorm, water seeped through the seams and zippers. The "breathability" is non-existent - I was soaked with sweat after a short hike. The fabric started pilling after just two weeks. For a $200 jacket, this performance is unacceptable. Customer service offered only a partial refund. Save your money and buy from established outdoor brands.',
'None',
'Leaks in rain, poor breathability, quality issues, bad customer service',
false, 'approved'),

(6, 14, NULL, 5, 'Incredible value compared to laptops',
'The TabMax Pro 12 offers incredible value when you consider what you''re getting. The performance rivals laptops costing twice as much. The display is better than most laptops. Battery life embarrasses traditional laptops. For my workflow - writing, research, light photo editing - it''s perfect. The tablet form factor is actually an advantage for reading and note-taking. At this price point, it''s an exceptional value.',
'Outstanding value, excellent performance, amazing display, versatile form factor',
'Some software limitations remain',
true, 'approved'),

(7, 5, NULL, 3, 'Overpriced for the quality',
'The SoundWave Pro headphones are decent but overpriced. The sound quality is good, not exceptional. Noise cancellation works but isn''t class-leading. Comfort is average - the headband pressure becomes noticeable after an hour. Build quality feels plasticky for the price. You''re paying a premium for the brand name. There are better options available for less money. These aren''t bad headphones, just poor value.',
'Decent sound quality, effective ANC',
'Overpriced, average comfort, plasticky build',
false, 'approved'),

(8, 15, NULL, 5, 'Outstanding quality and design',
'The Explorer 4-Season Tent showcases exceptional design and build quality. Every detail shows thoughtful engineering - from the color-coded poles to the reinforced stress points. Setup in wind is manageable thanks to the intuitive design. Interior space is well-utilized with smart pocket placement. Ventilation is excellent, minimizing condensation. The materials feel bombproof. This tent inspires confidence in harsh conditions. Worth the investment for serious outdoor enthusiasts.',
'Exceptional build quality, thoughtful design, stable in wind, excellent ventilation',
'Premium price, weight',
true, 'approved'),

(9, 11, NULL, 4, 'Good drone but poor customer support',
'The SkyMaster 4K is a capable drone with excellent image quality. Flight performance is stable and the intelligent modes work well. However, when I had an issue with a gimbal motor, customer support was terrible. Multiple emails went unanswered, phone support had hour-long waits, and the resolution took weeks. The drone itself is good, but the lack of support makes me hesitant to recommend it. Consider the support implications before purchasing.',
'Good image quality, stable flight, useful features',
'Terrible customer support, slow warranty service',
true, 'approved'),

(10, 13, NULL, 5, 'Best value in board gaming',
'Quest for the Crystal Kingdom offers incredible value. The amount of quality components you get for $90 is astounding. Compare this to other campaign games costing $150+ with fewer components. The gameplay is engaging and the replay value is massive. My group has logged 50+ hours and we''re not close to exhausting the content. The price-to-entertainment ratio is unbeatable. This game proves you don''t need to spend $200+ for an epic gaming experience.',
'Exceptional value, tons of content, high replay value, quality components',
'Initial rules learning curve',
true, 'approved'));

-- Update product ratings based on all reviews
UPDATE products SET rating_average = 4.4, rating_count = 5 WHERE product_id = 1;
UPDATE products SET rating_average = 4.3, rating_count = 5 WHERE product_id = 2;
UPDATE products SET rating_average = 4.3, rating_count = 4 WHERE product_id = 3;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 4;
UPDATE products SET rating_average = 3.7, rating_count = 4 WHERE product_id = 5;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 6;
UPDATE products SET rating_average = 4.0, rating_count = 3 WHERE product_id = 7;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 8;
UPDATE products SET rating_average = 4.0, rating_count = 3 WHERE product_id = 9;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 10;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 11;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 12;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 13;
UPDATE products SET rating_average = 4.7, rating_count = 3 WHERE product_id = 14;

-- Note: In a production environment, the comment_embedding column would be populated using:
-- 1. An embedding model (like Amazon Titan Text Embeddings v2 with 1024 dimensions)
-- 2. A trigger function to automatically generate embeddings on insert/update
-- 3. Or a batch process to generate embeddings for existing reviews
-- Example: UPDATE reviews SET comment_embedding = get_embedding(comment) WHERE comment_embedding IS NULL;

-- Sample queries to demonstrate the schema
-- Find all products in a category with their average rating
/*
SELECT p.name, p.price, p.rating_average, p.rating_count, c.name as category
FROM products p
JOIN categories c ON p.category_id = c.category_id
WHERE c.name = 'Electronics' OR c.parent_category_id = 1
ORDER BY p.rating_average DESC;
*/

-- Get order details with customer information
/*
SELECT o.order_number, u.first_name || ' ' || u.last_name as customer_name,
       o.total_amount, o.order_status, o.created_at
FROM orders o
JOIN users u ON o.user_id = u.user_id
ORDER BY o.created_at DESC;
*/

-- Find products with detailed reviews
/*
SELECT p.name, r.rating, r.title, r.comment, u.username
FROM reviews r
JOIN products p ON r.product_id = p.product_id
JOIN users u ON r.user_id = u.user_id
WHERE r.status = 'approved'
ORDER BY r.created_at DESC;
*/

-- Semantic search examples (requires embeddings to be populated)
-- Find reviews similar to "battery life issues" 
-- Note: Replace [your_query_embedding_vector] with actual 1024-dimension vector from Amazon Titan v2
/*
SELECT r.review_id, r.title, r.comment, r.rating, p.name as product_name,
       r.comment_embedding <=> '[your_query_embedding_vector]'::vector as distance
FROM reviews r
JOIN products p ON r.product_id = p.product_id
WHERE r.comment_embedding IS NOT NULL
ORDER BY r.comment_embedding <=> '[your_query_embedding_vector]'::vector
LIMIT 10;
*/

-- Analyze sentiment patterns for products
/*
SELECT p.name, p.category_id,
       COUNT(CASE WHEN r.rating >= 4 THEN 1 END) as positive_reviews,
       COUNT(CASE WHEN r.rating <= 2 THEN 1 END) as negative_reviews,
       AVG(r.rating) as avg_rating,
       COUNT(*) as total_reviews
FROM products p
JOIN reviews r ON p.product_id = r.product_id
WHERE r.status = 'approved'
GROUP BY p.product_id, p.name, p.category_id
HAVING COUNT(*) >= 3
ORDER BY avg_rating DESC;
*/

-- Find common themes in reviews (e.g., battery life issues across electronics)
/*
WITH battery_reviews AS (
  SELECT r.*, p.name as product_name, c.name as category_name
  FROM reviews r
  JOIN products p ON r.product_id = p.product_id
  JOIN categories c ON p.category_id = c.category_id
  WHERE r.comment ILIKE '%battery%' 
    AND r.status = 'approved'
)
SELECT category_name, 
       COUNT(*) as mention_count,
       AVG(rating) as avg_rating_when_mentioned,
       COUNT(CASE WHEN rating <= 3 THEN 1 END) as negative_mentions,
       COUNT(CASE WHEN rating >= 4 THEN 1 END) as positive_mentions
FROM battery_reviews
GROUP BY category_name
ORDER BY mention_count DESC;
*/