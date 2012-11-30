Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC V3 11/12] adapter: Upload long term keys from new storage
Date: Fri, 30 Nov 2012 15:47:05 +0100
Message-Id: <1354286826-24016-11-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
References: <1354286826-24016-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove check of long term keys from device_create,
this moves to load_devices.
---
 src/adapter.c |  127 +++++++++++++++++++++++----------------------------------
 src/device.c  |    6 ---
 2 files changed, 51 insertions(+), 82 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ff9d2e7..a0ae04c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1790,77 +1790,57 @@ failed:
 	return info;
 }
 
-static struct smp_ltk_info *get_ltk_info(const char *addr, uint8_t bdaddr_type,
-							const char *value)
+static struct smp_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer)
 {
-	struct smp_ltk_info *ltk;
-	char *ptr;
-	int i, ret;
+	struct smp_ltk_info *ltk = NULL;
+	char *key;
+	char *rand = NULL;
+	char *type = NULL;
+	uint8_t bdaddr_type;
 
-	if (strlen(value) < 60) {
-		error("Unexpectedly short (%zu) LTK", strlen(value));
-		return NULL;
-	}
+	key = g_key_file_get_string(key_file, "LongTermKey", "Key", NULL);
+	if (!key || strlen(key) != 34)
+		goto failed;
 
-	ltk = g_new0(struct smp_ltk_info, 1);
+	rand = g_key_file_get_string(key_file, "LongTermKey", "Rand", NULL);
+	if (!rand || strlen(rand) != 18)
+		goto failed;
 
-	str2ba(addr, &ltk->bdaddr);
+	type = g_key_file_get_string(key_file, "General", "AddressType", NULL);
+	if (!type)
+		goto failed;
 
-	ltk->bdaddr_type = bdaddr_type;
+	if (g_str_equal(type, "public"))
+		bdaddr_type = BDADDR_LE_PUBLIC;
+	else if (g_str_equal(type, "static"))
+		bdaddr_type = BDADDR_LE_RANDOM;
+	else
+		goto failed;
 
-	str2buf(value, ltk->val, sizeof(ltk->val));
+	ltk = g_new0(struct smp_ltk_info, 1);
 
-	ptr = (char *) value + 2 * sizeof(ltk->val) + 1;
+	str2ba(peer, &ltk->bdaddr);
+	ltk->bdaddr_type = bdaddr_type;
+	str2buf(&key[2], ltk->val, sizeof(ltk->val));
+	str2buf(&rand[2], ltk->rand, sizeof(ltk->rand));
 
-	ret = sscanf(ptr, " %hhd %hhd %hhd %hd %n",
-		     &ltk->authenticated, &ltk->master, &ltk->enc_size,
-							&ltk->ediv, &i);
-	if (ret < 2) {
-		g_free(ltk);
-		return NULL;
-	}
-	ptr += i;
+	ltk->authenticated = g_key_file_get_integer(key_file, "LongTermKey",
+							"Authenticated", NULL);
+	ltk->master = g_key_file_get_integer(key_file, "LongTermKey", "Master",
+						NULL);
+	ltk->enc_size = g_key_file_get_integer(key_file, "LongTermKey",
+						"EncSize", NULL);
+	ltk->ediv = g_key_file_get_integer(key_file, "LongTermKey", "EDiv",
+						NULL);
 
-	str2buf(ptr, ltk->rand, sizeof(ltk->rand));
+failed:
+	g_free(key);
+	g_free(rand);
+	g_free(type);
 
 	return ltk;
 }
 
-static void create_stored_device_from_ltks(char *key, char *value,
-							void *user_data)
-{
-	struct adapter_keys *keys = user_data;
-	struct btd_adapter *adapter = keys->adapter;
-	struct btd_device *device;
-	struct smp_ltk_info *info;
-	char address[18], srcaddr[18];
-	uint8_t bdaddr_type;
-
-	if (sscanf(key, "%17s#%hhu", address, &bdaddr_type) < 2)
-		return;
-
-	info = get_ltk_info(address, bdaddr_type, value);
-	if (info == NULL)
-		return;
-
-	keys->keys = g_slist_append(keys->keys, info);
-
-	if (g_slist_find_custom(adapter->devices, address,
-					(GCompareFunc) device_address_cmp))
-		return;
-
-	ba2str(&adapter->bdaddr, srcaddr);
-
-	if (g_strcmp0(srcaddr, address) == 0)
-		return;
-
-	device = device_create(adapter, address, bdaddr_type);
-	if (device) {
-		device_set_temporary(device, FALSE);
-		adapter->devices = g_slist_append(adapter->devices, device);
-	}
-}
-
 static GSList *string_to_primary_list(char *str)
 {
 	GSList *l = NULL;
@@ -1935,18 +1915,12 @@ static void create_stored_device_from_primaries(char *key, char *value,
 	g_slist_free(uuids);
 }
 
-static void smp_key_free(void *data)
-{
-	struct smp_ltk_info *info = data;
-
-	g_free(info);
-}
-
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
 	char srcaddr[18];
 	struct adapter_keys keys = { adapter, NULL };
+	struct adapter_keys ltks = { adapter, NULL };
 	int err;
 	DIR *dir;
 	struct dirent *entry;
@@ -1961,16 +1935,6 @@ static void load_devices(struct btd_adapter *adapter)
 	textfile_foreach(filename, create_stored_device_from_primaries,
 								adapter);
 
-	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "longtermkeys");
-	textfile_foreach(filename, create_stored_device_from_ltks, &keys);
-
-	err = mgmt_load_ltks(adapter->dev_id, keys.keys);
-	if (err < 0)
-		error("Unable to load ltks: %s (%d)", strerror(-err), -err);
-
-	g_slist_free_full(keys.keys, smp_key_free);
-	keys.keys = NULL;
-
 	snprintf(filename, PATH_MAX, STORAGEDIR "/%s", srcaddr);
 	filename[PATH_MAX] = '\0';
 
@@ -1985,6 +1949,7 @@ static void load_devices(struct btd_adapter *adapter)
 		char filename[PATH_MAX + 1];
 		GKeyFile *key_file;
 		struct link_key_info *key_info;
+		struct smp_ltk_info *ltk_info;
 		GSList *l;
 
 		if (entry->d_type != DT_DIR || bachk(entry->d_name) < 0)
@@ -2000,6 +1965,10 @@ static void load_devices(struct btd_adapter *adapter)
 		if (key_info)
 			keys.keys = g_slist_append(keys.keys, key_info);
 
+		ltk_info = get_ltk_info(key_file, entry->d_name);
+		if (ltk_info)
+			ltks.keys = g_slist_append(ltks.keys, ltk_info);
+
 		g_key_file_free(key_file);
 
 		l = g_slist_find_custom(adapter->devices, entry->d_name,
@@ -2017,7 +1986,7 @@ static void load_devices(struct btd_adapter *adapter)
 		adapter->devices = g_slist_append(adapter->devices, device);
 
 device_exist:
-		if (key_info) {
+		if (key_info || ltk_info) {
 			device_set_paired(device, TRUE);
 			device_set_bonded(device, TRUE);
 		}
@@ -2032,6 +2001,12 @@ device_exist:
 							strerror(-err), -err);
 
 	g_slist_free_full(keys.keys, g_free);
+
+	err = mgmt_load_ltks(adapter->dev_id, ltks.keys);
+	if (err < 0)
+		error("Unable to load ltks: %s (%d)", strerror(-err), -err);
+
+	g_slist_free_full(ltks.keys, g_free);
 }
 
 int btd_adapter_block_address(struct btd_adapter *adapter,
diff --git a/src/device.c b/src/device.c
index bb5689b..a5bdf4c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1904,12 +1904,6 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	load_info(device, srcaddr, address);
 
-	if (device_is_le(device) && has_longtermkeys(src, &device->bdaddr,
-							device->bdaddr_type)) {
-		device_set_paired(device, TRUE);
-		device_set_bonded(device, TRUE);
-	}
-
 	return btd_device_ref(device);
 }
 
-- 
1.7.9.5

