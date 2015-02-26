Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Fix not marking device as bonded
Date: Thu, 26 Feb 2015 18:13:41 +0100
Message-Id: <1424970821-21763-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any permanently stored key is indication of device being bonded.
---
 android/bluetooth.c | 49 ++++++++++++++++++++++++-------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 45cac5f..b5ff2bf 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2948,27 +2948,6 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 		dev->bredr = g_key_file_get_boolean(key_file, peer, "BREDR",
 									NULL);
 
-	str = g_key_file_get_string(key_file, peer, "LinkKey", NULL);
-	if (str) {
-		g_free(str);
-		dev->bredr_paired = true;
-		dev->bredr_bonded = true;
-	}
-
-	str = g_key_file_get_string(key_file, peer, "LongTermKey", NULL);
-	if (str) {
-		g_free(str);
-		dev->le_paired = true;
-		dev->le_bonded = true;
-	}
-
-	str = g_key_file_get_string(key_file, peer, "SlaveLongTermKey", NULL);
-	if (str) {
-		g_free(str);
-		dev->le_paired = true;
-		dev->le_bonded = true;
-	}
-
 	str = g_key_file_get_string(key_file, peer, "LocalCSRK", NULL);
 	if (str) {
 		int i;
@@ -2997,6 +2976,12 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 						"RemoteCSRKSignCounter", NULL);
 	}
 
+	/* If CSRK are present device is bonded */
+	if (dev->valid_local_csrk || dev->valid_remote_csrk) {
+		dev->le_paired = true;
+		dev->le_bonded = true;
+	}
+
 	str = g_key_file_get_string(key_file, peer, "GattCCC", NULL);
 	if (str) {
 		dev->gatt_ccc = atoi(str);
@@ -3221,19 +3206,29 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		struct mgmt_ltk_info *slave_ltk_info;
 		struct device *dev;
 
+		dev = create_device_from_info(key_file, devs[i]);
+
 		key_info = get_key_info(key_file, devs[i]);
 		irk_info = get_irk_info(key_file, devs[i]);
 		ltk_info = get_ltk_info(key_file, devs[i], true);
 		slave_ltk_info = get_ltk_info(key_file, devs[i], false);
 
-		if (!key_info && !ltk_info && !slave_ltk_info) {
+		/*
+		 * Skip devices that have no permanent keys
+		 * (CSRK are loaded by create_device_from_info())
+		 */
+		if (!dev->le_bonded && !key_info && !ltk_info &&
+						!slave_ltk_info && !irk_info) {
 			error("Failed to load keys for %s, skipping", devs[i]);
-
+			free_device(dev);
 			continue;
 		}
 
-		if (key_info)
+		if (key_info) {
 			keys = g_slist_prepend(keys, key_info);
+			dev->bredr_paired = true;
+			dev->bredr_bonded = true;
+		}
 
 		if (irk_info)
 			irks = g_slist_prepend(irks, irk_info);
@@ -3244,7 +3239,11 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		if (slave_ltk_info)
 			ltks = g_slist_prepend(ltks, slave_ltk_info);
 
-		dev = create_device_from_info(key_file, devs[i]);
+		if (!dev->le_paired &&
+				(irk_info || ltk_info || slave_ltk_info)) {
+			dev->le_paired = true;
+			dev->le_bonded = true;
+		}
 
 		bonded_devices = g_slist_prepend(bonded_devices, dev);
 	}
-- 
1.9.3

