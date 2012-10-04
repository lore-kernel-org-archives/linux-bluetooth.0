Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 06/15] gdbus: Implement DBus.Properties.Set method
Date: Thu,  4 Oct 2012 04:26:30 -0300
Message-Id: <1349335599-12443-7-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

Contrary to Get() and GetAll(), Set() is asynchronous so we pass an id
to the setter so later it can declare the Set() as successful or
otherwise.
---
 gdbus/gdbus.h  |  16 +++++++
 gdbus/object.c | 142 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index b2e78c4..ec7b1ef 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -69,6 +69,12 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data);
 
+typedef guint32 GDBusPendingPropertySet;
+
+typedef void (*GDBusPropertySetter)(const GDBusPropertyTable *property,
+			DBusMessageIter *value, GDBusPendingPropertySet id,
+			void *data);
+
 typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
 								void *data);
 
@@ -123,6 +129,7 @@ struct GDBusPropertyTable {
 	const char *name;
 	const char *type;
 	GDBusPropertyGetter get;
+	GDBusPropertySetter set;
 	GDBusPropertyExists exists;
 	GDBusPropertyFlags flags;
 };
@@ -239,6 +246,15 @@ guint g_dbus_add_signal_watch(DBusConnection *connection,
 gboolean g_dbus_remove_watch(DBusConnection *connection, guint tag);
 void g_dbus_remove_all_watches(DBusConnection *connection);
 
+void g_dbus_pending_property_success(DBusConnection *connection,
+						GDBusPendingPropertySet id);
+void g_dbus_pending_property_error_valist(DBusConnection *connection,
+					GDBusPendingReply id, const char *name,
+					const char *format, va_list args);
+void g_dbus_pending_property_error(DBusConnection *connection,
+					GDBusPendingReply id, const char *name,
+					const char *format, ...);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/gdbus/object.c b/gdbus/object.c
index c6e4a53..4509f76 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -59,6 +59,11 @@ struct security_data {
 	void *iface_user_data;
 };
 
+struct property_data {
+	GDBusPendingPropertySet id;
+	DBusMessage *message;
+};
+
 static void print_arguments(GString *gstr, const GDBusArgInfo *args,
 						const char *direction)
 {
@@ -380,6 +385,79 @@ static gboolean check_privilege(DBusConnection *conn, DBusMessage *msg,
 	return FALSE;
 }
 
+static GDBusPendingPropertySet next_pending_property = 1;
+static GSList *pending_property_set;
+
+static struct property_data *remove_pending_property_data(
+						GDBusPendingPropertySet id)
+{
+	struct property_data *propdata;
+	GSList *l;
+
+        for (l = pending_property_set; l != NULL; l = l->next) {
+		propdata = l->data;
+		if (propdata->id != id)
+			continue;
+	}
+
+	if (l == NULL)
+		return NULL;
+
+	pending_property_set = g_slist_delete_link(pending_property_set, l);
+
+	return propdata;
+}
+
+void g_dbus_pending_property_success(DBusConnection *connection,
+						GDBusPendingPropertySet id)
+{
+	struct property_data *propdata;
+
+	propdata = remove_pending_property_data(id);
+	if (propdata == NULL)
+		return;
+
+	g_dbus_send_reply(connection, propdata->message, DBUS_TYPE_INVALID);
+	dbus_message_unref(propdata->message);
+	g_free(propdata);
+}
+
+void g_dbus_pending_property_error_valist(DBusConnection *connection,
+					GDBusPendingReply id, const char *name,
+					const char *format, va_list args)
+{
+	struct property_data *propdata;
+	DBusMessage *reply;
+
+	propdata = remove_pending_property_data(id);
+	if (propdata == NULL)
+		return;
+
+	reply = g_dbus_create_error_valist(propdata->message, name, format,
+									args);
+	if (reply != NULL) {
+		dbus_connection_send(connection, reply, NULL);
+		dbus_message_unref(reply);
+	}
+
+	dbus_message_unref(propdata->message);
+	g_free(propdata);
+}
+
+void g_dbus_pending_property_error(DBusConnection *connection,
+					GDBusPendingReply id, const char *name,
+					const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+
+	g_dbus_pending_property_error_valist(connection, id, name, format,
+									args);
+
+	va_end(args);
+}
+
 static void generic_unregister(DBusConnection *connection, void *user_data)
 {
 	struct generic_data *data = user_data;
@@ -636,7 +714,69 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 static DBusMessage *properties_set(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return dbus_message_new_method_return(message);
+	struct generic_data *data = user_data;
+	DBusMessageIter iter, sub;
+	struct interface_data *iface;
+	const GDBusPropertyTable *property;
+	const char *name, *interface;
+	struct property_data *propdata;
+
+	if (!dbus_message_iter_init(message, &iter))
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+							"No arguments given");
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_get_basic(&iter, &name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_get_basic(&iter, &interface);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	iface = find_interface(data->interfaces, interface);
+	if (iface == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"No such interface '%s'", interface);
+
+	property = find_property(iface->properties, name);
+	if (property == NULL)
+		return g_dbus_create_error(message,
+						DBUS_ERROR_UNKNOWN_PROPERTY,
+						"No such property '%s'", name);
+
+	if (property->set == NULL)
+		return g_dbus_create_error(message,
+					DBUS_ERROR_PROPERTY_READ_ONLY,
+					"Property '%s' is not writable", name);
+
+	if (property->exists != NULL &&
+			!property->exists(property, iface->user_data))
+		return g_dbus_create_error(message,
+						DBUS_ERROR_UNKNOWN_PROPERTY,
+						"No such property '%s'", name);
+
+	propdata = g_new(struct property_data, 1);
+	propdata->id = next_pending_property++;
+	propdata->message = dbus_message_ref(message);
+
+	property->set(property, &sub, propdata->id, iface->user_data);
+
+	return NULL;
 }
 
 static const GDBusMethodTable properties_methods[] = {
-- 
1.7.12.2

