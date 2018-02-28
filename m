Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 9/9] dbus-common: Remove unused functions due to use of
 g_dbus_dict_append_*()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <f8693002-1f4d-6635-b8c2-47a352cbc275@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:38:29 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/dbus-common.c | 85 ++-----------------------------------------------------
 src/dbus-common.h |  6 ----
 src/device.c      |  3 +-
 3 files changed, 4 insertions(+), 90 deletions(-)

diff --git a/src/dbus-common.c b/src/dbus-common.c
index adb0a7a4e..6e2097a2d 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -41,97 +41,16 @@
 
 static DBusConnection *connection = NULL;
 
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
-void dict_append_basic(DBusMessageIter *dict, int key_type, const void *key,
-						int type, void *val)
-{
-	DBusMessageIter entry;
-
-	if (type == DBUS_TYPE_STRING) {
-		const char *str = *((const char **) val);
-		if (str == NULL)
-			return;
-	}
-
-	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
-							NULL, &entry);
-
-	dbus_message_iter_append_basic(&entry, key_type, key);
-
-	append_variant(&entry, type, val);
-
-	dbus_message_iter_close_container(dict, &entry);
-
-}
-
 void dict_append_entry(DBusMessageIter *dict,
 			const char *key, int type, void *val)
 {
-	dict_append_basic(dict, DBUS_TYPE_STRING, &key, type, val);
-}
-
-void dict_append_basic_array(DBusMessageIter *dict, int key_type,
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
+	g_dbus_dict_append_entry(dict, key, type, val);
 }
 
 void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 			void *val, int n_elements)
 {
-	dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
-								n_elements);
+	g_dbus_dict_append_array(dict, key, type, val, n_elements);
 }
 
 void set_dbus_connection(DBusConnection *conn)
diff --git a/src/dbus-common.h b/src/dbus-common.h
index 2e7d51e84..fbf4acd28 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -21,14 +21,8 @@
  *
  */
 
-void dict_append_basic(DBusMessageIter *dict, int key_type, const void *key,
-						int type, void *val);
 void dict_append_entry(DBusMessageIter *dict,
 			const char *key, int type, void *val);
-
-void dict_append_basic_array(DBusMessageIter *dict, int key_type,
-					const void *key, int type, void *val,
-					int n_elements);
 void dict_append_array(DBusMessageIter *dict, const char *key, int type,
 			void *val, int n_elements);
 
diff --git a/src/device.c b/src/device.c
index 1b84040dd..8eb99e4bd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1199,7 +1199,8 @@ static void append_manufacturer_data(void *data, void *user_data)
 	struct bt_ad_manufacturer_data *md = data;
 	DBusMessageIter *dict = user_data;
 
-	dict_append_basic_array(dict, DBUS_TYPE_UINT16, &md->manufacturer_id,
+	g_dbus_dict_append_basic_array(dict,
+				DBUS_TYPE_UINT16, &md->manufacturer_id,
 				DBUS_TYPE_BYTE, &md->data, md->len);
 }
 
-- 
2.14.1

