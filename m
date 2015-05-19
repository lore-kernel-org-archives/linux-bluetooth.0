Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/hidhost: Fix connecting HOGP over BREDR
Date: Tue, 19 May 2015 10:25:11 +0200
Message-Id: <1432023911-7694-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes issue related to HID connection over BREDR.
To avoid HOG connection with dual mode device connected over
BREDR, bdaddr_type is checked, so that 'if' condition tests
connection type, not the features of remote device.
---
 android/hidhost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 729b884..100432f 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -874,6 +874,7 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	bdaddr_t dst;
 	GSList *l;
 	uuid_t uuid;
+	uint8_t bdaddr_type;
 
 	DBG("");
 
@@ -891,7 +892,9 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
 
-	if (bt_is_device_le(&dst)) {
+	bt_get_id_addr(&dst, &bdaddr_type);
+
+	if (bdaddr_type != BDADDR_BREDR) {
 		if (!hog_connect(dev)) {
 			status = HAL_STATUS_FAILED;
 			hid_device_remove(dev);
-- 
1.9.1

