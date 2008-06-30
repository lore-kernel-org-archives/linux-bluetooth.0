Return-Path: <cyrus@holtmann.org>
Message-ID: <e96e9eeb0806300506l1aaeaf6bje93db6f4f5af880e@mail.gmail.com>
Date: Mon, 30 Jun 2008 15:06:41 +0300
From: "Voni Hakau" <hakauvoni@gmail.com>
To: "Mumia W.." <paduille.4061.mumia.w+nospam@earthlink.net>
In-Reply-To: <4856EC25.5040508@earthlink.net>
MIME-Version: 1.0
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
	<e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
	<4856EC25.5040508@earthlink.net>
Cc: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluez build problem
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi !

On Tue, Jun 17, 2008 at 1:41 AM, Mumia W..
<paduille.4061.mumia.w+nospam@earthlink.net> wrote:
> But DESTDIR is used during "make install," and as you figured, you can use
> the platform's prefix.
>
> Note that some programs don't use the DESTDIR variable, but almost all do.
>

I have successfully built expat,dbus and bluez-libs with this idea, but it seems
that bluez-utils doesn't like it..

Here is my configure command:
BLUEZ_CFLAGS=-I/path/to/my/platform/root/usr/include
BLUEZ_LIBS="-L/path/to/my/platform/root/usr/lib -lbluetooth"
DBUS_LIBS="-L/path/to/my/platform/root/usr/lib -ldbus-1"
DBUS_CFLAGS="-I/path/to/my/platform/root/usr/include/dbus-1.0
-I/path/to/my/platform/root/usr/include/dbus-1.0/include"
CPPFLAGS=-I/path/to/my/platform/root/usr/include
LDFLAGS=-L/path/to/my/platform/root/usr/lib ./configure --prefix=/usr
--host=arm-linux --mandir=/usr/share/man --sysconfdir=/etc
--localstatedir=/var --libexecdir=/lib

configure runs ok, and then make runs a little until it is doing this:
arm-linux-gcc -I/path/to/my/platform/root/usr/include
-I/path/to/my/platform/root/usr/include/dbus-1.0
-I/path/to/my/platform/root/usr/include/dbus-1.0/include -I../eglib
-I../gdbus -DPLUGINDIR=\"/usr/lib/bluetooth/plugins\" -Wall -O2
-D_FORTIFY_SOURCE=2 -o hcid main.o -rdynamic
-L/path/to/my/platform/root/usr/lib libhciserver.a
../sdpd/libsdpserver.a ../common/libhelper.a ../gdbus/.libs/libgdbus.a
../eglib/.libs/libeglib.a -ldl /usr/lib/libdbus-1.so
/path/to/my/platform/root/usr/lib/libbluetooth.so   -Wl,--rpath
-Wl,/path/to/my/platform/root/usr/lib -Wl,--rpath
-Wl,/path/to/my/platform/root/usr/lib
/usr/lib/libdbus-1.so: file not recognized: File format not recognized
collect2: ld returned 1 exit status

we can see that it tried to use my host libdbus-1.so, and it ignores
the DBUS_LIBS variable..

did i do something wrong ?
maybe it is a bug in bluez ? do you know how to fix it or bypass it ?
I tried to look in the Makefiles themselves to change this behavior
but didn't find it..

Thank you again for this wonderful assistance !
Voni

(btw, I even tried to set up
PKG_CONFIG_PATH=/path/to/my/platform/root/usr/lib/pkgconfig
but it didn't help...)

>
>

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
