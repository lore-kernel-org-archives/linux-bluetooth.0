Return-Path: <cyrus@holtmann.org>
From: "Marcin Kijewski " <marcin.kijewski@pruftechnik.com.pl>
To: <linux-bluetooth@vger.kernel.org>
Subject: cross compile bluez 4.40 for ARM
Date: Fri, 22 May 2009 16:36:17 +0200
Message-ID: <9BC2E7448C24410C8868C690FF4C21E8@kijewski>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I have been trying to cross compile bluez 4.40 on ARM processor.

I configured bluez 4.40 by writing:
$ ./configure --host=arm-linux

Configuration seems to be ok.

Then I tried to make the library:
$ make

During compilation attempt I got following error:
(...)
arm-linux-gcc -DHAVE_CONFIG_H -I. -I.. -finline-functions
-fgcse-after-reload -funswitch-loops -funroll-loops -Wall -O2
-D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2 -MT libsbc_la-sbc.lo -MD -MP -MF
.deps/libsbc_la-sbc.Tpo -c sbc.c  -fPIC -DPIC -o .libs/libsbc_la-sbc.o
cc1: unrecognized option `-fgcse-after-reload'
cc1: unrecognized option `-funswitch-loops'
make[2]: *** [libsbc_la-sbc.lo] Error 1
make[2]: Leaving directory `/projects/bluetooth/bluez-4.40/sbc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/projects/bluetooth/bluez-4.40'
make: *** [all] Error 2

I tried to remove `-fgcse-after-reload' and `-funswitch-loops' from
"Makefile", "Makefile.in" and " Makefile.am" files.
In this case I got following error:
(...)
arm-linux-gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2 -o sbcinfo
sbcinfo.o
arm-linux-gcc -DHAVE_CONFIG_H -I. -I..     -Wall -O2 -D_FORTIFY_SOURCE=2
-D_FORTIFY_SOURCE=2 -MT sbcdec.o -MD -MP -MF .deps/sbcdec.Tpo -c -o sbcdec.o
sbcdec.c
mv -f .deps/sbcdec.Tpo .deps/sbcdec.Po
/bin/sh ../libtool --tag=CC   --mode=link arm-linux-gcc  -Wall -O2
-D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2   -o sbcdec sbcdec.o libsbc.la
arm-linux-gcc -Wall -O2 -D_FORTIFY_SOURCE=2 -D_FORTIFY_SOURCE=2 -o sbcdec
sbcdec.o  ./.libs/libsbc.a
./.libs/libsbc.a(libsbc_la-sbc_primitives.o)(.text+0x1f20): In function
`sbc_calc_scalefactors':
: undefined reference to `__builtin_clz'
collect2: ld returned 1 exit status
make[2]: *** [sbcdec] Error 1
make[2]: Leaving directory `/projects/bluetooth/bluez-4.40/sbc'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/projects/bluetooth/bluez-4.40'
make: *** [all] Error 2

I use arm compiler version 3.2.1

Can anybody help me ?
Should I use arm-compiler newer than 3.2.1 ?

Best Regards,

Marcin Kijewski

PRUFTECHNIK Technology sp. z o.o.
ul.Sulowska 43
51-180 Wroclaw, POLAND
Tel:    +48 71 326 57 34
Fax:    +48 71 326 57 10
http://www.pruftechnik-technology.pl/

------------------------------------------------------------
This e-mail is confidential and may be legally privileged.
It is intended solely for the addressee.
Access to this e-mail by anyone else is unauthorized.
If you have received this e-mail in error, please notify
info@pruftechnik.com.pl

PRUFTECHNIK Technology cannot guarantee that any files attached to this
e-mail 
are free from viruses or any other program code that may be harmful to your
computer, 
and, as such, is not liable for any damage that may be caused as a result. 
PRUFTECHNIK Technology reserves the right to monitor all e-mail
communications through 
its networks.



