Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Luciano Coelho <luciano.coelho@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-+q7q9B8ZTi/Y2PsgkpjR"
Date: Tue, 07 Nov 2006 11:56:49 +0200
Message-Id: <1162893409.5068.23.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] Patch with small CoD changes in hciconfig and hcitool
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


--=-+q7q9B8ZTi/Y2PsgkpjR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I was using hciconfig to perform some tests and I realized that there
were a few omissions and small mistakes in the way hciconfig and hcitool
were converting CoD information to strings.

I've created a small patch to fix this.  It's the first patch I send to
this list, so forgive me if there is any "childish" mistake or style
flaw in it ;-) Any comments are welcome.

Cheers,
Luca.

--=-+q7q9B8ZTi/Y2PsgkpjR
Content-Disposition: attachment; filename=hciconfig_cod.patch
Content-Type: text/x-patch; name=hciconfig_cod.patch; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 7bit

--- tools/hciconfig.c	26 Jul 2006 13:09:44 -0000	1.82
+++ tools/hciconfig.c	7 Nov 2006 09:47:46 -0000
@@ -597,16 +597,51 @@
 			return "Gaming/Toy";
 		}
 		break;
-	case 5:	/* peripheral */
-		switch(minor) {
+	case 5:	/* peripheral */ {
+		static char cls_str[48]; cls_str[0] = 0;
+
+		switch(minor & 48) {
 		case 16:
-			return "Keyboard";
+			strncpy(cls_str, "Keyboard", sizeof(cls_str));
+			break;
 		case 32:
-			return "Pointing device";
+			strncpy(cls_str, "Pointing device", sizeof(cls_str));
+			break;
 		case 48:
-			return "Combo keyboard/pointing device";
+			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
+			break;
 		}
-		break;
+		if((minor & 15) && (strlen(cls_str) > 0))
+			strcat(cls_str, "/");
+
+		switch(minor & 15) {
+		case 0:
+			break;
+		case 1:
+			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 2:
+			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 3:
+			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 4:
+			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 5:
+			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 6:
+			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
+			break;
+		default:
+			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
+			break;
+		}
+		if(strlen(cls_str) > 0)
+			return cls_str;
+	}
 	case 6:	/* imaging */
 		if (minor & 4)
 			return "Display";
@@ -617,6 +652,34 @@
 		if (minor & 32)
 			return "Printer";
 		break;
+	case 7: /* wearable */
+		switch(minor) {
+		case 1:
+			return "Wrist Watch";
+		case 2:
+			return "Pager";
+		case 3:
+			return "Jacket";
+		case 4:
+			return "Helmet";
+		case 5:
+			return "Glasses";
+		}
+		break;
+	case 8: /* toy */
+		switch(minor) {
+		case 1:
+			return "Robot";
+		case 2:
+			return "Vehicle";
+		case 3:
+			return "Doll / Action Figure";
+		case 4:
+			return "Controller";
+		case 5:
+			return "Game";
+		}
+		break;
 	case 63:	/* uncategorised */
 		return "";
 	}
Index: tools/hcitool.c
===================================================================
RCS file: /cvsroot/bluez/utils/tools/hcitool.c,v
retrieving revision 1.91
diff -u -r1.91 hcitool.c
--- tools/hcitool.c	29 Sep 2006 11:42:14 -0000	1.91
+++ tools/hcitool.c	7 Nov 2006 09:47:47 -0000
@@ -245,16 +245,51 @@
 			return "Gaming/Toy";
 		}
 		break;
-	case 5:	/* peripheral */
-		switch(minor) {
+	case 5:	/* peripheral */ {
+		static char cls_str[48]; cls_str[0] = 0;
+
+		switch(minor & 48) {
 		case 16:
-			return "Keyboard";
+			strncpy(cls_str, "Keyboard", sizeof(cls_str));
+			break;
 		case 32:
-			return "Pointing device";
+			strncpy(cls_str, "Pointing device", sizeof(cls_str));
+			break;
 		case 48:
-			return "Combo keyboard/pointing device";
+			strncpy(cls_str, "Combo keyboard/pointing device", sizeof(cls_str));
+			break;
 		}
+		if((minor & 15) && (strlen(cls_str) > 0))
+			strcat(cls_str, "/");
+
+		switch(minor & 15) {
+		case 0:
+			break;
+		case 1:
+			strncat(cls_str, "Joystick", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 2:
+			strncat(cls_str, "Gamepad", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 3:
+			strncat(cls_str, "Remote control", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 4:
+			strncat(cls_str, "Sensing device", sizeof(cls_str) - strlen(cls_str));
+			break;
+		case 5:
+			strncat(cls_str, "Digitizer tablet", sizeof(cls_str) - strlen(cls_str));
 		break;
+		case 6:
+			strncat(cls_str, "Card reader", sizeof(cls_str) - strlen(cls_str));
+			break;
+		default:
+			strncat(cls_str, "(reserved)", sizeof(cls_str) - strlen(cls_str));
+			break;
+		}
+		if(strlen(cls_str) > 0)
+			return cls_str;
+	}
 	case 6:	/* imaging */
 		if (minor & 4)
 			return "Display";
@@ -265,6 +300,34 @@
 		if (minor & 32)
 			return "Printer";
 		break;
+	case 7: /* wearable */
+		switch(minor) {
+		case 1:
+			return "Wrist Watch";
+		case 2:
+			return "Pager";
+		case 3:
+			return "Jacket";
+		case 4:
+			return "Helmet";
+		case 5:
+			return "Glasses";
+		}
+		break;
+	case 8: /* toy */
+		switch(minor) {
+		case 1:
+			return "Robot";
+		case 2:
+			return "Vehicle";
+		case 3:
+			return "Doll / Action Figure";
+		case 4:
+			return "Controller";
+		case 5:
+			return "Game";
+		}
+		break;
 	case 63:	/* uncategorised */
 		return "";
 	}

--=-+q7q9B8ZTi/Y2PsgkpjR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--=-+q7q9B8ZTi/Y2PsgkpjR
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-+q7q9B8ZTi/Y2PsgkpjR--
