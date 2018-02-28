Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 1/9] gdbus: Introduce functions appending to dbus
 message
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Message-ID: <d27c8d6a-0ff3-aff7-7c2f-f1f4aa93c3d5@jp.fujitsu.com>
Date: Wed, 28 Feb 2018 16:37:49 +0900
MIME-Version: 1.0
In-Reply-To: <1183089a-69de-d3bd-9531-a5179086a129@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/client.c | 135 +++++++++++++++++++++++++++++++++++++++++----------------
 gdbus/gdbus.h  |   9 ++++
 2 files changed, 106 insertions(+), 38 deletions(-)

diff --git a/gdbus/client.c b/gdbus/client.c
index eaab7d50b..dd5d2eb51 100644
--- a/gdbus/client.c
+++ b/gdbus/client.c
@@ -127,6 +127,99 @@ static gboolean modify_match(DBusConnection *conn, const char *member,
 	return TRUE;
 }
 
+static void append_variant(DBusMessageIter *iter, int type, const void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
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
+static void dict_append_basic(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val)
+{
+	DBusMessageIter entry;
+
+	if (type == DBUS_TYPE_STRING) {
+		const char *str = *((const char **) val);
+		if (str == NULL)
+			return;
+	}
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, key_type, key);
+
+	append_variant(&entry, type, val);
+
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+void g_dbus_dict_append_entry(DBusMessageIter *dict,
+					const char *key, int type, void *val)
+{
+	dict_append_basic(dict, DBUS_TYPE_STRING, &key, type, val);
+}
+
+void g_dbus_dict_append_basic_array(DBusMessageIter *dict, int key_type,
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
+void g_dbus_dict_append_array(DBusMessageIter *dict,
+					const char *key, int type, void *val,
+					int n_elements)
+{
+	g_dbus_dict_append_basic_array(dict, DBUS_TYPE_STRING, &key, type, val,
+								n_elements);
+}
+
 static void iter_append_iter(DBusMessageIter *base, DBusMessageIter *iter)
 {
 	int type;
@@ -754,9 +847,8 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 	struct set_property_data *data;
 	GDBusClient *client;
 	DBusMessage *msg;
-	DBusMessageIter iter, variant;
+	DBusMessageIter iter;
 	DBusPendingCall *call;
-	char type_as_str[2];
 
 	if (proxy == NULL || name == NULL || value == NULL)
 		return FALSE;
@@ -783,18 +875,12 @@ gboolean g_dbus_proxy_set_property_basic(GDBusProxy *proxy,
 		return FALSE;
 	}
 
-	type_as_str[0] = (char) type;
-	type_as_str[1] = '\0';
-
 	dbus_message_iter_init_append(msg, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
 							&proxy->interface);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
-						type_as_str, &variant);
-	dbus_message_iter_append_basic(&variant, type, value);
-	dbus_message_iter_close_container(&iter, &variant);
+	append_variant(&iter, type, value);
 
 	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 							&call, -1) == FALSE) {
@@ -819,10 +905,8 @@ gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 	struct set_property_data *data;
 	GDBusClient *client;
 	DBusMessage *msg;
-	DBusMessageIter iter, variant, array;
+	DBusMessageIter iter;
 	DBusPendingCall *call;
-	char array_sig[3];
-	char type_sig[2];
 
 	if (!proxy || !name || !value)
 		return FALSE;
@@ -851,37 +935,12 @@ gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 		return FALSE;
 	}
 
-	array_sig[0] = DBUS_TYPE_ARRAY;
-	array_sig[1] = (char) type;
-	array_sig[2] = '\0';
-
-	type_sig[0] = (char) type;
-	type_sig[1] = '\0';
-
 	dbus_message_iter_init_append(msg, &iter);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,
 							&proxy->interface);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
-							array_sig, &variant);
-
-	dbus_message_iter_open_container(&variant, DBUS_TYPE_ARRAY,
-							type_sig, &array);
-
-	if (dbus_type_is_fixed(type))
-		dbus_message_iter_append_fixed_array(&array, type, &value,
-									size);
-	else if (type == DBUS_TYPE_STRING || type == DBUS_TYPE_OBJECT_PATH) {
-		const char **str = (const char **) value;
-		size_t i;
-
-		for (i = 0; i < size; i++)
-			dbus_message_iter_append_basic(&array, type, &str[i]);
-	}
-
-	dbus_message_iter_close_container(&variant, &array);
-	dbus_message_iter_close_container(&iter, &variant);
+	append_array_variant(&iter, type, &value, size);
 
 	if (g_dbus_send_message_with_reply(client->dbus_conn, msg,
 							&call, -1) == FALSE) {
diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 4880c84e7..1a601c591 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -357,6 +357,15 @@ gboolean g_dbus_proxy_set_property_array(GDBusProxy *proxy,
 				size_t size, GDBusResultFunction function,
 				void *user_data, GDBusDestroyFunction destroy);
 
+void g_dbus_dict_append_entry(DBusMessageIter *dict,
+					const char *key, int type, void *val);
+void g_dbus_dict_append_basic_array(DBusMessageIter *dict, int key_type,
+					const void *key, int type, void *val,
+					int n_elements);
+void g_dbus_dict_append_array(DBusMessageIter *dict,
+					const char *key, int type, void *val,
+					int n_elements);
+
 typedef void (* GDBusSetupFunction) (DBusMessageIter *iter, void *user_data);
 typedef void (* GDBusReturnFunction) (DBusMessage *message, void *user_data);
 
-- 
2.14.1

