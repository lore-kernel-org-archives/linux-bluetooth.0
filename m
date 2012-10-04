Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v4 15/15] Use DBus.Properties on Manager interface
Date: Thu,  4 Oct 2012 04:26:39 -0300
Message-Id: <1349335599-12443-16-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/manager.c | 81 ++++++++++++++++++-----------------------------------------
 1 file changed, 25 insertions(+), 56 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index f1f0f4d..2ceeed1 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -132,46 +132,30 @@ done:
 	return reply;
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean manager_property_get_adapters(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	DBusMessage *reply;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	GSList *list;
-	char **array;
-	int i;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
+	DBusMessageIter entry;
+	GSList *l;
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_OBJECT_PATH_AS_STRING, &entry);
 
-	array = g_new0(char *, g_slist_length(adapters) + 1);
-	for (i = 0, list = adapters; list; list = list->next) {
-		struct btd_adapter *adapter = list->data;
+	for (l = adapters; l != NULL; l = l->next) {
+		struct btd_adapter *adapter = l->data;
+		const char *path = adapter_get_path(adapter);
 
-		array[i] = (char *) adapter_get_path(adapter);
-		i++;
+		dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+								&path);
 	}
-	dict_append_array(&dict, "Adapters", DBUS_TYPE_OBJECT_PATH, &array, i);
-	g_free(array);
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_close_container(iter, &entry);
 
-	return reply;
+	return TRUE;
 }
 
 static const GDBusMethodTable manager_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
 	{ GDBUS_METHOD("DefaultAdapter",
 			NULL, GDBUS_ARGS({ "adapter", "o" }),
 			default_adapter) },
@@ -189,8 +173,6 @@ static const GDBusMethodTable manager_methods[] = {
 };
 
 static const GDBusSignalTable manager_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("AdapterAdded",
 			GDBUS_ARGS({ "adapter", "o" })) },
 	{ GDBUS_SIGNAL("AdapterRemoved",
@@ -200,34 +182,19 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
+static const GDBusPropertyTable manager_properties[] = {
+	{ "Adapters", "ao", manager_property_get_adapters },
+	{ }
+};
+
 dbus_bool_t manager_init(const char *path)
 {
 	snprintf(base_path, sizeof(base_path), "/org/bluez/%d", getpid());
 
 	return g_dbus_register_interface(btd_get_dbus_connection(),
 					"/", MANAGER_INTERFACE,
-					manager_methods, manager_signals, NULL,
-					NULL, NULL);
-}
-
-static void manager_update_adapters(void)
-{
-	GSList *list;
-	char **array;
-	int i;
-
-	array = g_new0(char *, g_slist_length(adapters) + 1);
-	for (i = 0, list = adapters; list; list = list->next) {
-		struct btd_adapter *adapter = list->data;
-
-		array[i] = (char *) adapter_get_path(adapter);
-		i++;
-	}
-
-	emit_array_property_changed("/", MANAGER_INTERFACE, "Adapters",
-					DBUS_TYPE_OBJECT_PATH, &array, i);
-
-	g_free(array);
+					manager_methods, manager_signals,
+					manager_properties, NULL, NULL);
 }
 
 static void manager_set_default_adapter(int id)
@@ -261,7 +228,8 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	manager_update_adapters();
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), "/",
+					MANAGER_INTERFACE, "Adapters");
 
 	if (default_adapter_id == dev_id || default_adapter_id < 0) {
 		int new_default = hci_get_route(NULL);
@@ -381,7 +349,8 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID);
 
-	manager_update_adapters();
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),  "/",
+					MANAGER_INTERFACE, "Adapters");
 
 	btd_stop_exit_timer();
 
-- 
1.7.12.2

