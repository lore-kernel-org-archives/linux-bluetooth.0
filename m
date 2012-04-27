Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ RFC 1/5] gdbus: add skeleton of DBus.Properties interface
Date: Fri, 27 Apr 2012 18:25:18 -0300
Message-Id: <1335561922-3518-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This interface is responsible for handling properties of all objects in
a given path. Right now it only registers itself, doing nothing useful.
A conversion to this new layout will be done by subsequent patches.

org.freedesktop.org.DBus.Properties spec can be found at
http://dbus.freedesktop.org/doc/dbus-specification.html#standard-interfaces-properties
---
 gdbus/object.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/gdbus/object.c b/gdbus/object.c
index 540d1fc..31113e0 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -554,6 +554,36 @@ static const GDBusMethodTable introspect_methods[] = {
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
+	return NULL;
+}
+
+static const GDBusMethodTable properties_methods[] = {
+	{ "Get", "s[interface_name]s[property_name]", "v[value]", properties_get },
+	{ "Set", "s[interface_name]s[property_name]v[value]", "", properties_set },
+	{ "GetAll", "s[interface_name]", "a{sv}[props]", properties_get_all },
+	{ }
+};
+
+static const GDBusSignalTable properties_signals[] = {
+	{ "PropertiesChanged", "s[interface_name]a{sv}[changed_properties]as[invalidated_properties]" },
+	{ }
+};
+
 static char *undecorate_signature(const char *src)
 {
 	GString *dst = g_string_new(NULL);
@@ -679,6 +709,9 @@ static struct generic_data *object_path_ref(DBusConnection *connection,
 	add_interface(data, DBUS_INTERFACE_INTROSPECTABLE,
 			introspect_methods, NULL, NULL, data, NULL);
 
+	add_interface(data, DBUS_INTERFACE_PROPERTIES, properties_methods,
+					properties_signals, NULL, data, NULL);
+
 	return data;
 }
 
@@ -721,6 +754,7 @@ static void object_path_unref(DBusConnection *connection, const char *path)
 		return;
 
 	remove_interface(data, DBUS_INTERFACE_INTROSPECTABLE);
+	remove_interface(data, DBUS_INTERFACE_PROPERTIES);
 
 	invalidate_parent_data(connection, path);
 
-- 
1.7.10

