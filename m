Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/12] android/bluetooth: Use configured values for DID
Date: Tue, 30 Sep 2014 13:06:20 +0200
Message-Id: <1412075187-5518-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
References: <1412075187-5518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index c7ccf9d..3016ea4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -94,10 +94,6 @@
 #define DEVICES_FILE ANDROID_STORAGEDIR"/devices"
 #define CACHE_FILE ANDROID_STORAGEDIR"/cache"
 
-#define DEVICE_ID_SOURCE	0x0002	/* USB */
-#define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
-#define DEVICE_ID_PRODUCT	0x0247	/* BlueZ for Android */
-
 #define ADAPTER_MAJOR_CLASS 0x02 /* Phone */
 #define ADAPTER_MINOR_CLASS 0x03 /* Smartphone */
 
@@ -2827,26 +2823,21 @@ static void set_io_capability(void)
 static void set_device_id(void)
 {
 	struct mgmt_cp_set_device_id cp;
-	uint8_t major, minor;
-	uint16_t version;
-
-	if (sscanf(VERSION, "%hhu.%hhu", &major, &minor) != 2)
-		return;
-
-	version = major << 8 | minor;
 
 	memset(&cp, 0, sizeof(cp));
-	cp.source = htobs(DEVICE_ID_SOURCE);
-	cp.vendor = htobs(DEVICE_ID_VENDOR);
-	cp.product = htobs(DEVICE_ID_PRODUCT);
-	cp.version = htobs(version);
+	cp.source = htobs(bt_config_get_pnp_source());
+	cp.vendor = htobs(bt_config_get_pnp_vendor());
+	cp.product = htobs(bt_config_get_pnp_product());
+	cp.version = htobs(bt_config_get_pnp_version());
 
 	if (mgmt_send(mgmt_if, MGMT_OP_SET_DEVICE_ID, adapter.index,
 				sizeof(cp), &cp, NULL, NULL, NULL) == 0)
 		error("Failed to set device id");
 
-	register_device_id(DEVICE_ID_SOURCE, DEVICE_ID_VENDOR,
-						DEVICE_ID_PRODUCT, version);
+	register_device_id(bt_config_get_pnp_source(),
+						bt_config_get_pnp_vendor(),
+						bt_config_get_pnp_product(),
+						bt_config_get_pnp_version());
 
 	bt_adapter_add_record(sdp_record_find(0x10000), 0x00);
 }
-- 
1.9.1

