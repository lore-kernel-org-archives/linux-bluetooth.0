Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Compiling bluez packages
From: Marcel Holtmann <marcel@holtmann.org>
To: Philip MacIver <pmaciver@arishi.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040722084417.6d9279bb@reddevils>
References: <20040722084417.6d9279bb@reddevils>
Content-Type: text/plain
Message-Id: <1090484989.3626.2.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 22 Jul 2004 10:29:49 +0200

Hi Philip,

> I am get the following errors while compiling bluez-bluefw-1.0
> 
> ----------------------------8<-----------------------------------
> gcc -DPACKAGE_NAME=\"\" -DPACKAGE_TARNAME=\"\" -DPACKAGE_VERSION=\"\" -DPACKA GE_STRING=\"\" -DPACKAGE_BUGREPORT=\"\"
> -DPACKAGE=\"bluez-bluefw\" -DVERSION= \"1.0\" -DSTDC_HEADERS=1 -DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDL
> IB_H=1 -DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 -DHAVE_INTTYPES _H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1
> -DBT3C_SUPPORT=1  -I. -I. -I/usr/src /linux/include    -Wall -g -O2 -c `test -f 'bluefw.c' || echo './'`bluefw.c
> In file included from usblib.h:30,
>                  from bluefw.c:39:
> /usr/src/linux/include/linux/usbdevice_fs.h:49: error: variable or field `__u ser' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:49: warning: no semicolon at end of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:49: error: parse error before '*'  token
> /usr/src/linux/include/linux/usbdevice_fs.h:56: error: variable or field `__u ser' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:56: warning: no semicolon at end of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:56: error: parse error before '*'  token
> /usr/src/linux/include/linux/usbdevice_fs.h:66: error: variable or field `__u ser' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:66: warning: no semicolon at end of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:66: error: parse error before '*'  token
> /usr/src/linux/include/linux/usbdevice_fs.h:100: error: variable or field `__ user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:100: warning: no semicolon at end  of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:100: error: parse error before '* ' token
> /usr/src/linux/include/linux/usbdevice_fs.h:109: error: parse error before '} ' token
> /usr/src/linux/include/linux/usbdevice_fs.h:116: error: variable or field `__ user' declared void
> /usr/src/linux/include/linux/usbdevice_fs.h:116: warning: no semicolon at end  of struct or union
> /usr/src/linux/include/linux/usbdevice_fs.h:116: error: parse error before '* ' token
> In file included from bluefw.c:39:
> usblib.h:163: warning: `packed' attribute ignored
> make[1]: *** [bluefw.o] Error 1
> make[1]: Leaving directory `/home/pmaciver/bluetooth/bluez/bluez-bluefw-1.0'
> make: *** [all-recursive] Error 1

I haven't looked at bluefw for a long time. If you use a 2.6.x kernel
you can use the bcm203x driver and copy the firmware files to a place
where firmware.agent finds them.

> ....and also this error for bluez-pin-0.23
> ----------------------------8<-----------------------------------
> [root@reddevils bluez-pin-0.23]# make
> cc -O2 -g `pkg-config --cflags gtk+-2.0 libglade-2.0 dbus-glib-1 gconf-2.0` -DGTK_DISABLE_DEPRECATED
> -DDBUS_API_SUBJECT_TO_CHANGE -Wall -Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\" -DPREFIX=\"/usr/local\"
> -DPACKAGE_LOCALE_DIR=\"/usr/local/share/locale\"   -c main.c -o main.o
> Package dbus-glib-1 was not found in the pkg-config search path.
> Perhaps you should add the directory containing `dbus-glib-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-glib-1' found
> main.c:20:21: gtk/gtk.h: No such file or directory
> main.c:22:23: dbus/dbus.h: No such file or directory
> main.c:23:28: dbus/dbus-glib.h: No such file or directory
> In file included from main.c:25:
> pin-ui.h:4: error: parse error before "outgoing"
> main.c:35: error: parse error before "bluez_pin_handle_dbus_request"
> main.c:35: error: parse error before '*' token
> main.c:35: warning: type defaults to `int' in declaration of `bluez_pin_handle_dbus_request'
> main.c:35: warning: data definition has no type or storage class
> main.c:38: error: parse error before "handler_func"
> main.c:38: error: parse error before '*' token
> main.c:41: warning: return type defaults to `int'
> main.c: In function `handler_func':
> main.c:42: warning: implicit declaration of function `dbus_message_is_method_call'
> main.c:42: error: `message' undeclared (first use in this function)
> main.c:42: error: (Each undeclared identifier is reported only once
> main.c:42: error: for each function it appears in.)
> main.c:43: error: `connection' undeclared (first use in this function)
> main.c:48: warning: implicit declaration of function `dbus_message_is_signal'
> main.c:49: error: `DBUS_INTERFACE_ORG_FREEDESKTOP_LOCAL' undeclared (first use in this function)
> main.c:53: error: `DBUS_HANDLER_RESULT_NOT_YET_HANDLED' undeclared (first use in this function)
> main.c: At top level:
> main.c:56: error: parse error before "dbus_vtable"
> main.c:56: warning: type defaults to `int' in declaration of `dbus_vtable'
> main.c:57: warning: initialization makes integer from pointer without a cast
> main.c:58: warning: excess elements in scalar initializer
> main.c:58: warning: (near initialization for `dbus_vtable')
> main.c:60: warning: excess elements in scalar initializer
> main.c:60: warning: (near initialization for `dbus_vtable')
> main.c:60: warning: data definition has no type or storage class
> main.c: In function `bluez_pin_dbus_server_run':
> main.c:65: error: `DBusConnection' undeclared (first use in this function)
> main.c:65: error: `connection' undeclared (first use in this function)
> main.c:66: error: `DBusError' undeclared (first use in this function)
> main.c:66: error: parse error before "error"
> main.c:71: warning: implicit declaration of function `dbus_error_init'
> main.c:71: error: `error' undeclared (first use in this function)
> main.c:72: warning: implicit declaration of function `dbus_bus_get'
> main.c:72: error: `DBUS_BUS_SYSTEM' undeclared (first use in this function)
> main.c:77: warning: implicit declaration of function `dbus_error_free'
> main.c:81: warning: implicit declaration of function `dbus_connection_setup_with_g_main'
> main.c:83: warning: implicit declaration of function `dbus_connection_register_object_path'
> main.c:86: warning: implicit declaration of function `dbus_bus_acquire_service'
> main.c:87: warning: implicit declaration of function `dbus_error_is_set'
> main.c: At top level:
> main.c:107: error: parse error before "gchar"
> main.c: In function `legacy_pin_result':
> main.c:109: error: `result' undeclared (first use in this function)
> main.c:114: warning: implicit declaration of function `gtk_main_quit'
> main.c: At top level:
> main.c:118: error: parse error before "outgoing"
> main.c: In function `legacy_pin_request':
> main.c:122: error: `outgoing' undeclared (first use in this function)
> main.c:122: error: `address' undeclared (first use in this function)
> main.c:122: error: `name' undeclared (first use in this function)
> main.c:124: warning: implicit declaration of function `g_signal_connect'
> main.c:124: warning: implicit declaration of function `G_OBJECT'
> main.c:124: warning: implicit declaration of function `G_CALLBACK'
> main.c: In function `main':
> main.c:139: error: `gboolean' undeclared (first use in this function)
> main.c:139: error: parse error before "dbus_mode"
> main.c:140: error: `gchar' undeclared (first use in this function)
> main.c:140: error: `address' undeclared (first use in this function)
> main.c:140: error: `name' undeclared (first use in this function)
> main.c:140: warning: left-hand operand of comma expression has no effect
> main.c:150: error: `dbus_mode' undeclared (first use in this function)
> main.c:150: error: `TRUE' undeclared (first use in this function)
> main.c:152: error: `FALSE' undeclared (first use in this function)
> main.c:186: warning: implicit declaration of function `gtk_set_locale'
> main.c:187: warning: implicit declaration of function `gtk_init'
> main.c:193: warning: implicit declaration of function `gtk_main'
> main.c:197: error: parse error before "outgoing"
> main.c:203: error: `outgoing' undeclared (first use in this function)
> main.c:140: warning: statement with no effect
> make: *** [main.o] Error 1

Looks like you have to install the GTK and D-Bus development packages.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
