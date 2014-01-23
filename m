Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v3 5/5] android/bluetooth: Rename devices list to cached_devices
Date: Thu, 23 Jan 2014 23:18:10 +0100
Message-Id: <1390515490-29538-6-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
References: <1390515490-29538-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This makes it clear what is the purpose of this list.
---
 android/bluetooth.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 126b26a..a9e529f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -140,7 +140,7 @@ static uint16_t option_index = MGMT_INDEX_NONE;
 static struct mgmt *mgmt_if = NULL;
 
 static GSList *bonded_devices = NULL;
-static GSList *devices = NULL;
+static GSList *cached_devices = NULL;
 
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
@@ -300,7 +300,7 @@ static struct device *find_device(const bdaddr_t *bdaddr)
 	if (l)
 		return l->data;
 
-	l = g_slist_find_custom(devices, bdaddr, device_match);
+	l = g_slist_find_custom(cached_devices, bdaddr, device_match);
 	if (l)
 		return l->data;
 
@@ -320,24 +320,24 @@ static void cache_device(struct device *new_dev)
 	struct device *dev;
 	GSList *l;
 
-	l = g_slist_find(devices, new_dev);
+	l = g_slist_find(cached_devices, new_dev);
 	if (l) {
-		devices = g_slist_remove(devices, new_dev);
+		cached_devices = g_slist_remove(cached_devices, new_dev);
 		goto cache;
 	}
 
-	if (g_slist_length(devices) < DEVICES_CACHE_MAX)
+	if (g_slist_length(cached_devices) < DEVICES_CACHE_MAX)
 		goto cache;
 
-	l = g_slist_last(devices);
+	l = g_slist_last(cached_devices);
 	dev = l->data;
 
-	devices = g_slist_remove(devices, dev);
+	cached_devices = g_slist_remove(cached_devices, dev);
 	remove_device_info(dev, CACHE_FILE);
 	free_device(dev);
 
 cache:
-	devices = g_slist_prepend(devices, new_dev);
+	cached_devices = g_slist_prepend(cached_devices, new_dev);
 	new_dev->timestamp = time(NULL);
 	store_device_info(new_dev, CACHE_FILE);
 }
@@ -617,7 +617,7 @@ static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 		}
 		break;
 	case HAL_BOND_STATE_BONDED:
-		devices = g_slist_remove(devices, dev);
+		cached_devices = g_slist_remove(cached_devices, dev);
 		bonded_devices = g_slist_prepend(bonded_devices, dev);
 		remove_device_info(dev, CACHE_FILE);
 		store_device_info(dev, DEVICES_FILE);
@@ -1004,7 +1004,7 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
 	} else {
 		g_slist_foreach(bonded_devices, clear_device_found, NULL);
-		g_slist_foreach(devices, clear_device_found, NULL);
+		g_slist_foreach(cached_devices, clear_device_found, NULL);
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
@@ -1794,10 +1794,10 @@ static void load_devices_cache(void)
 		struct device *dev;
 
 		dev = create_device_from_info(key_file, devs[i]);
-		devices = g_slist_prepend(devices, dev);
+		cached_devices = g_slist_prepend(cached_devices, dev);
 	}
 
-	devices = g_slist_sort(devices, device_timestamp_cmp);
+	cached_devices = g_slist_sort(cached_devices, device_timestamp_cmp);
 
 	g_strfreev(devs);
 	g_key_file_free(key_file);
@@ -3213,8 +3213,8 @@ void bt_bluetooth_unregister(void)
 	g_slist_free_full(bonded_devices, (GDestroyNotify) free_device);
 	bonded_devices = NULL;
 
-	g_slist_free_full(devices, (GDestroyNotify) free_device);
-	devices = NULL;
+	g_slist_free_full(cached_devices, (GDestroyNotify) free_device);
+	cached_devices = NULL;
 
 	ipc_unregister(HAL_SERVICE_ID_CORE);
 }
-- 
1.8.5.3

