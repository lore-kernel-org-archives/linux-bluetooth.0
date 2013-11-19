Return-Path: <cyrus@holtmann.org>
Message-ID: <1384867741.2027.35.camel@nuvo>
Subject: [PATCH] autopair: Generate a specific pincode for the iCade
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Tue, 19 Nov 2013 14:29:01 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


We can't easily enter digits other than 1 through 4 (inclusive)
so generate a random pincode that it will be possible to enter.
---
 plugins/autopair.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 8c98c12..168a873 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -57,13 +57,32 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 {
 	char addr[18];
 	char pinstr[7];
+	char name[25];
 	uint32_t class;
 
 	ba2str(device_get_address(device), addr);
 
 	class = btd_device_get_class(device);
 
-	DBG("device %s 0x%x", addr, class);
+	device_get_name(device, name, sizeof(name));
+	name[sizeof(name) - 1] = 0;
+
+	DBG("device %s (%s) 0x%x", addr, name, class);
+
+	/* Only try this special PIN for the first attempt */
+	if (attempt == 0) {
+		if (g_str_equal(name, "iCade")) {
+			guint i;
+
+			for (i = 0; i < 6; i++) {
+				/* '1', '2', '3' or '4' */
+				pinbuf[i] = g_random_int_range('1', '5');
+			}
+			pinbuf[6] = 0;
+			*display = true;
+			return 6;
+		}
+	}
 
 	/* This is a class-based pincode guesser. Ignore devices with an
 	 * unknown class.
-- 
1.8.4.2


