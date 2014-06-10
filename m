Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android: Load Identity Resolving Keys
Date: Tue, 10 Jun 2014 16:03:45 +0200
Message-Id: <1402409025-4684-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402409025-4684-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402409025-4684-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Load IRKs from file.
---
 android/bluetooth.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index fa39b3b..83b8597 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2168,6 +2168,33 @@ static void load_ltks(GSList *ltks)
 	g_free(cp);
 }
 
+static void load_irks(GSList *irks)
+{
+	struct mgmt_cp_load_irks *cp;
+	struct mgmt_irk_info *irk;
+	size_t irk_count, cp_size;
+	GSList *l;
+
+	irk_count = g_slist_length(irks);
+
+	DBG("irks %zu", irk_count);
+
+	cp_size = sizeof(*cp) + (irk_count * sizeof(*irk));
+
+	cp = g_malloc0(cp_size);
+
+	cp->irk_count = htobs(irk_count);
+
+	for (l = irks, irk = cp->irks; l != NULL; l = g_slist_next(l), irk++)
+		memcpy(irk, irks->data, sizeof(*irk));
+
+	if (mgmt_send(mgmt_if, MGMT_OP_LOAD_IRKS, adapter.index, cp_size, cp,
+							NULL, NULL, NULL) == 0)
+		error("Failed to load IRKs");
+
+	g_free(cp);
+}
+
 static uint8_t get_adapter_uuids(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
@@ -2639,6 +2666,31 @@ failed:
 	return info;
 }
 
+static struct mgmt_irk_info *get_irk_info(GKeyFile *key_file, const char *peer)
+{
+	struct mgmt_irk_info *info = NULL;
+	unsigned int i;
+	char *str;
+
+	str = g_key_file_get_string(key_file, peer, "RemoteIRK", NULL);
+	if (!str || strlen(str) != 32)
+		goto failed;
+
+	info = g_new0(struct mgmt_irk_info, 1);
+
+	str2ba(peer, &info->addr.bdaddr);
+
+	info->addr.type = g_key_file_get_integer(key_file, peer, "Type", NULL);
+
+	for (i = 0; i < sizeof(info->val); i++)
+		sscanf(str + (i * 2), "%02hhX", &info->val[i]);
+
+failed:
+	g_free(str);
+
+	return info;
+}
+
 static time_t device_timestamp(const struct device *dev)
 {
 	if (dev->bredr && dev->le) {
@@ -2696,6 +2748,7 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	unsigned int i;
 	GSList *keys = NULL;
 	GSList *ltks = NULL;
+	GSList *irks = NULL;
 
 	key_file = g_key_file_new();
 
@@ -2706,10 +2759,12 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	for (i = 0; i < len; i++) {
 		struct mgmt_link_key_info *key_info;
 		struct mgmt_ltk_info *ltk_info;
+		struct mgmt_irk_info *irk_info;
 		struct mgmt_ltk_info *slave_ltk_info;
 		struct device *dev;
 
 		key_info = get_key_info(key_file, devs[i]);
+		irk_info = get_irk_info(key_file, devs[i]);
 		ltk_info = get_ltk_info(key_file, devs[i], true);
 		slave_ltk_info = get_ltk_info(key_file, devs[i], false);
 
@@ -2722,6 +2777,9 @@ static void load_devices_info(bt_bluetooth_ready cb)
 		if (key_info)
 			keys = g_slist_prepend(keys, key_info);
 
+		if (irk_info)
+			irks = g_slist_prepend(irks, irk_info);
+
 		if (ltk_info)
 			ltks = g_slist_prepend(ltks, ltk_info);
 
@@ -2736,6 +2794,9 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	load_ltks(ltks);
 	g_slist_free_full(ltks, g_free);
 
+	load_irks(irks);
+	g_slist_free_full(irks, g_free);
+
 	load_link_keys(keys, cb);
 	g_slist_free_full(keys, g_free);
 
-- 
2.0.0

