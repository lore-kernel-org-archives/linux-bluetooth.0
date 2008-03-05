Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ Hackers <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-1cB6oM5MTzcfYlLLCp3z"
Date: Wed, 05 Mar 2008 23:45:19 +0000
Message-Id: <1204760719.2640.83.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: [Bluez-devel] [PATCH] Add some device types
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-1cB6oM5MTzcfYlLLCp3z
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

A patch to add tablets and joypads/joysticks to client.c.

I'm currently reworking the device filter to suck a bit less.

Cheers

--=-1cB6oM5MTzcfYlLLCp3z
Content-Disposition: attachment; filename=bluez-gnome-add-device-types.patch
Content-Type: text/x-patch; name=bluez-gnome-add-device-types.patch;
	charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Index: client.c
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.c,v
retrieving revision 1.41
diff -u -p -u -p -r1.41 client.c
--- client.c	11 Feb 2008 22:23:36 -0000	1.41
+++ client.c	5 Mar 2008 23:41:16 -0000
@@ -137,6 +137,10 @@ const gchar *bluetooth_type_to_string(gu
 		return N_("Camera");
 	case BLUETOOTH_TYPE_PRINTER:
 		return N_("Printer");
+	case BLUETOOTH_TYPE_JOYPAD:
+		return N_("Joypad");
+	case BLUETOOTH_TYPE_TABLET:
+		return N_("Tablet");
 	default:
 		return N_("Unknown");
 	}
@@ -163,15 +167,28 @@ static guint class_to_type(guint32 class
 	case 0x04:
 		switch ((class & 0xfc) >> 2) {
 		case 0x01:
+		case 0x02:
 			return BLUETOOTH_TYPE_HEADSET;
 		}
 		break;
 	case 0x05:
 		switch ((class & 0xc0) >> 6) {
+		case 0x00:
+			switch ((class & 0x1e) >> 2) {
+			case 0x01:
+			case 0x02:
+				return BLUETOOTH_TYPE_JOYPAD;
+			}
+			break;
 		case 0x01:
 			return BLUETOOTH_TYPE_KEYBOARD;
 		case 0x02:
-			return BLUETOOTH_TYPE_MOUSE;
+			switch ((class & 0x1e) >> 2) {
+			case 0x05:
+				return BLUETOOTH_TYPE_TABLET;
+			default:
+				return BLUETOOTH_TYPE_MOUSE;
+			}
 		}
 		break;
 	case 0x06:
Index: client.h
===================================================================
RCS file: /cvsroot/bluez/gnome/common/client.h,v
retrieving revision 1.23
diff -u -p -u -p -r1.23 client.h
--- client.h	11 Feb 2008 22:23:36 -0000	1.23
+++ client.h	5 Mar 2008 23:41:16 -0000
@@ -86,10 +86,12 @@ enum {
 	BLUETOOTH_TYPE_KEYBOARD   = 1 << 6,
 	BLUETOOTH_TYPE_MOUSE      = 1 << 7,
 	BLUETOOTH_TYPE_CAMERA     = 1 << 8,
-	BLUETOOTH_TYPE_PRINTER    = 1 << 9 
+	BLUETOOTH_TYPE_PRINTER    = 1 << 9,
+	BLUETOOTH_TYPE_JOYPAD     = 1 << 10,
+	BLUETOOTH_TYPE_TABLET     = 1 << 11,
 };
 
-#define BLUETOOTH_TYPE_NUM_TYPES 10
+#define BLUETOOTH_TYPE_NUM_TYPES 12
 #define BLUETOOTH_TYPE_INPUT (BLUETOOTH_TYPE_KEYBOARD | BLUETOOTH_TYPE_MOUSE)
 
 const gchar *bluetooth_type_to_string(guint type);

--=-1cB6oM5MTzcfYlLLCp3z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--=-1cB6oM5MTzcfYlLLCp3z
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-1cB6oM5MTzcfYlLLCp3z--
