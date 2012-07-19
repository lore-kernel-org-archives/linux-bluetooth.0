Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 4/5] gdbus: Implement DBus.Properties.Set method
Date: Thu, 19 Jul 2012 00:20:07 -0300
Message-Id: <1342668008-5522-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1342668008-5522-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |  9 ++++++++
 gdbus/object.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index e2a8460..3e0c643 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -59,6 +59,14 @@ typedef struct GDBusPropertyTable GDBusPropertyTable;
 typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data);
 
+typedef enum {
+	G_DBUS_PROPERTY_SET_SUCCESS = 0,
+	G_DBUS_PROPERTY_SET_INVALID_ARGUMENTS,
+} GDBusPropertySetReturn;
+
+typedef GDBusPropertySetReturn (*GDBusPropertySetter)(const GDBusPropertyTable *property,
+					DBusMessageIter *value, void *data);
+
 typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
 								void *data);
 
@@ -113,6 +121,7 @@ struct GDBusPropertyTable {
 	const char *name;
 	const char *type;
 	GDBusPropertyGetter get;
+	GDBusPropertySetter set;
 	GDBusPropertyExists exists;
 	GDBusPropertyFlags flags;
 };
diff --git a/gdbus/object.c b/gdbus/object.c
index 6daaa81..c19f1d7 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -622,7 +622,74 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 static DBusMessage *properties_set(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return NULL;
+	GDBusPropertySetReturn ret;
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
+		return g_dbus_create_error(message,
+				DBUS_ERROR_UNKNOWN_PROPERTY,
+				"No such property '%s'", property_name);
+
+	if (property->set == NULL)
+		return g_dbus_create_error(message,
+					DBUS_ERROR_PROPERTY_READ_ONLY,
+					"Property '%s' is not writable",
+					property_name);
+
+	if (property->exists != NULL &&
+			!property->exists(property, iface->user_data))
+		return g_dbus_create_error(message,
+						DBUS_ERROR_UNKNOWN_PROPERTY,
+						"No such property '%s'",
+						property_name);
+
+	ret = property->set(property, &sub, iface->user_data);
+
+	switch (ret) {
+	case G_DBUS_PROPERTY_SET_SUCCESS:
+		return dbus_message_new_method_return(message);
+	case G_DBUS_PROPERTY_SET_INVALID_ARGUMENTS:
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+						"Invalid arguments");
+	}
+
+	return g_dbus_create_error(message, DBUS_ERROR_FAILED, "Failed");
 }
 
 static const GDBusMethodTable properties_methods[] = {
-- 
1.7.11.2

