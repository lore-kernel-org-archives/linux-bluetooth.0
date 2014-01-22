Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/4] android/bluetooth: Add support for loading caches devices from storage
Date: Wed, 22 Jan 2014 01:30:45 +0100
Message-Id: <1390350645-9725-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390350645-9725-1-git-send-email-szymon.janc@gmail.com>
References: <1390350645-9725-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Info is now stored for all devices and bond state depends on file.
Based on that devices loaded from storage are put either to cache
or to bonded_devices list.
---
 android/bluetooth.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 1785fc7..80690ec 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1668,7 +1668,8 @@ static void clear_uuids(void)
 					sizeof(cp), &cp, NULL, NULL, NULL);
 }
 
-static void create_device_from_info(GKeyFile *key_file, const char *peer)
+static struct device *create_device_from_info(GKeyFile *key_file,
+							const char *peer)
 {
 	struct device *dev;
 	uint8_t type;
@@ -1683,7 +1684,11 @@ static void create_device_from_info(GKeyFile *key_file, const char *peer)
 	str2ba(peer, &bdaddr);
 	dev = create_device(&bdaddr, type);
 
-	dev->bond_state = HAL_BOND_STATE_BONDED;
+	str = g_key_file_get_string(key_file, peer, "LinkKey", NULL);
+	if (str) {
+		g_free(str);
+		dev->bond_state = HAL_BOND_STATE_BONDED;
+	}
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
 	if (str) {
@@ -1719,6 +1724,8 @@ static void create_device_from_info(GKeyFile *key_file, const char *peer)
 
 		g_strfreev(uuids);
 	}
+
+	return dev;
 }
 
 static struct mgmt_link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
@@ -1751,6 +1758,40 @@ failed:
 	return info;
 }
 
+static int device_timestamp_cmp(gconstpointer  a, gconstpointer  b)
+{
+	const struct device *deva = a;
+	const struct device *devb = b;
+
+	return deva->timestamp < devb->timestamp;
+}
+
+static void load_devices_cache(void)
+{
+	GKeyFile *key_file;
+	gchar **devs;
+	gsize len = 0;
+	unsigned int i;
+
+	key_file = g_key_file_new();
+
+	g_key_file_load_from_file(key_file, CACHE_FILE, 0, NULL);
+
+	devs = g_key_file_get_groups(key_file, &len);
+
+	for (i = 0; i < len; i++) {
+		struct device *dev;
+
+		dev = create_device_from_info(key_file, devs[i]);
+		devices = g_slist_prepend(devices, dev);
+	}
+
+	devices = g_slist_sort(devices, device_timestamp_cmp);
+
+	g_strfreev(devs);
+	g_key_file_free(key_file);
+}
+
 static void load_devices_info(bt_bluetooth_ready cb)
 {
 	GKeyFile *key_file;
@@ -1767,14 +1808,21 @@ static void load_devices_info(bt_bluetooth_ready cb)
 
 	for (i = 0; i < len; i++) {
 		struct mgmt_link_key_info *key_info;
+		struct device *dev;
 
-		create_device_from_info(key_file, devs[i]);
+		dev = create_device_from_info(key_file, devs[i]);
 
 		key_info = get_key_info(key_file, devs[i]);
-		if (key_info)
-			keys = g_slist_prepend(keys, key_info);
+		if (!key_info) {
+			error("Failed to load linkkey for %s, skipping",
+								devs[i]);
+			continue;
+		}
 
 		/* TODO ltk */
+
+		keys = g_slist_prepend(keys, key_info);
+		bonded_devices = g_slist_prepend(bonded_devices, dev);
 	}
 
 	load_link_keys(keys, cb);
@@ -1862,6 +1910,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	clear_uuids();
 
 	load_devices_info(cb);
+	load_devices_cache();
 
 	set_io_capability();
 	set_device_id();
-- 
1.8.5.3

