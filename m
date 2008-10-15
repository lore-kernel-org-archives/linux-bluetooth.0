Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Fix Apple Wireless keyboard pairing?
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-eobfszUDYa3sHApVJP8U"
Date: Wed, 15 Oct 2008 02:06:23 +0100
Message-Id: <1224032783.5268.1418.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-eobfszUDYa3sHApVJP8U
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Heya,

If anyone has an Apple Wireless keyboard to test pairing against. I
believe the attached patch to be correct. Otherwise Apple keyboards
(which use the same OUI) will get a PIN of 0000.

Cheers

--=-eobfszUDYa3sHApVJP8U
Content-Disposition: attachment; filename="bluez-apple-wireless-kbd.patch"
Content-Type: text/x-patch; name="bluez-apple-wireless-kbd.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

diff --git a/wizard/main.c b/wizard/main.c
index 0854913..0340063 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -62,9 +62,10 @@ static gboolean pincode_callback(DBusGMethodInvocation *context,
 	const char *pincode = target_pincode;
 	gchar *text;
 
-	/* Apple Wireless and Mighty Mouse */
-	if (g_str_has_prefix(target_address, "00:0A:95:") == TRUE ||
-			g_str_has_prefix(target_address, "00:14:51:") == TRUE)
+	/* Apple Wireless and Mighty Mouse, and just the mice */
+	if ((g_str_has_prefix(target_address, "00:0A:95:") == TRUE ||
+			g_str_has_prefix(target_address, "00:14:51:") == TRUE) &&
+	    target_type == BLUETOOTH_TYPE_MOUSE)
 		pincode = "0000";
 
 	/* Most headsets are using 0000 as pincode */

--=-eobfszUDYa3sHApVJP8U--

