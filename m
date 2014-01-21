Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] android/bluetooth: Add support for loading caches devices from storage
Date: Tue, 21 Jan 2014 16:01:37 +0100
Message-Id: <1390316497-18451-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com>
References: <1390316497-18451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Info is now stored for all devices and bond state depends on linkkey
being stored. Based on that devices loaded from storage are put either
to cache or to bonded_devices list.
---
 android/bluetooth.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6afde35..80490f1 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1688,7 +1688,8 @@ static void clear_uuids(void)
 					sizeof(cp), &cp, NULL, NULL, NULL);
 }
 
-static void create_device_from_info(GKeyFile *key_file, const char *peer)
+static struct device *create_device_from_info(GKeyFile *key_file,
+							const char *peer)
 {
 	struct device *dev;
 	uint8_t type;
@@ -1703,7 +1704,7 @@ static void create_device_from_info(GKeyFile *key_file, const char *peer)
 	str2ba(peer, &bdaddr);
 	dev = create_device(&bdaddr, type);
 
-	dev->bond_state = HAL_BOND_STATE_BONDED;
+	dev->bond_state = HAL_BOND_STATE_NONE;
 
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
 	if (str) {
@@ -1739,6 +1740,8 @@ static void create_device_from_info(GKeyFile *key_file, const char *peer)
 
 		g_strfreev(uuids);
 	}
+
+	return dev;
 }
 
 static struct mgmt_link_key_info *get_key_info(GKeyFile *key_file, const char *peer)
@@ -1771,6 +1774,14 @@ failed:
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
 static void load_devices_info(bt_bluetooth_ready cb)
 {
 	GKeyFile *key_file;
@@ -1787,16 +1798,24 @@ static void load_devices_info(bt_bluetooth_ready cb)
 
 	for (i = 0; i < len; i++) {
 		struct mgmt_link_key_info *key_info;
+		struct device *dev;
 
-		create_device_from_info(key_file, devs[i]);
+		dev = create_device_from_info(key_file, devs[i]);
 
 		key_info = get_key_info(key_file, devs[i]);
-		if (key_info)
+		if (key_info) {
 			keys = g_slist_prepend(keys, key_info);
+			bonded_devices = g_slist_prepend(bonded_devices, dev);
+			dev->bond_state = HAL_BOND_STATE_BONDED;
+		} else {
+			devices = g_slist_prepend(devices, dev);
+		}
 
 		/* TODO ltk */
 	}
 
+	devices = g_slist_sort(devices, device_timestamp_cmp);
+
 	load_link_keys(keys, cb);
 	g_strfreev(devs);
 	g_slist_free_full(keys, g_free);
-- 
1.8.3.2

