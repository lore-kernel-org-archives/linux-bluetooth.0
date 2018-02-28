Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/9] mesh: Use g_dbus_dict_append_{entry,array}()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <b419005a-3f75-7d44-07fc-f2d6d6a547bc@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:38:10 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mesh/main.c | 100 +++++-------------------------------------------------------
 1 file changed, 8 insertions(+), 92 deletions(-)

diff --git a/mesh/main.c b/mesh/main.c
index b5ec4bcd5..000e6b451 100644
--- a/mesh/main.c
+++ b/mesh/main.c
@@ -1397,93 +1397,6 @@ static void cmd_power(int argc, char *argv[])
 	g_free(str);
 }
 
-static void append_variant(DBusMessageIter *iter, int type, void *val)
-{
-	DBusMessageIter value;
-	char sig[2] = { type, '\0' };
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
-
-	dbus_message_iter_append_basic(&value, type, val);
-
-	dbus_message_iter_close_container(iter, &value);
-}
-
-static void append_array_variant(DBusMessageIter *iter, int type, void *val,
-							int n_elements)
-{
-	DBusMessageIter variant, array;
-	char type_sig[2] = { type, '\0' };
-	char array_sig[3] = { DBUS_TYPE_ARRAY, type, '\0' };
-
-	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT,
-						array_sig, &variant);
-
-	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-						type_sig, &array);
-
-	if (dbus_type_is_fixed(type) == TRUE) {
-		dbus_message_iter_append_fixed_array(&array, type, val,
-							n_elements);
-	} else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
-		const char ***str_array = val;
-		int i;
-
-		for (i = 0; i < n_elements; i++)
-			dbus_message_iter_append_basic(&array, type,
-							&((*str_array)[i]));
-	}
-
-	dbus_message_iter_close_container(&variant, &array);
-
-	dbus_message_iter_close_container(iter, &variant);
-}
-
-static void dict_append_entry(DBusMessageIter *dict, const char *key,
-							int type, void *val)
-{
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &key);
-
-	append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
-static void dict_append_basic_array(DBusMessageIter *dict, int key_type,
-					const void *key, int type, void *val,
-					int n_elements)
-{
-	DBusMessageIter entry;
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-						NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, key_type, key);
-
-	append_array_variant(&entry, type, val, n_elements);
-
-	dbus_message_iter_close_container(dict, &entry);
-}
-
-static void dict_append_array(DBusMessageIter *dict, const char *key, int type,
-						void *val, int n_elements)
-{
-	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
-								n_elements);
-}
-
 #define	DISTANCE_VAL_INVALID	0x7FFF
 
 struct set_discovery_filter_args {
@@ -1506,21 +1419,24 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
 				DBUS_TYPE_VARIANT_AS_STRING
 				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &args->uuids,
+	g_dbus_dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING,
+							&args->uuids,
 							args->uuids_len);
 
 	if (args->pathloss != DISTANCE_VAL_INVALID)
-		dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
+		g_dbus_dict_append_entry(&dict, "Pathloss", DBUS_TYPE_UINT16,
 						&args->pathloss);
 
 	if (args->rssi != DISTANCE_VAL_INVALID)
-		dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16, &args->rssi);
+		g_dbus_dict_append_entry(&dict, "RSSI", DBUS_TYPE_INT16,
+						&args->rssi);
 
 	if (args->transport != NULL)
-		dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
+		g_dbus_dict_append_entry(&dict, "Transport", DBUS_TYPE_STRING,
 						&args->transport);
 	if (args->duplicate)
-		dict_append_entry(&dict, "DuplicateData", DBUS_TYPE_BOOLEAN,
+		g_dbus_dict_append_entry(&dict, "DuplicateData",
+						DBUS_TYPE_BOOLEAN,
 						&args->duplicate);
 
 	dbus_message_iter_close_container(iter, &dict);
-- 
2.14.1

