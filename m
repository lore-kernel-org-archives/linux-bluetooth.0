Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 13/15] gdbus: Implement PropertiesChanged signal
Date: Sat, 18 Aug 2012 03:51:00 -0300
Message-Id: <1345272662-2850-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |   4 +++
 gdbus/object.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 110 insertions(+), 2 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 3e4aa16..e1b2533 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -246,6 +246,10 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
+void g_dbus_emit_property_changed(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gdbus/object.c b/gdbus/object.c
index 78f7aa1..2b71e73 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -48,6 +48,7 @@ struct generic_data {
 	GSList *added;
 	GSList *removed;
 	guint process_id;
+	gboolean pending_prop;
 	char *introspect;
 	struct generic_data *parent;
 };
@@ -57,6 +58,7 @@ struct interface_data {
 	const GDBusMethodTable *methods;
 	const GDBusSignalTable *signals;
 	const GDBusPropertyTable *properties;
+	GSList *pending_prop;
 	void *user_data;
 	GDBusDestroyFunction destroy;
 };
@@ -69,6 +71,9 @@ struct security_data {
 };
 
 static gboolean process_changes(gpointer user_data);
+static void process_properties_from_interface(struct generic_data *data,
+						struct interface_data *iface);
+static void process_property_changes(struct generic_data *data);
 
 static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
@@ -868,6 +873,10 @@ static gboolean process_changes(gpointer user_data)
 	if (data->added != NULL)
 		emit_interfaces_added(data);
 
+	/* Flush pending properties */
+	if (data->pending_prop == TRUE)
+		process_property_changes(data);
+
 	if (data->removed != NULL)
 		emit_interfaces_removed(data);
 
@@ -884,8 +893,7 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 
 	if (data->process_id > 0) {
 		g_source_remove(data->process_id);
-		if (data->removed != NULL)
-			emit_interfaces_removed(data);
+		process_changes(data);
 	}
 
 	g_slist_foreach(data->objects, reset_parent, data->parent);
@@ -1397,3 +1405,99 @@ gboolean g_dbus_emit_signal_valist(DBusConnection *connection,
 	return emit_signal_valist(connection, path, interface,
 							name, type, args);
 }
+
+static void process_properties_from_interface(struct generic_data *data,
+						struct interface_data *iface)
+{
+	GSList *l;
+	DBusMessage *signal;
+	DBusMessageIter iter, dict, array;
+
+	if (iface->pending_prop == NULL)
+		return;
+
+	signal = dbus_message_new_signal(data->path,
+			DBUS_INTERFACE_PROPERTIES, "PropertiesChanged");
+	if (signal == NULL) {
+		error("Unable to allocate new " DBUS_INTERFACE_PROPERTIES
+						".PropertiesChanged signal");
+		return;
+	}
+
+	iface->pending_prop = g_slist_reverse(iface->pending_prop);
+
+	dbus_message_iter_init_append(signal, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING,	&iface->name);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	for (l = iface->pending_prop; l != NULL; l = l->next) {
+		GDBusPropertyTable *p = l->data;
+
+		if (p->get == NULL)
+			continue;
+
+		if (p->exists != NULL && !p->exists(p, iface->user_data))
+			continue;
+
+		append_property(iface, p, &dict);
+	}
+
+	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+				DBUS_TYPE_STRING_AS_STRING, &array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(data->conn, signal);
+
+	g_slist_free(iface->pending_prop);
+	iface->pending_prop = NULL;
+}
+
+static void process_property_changes(struct generic_data *data)
+{
+	GSList *l;
+
+	for (l = data->interfaces; l != NULL; l = l->next) {
+		struct interface_data *iface = l->data;
+
+		process_properties_from_interface(data, iface);
+	}
+
+	data->pending_prop = FALSE;
+}
+
+void g_dbus_emit_property_changed(DBusConnection *connection,
+				const char *path, const char *interface,
+				const char *name)
+{
+	const GDBusPropertyTable *property;
+	struct generic_data *data;
+	struct interface_data *iface;
+
+	if (!dbus_connection_get_object_path_data(connection, path,
+					(void **) &data) || data == NULL)
+		return;
+
+	iface = find_interface(data->interfaces, interface);
+	if (iface == NULL)
+		return;
+
+	property = find_property(iface->properties, name);
+	if (property == NULL) {
+		error("Could not find property %s in %p", name,
+							iface->properties);
+		return;
+	}
+
+	data->pending_prop = TRUE;
+	iface->pending_prop = g_slist_prepend(iface->pending_prop,
+						(void *) property);
+
+	if (!data->process_id) {
+		data->process_id = g_idle_add(process_changes, data);
+		return;
+	}
+}
-- 
1.7.11.5

