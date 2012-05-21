Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] gdbus: Group interface changes to reduce the amount of signals emitted
Date: Mon, 21 May 2012 13:02:32 +0300
Message-Id: <1337594552-14920-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1337594552-14920-1-git-send-email-luiz.dentz@gmail.com>
References: <1337594552-14920-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

InterfacesAdded and InterfacesRemoved can group all the interfaces
changes together in one message.
---
 gdbus/object.c |  396 +++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 234 insertions(+), 162 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 6df32dc..5705c1e 100644
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
@@ -65,6 +68,8 @@ struct security_data {
 	void *iface_user_data;
 };
 
+static gboolean process_changes(gpointer user_data);
+
 static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
 {
@@ -378,21 +383,80 @@ static void reset_parent(gpointer data, gpointer user_data)
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
+	data->interfaces = g_slist_concat(data->interfaces, data->added);
+	data->added = NULL;
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
+}
+
+static void interface_removed(struct generic_data *data,
+						struct interface_data *iface)
+{
+	data->interfaces = g_slist_remove(data->interfaces, iface);
+
+	g_free(iface->name);
+	g_free(iface);
 }
 
 static struct interface_data *find_interface(GSList *interfaces,
@@ -405,6 +469,7 @@ static struct interface_data *find_interface(GSList *interfaces,
 
 	for (list = interfaces; list; list = list->next) {
 		struct interface_data *iface = list->data;
+
 		if (!strcmp(name, iface->name))
 			return iface;
 	}
@@ -433,45 +498,36 @@ static gboolean g_dbus_args_have_signature(const GDBusArgInfo *args,
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
+	if (find_interface(data->removed, name) != NULL)
+		return FALSE;
 
-	iface = find_interface(data->interfaces, interface);
+	iface = find_interface(data->interfaces, name);
 	if (iface == NULL)
-		return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
+		return FALSE;
 
-	for (method = iface->methods; method &&
-			method->name && method->function; method++) {
-		if (dbus_message_is_method_call(message, iface->name,
-							method->name) == FALSE)
-			continue;
+	if (iface->destroy) {
+		iface->destroy(iface->user_data);
+		iface->user_data = NULL;
+	}
 
-		if (g_dbus_args_have_signature(method->in_args,
-							message) == FALSE)
-			continue;
+	if (data->parent == NULL) {
+		interface_removed(data, iface);
+		return TRUE;
+	}
 
-		if (check_privilege(connection, message, method,
-						iface->user_data) == TRUE)
-			return DBUS_HANDLER_RESULT_HANDLED;
+	data->removed = g_slist_prepend(data->removed, iface);
 
-		return process_message(connection, message, method,
-							iface->user_data);
-	}
+	if (data->process_id > 0)
+		return TRUE;
 
-	return DBUS_HANDLER_RESULT_NOT_YET_HANDLED;
-}
+	data->process_id = g_idle_add(process_changes, data);
 
-static DBusObjectPathVTable generic_table = {
-	.unregister_function	= generic_unregister,
-	.message_function	= generic_message,
-};
+	return TRUE;
+}
 
 static struct generic_data *invalidate_parent_data(DBusConnection *conn,
 						const char *child_path)
@@ -523,41 +579,141 @@ done:
 	return data;
 }
 
-static const GDBusMethodTable introspect_methods[] = {
-	{ GDBUS_METHOD("Introspect", NULL,
-			GDBUS_ARGS({ "xml", "s" }), introspect) },
-	{ }
-};
+static void generic_unref(struct generic_data *data)
+{
+	data->refcount--;
 
-static void append_properties(struct interface_data *data,
-							DBusMessageIter *iter)
+	if (data->refcount > 0)
+		return;
+
+	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
+	remove_interface(data, DBUS_INTERFACE_OBJECT_MANAGER);
+
+	invalidate_parent_data(data->conn, data->path);
+
+	dbus_connection_unregister_object_path(data->conn, data->path);
+}
+
+static void emit_interfaces_removed(struct generic_data *data)
 {
-	DBusMessageIter dict;
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
+	struct generic_data *parent = data->parent;
 
-	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
-				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-				DBUS_TYPE_STRING_AS_STRING
-				DBUS_TYPE_VARIANT_AS_STRING
-				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	if (parent == NULL)
+		return;
 
-	/* TODO: list properties */
+	signal = dbus_message_new_signal(parent->path,
+					DBUS_INTERFACE_OBJECT_MANAGER,
+					"InterfacesRemoved");
+	if (signal == NULL)
+		return;
 
-	dbus_message_iter_close_container(iter, &dict);
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH,
+								&data->path);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+
+	while (data->removed != NULL) {
+		struct interface_data *iface = data->removed->data;
+
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+								&iface->name);
+
+		data->removed = g_slist_remove(data->removed, iface);
+		interface_removed(data, iface);
+	}
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
@@ -642,43 +798,6 @@ static const GDBusSignalTable manager_signals[] = {
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
@@ -697,9 +816,16 @@ static void add_interface(struct generic_data *data,
 	iface->user_data = user_data;
 	iface->destroy = destroy;
 
-	data->interfaces = g_slist_append(data->interfaces, iface);
+	if (data->parent == NULL) {
+		data->interfaces = g_slist_append(data->interfaces, iface);
+		return;
+	}
+
+	data->added = g_slist_append(data->added, iface);
+	if (data->process_id > 0)
+		return;
 
-	emit_interface_added(data, iface);
+	data->process_id = g_idle_add(process_changes, data);
 }
 
 static struct generic_data *object_path_ref(DBusConnection *connection,
@@ -740,55 +866,6 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
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
@@ -800,17 +877,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 	if (data == NULL)
 		return;
 
-	data->refcount--;
-
-	if (data->refcount > 0)
-		return;
-
-	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
-	remove_interface(data, DBUS_INTERFACE_OBJECT_MANAGER);
-
-	invalidate_parent_data(connection, path);
-
-	dbus_connection_unregister_object_path(connection, path);
+	generic_unref(data);
 }
 
 static gboolean check_signal(DBusConnection *conn, const char *path,
@@ -909,6 +976,11 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
+	if (find_interface(data->added, name)) {
+		object_path_unref(connection, path);
+		return FALSE;
+	}
+
 	add_interface(data, name, methods, signals, properties, user_data,
 								destroy);
 
@@ -939,7 +1011,7 @@ gboolean g_dbus_unregister_interface(DBusConnection *connection,
 	g_free(data->introspect);
 	data->introspect = NULL;
 
-	object_path_unref(connection, path);
+	object_path_unref(connection, data->path);
 
 	return TRUE;
 }
-- 
1.7.7.6

