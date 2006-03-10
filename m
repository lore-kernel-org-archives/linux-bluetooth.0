Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <62d428280603100409j4e8318a3o890d4ba137c91991@mail.gmail.com>
From: "Johan Andersen" <johan.m.andersen@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] blue-utils-2.25, dbus.c: dbus_connection_close() not found
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
Date: Fri, 10 Mar 2006 13:09:08 +0100

Hi,

I downloaded and compiled all four packages from
http://www.bluez.org/download.html
    * bluez-libs-2.25.tar.gz
    * bluez-utils-2.25.tar.gz
    * bluez-firmware-1.1.tar.gz
    * bluez-hcidump-1.30.tar.gz

I only had problems compiling bluez-utils - all other three packages
has been compiled and installed.
dbus_connection_close() in dbus.c does not seem to difined nor declared.
Where is it supposed to be? Do I need to definen some paths, or
install something else?

Here is the error message (stderr) from make:
dbus.c: In function 'hcid_dbus_exit':
dbus.c:952: warning: implicit declaration of function 'dbus_connection_clos=
e'
dbus.o(.text+0xf86): In function `hcid_dbus_exit':
dbus.c: undefined reference to `dbus_connection_close'
dbus.o(.text+0x21d2): In function `hci_signal_filter':
dbus.c: undefined reference to `dbus_connection_close'
collect2: ld returned 1 exit status
make[2]: *** [hcid] Error 1
make[1]: *** [all-recursive] Error 1
make: *** [all] Error 2

And here is part of the logging to stdout from make:

fi
if gcc -DHAVE_CONFIG_H -I. -I. -I.. -I../common   -I/usr/include
-DDBUS_API_SUBJECT_TO_CHANGE -I/usr/include/dbus-1.0
-I/usr/lib/dbus-1.0/include -DENABLE_DBUS
-DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=3D2 -MT dbus.o
-MD -MP -MF ".deps/dbus.Tpo" \
  -c -o dbus.o `test -f 'dbus.c' || echo './'`dbus.c; \
then mv -f ".deps/dbus.Tpo" ".deps/dbus.Po"; \
else rm -f ".deps/dbus.Tpo"; exit 1; \
fi
/bin/sh ../libtool --mode=3Dlink gcc -I/usr/include
-DDBUS_API_SUBJECT_TO_CHANGE -I/usr/include/dbus-1.0
-I/usr/lib/dbus-1.0/include -DENABLE_DBUS -DDBUS_API_SUBJECT_TO_CHANGE
-Wall -O2 -D_FORTIFY_SOURCE=3D2   -o hcid  main.o security.o storage.o
lib.o parser.o lexer.o kword.o dbus.o -L/usr/lib -ldbus-1  -L/usr/lib
-lbluetooth ../common/libglib-ectomy.a ../common/libtextfile.a
mkdir .libs
gcc -I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE
-I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DENABLE_DBUS
-DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -D_FORTIFY_SOURCE=3D2 -o hcid
main.o security.o storage.o lib.o parser.o lexer.o kword.o
dbus.o  -L/usr/lib -ldbus-1 /usr/lib/libbluetooth.so ../common/libglib-ecto=
my.a
../common/libtextfile.a
make[2]: Leaving directory `/home/johan/bluetooth/bluez-utils-2.25/hcid'
make[1]: Leaving directory `/home/johan/bluetooth/bluez-utils-2.25'

Best regards,
Johan


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
