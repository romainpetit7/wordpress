sed -i -e "s|database_name_here|$DB_NAME|g" /var/www/html/wordpress/wp-config.php \
&& sed -i -e "s|username_here|$DB_USER|g" /var/www/html/wordpress/wp-config.php \
&& sed -i -e "s|password_here|$DB_PASSWORD|g" /var/www/html/wordpress/wp-config.php \
&& sed -i -e "s|localhost|$DB_HOST|g" /var/www/html/wordpress/wp-config.php 


apache2-foreground


