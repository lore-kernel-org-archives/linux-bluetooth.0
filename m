Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 12 Jul 2006 21:05:53 +0200
From: barthelemy.lemaire@gmail.com
To: Bluez-devel@lists.sourceforge.net
Message-Id: <20060712210553.dad90888.barthelemy.lemaire@gmail.com>
Mime-Version: 1.0
Subject: [Bluez-devel] Compilation of a simple program (Debian Sid)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hello all,

I started Bluetooth Linux development yesterday and I'm having a problem in=
 compiling the very simple program shown below : =


I'm running Debian Sid and the incriminated headers are in the libbluetooth=
2-dev package (Version=A0: 3.1-1). Did I miss something? is there a bug in =
the package?

Thanks in advance

Barth


bluetooth.c:

#define EXIT_SUCCESS 0

#include <stdlib.h>
#include <netdb.h>
#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>

int main ( int argc, char *argv[] )
{
	return EXIT_SUCCESS;
}				/* ----------  end of function main  ---------- */


Makefile : =


CFLAGS =3D -Wall -ansi
LDLAGS =3D -Wall -ansi =

EXEC =3D b
LIBRARY=3D -lbluetooth

$(EXEC):$(EXEC).o
	gcc -o $@ $^
$(EXEC).o:$(EXEC).c
	gcc -o $@ -c $^ $(CFLAGS) $(LIBRARY)


Here is the output : =


barth@debian:~/dev$ make
gcc -o bluetooth.o -c bluetooth.c -Wall -ansi -lbluetooth
In file included from bluetooth.c:23:
/usr/include/bluetooth/bluetooth.h:113: error: expected '=3D', ',', ';', 'a=
sm' or '__attribute__' before 'int'
/usr/include/bluetooth/bluetooth.h:117: error: expected '=3D', ',', ';', 'a=
sm' or '__attribute__' before 'void'
In file included from bluetooth.c:25:
/usr/include/bluetooth/hci_lib.h:137: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:142: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:147: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'int'
/usr/include/bluetooth/hci_lib.h:153: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:157: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:161: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:165: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'int'
/usr/include/bluetooth/hci_lib.h:169: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:173: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:177: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:181: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'int'
/usr/include/bluetooth/hci_lib.h:185: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:189: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:193: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'void'
/usr/include/bluetooth/hci_lib.h:197: error: expected '=3D', ',', ';', 'asm=
' or '__attribute__' before 'int'
make: *** [bluetooth.o] Erreur 1








-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
