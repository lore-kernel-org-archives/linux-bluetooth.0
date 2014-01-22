Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 2/4] android/bluetooth: Use defines for settings and devices files paths
Date: Wed, 22 Jan 2014 01:30:43 +0100
Message-Id: <1390350645-9725-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390350645-9725-1-git-send-email-szymon.janc@gmail.com>
References: <1390350645-9725-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5d222e1..f5ac0e4 100644
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
@@ -148,8 +151,7 @@ static void store_adapter_config(void)
 
 	key_file = g_key_file_new();
 
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL);
 
 	ba2str(&adapter.bdaddr, addr);
 
@@ -160,7 +162,7 @@ static void store_adapter_config(void)
 
 	data = g_key_file_to_data(key_file, &length, NULL);
 
-	g_file_set_contents(ANDROID_STORAGEDIR"/settings", data, length, NULL);
+	g_file_set_contents(SETTINGS_FILE, data, length, NULL);
 
 	g_free(data);
 	g_key_file_free(key_file);
@@ -173,8 +175,7 @@ static void load_adapter_config(void)
 	char *str;
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/settings", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, SETTINGS_FILE, 0, NULL);
 
 	str = g_key_file_get_string(key_file, "General", "Address", NULL);
 	if (!str) {
@@ -216,8 +217,7 @@ static void store_device_info(struct device *dev)
 	ba2str(&dev->bdaddr, addr);
 
 	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
 
 	if (dev->bond_state == HAL_BOND_STATE_NONE) {
 		g_key_file_remove_group(key_file, addr, NULL);
@@ -266,7 +266,7 @@ static void store_device_info(struct device *dev)
 
 done:
 	str = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(ANDROID_STORAGEDIR"/devices", str, length, NULL);
+	g_file_set_contents(DEVICES_FILE, str, length, NULL);
 	g_free(str);
 
 	g_key_file_free(key_file);
@@ -521,8 +521,7 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 
 	key_file = g_key_file_new();
 
-	if (!g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices",
-								0, NULL))
+	if (!g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL))
 		return;
 
 	ba2str(dst, addr);
@@ -537,7 +536,7 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 	g_key_file_set_integer(key_file, addr, "LinkKeyPinLength", pin_length);
 
 	data = g_key_file_to_data(key_file, &length, NULL);
-	g_file_set_contents(ANDROID_STORAGEDIR"/devices", data, length, NULL);
+	g_file_set_contents(DEVICES_FILE, data, length, NULL);
 	g_free(data);
 
 	g_key_file_free(key_file);
@@ -1727,8 +1726,7 @@ static void load_devices_info(bt_bluetooth_ready cb)
 
 	key_file = g_key_file_new();
 
-	g_key_file_load_from_file(key_file, ANDROID_STORAGEDIR"/devices", 0,
-									NULL);
+	g_key_file_load_from_file(key_file, DEVICES_FILE, 0, NULL);
 
 	devs = g_key_file_get_groups(key_file, &len);
 
-- 
1.8.5.3

