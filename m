Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix filtered scan
Date: Wed, 29 Jun 2016 11:35:16 +0300
Message-Id: <1467189316-28213-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Empty list of UUIDs should be allowed to be passed to
set-scan-filter-uuids as bluetoothd accepts it to enable filtering
every UUID.
---
 client/main.c | 134 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 86 insertions(+), 48 deletions(-)

diff --git a/client/main.c b/client/main.c
index c75b558..6a2892a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -932,6 +932,36 @@ static void append_variant(DBusMessageIter *iter, int type, void *val)
 	dbus_message_iter_close_container(iter, &value);
 }
 
+static void append_array_variant(DBusMessageIter *iter, int type, void *val,
+							int n_elements)
+{
+	DBusMessageIter variant, array;
+	char type_sig[2] = { type, '\0' };
+	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
+						array_sig, &variant);
+
+	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
+						type_sig, &array);
+
+	if (dbus_type_is_fixed(type) == TRUE) {
+		dbus_message_iter_append_fixed_array(&array, type, val,
+							n_elements);
+	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
+		const char ***str_array = val;
+		int i;
+
+		for (i = 0; i < n_elements; i++)
+			dbus_message_iter_append_basic(&array, type,
+							&((*str_array)[i]));
+	}
+
+	dbus_message_iter_close_container(&variant, &array);
+
+	dbus_message_iter_close_container(iter, &variant);
+}
+
 static void dict_append_entry(DBusMessageIter *dict, const char *key,
 							int type, void *val)
 {
@@ -954,13 +984,37 @@ static void dict_append_entry(DBusMessageIter *dict, const char *key,
 	dbus_message_iter_close_container(dict, &entry);
 }
 
+static void dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements)
+{
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+						NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, key_type, key);
+
+	append_array_variant(&entry, type, val, n_elements);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
+						void *val, int n_elements)
+{
+	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
+								n_elements);
+}
+
 #define	DISTANCE_VAL_INVALID	0x7FFF
 
 struct set_discovery_filter_args {
 	char *transport;
 	dbus_uint16_t rssi;
 	dbus_int16_t pathloss;
-	GSList *uuids;
+	char **uuids;
+	size_t uuids_len;
 };
 
 static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
@@ -974,37 +1028,9 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 				DBUS_TYPE_VARIANT_AS_STRING
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	if (args->uuids != NULL) {
-		DBusMessageIter entry, value, arrayIter;
-		char *uuids = "UUIDs";
-		GSList *l;
-
-		dbus_message_iter_open_container(&dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-		/* dict key */
-		dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
-							&uuids);
-
-		dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT,
-							"as", &value);
-
-		dbus_message_iter_open_container(&value, DBUS_TYPE_ARRAY, "s",
-							&arrayIter);
-
-		for (l = args->uuids; l != NULL; l = g_slist_next(l))
-			/* list->data contains string representation of uuid */
-			dbus_message_iter_append_basic(&arrayIter,
-							DBUS_TYPE_STRING,
-							&l->data);
-
-		dbus_message_iter_close_container(&value, &arrayIter);
 
-		/* close vararg*/
-		dbus_message_iter_close_container(&entry, &value);
-
-		/* close entry */
-		dbus_message_iter_close_container(&dict, &entry);
-	}
+	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, args->uuids,
+							args->uuids_len);
 
 	if (args->pathloss != DISTANCE_VAL_INVALID)
 		dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
@@ -1037,7 +1063,8 @@ static void set_discovery_filter_reply(DBusMessage *message, void *user_data)
 
 static gint filtered_scan_rssi = DISTANCE_VAL_INVALID;
 static gint filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-static GSList *filtered_scan_uuids;
+static char **filtered_scan_uuids;
+static size_t filtered_scan_uuids_len;
 static char *filtered_scan_transport;
 
 static void cmd_set_scan_filter_commit(void)
@@ -1049,6 +1076,7 @@ static void cmd_set_scan_filter_commit(void)
 	args.rssi = filtered_scan_rssi;
 	args.transport = filtered_scan_transport;
 	args.uuids = filtered_scan_uuids;
+	args.uuids_len = filtered_scan_uuids_len;
 
 	if (check_default_ctrl() == FALSE)
 		return;
@@ -1063,25 +1091,17 @@ static void cmd_set_scan_filter_commit(void)
 
 static void cmd_set_scan_filter_uuids(const char *arg)
 {
-	char *uuid_str, *saveptr, *uuids, *uuidstmp;
-
-	g_slist_free_full(filtered_scan_uuids, g_free);
+	g_strfreev(filtered_scan_uuids);
 	filtered_scan_uuids = NULL;
+	filtered_scan_uuids_len = 0;
 
 	if (!arg || !strlen(arg))
-		return;
-
-	uuids = g_strdup(arg);
-	for (uuidstmp = uuids; ; uuidstmp = NULL) {
-		uuid_str = strtok_r(uuidstmp, " \t", &saveptr);
-		if (uuid_str == NULL)
-			break;
-		filtered_scan_uuids = g_slist_append(filtered_scan_uuids,
-							strdup(uuid_str));
-	}
+		goto commit;
 
-	g_free(uuids);
+	filtered_scan_uuids = g_strsplit(arg, " ", -1);
+	filtered_scan_uuids_len = g_strv_length(filtered_scan_uuids);
 
+commit:
 	cmd_set_scan_filter_commit();
 }
 
@@ -1121,17 +1141,35 @@ static void cmd_set_scan_filter_transport(const char *arg)
 	cmd_set_scan_filter_commit();
 }
 
+static void clear_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
 static void cmd_set_scan_filter_clear(const char *arg)
 {
 	/* set default values for all options */
 	filtered_scan_rssi = DISTANCE_VAL_INVALID;
 	filtered_scan_pathloss = DISTANCE_VAL_INVALID;
-	g_slist_free_full(filtered_scan_uuids, g_free);
+	g_strfreev(filtered_scan_uuids);
 	filtered_scan_uuids = NULL;
+	filtered_scan_uuids_len = 0;
 	g_free(filtered_scan_transport);
 	filtered_scan_transport = NULL;
 
-	cmd_set_scan_filter_commit();
+	if (g_dbus_proxy_method_call(default_ctrl, "SetDiscoveryFilter",
+		clear_discovery_filter_setup, set_discovery_filter_reply,
+		NULL, NULL) == FALSE) {
+		rl_printf("Failed to clear discovery filter\n");
+	}
 }
 
 static struct GDBusProxy *find_device(const char *arg)
-- 
2.7.4

