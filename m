Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 03/15] gdbus: Add skeleton of DBus.Properties interface
Date: Thu,  4 Oct 2012 04:26:27 -0300
Message-Id: <1349335599-12443-4-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

This interface is responsible for handling properties of all objects in
a given path. Right now it only registers itself, doing nothing useful.
A conversion to this new layout will be done by subsequent patches.

org.freedesktop.org.DBus.Properties spec can be found at
http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties
---
 gdbus/object.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 24e8285..6c11528 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -507,6 +507,48 @@ static const GDBusMethodTable introspect_methods[] = {
 	{ }
 };
 
+static DBusMessage *properties_get(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return NULL;
+}
+
+static DBusMessage *properties_get_all(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return NULL;
+}
+
+static DBusMessage *properties_set(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	return dbus_message_new_method_return(message);
+}
+
+static const GDBusMethodTable properties_methods[] = {
+	{ GDBUS_METHOD("Get",
+			GDBUS_ARGS({ "interface", "s" }, { "name", "s" }),
+			GDBUS_ARGS({ "value", "v" }),
+			properties_get) },
+	{ GDBUS_ASYNC_METHOD("Set", NULL,
+			GDBUS_ARGS({ "interface", "s" }, { "name", "s" },
+							{ "value", "v" }),
+			properties_set) },
+	{ GDBUS_METHOD("GetAll",
+			GDBUS_ARGS({ "interface", "s" }),
+			GDBUS_ARGS({ "properties", "a{sv}" }),
+			properties_get_all) },
+	{ }
+};
+
+static const GDBusSignalTable properties_signals[] = {
+	{ GDBUS_SIGNAL("PropertiesChanged",
+			GDBUS_ARGS({ "interface", "s" },
+					{ "changed_properties", "a{sv}" },
+					{ "invalidated_properties", "as"})) },
+	{ }
+};
+
 static void add_interface(struct generic_data *data, const char *name,
 				const GDBusMethodTable *methods,
 				const GDBusSignalTable *signals,
@@ -557,6 +599,9 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE,
 			introspect_methods, NULL, NULL, data, NULL);
 
+	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
+					properties_signals, NULL, data, NULL);
+
 	return data;
 }
 
@@ -596,6 +641,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 		return;
 
 	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
+	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
 
 	invalidate_parent_data(connection, path);
 
-- 
1.7.12.2

