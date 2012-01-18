Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 1/4] Add support for creating devices from the stored LTK's
Date: Wed, 18 Jan 2012 20:13:29 -0300
Message-Id: <1326928412-25910-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |  109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 106 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a75a0c4..6e8552b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1797,6 +1797,23 @@ struct adapter_keys {
 	GSList *keys;
 };
 
+static int str2buf(const char *str, uint8_t *buf, size_t blen)
+{
+	int i, dlen;
+
+	if (str == NULL)
+		return -EINVAL;
+
+	memset(buf, 0, blen);
+
+	dlen = MIN((strlen(str) / 2), blen);
+
+	for (i = 0; i < dlen; i++)
+		sscanf(str + (i * 2), "%02hhX", &buf[i]);
+
+	return 0;
+}
+
 static struct link_key_info *get_key_info(const char *addr, const char *value)
 {
 	struct link_key_info *info;
@@ -1832,6 +1849,43 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 	return info;
 }
 
+static struct smp_ltk_info *get_ltk_info(const char *addr, const char *value)
+{
+	struct smp_ltk_info *ltk;
+	char *ptr;
+	int i, ret, total;
+
+	total = strlen(value);
+	if (total < 60) {
+		error("Unexpectedly short (%zu) LTK", strlen(value));
+		return NULL;
+	}
+
+	ltk = g_new0(struct smp_ltk_info, 1);
+
+	str2ba(addr, &ltk->bdaddr);
+
+	str2buf(value, ltk->val, sizeof(ltk->val));
+
+	ptr = (char *) value + 2 * sizeof(ltk->val) + 1;
+	total -= 2 * sizeof(ltk->val) + 1;
+
+	ret = sscanf(ptr, " %hhd %hhd %hhd %hhd %hd %n",
+					(uint8_t *) &ltk->addr_type,
+					&ltk->authenticated, &ltk->master,
+					&ltk->enc_size, &ltk->ediv, &i);
+	if (ret < 2) {
+		g_free(ltk);
+		return NULL;
+	}
+	ptr += i;
+	total -= i;
+
+	str2buf(ptr, ltk->rand, sizeof(ltk->rand));
+
+	return ltk;
+}
+
 static void create_stored_device_from_linkkeys(char *key, char *value,
 							void *user_data)
 {
@@ -1855,6 +1909,37 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 	}
 }
 
+static void create_stored_device_from_ltks(char *key, char *value,
+							void *user_data)
+{
+	struct adapter_keys *keys = user_data;
+	struct btd_adapter *adapter = keys->adapter;
+	struct btd_device *device;
+	struct smp_ltk_info *info;
+	char srcaddr[18];
+	bdaddr_t src;
+
+	info = get_ltk_info(key, value);
+	if (info)
+		keys->keys = g_slist_append(keys->keys, info);
+
+	if (g_slist_find_custom(adapter->devices, key,
+					(GCompareFunc) device_address_cmp))
+		return;
+
+	adapter_get_address(adapter, &src);
+	ba2str(&src, srcaddr);
+
+	if (g_strcmp0(srcaddr, key) == 0)
+		return;
+
+	device = device_create(connection, adapter, key, info->addr_type);
+	if (device) {
+		device_set_temporary(device, FALSE);
+		adapter->devices = g_slist_append(adapter->devices, device);
+	}
+}
+
 static void create_stored_device_from_blocked(char *key, char *value,
 							void *user_data)
 {
@@ -1942,6 +2027,13 @@ static void create_stored_device_from_primary(char *key, char *value,
 	g_slist_free(uuids);
 }
 
+static void smp_key_free(void *data)
+{
+	struct smp_ltk_info *info = data;
+
+	g_free(info);
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -1964,11 +2056,22 @@ static void load_devices(struct btd_adapter *adapter)
 
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
+
+	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "longtermkeys");
+	textfile_foreach(filename, create_stored_device_from_ltks, &keys);
+
+	err = adapter_ops->load_ltks(adapter->dev_id, keys.keys);
+	if (err < 0)
+		error("Unable to load keys to adapter_ops: %s (%d)",
+							strerror(-err), -err);
+	g_slist_free_full(keys.keys, smp_key_free);
+	keys.keys = NULL;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
-- 
1.7.8.1

