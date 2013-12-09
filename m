Return-Path: <cyrus@holtmann.org>
Message-ID: <1386608891.5021.1.camel@nuvo>
Subject: [PATCH] autopair: Don't handle the iCade
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Date: Mon, 09 Dec 2013 18:08:11 +0100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


We can't easily enter digits other than 1 through 4 (inclusive)
so leave it up to the agent to figure out a good passcode
for the iCade.

Note that we can not use the VID/PID of the device, as it is not
yet known at that point.
---
 plugins/autopair.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 8c98c12..5d2f6f7 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -57,13 +57,23 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
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
+	g_message ("vendor 0x%X product: 0x%X", btd_device_get_vendor (device), btd_device_get_product (device));
+
+	/* The iCade shouldn't use random PINs like normal keyboards */
+	if (name != NULL && strstr(name, "iCade") != NULL)
+		return 0;
 
 	/* This is a class-based pincode guesser. Ignore devices with an
 	 * unknown class.
-- 
1.8.4.2


