Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ RFC 4/5] gdbus: implement DBus.Properties.Set method
Date: Fri, 27 Apr 2012 18:25:21 -0300
Message-Id: <1335561922-3518-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |    6 ++++++
 gdbus/object.c |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 359e8a0..6fde16d 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -61,6 +61,11 @@ typedef gboolean (*GDBusPropertyGetter)(DBusConnection *connection,
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data);
 
+typedef DBusMessage *(*GDBusPropertySetter)(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data);
+
 typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
 								void *data);
 
@@ -111,6 +116,7 @@ struct GDBusPropertyTable {
 	const char *type;
 	GDBusPropertyFlags flags;
 	GDBusPropertyGetter get;
+	GDBusPropertySetter set;
 	GDBusPropertyExists exists;
 };
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 5a1db15..ff5380a 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -689,7 +689,61 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 static DBusMessage *properties_set(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return NULL;
+	struct generic_data *data = user_data;
+	DBusMessageIter iter, sub;
+	struct interface_data *iface;
+	const GDBusPropertyTable *property;
+	const char *property_name, *interface_name;
+
+	if (!dbus_message_iter_init(message, &iter))
+		return NULL;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_get_basic(&iter, &property_name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_get_basic(&iter, &interface_name);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	iface = find_interface(data->interfaces, interface_name);
+	if (iface == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+				"No such interface '%s'", interface_name);
+
+	property = find_property(iface->properties, property_name);
+	if (property == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+				"No such property '%s'", property_name);
+
+	if (property->set == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Property '%s' is not writable",
+					property_name);
+
+	if (property->exists != NULL &&
+			!property->exists(property, iface->user_data))
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+						"No such property '%s'",
+						property_name);
+
+	return property->set(connection, message, property, &sub,
+							iface->user_data);
 }
 
 static const GDBusMethodTable properties_methods[] = {
-- 
1.7.10

