Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/14] device: Add device_create_from_storage() function
Date: Wed, 12 Dec 2012 16:47:51 +0100
Message-Id: <1355327283-1558-2-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
References: <1355327283-1558-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is used from load_devices() of adapter.c
during bluetoothd start-up to re-load known devices from
storage key file.

device_create() is used to create new devices for which
no storage exists, but until all device load during start-up
has been converted we should continue to call load_info().
---
 src/adapter.c |   10 +++++----
 src/device.c  |   69 ++++++++++++++++++++++++++++++++++++++++++++-------------
 src/device.h  |    2 ++
 3 files changed, 61 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 34af063..7fcd42c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1888,8 +1888,6 @@ static void load_devices(struct btd_adapter *adapter)
 		if (ltk_info)
 			ltks.keys = g_slist_append(ltks.keys, ltk_info);
 
-		g_key_file_free(key_file);
-
 		l = g_slist_find_custom(adapter->devices, entry->d_name,
 					(GCompareFunc) device_address_cmp);
 		if (l) {
@@ -1897,9 +1895,10 @@ static void load_devices(struct btd_adapter *adapter)
 			goto device_exist;
 		}
 
-		device = device_create(adapter, entry->d_name, BDADDR_BREDR);
+		device = device_create_from_storage(adapter, entry->d_name,
+							key_file);
 		if (!device)
-			continue;
+			goto free;
 
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1909,6 +1908,9 @@ device_exist:
 			device_set_paired(device, TRUE);
 			device_set_bonded(device, TRUE);
 		}
+
+free:
+		g_key_file_free(key_file);
 	}
 
 	closedir(dir);
diff --git a/src/device.c b/src/device.c
index d6f8a9a..99ef77c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1923,10 +1923,8 @@ failed:
 }
 
 static void load_info(struct btd_device *device, const gchar *local,
-			const gchar *peer)
+			const gchar *peer, GKeyFile *key_file)
 {
-	char filename[PATH_MAX + 1];
-	GKeyFile *key_file;
 	char *str;
 	gboolean store_needed = FALSE;
 	gboolean blocked;
@@ -1935,12 +1933,6 @@ static void load_info(struct btd_device *device, const gchar *local,
 	gboolean bredr = FALSE;
 	gboolean le = FALSE;
 
-	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", local, peer);
-	filename[PATH_MAX] = '\0';
-
-	key_file = g_key_file_new();
-	g_key_file_load_from_file(key_file, filename, 0, NULL);
-
 	/* Load device name from storage info file, if that fails fall back to
 	 * the cache.
 	 */
@@ -2035,18 +2027,14 @@ next:
 
 	if (store_needed)
 		store_device_info(device);
-
-	g_key_file_free(key_file);
 }
 
-struct btd_device *device_create(struct btd_adapter *adapter,
-				const gchar *address, uint8_t bdaddr_type)
+static struct btd_device *device_new(struct btd_adapter *adapter,
+				const gchar *address)
 {
 	gchar *address_up;
 	struct btd_device *device;
 	const gchar *adapter_path = adapter_get_path(adapter);
-	const bdaddr_t *src;
-	char srcaddr[18];
 
 	device = g_try_malloc0(sizeof(struct btd_device));
 	if (device == NULL)
@@ -2070,11 +2058,60 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
+
+	return btd_device_ref(device);
+}
+
+struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
+				const char *address, GKeyFile *key_file)
+{
+	struct btd_device *device;
+	const bdaddr_t *src;
+	char srcaddr[18];
+
+	device = device_new(adapter, address);
+	if (device == NULL)
+		return NULL;
+
+	src = adapter_get_address(adapter);
+	ba2str(src, srcaddr);
+
+	load_info(device, srcaddr, address, key_file);
+
+	return device;
+}
+
+struct btd_device *device_create(struct btd_adapter *adapter,
+				const gchar *address, uint8_t bdaddr_type)
+{
+	struct btd_device *device;
+	const bdaddr_t *src;
+	char srcaddr[18];
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+
+	device = device_new(adapter, address);
+	if (device == NULL)
+		return NULL;
+
 	device->bdaddr_type = bdaddr_type;
 	src = adapter_get_address(adapter);
 	ba2str(src, srcaddr);
 
-	load_info(device, srcaddr, address);
+	/*TODO: after all device load during start-up has been converted to
+	 * new key file structure, this should be replaced by :
+	 *	str = load_cached_name(device, srcaddr, address);
+	 *	if (str) {
+	 *		strcpy(device->name, str);
+	 *		g_free(str);
+	 *	}
+	 */
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/info", srcaddr,
+			address);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+	load_info(device, srcaddr, address, key_file);
+	g_key_file_free(key_file);
 
 	return btd_device_ref(device);
 }
diff --git a/src/device.h b/src/device.h
index 1987a80..5c55b35 100644
--- a/src/device.h
+++ b/src/device.h
@@ -28,6 +28,8 @@ struct btd_device;
 
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
+struct btd_device *device_create_from_storage(struct btd_adapter *adapter,
+				const char *address, GKeyFile *key_file);
 
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
-- 
1.7.9.5

