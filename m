Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <1ffb4b0705032306446b2edc2b@mail.gmail.com>
From: Mike Lee <eemike@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] About obexftp cross compile
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 23 Mar 2005 22:44:00 +0800

Dear all 

    This is my config script,
./configure  --host=arm-linux --prefix=/usr/local/arm/3.3.2/arm-linux 

    The error is on line 179 , which is "FD_ZERO(&fdset);" Is this the
problem to ARM platiform? or

make[2]: Entering directory `/home/mike/elinux/app/obexftp-0.10.6/cobexbfb'
if /bin/sh ../libtool --mode=compile arm-linux-gcc -DHAVE_CONFIG_H -I.
-I. -I.. -I/usr/include -I.. -I../includes    -g -O2 -g -Wall
-Wmissing-declarations -Wmissing-prototypes -Wall -MT cobex_bfb.lo -MD
-MP -MF ".deps/cobex_bfb.Tpo" \
  -c -o cobex_bfb.lo `test -f 'cobex_bfb.c' || echo './'`cobex_bfb.c; \
then mv -f ".deps/cobex_bfb.Tpo" ".deps/cobex_bfb.Plo"; \
else rm -f ".deps/cobex_bfb.Tpo"; exit 1; \
fi
 arm-linux-gcc -DHAVE_CONFIG_H -I. -I. -I.. -I/usr/include -I..
-I../includes -g -O2 -g -Wall -Wmissing-declarations
-Wmissing-prototypes -Wall -MT cobex_bfb.lo -MD -MP -MF
.deps/cobex_bfb.Tpo -c cobex_bfb.c  -fPIC -DPIC -o .libs/cobex_bfb.o
cobex_bfb.c: In function `cobex_handleinput':
cobex_bfb.c:179: error: impossible constraint in `asm'
make[2]: *** [cobex_bfb.lo] Error 1
make[2]: Leaving directory `/home/mike/elinux/app/obexftp-0.10.6/cobexbfb'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/home/mike/elinux/app/obexftp-0.10.6'
make: *** [all] Error 2


-- 
-----------------------------------------------
Mike Lee


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
