Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/8] adapter: Upload link keys from new storage
Date: Wed, 28 Nov 2012 14:39:26 +0100
Message-Id: <1354109967-6238-7-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354109967-6238-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove read_link_key() from device_create, this moves to load_devices.
---
 src/adapter.c |  109 +++++++++++++++++++++++++--------------------------------
 src/device.c  |    6 ----
 2 files changed, 48 insertions(+), 67 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 5bad0f9..a87eeda 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1777,31 +1777,35 @@ static int str2buf(const char *str, uint8_t *buf, size_t blen)
 	return 0;
 }
 
-static struct link_key_info *get_key_info(const char *addr, const char *value)
+static struct link_key_info *get_key_info(const char *local,
+						const char *peer)
 {
-	struct link_key_info *info;
-	char tmp[3];
-	long int l;
+	struct link_key_info *info = NULL;
+	char filename[PATH_MAX + 1];
+	GKeyFile *key_file;
+	char *str;
 
-	if (strlen(value) < 36) {
-		error("Unexpectedly short (%zu) link key line", strlen(value));
-		return NULL;
-	}
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/keys", local, peer);
 
-	info = g_new0(struct link_key_info, 1);
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
 
-	str2ba(addr, &info->bdaddr);
+	str = g_key_file_get_string(key_file, "LinkKey", "Key", NULL);
+	if (!str || strlen(str) != 34)
+		goto failed;
 
-	str2buf(value, info->key, sizeof(info->key));
+	info = g_new0(struct link_key_info, 1);
+
+	str2ba(peer, &info->bdaddr);
+	str2buf(&str[2], info->key, sizeof(info->key));
 
-	memcpy(tmp, value + 33, 2);
-	info->type = (uint8_t) strtol(tmp, NULL, 10);
+	info->type = g_key_file_get_integer(key_file, "LinkKey", "Type", NULL);
+	info->pin_len = g_key_file_get_integer(key_file, "LinkKey", "PINLength",
+						NULL);
 
-	memcpy(tmp, value + 35, 2);
-	l = strtol(tmp, NULL, 10);
-	if (l < 0)
-		l = 0;
-	info->pin_len = l;
+failed:
+	g_free(str);
+	g_key_file_free(key_file);
 
 	return info;
 }
@@ -1842,34 +1846,6 @@ static struct smp_ltk_info *get_ltk_info(const char *addr, uint8_t bdaddr_type,
 	return ltk;
 }
 
-static void create_stored_device_from_linkkeys(char *key, char *value,
-							void *user_data)
-{
-	char address[18];
-	uint8_t bdaddr_type;
-	struct adapter_keys *keys = user_data;
-	struct btd_adapter *adapter = keys->adapter;
-	struct btd_device *device;
-	struct link_key_info *info;
-
-	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
-		bdaddr_type = BDADDR_BREDR;
-
-	info = get_key_info(address, value);
-	if (info)
-		keys->keys = g_slist_append(keys->keys, info);
-
-	if (g_slist_find_custom(adapter->devices, address,
-					(GCompareFunc) device_address_cmp))
-		return;
-
-	device = device_create(adapter, address, bdaddr_type);
-	if (device) {
-		device_set_temporary(device, FALSE);
-		adapter->devices = g_slist_append(adapter->devices, device);
-	}
-}
-
 static void create_stored_device_from_ltks(char *key, char *value,
 							void *user_data)
 {
@@ -2022,18 +1998,6 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_primaries,
 								adapter);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "linkkeys");
-	textfile_foreach(filename, create_stored_device_from_linkkeys, &keys);
-
-	err = mgmt_load_link_keys(adapter->dev_id, keys.keys,
-							main_opts.debug_keys);
-	if (err < 0)
-		error("Unable to load link keys: %s (%d)",
-							strerror(-err), -err);
-
-	g_slist_free_full(keys.keys, g_free);
-	keys.keys = NULL;
-
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "longtermkeys");
 	textfile_foreach(filename, create_stored_device_from_ltks, &keys);
 
@@ -2058,13 +2022,22 @@ static void load_devices(struct btd_adapter *adapter)
 
 	while ((entry = readdir(dir)) != NULL) {
 		struct btd_device *device;
+		struct link_key_info *key_info;
+		GSList *l;
 
 		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
 			continue;
 
-		if (g_slist_find_custom(adapter->devices, entry->d_name,
-					(GCompareFunc) device_address_cmp))
-			continue;
+		key_info = get_key_info(srcaddr, entry->d_name);
+		if (key_info)
+			keys.keys = g_slist_append(keys.keys, key_info);
+
+		l = g_slist_find_custom(adapter->devices, entry->d_name,
+					(GCompareFunc) device_address_cmp);
+		if (l) {
+			device = l->data;
+			goto device_exist;
+		}
 
 		device = device_create(adapter, entry->d_name, BDADDR_BREDR);
 		if (!device)
@@ -2072,9 +2045,23 @@ static void load_devices(struct btd_adapter *adapter)
 
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
+
+device_exist:
+		if (key_info) {
+			device_set_paired(device, TRUE);
+			device_set_bonded(device, TRUE);
+		}
 	}
 
 	closedir(dir);
+
+	err = mgmt_load_link_keys(adapter->dev_id, keys.keys,
+							main_opts.debug_keys);
+	if (err < 0)
+		error("Unable to load link keys: %s (%d)",
+							strerror(-err), -err);
+
+	g_slist_free_full(keys.keys, g_free);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index 9f05c1b..53d1220 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1905,12 +1905,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	load_info(device, srcaddr, address);
 
-	if (read_link_key(src, &device->bdaddr, device->bdaddr_type, NULL,
-								NULL) == 0) {
-		device_set_paired(device, TRUE);
-		device_set_bonded(device, TRUE);
-	}
-
 	if (device_is_le(device) && has_longtermkeys(src, &device->bdaddr,
 							device->bdaddr_type)) {
 		device_set_paired(device, TRUE);
-- 
1.7.9.5

