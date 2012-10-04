Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4 09/15] gdbus: Group interface changes to reduce the amount of signals emitted
Date: Thu,  4 Oct 2012 04:26:33 -0300
Message-Id: <1349335599-12443-10-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

InterfacesAdded and InterfacesRemoved can group all the interfaces
changes together in one message.
---
 gdbus/object.c | 362 +++++++++++++++++++++++++++++++++------------------------
 1 file changed, 208 insertions(+), 154 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 6f5958a..5b5dc7e 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -45,6 +45,9 @@ struct generic_data {
 	char *path;
 	GSList *interfaces;
 	GSList *objects;
+	GSList *added;
+	GSList *removed;
+	guint process_id;
 	char *introspect;
 	struct generic_data *parent;
 };
@@ -70,6 +73,8 @@ struct property_data {
 	DBusMessage *message;
 };
 
+static gboolean process_changes(gpointer user_data);
+
 static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
 {
@@ -491,21 +496,71 @@ static void reset_parent(gpointer data, gpointer user_data)
 	child->parent = parent;
 }
 
-static void generic_unregister(DBusConnection *connection, void *user_data)
+static void append_properties(struct interface_data *data,
+							DBusMessageIter *iter)
 {
-	struct generic_data *data = user_data;
+	DBusMessageIter dict;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	/* TODO: list properties */
+
+	dbus_message_iter_close_container(iter, &dict);
+}
+
+static void append_interface(gpointer data, gpointer user_data)
+{
+	struct interface_data *iface = data;
+	DBusMessageIter *array = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &iface->name);
+	append_properties(data, &entry);
+	dbus_message_iter_close_container(array, &entry);
+}
+
+static void emit_interfaces_added(struct generic_data *data)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
 	struct generic_data *parent = data->parent;
 
-	if (parent != NULL)
-		parent->objects = g_slist_remove(parent->objects, data);
+	if (parent == NULL)
+		return;
 
-	g_slist_foreach(data->objects, reset_parent, data->parent);
-	g_slist_free(data->objects);
+	signal = dbus_message_new_signal(parent->path,
+					DBUS_INTERFACE_OBJECT_MANAGER,
+					"InterfacesAdded");
+	if (signal == NULL)
+		return;
 
-	dbus_connection_unref(data->conn);
-	g_free(data->introspect);
-	g_free(data->path);
-	g_free(data);
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+								&data->path);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_ARRAY_AS_STRING
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+
+	g_slist_foreach(data->added, append_interface, &array);
+	g_slist_free(data->added);
+	data->added = NULL;
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
 }
 
 static struct interface_data *find_interface(GSList *interfaces,
@@ -546,45 +601,37 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
 	return TRUE;
 }
 
-static DBusHandlerResult generic_message(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
+static gboolean remove_interface(struct generic_data *data, const char *name)
 {
-	struct generic_data *data = user_data;
 	struct interface_data *iface;
-	const GDBusMethodTable *method;
-	const char *interface;
 
-	interface = dbus_message_get_interface(message);
-
-	iface = find_interface(data->interfaces, interface);
+	iface = find_interface(data->interfaces, name);
 	if (iface == NULL)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-
-	for (method = iface->methods; method &&
-			method->name && method->function; method++) {
-		if (dbus_message_is_method_call(message, iface->name,
-							method->name) == FALSE)
-			continue;
+		return FALSE;
 
-		if (g_dbus_args_have_signature(method->in_args,
-							message) == FALSE)
-			continue;
+	data->interfaces = g_slist_remove(data->interfaces, iface);
 
-		if (check_privilege(connection, message, method,
-						iface->user_data) == TRUE)
-			return DBUS_HANDLER_RESULT_HANDLED;
+	if (iface->destroy) {
+		iface->destroy(iface->user_data);
+		iface->user_data = NULL;
+	}
 
-		return process_message(connection, message, method,
-							iface->user_data);
+	if (data->parent == NULL) {
+		g_free(iface->name);
+		g_free(iface);
+		return TRUE;
 	}
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-}
+	data->removed = g_slist_prepend(data->removed, iface->name);
+	g_free(iface);
 
-static DBusObjectPathVTable generic_table = {
-	.unregister_function	= generic_unregister,
-	.message_function	= generic_message,
-};
+	if (data->process_id > 0)
+		return TRUE;
+
+	data->process_id = g_idle_add(process_changes, data);
+
+	return TRUE;
+}
 
 static struct generic_data *invalidate_parent_data(DBusConnection *conn,
 						const char *child_path)
@@ -636,12 +683,6 @@ done:
 	return data;
 }
 
-static const GDBusMethodTable introspect_methods[] = {
-	{ GDBUS_METHOD("Introspect", NULL,
-			GDBUS_ARGS({ "xml", "s" }), introspect) },
-	{ }
-};
-
 static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *properties,
 							const char *name)
 {
@@ -860,35 +901,128 @@ static const GDBusSignalTable properties_signals[] = {
 	{ }
 };
 
-static void append_properties(struct interface_data *data,
-							DBusMessageIter *iter)
+static void append_name(gpointer data, gpointer user_data)
 {
-	DBusMessageIter dict;
+	char *name = data;
+	DBusMessageIter *iter = user_data;
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-				DBUS_TYPE_STRING_AS_STRING
-				DBUS_TYPE_VARIANT_AS_STRING
-				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &name);
+}
 
-	/* TODO: list properties */
+static void emit_interfaces_removed(struct generic_data *data)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
+	struct generic_data *parent = data->parent;
 
-	dbus_message_iter_close_container(iter, &dict);
+	if (parent == NULL)
+		return;
+
+	signal = dbus_message_new_signal(parent->path,
+					DBUS_INTERFACE_OBJECT_MANAGER,
+					"InterfacesRemoved");
+	if (signal == NULL)
+		return;
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+								&data->path);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	g_slist_foreach(data->removed, append_name, &array);
+	g_slist_free_full(data->removed, g_free);
+	data->removed = NULL;
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
 }
 
-static void append_interface(gpointer data, gpointer user_data)
+static gboolean process_changes(gpointer user_data)
 {
-	struct interface_data *iface = data;
-	DBusMessageIter *array = user_data;
-	DBusMessageIter entry;
+	struct generic_data *data = user_data;
 
-	dbus_message_iter_open_container(array, DBUS_TYPE_DICT_ENTRY, NULL,
-								&entry);
-	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING, &iface->name);
-	append_properties(data, &entry);
-	dbus_message_iter_close_container(array, &entry);
+	data->process_id = 0;
+
+	if (data->added != NULL)
+		emit_interfaces_added(data);
+
+	if (data->removed != NULL)
+		emit_interfaces_removed(data);
+
+	return FALSE;
 }
 
+static void generic_unregister(DBusConnection *connection, void *user_data)
+{
+	struct generic_data *data = user_data;
+	struct generic_data *parent = data->parent;
+
+	if (parent != NULL)
+		parent->objects = g_slist_remove(parent->objects, data);
+
+	if (data->process_id > 0) {
+		g_source_remove(data->process_id);
+		if (data->removed != NULL)
+			emit_interfaces_removed(data);
+	}
+
+	g_slist_foreach(data->objects, reset_parent, data->parent);
+	g_slist_free(data->objects);
+
+	dbus_connection_unref(data->conn);
+	g_free(data->introspect);
+	g_free(data->path);
+	g_free(data);
+}
+
+static DBusHandlerResult generic_message(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct generic_data *data = user_data;
+	struct interface_data *iface;
+	const GDBusMethodTable *method;
+	const char *interface;
+
+	interface = dbus_message_get_interface(message);
+
+	iface = find_interface(data->interfaces, interface);
+	if (iface == NULL)
+		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+
+	for (method = iface->methods; method &&
+			method->name && method->function; method++) {
+		if (dbus_message_is_method_call(message, iface->name,
+							method->name) == FALSE)
+			continue;
+
+		if (g_dbus_args_have_signature(method->in_args,
+							message) == FALSE)
+			continue;
+
+		if (check_privilege(connection, message, method,
+						iface->user_data) == TRUE)
+			return DBUS_HANDLER_RESULT_HANDLED;
+
+		return process_message(connection, message, method,
+							iface->user_data);
+	}
+
+	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+}
+
+static DBusObjectPathVTable generic_table = {
+	.unregister_function	= generic_unregister,
+	.message_function	= generic_message,
+};
+
+static const GDBusMethodTable introspect_methods[] = {
+	{ GDBUS_METHOD("Introspect", NULL,
+			GDBUS_ARGS({ "xml", "s" }), introspect) },
+	{ }
+};
+
 static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
 {
 	DBusMessageIter array;
@@ -973,43 +1107,6 @@ static const GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
-static void emit_interface_added(struct generic_data *data,
-						struct interface_data *iface)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter, array;
-	struct generic_data *parent = data->parent;
-
-	if (parent == NULL)
-		return;
-
-	signal = dbus_message_new_signal(parent->path,
-					DBUS_INTERFACE_OBJECT_MANAGER,
-					"InterfacesAdded");
-	if (signal == NULL)
-		return;
-
-	dbus_message_iter_init_append(signal, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
-								&data->path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-				DBUS_TYPE_STRING_AS_STRING
-				DBUS_TYPE_ARRAY_AS_STRING
-				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-				DBUS_TYPE_STRING_AS_STRING
-				DBUS_TYPE_VARIANT_AS_STRING
-				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
-				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
-
-	append_interface(iface, &array);
-
-	dbus_message_iter_close_container(&iter, &array);
-
-	g_dbus_send_message(data->conn, signal);
-}
-
 static void add_interface(struct generic_data *data,
 				const char *name,
 				const GDBusMethodTable *methods,
@@ -1029,8 +1126,14 @@ static void add_interface(struct generic_data *data,
 	iface->destroy = destroy;
 
 	data->interfaces = g_slist_append(data->interfaces, iface);
+	if (data->parent == NULL)
+		return;
+
+	data->added = g_slist_append(data->added, iface);
+	if (data->process_id > 0)
+		return;
 
-	emit_interface_added(data, iface);
+	data->process_id = g_idle_add(process_changes, data);
 }
 
 static struct generic_data *object_path_ref(DBusConnection *connection,
@@ -1074,55 +1177,6 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	return data;
 }
 
-static void emit_interface_remove(struct generic_data *data,
-						struct interface_data *iface)
-{
-	DBusMessage *signal;
-	DBusMessageIter iter, array;
-	struct generic_data *parent = data->parent;
-
-	if (parent == NULL)
-		return;
-
-	signal = dbus_message_new_signal(parent->path,
-					DBUS_INTERFACE_OBJECT_MANAGER,
-					"InterfacesRemoved");
-	if (signal == NULL)
-		return;
-
-	dbus_message_iter_init_append(signal, &iter);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
-								&data->path);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-					DBUS_TYPE_STRING_AS_STRING, &array);
-	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &iface->name);
-	dbus_message_iter_close_container(&iter, &array);
-
-	g_dbus_send_message(data->conn, signal);
-}
-
-static gboolean remove_interface(struct generic_data *data, const char *name)
-{
-	struct interface_data *iface;
-
-	iface = find_interface(data->interfaces, name);
-	if (iface == NULL)
-		return FALSE;
-
-	emit_interface_remove(data, iface);
-
-	data->interfaces = g_slist_remove(data->interfaces, iface);
-
-	if (iface->destroy)
-		iface->destroy(iface->user_data);
-
-	g_free(iface->name);
-	g_free(iface);
-
-	return TRUE;
-}
-
 static void object_path_unref(DBusConnection *connection, const char *path)
 {
 	struct generic_data *data = NULL;
@@ -1143,9 +1197,9 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
 	remove_interface(data, DBUS_INTERFACE_OBJECT_MANAGER);
 
-	invalidate_parent_data(connection, path);
+	invalidate_parent_data(data->conn, data->path);
 
-	dbus_connection_unregister_object_path(connection, path);
+	dbus_connection_unregister_object_path(data->conn, data->path);
 }
 
 static gboolean check_signal(DBusConnection *conn, const char *path,
@@ -1270,7 +1324,7 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 	g_free(data->introspect);
 	data->introspect = NULL;
 
-	object_path_unref(connection, path);
+	object_path_unref(connection, data->path);
 
 	return TRUE;
 }
-- 
1.7.12.2

