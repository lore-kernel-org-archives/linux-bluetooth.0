Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <435FFD9B.1030904@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] Makefile.am dependency problem
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
Date: Wed, 26 Oct 2005 16:05:15 -0600

Hi

I noticed a strange dependency problem... it's common in bluez where a
library is used. Header file changes don't force a recompile:

bmidgley@jag:/usr/src/bluez/utils/common$ make
make: Nothing to be done for `all'.
bmidgley@jag:/usr/src/bluez/utils/common$ touch textfile.h
bmidgley@jag:/usr/src/bluez/utils/common$ make
make: Nothing to be done for `all'.
bmidgley@jag:/usr/src/bluez/utils/common$ touch textfile.c
bmidgley@jag:/usr/src/bluez/utils/common$ make
gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c textfile.c
rm -f libtextfile.a
ar cru libtextfile.a textfile.o
ranlib libtextfile.a
/bin/sh ../libtool --tag=CC --mode=link gcc  -Wall -O2   -o
test_textfile  test_textfile.o libtextfile.a
gcc -Wall -O2 -o test_textfile test_textfile.o  libtextfile.a

Makefile.am has a line that mentions textfile.h:

libtextfile_a_SOURCES = textfile.h textfile.c

but that doesn't seem to be enough.

In btsco/sbc, the problem is similar, except that the .a is rebuilt
(when its .o object really needs to be rebuilt too):

bmidgley@jag:/usr/src/btsco/sbc$ touch sbc.h
bmidgley@jag:/usr/src/btsco/sbc$ make
rm -f libsbc.a
ar cru libsbc.a sbc.o
ranlib libsbc.a
gcc  -DUSE_FIXED  -Wall -O2   -o sbcdec  sbcdec.o libsbc.a -lasound -lm
-ldl -lpthread -lbluetooth
gcc  -DUSE_FIXED  -Wall -O2   -o sbcenc  sbcenc.o libsbc.a -lasound -lm
-ldl -lpthread -lbluetooth
bmidgley@jag:/usr/src/btsco/sbc$ touch sbc.c
bmidgley@jag:/usr/src/btsco/sbc$ make
gcc -DHAVE_CONFIG_H -I. -I. -I..     -DUSE_FIXED  -Wall -O2 -c `test -f
'sbc.c' || echo './'`sbc.c
rm -f libsbc.a
ar cru libsbc.a sbc.o
ranlib libsbc.a
gcc  -DUSE_FIXED  -Wall -O2   -o sbcdec  sbcdec.o libsbc.a -lasound -lm
-ldl -lpthread -lbluetooth
gcc  -DUSE_FIXED  -Wall -O2   -o sbcenc  sbcenc.o libsbc.a -lasound -lm
-ldl -lpthread -lbluetooth

Brad


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
