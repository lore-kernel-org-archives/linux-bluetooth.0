Return-Path: <cyrus@holtmann.org>
Date: Tue, 1 Jul 2008 11:09:05 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <e96e9eeb0806300509w12d1dfaen3f00db7732db80c8@mail.gmail.com>
Message-ID: <alpine.LNX.1.10.0807011047300.6029@nge2.ngu.pk>
References: <e96e9eeb0806130507u139f58a2sa7094a65f9ecff17@mail.gmail.com>
	<4852914F.6020209@earthlink.net>
	<e96e9eeb0806160505m44d366e7if9cea8e1d3c6978b@mail.gmail.com>
	<4856EC25.5040508@earthlink.net>
	<e96e9eeb0806300506l1aaeaf6bje93db6f4f5af880e@mail.gmail.com>
	<e96e9eeb0806300509w12d1dfaen3f00db7732db80c8@mail.gmail.com>
MIME-Version: 1.0
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


On Mon, 30 Jun 2008, Voni Hakau wrote:

-> > I have successfully built expat,dbus and bluez-libs with this idea, but it seems
-> > that bluez-utils doesn't like it..
-> >
-> > Here is my configure command:
-> > BLUEZ_CFLAGS=-I/path/to/my/platform/root/usr/include
-> > BLUEZ_LIBS="-L/path/to/my/platform/root/usr/lib -lbluetooth"
-> > DBUS_LIBS="-L/path/to/my/platform/root/usr/lib -ldbus-1"
-> > DBUS_CFLAGS="-I/path/to/my/platform/root/usr/include/dbus-1.0
-> > -I/path/to/my/platform/root/usr/include/dbus-1.0/include"
-> > CPPFLAGS=-I/path/to/my/platform/root/usr/include
-> > LDFLAGS=-L/path/to/my/platform/root/usr/lib ./configure --prefix=/usr
-> > --host=arm-linux --mandir=/usr/share/man --sysconfdir=/etc
-> > --localstatedir=/var --libexecdir=/lib
-> >
-> > configure runs ok, and then make runs a little until it is doing this:
-> > arm-linux-gcc -I/path/to/my/platform/root/usr/include
-> > -I/path/to/my/platform/root/usr/include/dbus-1.0
-> > -I/path/to/my/platform/root/usr/include/dbus-1.0/include -I../eglib
-> > -I../gdbus -DPLUGINDIR=\"/usr/lib/bluetooth/plugins\" -Wall -O2
-> > -D_FORTIFY_SOURCE=2 -o hcid main.o -rdynamic
-> > -L/path/to/my/platform/root/usr/lib libhciserver.a
-> > ../sdpd/libsdpserver.a ../common/libhelper.a ../gdbus/.libs/libgdbus.a
-> > ../eglib/.libs/libeglib.a -ldl /usr/lib/libdbus-1.so
-> > /path/to/my/platform/root/usr/lib/libbluetooth.so   -Wl,--rpath
-> > -Wl,/path/to/my/platform/root/usr/lib -Wl,--rpath
-> > -Wl,/path/to/my/platform/root/usr/lib
-> > /usr/lib/libdbus-1.so: file not recognized: File format not recognized
-> > collect2: ld returned 1 exit status
-> >
-> > we can see that it tried to use my host libdbus-1.so, and it ignores
-> > the DBUS_LIBS variable..
-> >
-> > did i do something wrong ?
-> > maybe it is a bug in bluez ? do you know how to fix it or bypass it ?
-> > I tried to look in the Makefiles themselves to change this behavior
-> > but didn't find it..

Perhaps the library is mentioned in a libtool (.la) file? You should be able 
to change the Makefiles if needed. Looking in 3.34 utils, I see your libdbus-1 
is mentioned in lots of places (found with `rgrep -r 'dbus-1' . | most ` while 
cwd was /tmp/bluez-utils-3.34):

./sdpd/Makefile:DBUS_CFLAGS = -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
./sdpd/Makefile:DBUS_LIBS = -ldbus-1
./hcid/Makefile:DBUS_CFLAGS = -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include
./hcid/Makefile:DBUS_LIBS = -ldbus-1
./hcid/Makefile:#dbusdir = $(sysconfdir)/dbus-1/system.d
./hcid/Makefile:        $(top_builddir)/gdbus/libgdbus.la -Wl,--export-dynamic 
-lgmodule-2.0 -ldl -lglib-2.0   -lglib-2.0   -ldbus-1

You could try giving the full path names.

/path/to/my/platform/root/usr/lib/libdbus-1.so

DBUS_LIBS="/path/to/my/platform/root/usr/lib/libdbus-1.so "

If it still gives errors, start grepping through .la files to see if one is 
listing a -ldbus-1.


-> btw, I can also see another problem:
-> 
-> -DPLUGINDIR=\"/usr/lib/bluetooth/plugins\"
-> 
-> i don't know if it is severe..

I think yes, if that path doesn't exist on the target you are compiling for, 
because the daemons will need to load their plugins while they run on the 
target machine. If the target actually has a /usr/lib/bluetooth/plugins dir, 
then it should be OK.



-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
