Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [RFC 2/5] android/bluetooth: Use defines for settings and devices files paths
Date: Tue, 14 Jan 2014 12:11:42 +0100
Message-Id: <1389697905-18532-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
References: <1389697905-18532-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

---
 android/bluetooth.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 78e98c1..23a528a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -54,6 +54,9 @@
 
 #define DUT_MODE_FILE "/sys/kernel/debug/bluetooth/hci%u/dut_mode"
 
+#define SETTINGS_FILE ANDROID_STORAGEDIR"/settings"
+#define DEVICES_FILE ANDROID_STORAGEDIR"/devices"
+
 #define DEVICE_ID_SOURCE	0x0002	/* USB */
 #define DEVICE_ID_VENDOR	0x1d6b	/* Linux Foundation */
 #define DEVICE_ID_PRODUCT	0x0247	/* BlueZ for Android */
@@ -149,8 +152,7 @@ static void store_adapter_config(void)
 
 	key_file = g_key_file_new();
 
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL);
 
 	ba2str(&adapter.bdaddr, addr);
 
@@ -161,7 +163,7 @@ static void store_adapter_config(void)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 
-	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);
+	g_file_set_contents(SETTINGS_FILE, data, length, NULL);
 
 	g_free(data);
 	g_key_file_free(key_file);
@@ -174,8 +176,7 @@ static void load_adapter_config(void)
 	char *str;
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL);
 
 	str = g_key_file_get_string(key_file, "General", "Address", NULL);
 	if (!str) {
@@ -217,8 +218,7 @@ static void store_device_info(struct device *dev)
 	ba2str(&dev->bdaddr, addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
 
 	if (dev->bond_state == HAL_BOND_STATE_NONE) {
 		g_key_file_remove_group(key_file, addr, NULL);
@@ -267,7 +267,7 @@ static void store_device_info(struct device *dev)
 
 done:
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(ANDROID_STORAGEDIR"/devices", str, length, NULL);
+	g_file_set_contents(DEVICES_FILE, str, length, NULL);
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -522,8 +522,7 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 
 	key_file = g_key_file_new();
 
-	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices",
-								0, NULL))
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL))
 		return;
 
 	ba2str(dst, addr);
@@ -538,7 +537,7 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 	g_key_file_set_integer(key_file, addr, "LinkKeyPinLength", pin_length);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(ANDROID_STORAGEDIR"/devices", data, length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
 	g_free(data);
 
 	g_key_file_free(key_file);
@@ -1732,8 +1731,7 @@ static void load_devices_info(bt_bluetooth_ready cb)
 
 	key_file = g_key_file_new();
 
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
 
 	devs = g_key_file_get_groups(key_file, &len);
 
-- 
1.8.3.2

