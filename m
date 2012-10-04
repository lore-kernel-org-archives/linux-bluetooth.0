Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH BlueZ v4 08/15] gdbus: Add support for org.freedesktop.DBus.ObjectManager interface
Date: Thu,  4 Oct 2012 04:26:32 -0300
Message-Id: <1349335599-12443-9-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements initial support for ObjectManager, it automatically adds
objects to its parents so no action is needed by daemons to get their
objects managed by this interface.

ObjectManager is part of D-Bus spec since revision 0.17:
http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-objectmanager
---
 gdbus/object.c | 247 ++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 237 insertions(+), 10 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index c145328..6f5958a 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -37,10 +37,16 @@
 #define error(fmt...)
 #define debug(fmt...)
 
+#define DBUS_INTERFACE_OBJECT_MANAGER "org.freedesktop.DBus.ObjectManager"
+
 struct generic_data {
 	unsigned int refcount;
+	DBusConnection *conn;
+	char *path;
 	GSList *interfaces;
+	GSList *objects;
 	char *introspect;
+	struct generic_data *parent;
 };
 
 struct interface_data {
@@ -477,11 +483,28 @@ void g_dbus_pending_property_error(DBusConnection *connection,
 	va_end(args);
 }
 
+static void reset_parent(gpointer data, gpointer user_data)
+{
+	struct generic_data *child = data;
+	struct generic_data *parent = user_data;
+
+	child->parent = parent;
+}
+
 static void generic_unregister(DBusConnection *connection, void *user_data)
 {
 	struct generic_data *data = user_data;
+	struct generic_data *parent = data->parent;
 
+	if (parent != NULL)
+		parent->objects = g_slist_remove(parent->objects, data);
+
+	g_slist_foreach(data->objects, reset_parent, data->parent);
+	g_slist_free(data->objects);
+
+	dbus_connection_unref(data->conn);
 	g_free(data->introspect);
+	g_free(data->path);
 	g_free(data);
 }
 
@@ -563,9 +586,10 @@ static DBusObjectPathVTable generic_table = {
 	.message_function	= generic_message,
 };
 
-static void invalidate_parent_data(DBusConnection *conn, const char *child_path)
+static struct generic_data *invalidate_parent_data(DBusConnection *conn,
+						const char *child_path)
 {
-	struct generic_data *data = NULL;
+	struct generic_data *data = NULL, *child = NULL, *parent = NULL;
 	char *parent_path, *slash;
 
 	parent_path = g_strdup(child_path);
@@ -586,16 +610,30 @@ static void invalidate_parent_data(DBusConnection *conn, const char *child_path)
 		goto done;
 	}
 
-	invalidate_parent_data(conn, parent_path);
+	parent = invalidate_parent_data(conn, parent_path);
 
-	if (data == NULL)
-		goto done;
+	if (data == NULL) {
+		data = parent;
+		if (data == NULL)
+			goto done;
+	}
 
 	g_free(data->introspect);
 	data->introspect = NULL;
 
+	if (!dbus_connection_get_object_path_data(conn, child_path,
+							(void *) &child))
+		goto done;
+
+	if (child == NULL || g_slist_find(data->objects, child) != NULL)
+		goto done;
+
+	data->objects = g_slist_prepend(data->objects, child);
+	child->parent = data;
+
 done:
 	g_free(parent_path);
+	return data;
 }
 
 static const GDBusMethodTable introspect_methods[] = {
@@ -822,7 +860,158 @@ static const GDBusSignalTable properties_signals[] = {
 	{ }
 };
 
-static void add_interface(struct generic_data *data, const char *name,
+static void append_properties(struct interface_data *data,
+							DBusMessageIter *iter)
+{
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
+static void append_interfaces(struct generic_data *data, DBusMessageIter *iter)
+{
+	DBusMessageIter array;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_ARRAY_AS_STRING
+				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+				DBUS_TYPE_STRING_AS_STRING
+				DBUS_TYPE_VARIANT_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+				DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &array);
+
+	g_slist_foreach(data->interfaces, append_interface, &array);
+
+	dbus_message_iter_close_container(iter, &array);
+}
+
+static void append_object(gpointer data, gpointer user_data)
+{
+	struct generic_data *child = data;
+	DBusMessageIter *array = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+								&child->path);
+	append_interfaces(child, &entry);
+	dbus_message_iter_close_container(array, &entry);
+}
+
+static DBusMessage *get_objects(DBusConnection *connection,
+				DBusMessage *message, void *user_data)
+{
+	struct generic_data *data = user_data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter array;
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	g_slist_foreach(data->objects, append_object, &array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static const GDBusMethodTable manager_methods[] = {
+	{ GDBUS_METHOD("GetManagedObjects", NULL,
+		GDBUS_ARGS({ "objects", "a{oa{sa{sv}}}" }), get_objects) },
+	{ }
+};
+
+static const GDBusSignalTable manager_signals[] = {
+	{ GDBUS_SIGNAL("InterfacesAdded",
+		GDBUS_ARGS({ "object", "o" },
+				{ "interfaces", "a{sa{sv}}" })) },
+	{ GDBUS_SIGNAL("InterfacesRemoved",
+		GDBUS_ARGS({ "object", "o" }, { "interfaces", "as" })) },
+	{ }
+};
+
+static void emit_interface_added(struct generic_data *data,
+						struct interface_data *iface)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
+	struct generic_data *parent = data->parent;
+
+	if (parent == NULL)
+		return;
+
+	signal = dbus_message_new_signal(parent->path,
+					DBUS_INTERFACE_OBJECT_MANAGER,
+					"InterfacesAdded");
+	if (signal == NULL)
+		return;
+
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
+	append_interface(iface, &array);
+
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
+}
+
+static void add_interface(struct generic_data *data,
+				const char *name,
 				const GDBusMethodTable *methods,
 				const GDBusSignalTable *signals,
 				const GDBusPropertyTable *properties,
@@ -840,6 +1029,8 @@ static void add_interface(struct generic_data *data, const char *name,
 	iface->destroy = destroy;
 
 	data->interfaces = g_slist_append(data->interfaces, iface);
+
+	emit_interface_added(data, iface);
 }
 
 static struct generic_data *object_path_ref(DBusConnection *connection,
@@ -856,6 +1047,8 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	}
 
 	data = g_new0(struct generic_data, 1);
+	data->conn = dbus_connection_ref(connection);
+	data->path = g_strdup(path);
 	data->refcount = 1;
 
 	data->introspect = g_strdup(DBUS_INTROSPECT_1_0_XML_DOCTYPE_DECL_NODE "<node></node>");
@@ -869,8 +1062,11 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 
 	invalidate_parent_data(connection, path);
 
-	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE,
-			introspect_methods, NULL, NULL, data, NULL);
+	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE, introspect_methods,
+						NULL, NULL, data, NULL);
+
+	add_interface(data, DBUS_INTERFACE_OBJECT_MANAGER, manager_methods,
+					manager_signals, NULL, data, NULL);
 
 	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
 					properties_signals, NULL, data, NULL);
@@ -878,6 +1074,34 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	return data;
 }
 
+static void emit_interface_remove(struct generic_data *data,
+						struct interface_data *iface)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter, array;
+	struct generic_data *parent = data->parent;
+
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
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_TYPE_STRING_AS_STRING, &array);
+	dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING, &iface->name);
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
+}
+
 static gboolean remove_interface(struct generic_data *data, const char *name)
 {
 	struct interface_data *iface;
@@ -886,6 +1110,8 @@ static gboolean remove_interface(struct generic_data *data, const char *name)
 	if (iface == NULL)
 		return FALSE;
 
+	emit_interface_remove(data, iface);
+
 	data->interfaces = g_slist_remove(data->interfaces, iface);
 
 	if (iface->destroy)
@@ -915,6 +1141,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 
 	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
 	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
+	remove_interface(data, DBUS_INTERFACE_OBJECT_MANAGER);
 
 	invalidate_parent_data(connection, path);
 
@@ -1013,8 +1240,8 @@ gboolean g_dbus_register_interface(DBusConnection *connection,
 		return FALSE;
 	}
 
-	add_interface(data, name, methods, signals,
-			properties, user_data, destroy);
+	add_interface(data, name, methods, signals, properties, user_data,
+								destroy);
 
 	g_free(data->introspect);
 	data->introspect = NULL;
-- 
1.7.12.2

