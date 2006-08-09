Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44D9CCF1.9060102@prolly.org>
Date: Wed, 09 Aug 2006 07:54:25 -0400
From: Douglas Ward <douglas.ward@prolly.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------000805070702060703080208"
Subject: [Bluez-devel] logitech mx 5000
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------000805070702060703080208
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

here... this makes (046d:0b02) switch to HCI mode. I'm not sure why
but it requires that the switch command be sent to both the emulated
keyboard and mouse devices. switching one seems to make the hci device
show up, but it doesn't actually function. I don't know enough about
bluez to do anymore then this. my mx 5000 combo have been working in
bluetooth mode for quite some time now and i even reported my success
on this mailing list. the other keyboard set (dinovo?) with this
dongle may need its emulated devices added as well.


--------------000805070702060703080208
Content-Type: text/x-patch;
 name="mx5000.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mx5000.patch"

? mx5000.patch
Index: tools/hid2hci.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hid2hci.c,v
retrieving revision 1.10
diff -u -r1.10 hid2hci.c
--- tools/hid2hci.c	12 Apr 2006 22:03:51 -0000	1.10
+++ tools/hid2hci.c	9 Aug 2006 11:46:51 -0000
@@ -222,7 +222,8 @@
 	{ HCI, 0x046d, 0xc703, switch_logitech },
 	{ HCI, 0x046d, 0xc704, switch_logitech },
 	{ HCI, 0x046d, 0xc705, switch_logitech },
-	{ HCI, 0x046d, 0x0b02, switch_logitech },	/* Logitech diNovo Media Desktop Laser */
+	{ HCI, 0x046d, 0xc70a, switch_logitech },	/* Logitech MX 5000 part1 */
+	{ HCI, 0x046d, 0xc70e, switch_logitech },	/* logitech MX 5000 part2 */
 	{ -1 }
 };
 

--------------000805070702060703080208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------000805070702060703080208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------000805070702060703080208--
