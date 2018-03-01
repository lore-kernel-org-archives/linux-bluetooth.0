Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 4/9] client: Use g_dbus_dict_append_*()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Message-ID: <63aa6943-8e19-9795-396b-b0e31588f5f9@jp.fujitsu.com>
Date: Thu, 1 Mar 2018 13:27:21 +0900
MIME-Version: 1.0
In-Reply-To: <b4b7e77f-8575-36ec-62ef-b879c20f64f2@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/advertising.c |  58 ++----------------------------
 client/main.c        | 100 +++++----------------------------------------------
 2 files changed, 11 insertions(+), 147 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index a0e6906e3..b2965ceb6 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -237,59 +237,6 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
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
-				void *val, int n_elements)
-{
-	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
-								n_elements);
-}
-
 static gboolean service_data_exists(const GDBusPropertyTable *property,
 								void *data)
 {
@@ -305,7 +252,7 @@ static gboolean get_service_data(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
-	dict_append_array(&dict, ad.service.uuid, DBUS_TYPE_BYTE, &val,
+	g_dbus_dict_append_array(&dict, ad.service.uuid, DBUS_TYPE_BYTE, &val,
 								data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
@@ -328,7 +275,8 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{qv}", &dict);
 
-	dict_append_basic_array(&dict, DBUS_TYPE_UINT16, &ad.manufacturer.id,
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_UINT16,
+					&ad.manufacturer.id,
 					DBUS_TYPE_BYTE, &val, data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
diff --git a/client/main.c b/client/main.c
index f186a3124..a83010b48 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1111,93 +1111,6 @@ static void start_discovery_reply(DBusMessage *message, void *user_data)
 	/* Leave the discovery running even on noninteractive mode */
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
 
 static struct set_discovery_filter_args {
@@ -1225,22 +1138,25 @@ static void set_discovery_filter_setup(DBusMessageIter *iter, void *user_data)
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

