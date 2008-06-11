Return-Path: <cyrus@holtmann.org>
Message-ID: <95bb57cb0806110251xe9cc530v80224cfd836aef05@mail.gmail.com>
Date: Wed, 11 Jun 2008 11:51:41 +0200
From: "nico bats" <sl1200mk2@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] compile on apple
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1326357016=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1326357016==
Content-Type: multipart/alternative;
	boundary="----=_Part_34437_22952518.1213177901315"

------=_Part_34437_22952518.1213177901315
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,
i've tried to compile Bluez on macbookpro and came across error:

/bin/sh ../libtool --tag=CC   --mode=compile gcc -DHAVE_CONFIG_H -I. -I..
-I../include    -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF
.deps/bluetooth.Tpo -c -o bluetooth.lo bluetooth.c
mkdir .libs
 gcc -DHAVE_CONFIG_H -I. -I.. -I../include -Wall -O2 -D_FORTIFY_SOURCE=2 -MT
bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo -c bluetooth.c  -fno-common
-DPIC -o .libs/bluetooth.o
bluetooth.c:35:20: error: malloc.h: No such file or directory
In file included from bluetooth.c:39:
../include/bluetooth/bluetooth.h:36:20: error: endian.h: No such file or
directory
../include/bluetooth/bluetooth.h:37:22: error: byteswap.h: No such file or
directory

does macros included in endian.h & byteswap.h can be coded in a portable way
?
best regards
nicolas

------=_Part_34437_22952518.1213177901315
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

hi all,<br>i&#39;ve tried to compile Bluez on macbookpro and came across error:<br><br>/bin/sh ../libtool --tag=CC&nbsp;&nbsp; --mode=compile gcc -DHAVE_CONFIG_H -I. -I.. -I../include&nbsp;&nbsp;&nbsp; -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo -c -o bluetooth.lo bluetooth.c<br>
mkdir .libs<br>&nbsp;gcc -DHAVE_CONFIG_H -I. -I.. -I../include -Wall -O2 -D_FORTIFY_SOURCE=2 -MT bluetooth.lo -MD -MP -MF .deps/bluetooth.Tpo -c bluetooth.c&nbsp; -fno-common -DPIC -o .libs/bluetooth.o<br>bluetooth.c:35:20: error: malloc.h: No such file or directory<br>
In file included from bluetooth.c:39:<br>../include/bluetooth/bluetooth.h:36:20: error: endian.h: No such file or directory<br>../include/bluetooth/bluetooth.h:37:22: error: byteswap.h: No such file or directory<br><br>does macros included in endian.h &amp; byteswap.h can be coded in a portable way ?<br>
best regards<br>nicolas<br>

------=_Part_34437_22952518.1213177901315--


--===============1326357016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
--===============1326357016==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1326357016==--
