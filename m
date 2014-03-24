Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/5] android/bluetooth: Add support for loading LTKs
Date: Mon, 24 Mar 2014 13:36:44 +0100
Message-Id: <1395664606-32263-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
References: <1395664606-32263-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ce4cc86..01c84e9 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -28,6 +28,7 @@
 #include <errno.h>
 #include <stdlib.h>
 #include <unistd.h>
+#include <inttypes.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
@@ -1594,6 +1595,37 @@ static void load_link_keys(GSList *keys, bt_bluetooth_ready cb)
 	}
 }
 
+static void load_ltks(GSList *ltks)
+{
+	struct mgmt_cp_load_long_term_keys *cp;
+	struct mgmt_ltk_info *ltk;
+	size_t ltk_count, cp_size;
+	GSList *l;
+
+	ltk_count = g_slist_length(ltks);
+
+	DBG("ltks %zu", ltk_count);
+
+	cp_size = sizeof(*cp) + (ltk_count * sizeof(*ltk));
+
+	cp = g_malloc0(cp_size);
+
+	/* Even if the list of stored keys is empty, it is important to load
+	 * an empty list into the kernel. That way it is ensured that no old
+	 * keys from a previous daemon are present.
+	 */
+	cp->key_count = htobs(ltk_count);
+
+	for (l = ltks, ltk = cp->keys; l != NULL; l = g_slist_next(l), ltk++)
+		memcpy(ltk, ltks->data, sizeof(*ltk));
+
+	if (mgmt_send(mgmt_if, MGMT_OP_LOAD_LONG_TERM_KEYS, adapter.index,
+					cp_size, cp, NULL, NULL, NULL) == 0)
+		error("Failed to load LTKs");
+
+	g_free(cp);
+}
+
 static uint8_t get_adapter_uuids(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
@@ -1891,6 +1923,18 @@ static struct device *create_device_from_info(GKeyFile *key_file,
 		dev->bond_state = HAL_BOND_STATE_BONDED;
 	}
 
+	str = g_key_file_get_string(key_file, peer, "LongTermKey", NULL);
+	if (str) {
+		g_free(str);
+		dev->bond_state = HAL_BOND_STATE_BONDED;
+	}
+
+	str = g_key_file_get_string(key_file, peer, "SlaveLongTermKey", NULL);
+	if (str) {
+		g_free(str);
+		dev->bond_state = HAL_BOND_STATE_BONDED;
+	}
+
 	str = g_key_file_get_string(key_file, peer, "Name", NULL);
 	if (str) {
 		g_free(dev->name);
@@ -1960,6 +2004,51 @@ failed:
 	return info;
 }
 
+static struct mgmt_ltk_info *get_ltk_info(GKeyFile *key_file, const char *peer,
+								bool master)
+{
+	const char *key_s, *keytype_s, *encsize_s, *ediv_s, *rand_s;
+	struct mgmt_ltk_info *info = NULL;
+	char *key;
+	unsigned int i;
+
+	key_s = master ? "LongTermKey" : "SlaveLongTermKey";
+	keytype_s = master ? "LongTermKeyType" : "SlaveLongTermKeyType";
+	encsize_s = master ? "LongTermKeyEncSize" : "SlaveLongTermKeyEncSize";
+	ediv_s = master ? "LongTermKeyEDiv" : "SlaveLongTermKeyEDiv";
+	rand_s = master ? "LongTermKeyRand" : "SlaveLongTermKeyRand";
+
+	key = g_key_file_get_string(key_file, peer, key_s, NULL);
+	if (!key || strlen(key) != 32)
+		goto failed;
+
+	info = g_new0(struct mgmt_ltk_info, 1);
+
+	str2ba(peer, &info->addr.bdaddr);
+
+	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+
+	for (i = 0; i < sizeof(info->val); i++)
+		sscanf(key + (i * 2), "%02hhX", &info->val[i]);
+
+	info->type = g_key_file_get_integer(key_file, peer, keytype_s, NULL);
+
+	info->enc_size = g_key_file_get_integer(key_file, peer, encsize_s, NULL);
+
+	info->rand = g_key_file_get_uint64(key_file, peer, rand_s, NULL);
+	info->rand = cpu_to_le64(info->rand);
+
+	info->ediv = g_key_file_get_integer(key_file, peer, ediv_s, NULL);
+	info->ediv = cpu_to_le16(info->ediv);
+
+	info->master = master;
+
+failed:
+	g_free(key);
+
+	return info;
+}
+
 static int device_timestamp_cmp(gconstpointer  a, gconstpointer  b)
 {
 	const struct device *deva = a;
@@ -2001,6 +2090,7 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	gsize len = 0;
 	unsigned int i;
 	GSList *keys = NULL;
+	GSList *ltks = NULL;
 
 	key_file = g_key_file_new();
 
@@ -2010,26 +2100,41 @@ static void load_devices_info(bt_bluetooth_ready cb)
 
 	for (i = 0; i < len; i++) {
 		struct mgmt_link_key_info *key_info;
+		struct mgmt_ltk_info *ltk_info;
+		struct mgmt_ltk_info *slave_ltk_info;
 		struct device *dev;
 
 		key_info = get_key_info(key_file, devs[i]);
-		if (!key_info) {
-			error("Failed to load linkkey for %s, skipping",
-								devs[i]);
+		ltk_info = get_ltk_info(key_file, devs[i], true);
+		slave_ltk_info = get_ltk_info(key_file, devs[i], false);
+
+		if (!key_info && !ltk_info && !slave_ltk_info) {
+			error("Failed to load keys for %s, skipping", devs[i]);
+
 			continue;
 		}
 
-		/* TODO ltk */
+		if (key_info)
+			keys = g_slist_prepend(keys, key_info);
+
+		if (ltk_info)
+			ltks = g_slist_prepend(ltks, ltk_info);
+
+		if (slave_ltk_info)
+			ltks = g_slist_prepend(ltks, slave_ltk_info);
 
 		dev = create_device_from_info(key_file, devs[i]);
 
-		keys = g_slist_prepend(keys, key_info);
 		bonded_devices = g_slist_prepend(bonded_devices, dev);
 	}
 
+	load_ltks(ltks);
+	g_slist_free_full(ltks, g_free);
+
 	load_link_keys(keys, cb);
-	g_strfreev(devs);
 	g_slist_free_full(keys, g_free);
+
+	g_strfreev(devs);
 	g_key_file_free(key_file);
 }
 
-- 
1.9.1

