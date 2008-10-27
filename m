Return-Path: <cyrus@holtmann.org>
Subject: Re: 4.16 Bluez compile failure
From: Marcel Holtmann <marcel@holtmann.org>
To: "George F. Nemeyer" <tigerwolf@tigerden.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0810260102170.14544@tiger.tigerden.com>
References: <Pine.LNX.4.53.0810260102170.14544@tiger.tigerden.com>
Content-Type: text/plain
Date: Mon, 27 Oct 2008 20:46:45 +0100
Message-Id: <1225136805.7157.29.camel@californication>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi George,

> Compile of 4.16 package fails with:
> 
> gcc -I../include -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
> -I/usr/include/glib-2.0 -I/usr/lib/glib-2.0/include -I../gdbus
> -DPLUGINDIR=\"/usr/lib/bluetooth/plugins\" -O2 -march=i586 -mtune=i686
> -D_FORTIFY_SOURCE=2 -fPIC -Wl,--export-dynamic -pie -o .libs/bluetoothd
> main.o security.o sdpd-server.o sdpd-request.o sdpd-service.o
> sdpd-database.o plugin.o storage.o agent.o error.o manager.o adapter.o
> device.o dbus-common.o dbus-hci.o  ../common/libhelper.a
> ../gdbus/.libs/libgdbus.a /usr/lib/libglib-2.0.so /usr/lib/libdbus-1.so
> ../lib/.libs/libbluetooth.so -ldl
> device.o(.text+0xbb5): In function `disconnect':
> : undefined reference to `g_timeout_add_seconds'
> collect2: ld returned 1 exit status
> make[2]: *** [bluetoothd] Error 1
> make[2]: Leaving directory `/root/Desktop/bluez-4.16/src'
> make[1]: *** [all-recursive] Error 1
> make[1]: Leaving directory `/root/Desktop/bluez-4.16'
> make: *** [all] Error 2
> 
> Machine info:
> Linux blackwolf.tigerden.net 2.6.20_IBM-600 #2 PREEMPT Thu May 8 01:08:22
> EDT 2008 i686 pentium2 i386 GNU/Linux
> 
> DISTRO:  Vector Linux 5.8 Standard (based on slackware)

you need a GLib version with g_timeout_add_seconds. So it seems that
your version of GLib is just too old. Which version are you using?

Regards

Marcel


