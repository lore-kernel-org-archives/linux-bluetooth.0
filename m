Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <3e9cdced0805160215k26da6656x36a6005400c55c50@mail.gmail.com>
References: <3e9cdced0805160215k26da6656x36a6005400c55c50@mail.gmail.com>
Date: Fri, 16 May 2008 11:31:07 +0200
Message-Id: <1210930267.7025.79.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] arm cross-compile problem with sockios.h
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

Hi Fritz,

> I try to cross compile blueu-utils 3-31 with my linux-arm-gcc
> crosscompiler.
> 
> the build-process fails at the following position:
> 
> bin/sh ../libtool --tag=CC   --mode=compile arm-linux-gcc
> -DHAVE_CONFIG_H -I. -I.. -I../common -I../hcid -I../sdpd
> -I/opt/devel/toolchains/arm9/arm-linux/include/dbus-1.0
> -I/opt/devel/toolchains/arm9/arm-linux/lib/dbus-1.0/include -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bridge.lo -MD -MP
> -MF .deps/bridge.Tpo -c -o bridge.lo bridge.c
>  arm-linux-gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../hcid
> -I../sdpd -I/opt/devel/toolchains/arm9/arm-linux/include/dbus-1.0
> -I/opt/devel/toolchains/arm9/arm-linux/lib/dbus-1.0/include -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bridge.lo -MD -MP
> -MF .deps/bridge.Tpo -c bridge.c  -fPIC -DPIC -o .libs/bridge.o
> bridge.c: In function `bridge_create':
> bridge.c:82: error: `SIOCBRADDBR' undeclared (first use in this
> function)
> bridge.c:82: error: (Each undeclared identifier is reported only once
> bridge.c:82: error: for each function it appears in.)
> bridge.c: In function `bridge_remove':
> bridge.c:98: error: `SIOCBRDELBR' undeclared (first use in this
> function)
> bridge.c: In function `bridge_add_interface':
> bridge.c:121: error: `SIOCBRADDIF' undeclared (first use in this
> function)
> make[2]: *** [bridge.lo] Fehler 1
> 
> Taking a look at my arm toolchain folder in the header
> include/linux/sockios.h the defines are missing.
> 
> Taking a look at my local build system (i386)
> in /usr/include/linux/sockios.h the defines are there.
> 
> But both headers are the same version @(#)sockios.h   1.0.2
> 03/09/93.
> 
> If i add the necessary defines to the header of my cross-compiler the
> described error doesn't occur anymore, but
> I run into the following:
> 
> bin/sh ../libtool --tag=CC   --mode=compile arm-linux-gcc
> -DHAVE_CONFIG_H -I. -I.. -I../common -I../hcid
> -I/opt/devel/toolchains/arm9/arm-linux/include/dbus-1.0
> -I/opt/devel/toolchains/arm9/arm-linux/lib/dbus-1.0/include -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2 -MT device.lo -MD -MP
> -MF .deps/device.Tpo -c -o device.lo device.c
>  arm-linux-gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../hcid
> -I/opt/devel/toolchains/arm9/arm-linux/include/dbus-1.0
> -I/opt/devel/toolchains/arm9/arm-linux/lib/dbus-1.0/include -I../eglib
> -Wall -O2 -D_FORTIFY_SOURCE=2 -MT device.lo -MD -MP
> -MF .deps/device.Tpo -c device.c  -fPIC -DPIC -o .libs/device.o
> device.c: In function `hidp_connadd':
> device.c:531: error: `ENOKEY' undeclared (first use in this function)
> device.c:531: error: (Each undeclared identifier is reported only once
> device.c:531: error: for each function it appears in.)
> make[2]: *** [device.lo] Fehler 1

replace it with EACCES. I changed the CVS to do them same already.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
