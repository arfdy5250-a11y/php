# استخدام صورة PHP مع سيرفر Apache
FROM php:8.2-apache

# تثبيت إضافات PHP الضرورية (مثل Curl) التي يحتاجها كودك
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    pkg-config \
    libssl-dev \
    && docker-php-ext-install curl

# تفعيل مود Rewrite في Apache (للمسارات)
RUN a2enmod rewrite

# نسخ ملفاتك إلى مجلد السيرفر
COPY . /var/www/html/

# إعطاء صلاحيات الكتابة (ضروري جداً لأن بوتك يقوم بإنشاء مجلدات وملفات)
RUN chown -R www-data:www-data /var/www/html && chmod -R 777 /var/www/html

# تحديد المنفذ (Render يستخدم بورت متغير)
EXPOSE 80

# تشغيل السيرفر
CMD ["apache2-foreground"]
