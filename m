Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tamer Higazi <tamer23@myrealbox.com>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1110730150.15038.9.camel@tux>
Mime-Version: 1.0
Subject: [Bluez-users] problems getting connection to cell phone
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
Date: Sun, 13 Mar 2005 17:09:10 +0100

Hi! 

I have problems getting a stable connection between my Computer and my
cellular phone through bluetooth. Could be the problem because the
package bluez-pin was not installed? 

I unpacked the package and tried to compile it, and I receive a long
list of errors. Here the output: 


make
cc -O2 -g `pkg-config --cflags gtk+-2.0 libglade-2.0 dbus-glib-1
gconf-2.0` -DGTK_DISABLE_DEPRECATED -DDBUS_API_SUBJECT_TO_CHANGE -Wall
-Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\" -DPREFIX=\"/usr\"
-DPACKAGE_LOCALE_DIR=\"/usr/share/locale\"   -c main.c -o main.o
Package dbus-glib-1 was not found in the pkg-config search path.
Perhaps you should add the directory containing `dbus-glib-1.pc'
to the PKG_CONFIG_PATH environment variable
No package 'dbus-glib-1' found
main.c:20:21: gtk/gtk.h: No such file or directory
main.c:22:23: dbus/dbus.h: No such file or directory
main.c:23:28: dbus/dbus-glib.h: No such file or directory
main.c:24:37: dbus/dbus-glib-lowlevel.h: No such file or directory
In file included from main.c:26:
pin-ui.h:4: error: parse error before "outgoing"
main.c:36: error: parse error before "bluez_pin_handle_dbus_request"
main.c:36: error: parse error before '*' token
main.c:36: warning: type defaults to `int' in declaration of
`bluez_pin_handle_dbus_request'
main.c:36: warning: data definition has no type or storage class
main.c:39: error: parse error before "handler_func"
main.c:39: error: parse error before '*' token
main.c:42: warning: return type defaults to `int'
main.c: In function `handler_func':
main.c:43: warning: implicit declaration of function
`dbus_message_is_method_call'
main.c:43: error: `message' undeclared (first use in this function)
main.c:43: error: (Each undeclared identifier is reported only once
main.c:43: error: for each function it appears in.)
main.c:44: error: `connection' undeclared (first use in this function)
main.c:49: warning: implicit declaration of function
`dbus_message_is_signal'
main.c:50: error: `DBUS_INTERFACE_ORG_FREEDESKTOP_LOCAL' undeclared
(first use in this function)
main.c:54: error: `DBUS_HANDLER_RESULT_NOT_YET_HANDLED' undeclared
(first use in this function)
main.c: At top level:
main.c:57: error: parse error before "dbus_vtable"
main.c:57: warning: type defaults to `int' in declaration of
`dbus_vtable'
main.c:58: warning: initialization makes integer from pointer without a
cast
main.c:59: warning: excess elements in scalar initializer
main.c:59: warning: (near initialization for `dbus_vtable')
main.c:61: warning: excess elements in scalar initializer
main.c:61: warning: (near initialization for `dbus_vtable')
main.c:61: warning: data definition has no type or storage class
main.c: In function `bluez_pin_dbus_server_run':
main.c:66: error: `DBusConnection' undeclared (first use in this
function)
main.c:66: error: `connection' undeclared (first use in this function)
main.c:67: error: `DBusError' undeclared (first use in this function)
main.c:67: error: parse error before "error"
main.c:72: warning: implicit declaration of function `dbus_error_init'
main.c:72: error: `error' undeclared (first use in this function)
main.c:73: warning: implicit declaration of function `dbus_bus_get'
main.c:73: error: `DBUS_BUS_SYSTEM' undeclared (first use in this
function)
main.c:78: warning: implicit declaration of function `dbus_error_free'
main.c:82: warning: implicit declaration of function
`dbus_connection_setup_with_g_main'
main.c:84: warning: implicit declaration of function
`dbus_connection_register_object_path'
main.c:87: warning: implicit declaration of function
`dbus_bus_acquire_service'
main.c:88: warning: implicit declaration of function `dbus_error_is_set'
main.c: At top level:
main.c:108: error: parse error before "gchar"
main.c: In function `legacy_pin_result':
main.c:110: error: `result' undeclared (first use in this function)
main.c:115: warning: implicit declaration of function `gtk_main_quit'
main.c: At top level:
main.c:119: error: parse error before "outgoing"
main.c: In function `legacy_pin_request':
main.c:123: error: `outgoing' undeclared (first use in this function)
main.c:123: error: `address' undeclared (first use in this function)
main.c:123: error: `name' undeclared (first use in this function)
main.c:125: warning: implicit declaration of function `g_signal_connect'
main.c:125: warning: implicit declaration of function `G_OBJECT'
main.c:125: warning: implicit declaration of function `G_CALLBACK'
main.c: In function `main':
main.c:140: error: `gboolean' undeclared (first use in this function)
main.c:140: error: parse error before "dbus_mode"
main.c:141: error: `gchar' undeclared (first use in this function)
main.c:141: error: `address' undeclared (first use in this function)
main.c:141: error: `name' undeclared (first use in this function)
main.c:141: warning: left-hand operand of comma expression has no effect
main.c:151: error: `dbus_mode' undeclared (first use in this function)
main.c:151: error: `TRUE' undeclared (first use in this function)
main.c:153: error: `FALSE' undeclared (first use in this function)
main.c:187: warning: implicit declaration of function `gtk_set_locale'
main.c:188: warning: implicit declaration of function `gtk_init'
main.c:194: warning: implicit declaration of function `gtk_main'
main.c:198: error: parse error before "outgoing"
main.c:204: error: `outgoing' undeclared (first use in this function)
make: *** [main.o] Error 1


For any help. thank you


Tamer




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
