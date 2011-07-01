Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/8] Add support for creating the device from the SMP keys
Date: Fri,  1 Jul 2011 16:12:33 -0300
Message-Id: <1309547558-9617-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547558-9617-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for creating the device from the SMP keys (for now
just the LTK) previously stored.
---
 plugins/mgmtops.c |   24 +++++++++++++---
 src/adapter.c     |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 8 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index f11ff50..4b4ac6f 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1866,13 +1866,20 @@ static int mgmt_load_keys(int index, GSList *keys, gboolean debug_keys)
 	struct mgmt_key_info *key;
 	size_t key_count, cp_size;
 	GSList *l;
-	int err;
+	int err, i;
 
-	key_count = g_slist_length(keys);
+	key_count = 0;
+	cp_size = sizeof(*cp);
+	for (l = keys; l; l = g_slist_next(l)) {
+		struct link_key_info *info = l->data;
+		key_count++;
+		cp_size += sizeof(struct mgmt_key_info) + info->dlen;
+	}
 
-	DBG("index %d keys %zu debug_keys %d", index, key_count, debug_keys);
+	if (key_count == 0)
+		return 0;
 
-	cp_size = sizeof(*cp) + (key_count * sizeof(*key));
+	DBG("index %d keys %zu debug_keys %d size %zd", index, key_count, debug_keys, cp_size);
 
 	buf = g_try_malloc0(sizeof(*hdr) + cp_size);
 	if (buf == NULL)
@@ -1889,13 +1896,20 @@ static int mgmt_load_keys(int index, GSList *keys, gboolean debug_keys)
 	cp->debug_keys = debug_keys;
 	cp->key_count = htobs(key_count);
 
-	for (l = keys, key = cp->keys; l != NULL; l = g_slist_next(l), key++) {
+	i = 0;
+	for (l = keys; l != NULL; l = g_slist_next(l)) {
 		struct link_key_info *info = l->data;
 
+		key = ((void *) cp->keys) + i;
+
 		bacpy(&key->bdaddr, &info->bdaddr);
 		key->type = info->type;
 		memcpy(key->val, info->key, 16);
 		key->pin_len = info->pin_len;
+		memcpy(key->data, info->data, info->dlen);
+		key->dlen = info->dlen;
+
+		i += sizeof(struct mgmt_key_info) + info->dlen;
 	}
 
 	if (write(mgmt_sock, buf, sizeof(*hdr) + cp_size) < 0)
diff --git a/src/adapter.c b/src/adapter.c
index 0909a22..f1def26 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1924,6 +1924,47 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 	return info;
 }
 
+static struct link_key_info *get_ltk_info(const char *addr, const char *value)
+{
+	struct link_key_info *info;
+	char tmp[3], *ptr;
+	int i, ret;
+
+	if (strlen(value) < 36) {
+		error("Unexpectedly short (%zu) link key line", strlen(value));
+		return NULL;
+	}
+
+	info = g_new0(struct link_key_info, 1);
+
+	str2ba(addr, &info->bdaddr);
+
+	memset(tmp, 0, sizeof(tmp));
+
+	for (i = 0; i < 16; i++) {
+		memcpy(tmp, value + (i * 2), 2);
+		info->key[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	ptr = (char *) value + 33;
+
+	ret = sscanf(ptr, "%hhd %hhd %hhd %n", &info->type, &info->pin_len,
+							&info->dlen, &i);
+	if (ret < 3) {
+		g_free(info);
+		return NULL;
+	}
+	ptr += i;
+
+	info = g_realloc(info, sizeof(struct link_key_info) + info->dlen);
+	for (i = 0; i < info->dlen; i++) {
+		memcpy(tmp, ptr + (i * 2), 2);
+		info->data[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	return info;
+}
+
 static void create_stored_device_from_linkkeys(char *key, char *value,
 							void *user_data)
 {
@@ -1947,6 +1988,29 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 	}
 }
 
+static void create_stored_device_from_ltks(char *key, char *value,
+							void *user_data)
+{
+	struct adapter_keys *keys = user_data;
+	struct btd_adapter *adapter = keys->adapter;
+	struct btd_device *device;
+	struct link_key_info *info;
+
+	info = get_ltk_info(key, value);
+	if (info)
+		keys->keys = g_slist_append(keys->keys, info);
+
+	if (g_slist_find_custom(adapter->devices, key,
+					(GCompareFunc) device_address_cmp))
+		return;
+
+	device = device_create(connection, adapter, key, DEVICE_TYPE_LE);
+	if (device) {
+		device_set_temporary(device, FALSE);
+		adapter->devices = g_slist_append(adapter->devices, device);
+	}
+}
+
 static void create_stored_device_from_blocked(char *key, char *value,
 							void *user_data)
 {
@@ -2077,13 +2141,17 @@ static void load_devices(struct btd_adapter *adapter)
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "linkkeys");
 	textfile_foreach(filename, create_stored_device_from_linkkeys, &keys);
 
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "longtermkeys");
+	textfile_foreach(filename, create_stored_device_from_ltks, &keys);
+
 	err = adapter_ops->load_keys(adapter->dev_id, keys.keys,
 							main_opts.debug_keys);
-	if (err < 0) {
+	if (err < 0)
 		error("Unable to load keys to adapter_ops: %s (%d)",
 							strerror(-err), -err);
-		g_slist_free_full(keys.keys, g_free);
-	}
+
+	g_slist_free_full(keys.keys, g_free);
+	keys.keys = NULL;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
-- 
1.7.6

