Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v3 06/15] gdbus: Implement DBus.Properties.Set method
Date: Sat, 18 Aug 2012 03:50:53 -0300
Message-Id: <1345272662-2850-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1345272662-2850-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Contrary to Get() and GetAll(), Set is asynchronous so we pass on the
DBusMessage so user is able to create the response. It's the only use of
this parameter.
---
 gdbus/gdbus.h  |  7 +++++++
 gdbus/object.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index b2e78c4..3e4aa16 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -31,6 +31,8 @@ extern "C" {
 #include <dbus/dbus.h>
 #include <glib.h>
 
+typedef enum GDBusPropertySetReturn GDBusPropertySetReturn;
+
 typedef enum GDBusMethodFlags GDBusMethodFlags;
 typedef enum GDBusSignalFlags GDBusSignalFlags;
 typedef enum GDBusPropertyFlags GDBusPropertyFlags;
@@ -69,6 +71,10 @@ typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data);
 
+typedef DBusMessage *(*GDBusPropertySetter)(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					DBusMessage *msg, void *data);
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
diff --git a/gdbus/object.c b/gdbus/object.c
index 50b6dc2..22b8ebb 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -636,7 +636,62 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 static DBusMessage *properties_set(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return NULL;
+	struct generic_data *data = user_data;
+	DBusMessageIter iter, sub;
+	struct interface_data *iface;
+	const GDBusPropertyTable *property;
+	const char *name, *interface;
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
+	return property->set(property, &sub, message, iface->user_data);
 }
 
 static const GDBusMethodTable properties_methods[] = {
@@ -644,7 +699,7 @@ static const GDBusMethodTable properties_methods[] = {
 			GDBUS_ARGS({ "interface", "s" }, { "name", "s" }),
 			GDBUS_ARGS({ "value", "v" }),
 			properties_get) },
-	{ GDBUS_METHOD("Set", NULL,
+	{ GDBUS_ASYNC_METHOD("Set", NULL,
 			GDBUS_ARGS({ "interface", "s" }, { "name", "s" },
 							{ "value", "v" }),
 			properties_set) },
-- 
1.7.11.5

