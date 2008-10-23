Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Add support for pairing a few GPS devices
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-HqZWo2iFlMERZpgL6uU6"
Date: Thu, 23 Oct 2008 22:54:07 +0100
Message-Id: <1224798847.2895.224.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-HqZWo2iFlMERZpgL6uU6
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Add support for hard-coded pincodes for a few GPS devices, one being
mine, the other being mentioned by Ralph Loader in
https://bugzilla.redhat.com/show_bug.cgi?id=464446

Cheers

--=-HqZWo2iFlMERZpgL6uU6
Content-Disposition: attachment; filename="0001-Add-support-for-pairing-a-few-GPS-devices.patch"
Content-Type: text/x-patch; name="0001-Add-support-for-pairing-a-few-GPS-devices.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 91d5a9fc32f990c92fa5091c046ccbb6ed2e72e0 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Thu, 23 Oct 2008 22:51:30 +0100
Subject: [PATCH] Add support for pairing a few GPS devices

Add support for hard-coded pincodes for a few GPS devices, one being
mine, the other being mentioned by Ralph Loader in
https://bugzilla.redhat.com/show_bug.cgi?id=464446
---
 wizard/main.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/wizard/main.c b/wizard/main.c
index 6f0b035..a20e280 100644
--- a/wizard/main.c
+++ b/wizard/main.c
@@ -75,6 +75,14 @@ static gboolean pincode_callback(DBusGMethodInvocation *context,
 				target_type == BLUETOOTH_TYPE_HEADPHONE)
 		pincode = "0000";
 
+	/* Most GPS devices also use 0000 as pincode */
+	if (g_str_has_prefix(target_address, "00:0D:B5") == TRUE &&
+				(g_str_equal(target_name,
+							"TomTom Wireless GPS MkII") == TRUE ||
+				g_str_equal(target_name,
+							"GPS-GW-005") == TRUE))
+		pincode = "0000";
+
 	text = g_strdup_printf(_("Please enter the following PIN code: %s"),
 								pincode);
 	gtk_label_set_markup(GTK_LABEL(label_passkey), text);
-- 
1.6.0.3


--=-HqZWo2iFlMERZpgL6uU6--

