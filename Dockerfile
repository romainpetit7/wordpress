# Dockerfile Romain PETIT test apache-PHP 7.2
FROM php:7.2-apache



#Update des repo plus installation de wget et unzip
RUN apt-get update \ 
&& apt-get install -y wget unzip \
&& apt-get install -y iputils-ping 




#on récupère le zip de Wordpress puis on le dézip via unzip
#et enfin on supprime l'archive zip
RUN wget https://wordpress.org/wordpress-4.9.5.zip -O /var/www/html/wordpress-4.9.5.zip \ 
&& unzip /var/www/html/wordpress-4.9.5.zip -d /var/www/html/ \ 
&& rm /var/www/html/wordpress-4.9.5.zip

#Ajout des persmisions nécessaire pour que wordpress fonctionne 
RUN chown -R www-data:www-data /var/www/html/ 


#Ajout du fichier de conf wordpress à Apache
ADD wordpress.conf /etc/apache2/sites-available/

#Ajout de la librairie mysqli pour PHP
RUN docker-php-ext-install mysqli

#Ajout du fichier de conf wp-config.php
ADD wp-config.php /var/www/html/wordpress/ 
ADD modifenv.sh /var/www/html/script/

#Ajout droit d'execution sur script Shell modifenv.sh
RUN chmod +x /var/www/html/script/modifenv.sh

#Application du fichier de conf à Apache et reboot du service pour appliquer la modif
RUN a2ensite wordpress.conf && a2enmod rewrite && service apache2 restart


USER www-data

CMD ["script/modifenv.sh"] 

