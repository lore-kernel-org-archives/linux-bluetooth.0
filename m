Return-Path: <liziero.diego@unimore.it>
Subject: [patch] hciattach: added other serial speeds and small help fix.
From: Diego Liziero <liziero.diego@unimore.it>
Reply-To: diego.liziero@unimore.it
To: "'BlueZ Mailing List'" <bluez-devel@lists.sourceforge.net>
Cc: Marcel Holtmann <marcel@holtmann.org>
Content-Type: multipart/mixed; boundary="=-ly0xfpXGY3XZlvOgqYAj"
Message-Id: <1095695153.15993.40.camel@igno>
Mime-Version: 1.0
Date: Mon, 20 Sep 2004 17:45:53 +0200
List-ID: <bluez-devel.lists.sourceforge.net>


--=-ly0xfpXGY3XZlvOgqYAj
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I spent a couple of hours before understanding that to disable
flow control in H4 modules I needed to put the word "noflow" instead
of just omitting the word "flow" :)

That's why I propose this help change.

Added also other speeds (tested with a csr based module).

Regards,
Diego.


--=-ly0xfpXGY3XZlvOgqYAj
Content-Disposition: attachment; filename=patch-bluez-utils-2.10-hciattach
Content-Type: text/plain; name=patch-bluez-utils-2.10-hciattach; charset=us-ascii
Content-Transfer-Encoding: 7bit

--- bluez-utils-2.10/tools/hciattach.c	2004-07-25 19:09:23.000000000 +0200
+++ bluez-utils-2.10-new/tools/hciattach.c	2004-09-20 17:00:09.000000000 +0200
@@ -84,12 +84,18 @@
 		return B230400;
 	case 460800:
 		return B460800;
+	case 500000:
+		return B500000;
+	case 576000:
+		return B576000;
 	case 921600:
 		return B921600;
 	case 1000000:
 		return B1000000;
 	case 1152000:
 		return B1152000;
+	case 1500000:
+		return B1500000;
 	default:
 		return B57600;
 	}
@@ -932,7 +938,7 @@
 {
 	printf("hciattach - HCI UART driver initialization utility\n");
 	printf("Usage:\n");
-	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow]\n");
+	printf("\thciattach [-n] [-p] [-b] [-t timeout] [-s initial_speed] <tty> <type | id> [speed] [flow|noflow]\n");
 	printf("\thciattach -l\n");
 }
 

--=-ly0xfpXGY3XZlvOgqYAj--
