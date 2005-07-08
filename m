Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050708200429.66216.qmail@web50705.mail.yahoo.com>
From: "John H." <mistamaila@yahoo.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <BAY106-F18ED26F8078BBF56D2EC87FAD90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: [Bluez-users] bluez-pin .25 won't compile on fc4
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 8 Jul 2005 13:04:29 -0700 (PDT)

 make
cc -O3 -O2 -g `pkg-config --cflags gtk+-2.0
libglade-2.0 dbus-glib-1 gconf-2.0`
-DGTK_DISABLE_DEPRECATED -DDBUS_API_SUBJECT_TO_CHANGE
-Wall -Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\"
-DPREFIX=\"/usr/local\"
-DPACKAGE_LOCALE_DIR=\"/usr/local/share/locale\"   -c
main.c -o main.o
main.c: In function 'handler_func':
main.c:50: error:
'DBUS_INTERFACE_ORG_FREEDESKTOP_LOCAL' undeclared
(first use in this function)
main.c:50: error: (Each undeclared identifier is
reported only once
main.c:50: error: for each function it appears in.)
main.c: In function 'bluez_pin_dbus_server_run':
main.c:87: warning: implicit declaration of function
'dbus_bus_acquire_service'
make: *** [main.o] Error 1



		
____________________________________________________
Sell on Yahoo! Auctions – no fees. Bid on great items.  
http://auctions.yahoo.com/


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
