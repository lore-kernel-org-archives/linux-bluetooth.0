Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Petri T. Koistinen" <petri.koistinen@iki.fi>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0402050206210.3075@dsl-hkigw4m08.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-devel] [PATCH] Bluetooth URL updates: www.bluez.org
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 5 Feb 2004 02:35:52 +0200 (EET)

Hi!

Little updates, don't know if these are correct, but at least
bluez.sourceforge.net seems to redirect to www.bluez.org.

Petri

--- linux-2.6/drivers/bluetooth/Kconfig.orig	2004-02-05 02:24:39.000000000 +0200
+++ linux-2.6/drivers/bluetooth/Kconfig	2004-02-05 02:25:08.000000000 +0200
@@ -113,7 +113,7 @@
 	     HP Bluetooth Card

 	  The HCI BT3C driver uses external firmware loader program provided in
-	  the BlueFW package. For more information, see <http://bluez.sf.net>.
+	  the BlueFW package. For more information, see <http://www.bluez.org/>.

 	  Say Y here to compile support for HCI BT3C devices into the
 	  kernel or say M to compile it as module (bt3c_cs).


--- linux-2.6/net/bluetooth/Kconfig.orig	2004-02-05 02:14:50.000000000 +0200
+++ linux-2.6/net/bluetooth/Kconfig	2004-02-05 02:17:46.000000000 +0200
@@ -29,7 +29,7 @@
 	  To use Linux Bluetooth subsystem, you will need several user-space
 	  utilities like hciconfig and hcid.  These utilities and updates to
 	  Bluetooth kernel modules are provided in the BlueZ packages.
-	  For more information, see <http://bluez.sourceforge.net/>.
+	  For more information, see <http://www.bluez.org/>.

 	  If you want to compile Bluetooth Core as module (bluetooth) say M here.


--- linux-2.6/net/bluetooth/bnep/Kconfig.orig	2004-02-05 02:05:01.000000000 +0200
+++ linux-2.6/net/bluetooth/bnep/Kconfig	2004-02-05 02:05:40.000000000 +0200
@@ -8,8 +8,7 @@
 	  PAN (Personal Area Network).

 	  To use BNEP, you will need user-space utilities provided in the
-	  BlueZ-PAN package.
-	  For more information, see <http://bluez.sourceforge.net>.
+	  BlueZ-PAN package. For more information, see <http://www.bluez.org/>.

 	  Say Y here to compile BNEP support into the kernel or say M to
 	  compile it as module (bnep).


--- linux-2.6/MAINTAINERS.orig	2004-02-05 02:10:04.000000000 +0200
+++ linux-2.6/MAINTAINERS	2004-02-05 02:11:47.000000000 +0200
@@ -343,7 +343,7 @@
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
 L:	bluez-devel@lists.sf.net
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BLUETOOTH RFCOMM LAYER
@@ -351,7 +351,7 @@
 M:	marcel@holtmann.org
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BLUETOOTH BNEP LAYER
@@ -359,7 +359,7 @@
 M:	marcel@holtmann.org
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BLUETOOTH CMTP LAYER
@@ -373,7 +373,7 @@
 M:	marcel@holtmann.org
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BLUETOOTH HCI UART DRIVER
@@ -381,7 +381,7 @@
 M:	marcel@holtmann.org
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BLUETOOTH HCI BCM203X DRIVER
@@ -423,7 +423,7 @@
 BLUETOOTH HCI VHCI DRIVER
 P:	Maxim Krasnyansky
 M:	maxk@qualcomm.com
-W:	http://bluez.sf.net
+W:	http://www.bluez.org/
 S:	Maintained

 BONDING DRIVER


--- linux-2.6/CREDITS.orig	2004-02-05 02:22:13.000000000 +0200
+++ linux-2.6/CREDITS	2004-02-05 02:23:14.000000000 +0200
@@ -1728,7 +1728,7 @@
 N: Maxim Krasnyansky
 E: maxk@qualcomm.com
 W: http://vtun.sf.net
-W: http://bluez.sf.net
+W: http://www.bluez.org/
 D: Author of the Universal TUN/TAP driver
 D: Author of the Linux Bluetooth Subsystem (BlueZ)
 D: Various other kernel patches, cleanups and fixes


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
