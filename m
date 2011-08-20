Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 07/12] Add support for creating devices from the stored SMP keys
Date: Fri, 19 Aug 2011 21:12:03 -0300
Message-Id: <1313799128-8842-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313799128-8842-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 118 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4c88a0e..cfa4ddc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1926,6 +1926,71 @@ static struct link_key_info *get_key_info(const char *addr, const char *value)
 	return info;
 }
 
+static uint8_t *str2buf(const char *str, int *len)
+{
+	uint8_t *buf;
+	int i, dlen;
+
+	DBG("");
+
+	if (str == NULL)
+		return NULL;
+
+	dlen = (strlen(str) / 2);
+
+	buf = g_try_malloc0(sizeof(uint8_t) * dlen);
+	if (buf == NULL)
+		return NULL;
+
+	for (i = 0; i < dlen; i++)
+		sscanf(str + (i * 2), "%02hhX", &buf[i]);
+
+	if (len)
+		*len = dlen;
+
+	return buf;
+}
+
+static struct smp_key_info *get_ltk_info(const char *addr, const char *value)
+{
+	struct smp_key_info *ltk;
+	char tmp[3], *ptr;
+	int i, ret, total;
+
+	total = strlen(value);
+	/* FIXME */
+	if (total < 99) {
+		error("Unexpectedly short (%zu) LTK", strlen(value));
+		return NULL;
+	}
+
+	ltk = g_new0(struct smp_key_info, 1);
+
+	str2ba(addr, &ltk->bdaddr);
+
+	memset(tmp, 0, sizeof(tmp));
+
+	for (i = 0; i < 16; i++) {
+		memcpy(tmp, value + (i * 2), 2);
+		ltk->val[i] = (uint8_t) strtol(tmp, NULL, 16);
+	}
+
+	ptr = (char *) value + 33;
+	total -= 33;
+
+	ret = sscanf(ptr, "%hhd %hhd %n", &ltk->type, &ltk->pin_len, &i);
+	if (ret < 2) {
+		g_free(ltk);
+		return NULL;
+	}
+	ptr += i;
+	total -= i;
+
+	ltk->data = str2buf(ptr, &ltk->dlen);
+
+	return ltk;
+}
+
 static void create_stored_device_from_linkkeys(char *key, char *value,
 							void *user_data)
 {
@@ -1949,6 +2014,37 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 	}
 }
 
+static void create_stored_device_from_ltks(char *key, char *value,
+							void *user_data)
+{
+	struct adapter_keys *keys = user_data;
+	struct btd_adapter *adapter = keys->adapter;
+	struct btd_device *device;
+	struct smp_key_info *info;
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
@@ -2060,6 +2156,14 @@ static void create_stored_device_from_primary(char *key, char *value,
 	g_slist_free(uuids);
 }
 
+static void smp_key_free(void *data)
+{
+	struct smp_key_info *info = data;
+
+	g_free(info->data);
+	g_free(info);
+}
+
 static void load_devices(struct btd_adapter *adapter)
 {
 	char filename[PATH_MAX + 1];
@@ -2082,11 +2186,22 @@ static void load_devices(struct btd_adapter *adapter)
 
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
+	err = adapter_ops->load_smp_keys(adapter->dev_id, keys.keys);
+	if (err < 0)
+		error("Unable to load keys to adapter_ops: %s (%d)",
+							strerror(-err), -err);
+	g_slist_free_full(keys.keys, smp_key_free);
+	keys.keys = NULL;
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
 	textfile_foreach(filename, create_stored_device_from_blocked, adapter);
-- 
1.7.6

