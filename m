Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems getting connection to cell phone
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1110730150.15038.9.camel@tux>
References: <1110730150.15038.9.camel@tux>
Content-Type: text/plain
Message-Id: <1110795898.8158.52.camel@pegasus>
Mime-Version: 1.0
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
Date: Mon, 14 Mar 2005 11:24:58 +0100

Hi Tamer,

> I have problems getting a stable connection between my Computer and my
> cellular phone through bluetooth. Could be the problem because the
> package bluez-pin was not installed? 
> 
> I unpacked the package and tried to compile it, and I receive a long
> list of errors. Here the output: 
> 
> 
> make
> cc -O2 -g `pkg-config --cflags gtk+-2.0 libglade-2.0 dbus-glib-1
> gconf-2.0` -DGTK_DISABLE_DEPRECATED -DDBUS_API_SUBJECT_TO_CHANGE -Wall
> -Os -fomit-frame-pointer -DPACKAGE=\"bluez-pin\" -DPREFIX=\"/usr\"
> -DPACKAGE_LOCALE_DIR=\"/usr/share/locale\"   -c main.c -o main.o
> Package dbus-glib-1 was not found in the pkg-config search path.
> Perhaps you should add the directory containing `dbus-glib-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-glib-1' found
> main.c:20:21: gtk/gtk.h: No such file or directory
> main.c:22:23: dbus/dbus.h: No such file or directory
> main.c:23:28: dbus/dbus-glib.h: No such file or directory
> main.c:24:37: dbus/dbus-glib-lowlevel.h: No such file or directory

I think this makes it quite clear. You need GTK and DBus development
libraries to be installed.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
