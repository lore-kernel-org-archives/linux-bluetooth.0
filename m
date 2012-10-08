Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [WORKAROUND BlueZ 2/3] gdbus: Add fallback to SetProperty
Date: Mon,  8 Oct 2012 10:11:23 +0200
Message-Id: <1349683884-22251-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
References: <1349683884-22251-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds a fallback for SetProperty method when it is not implemented.
---
 gdbus/object.c | 94 +++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 67 insertions(+), 27 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index e7a4cc3..8f6cbed 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -827,15 +827,47 @@ static DBusMessage *properties_get_all(DBusConnection *connection,
 	return reply;
 }
 
+static DBusMessage *property_set(struct interface_data *iface,
+				DBusMessage *message, const char *name,
+				DBusMessageIter *iter)
+{
+	const GDBusPropertyTable *property;
+	struct property_data *propdata;
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
+	pending_property_set = g_slist_prepend(pending_property_set, propdata);
+
+	property->set(property, iter, propdata->id, iface->user_data);
+
+	return NULL;
+}
+
 static DBusMessage *properties_set(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
 	struct generic_data *data = user_data;
 	DBusMessageIter iter, sub;
 	struct interface_data *iface;
-	const GDBusPropertyTable *property;
 	const char *name, *interface;
-	struct property_data *propdata;
 
 	if (!dbus_message_iter_init(message, &iter))
 		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
@@ -869,31 +901,7 @@ static DBusMessage *properties_set(DBusConnection *connection,
 		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
 					"No such interface '%s'", interface);
 
-	property = find_property(iface->properties, name);
-	if (property == NULL)
-		return g_dbus_create_error(message,
-						DBUS_ERROR_UNKNOWN_PROPERTY,
-						"No such property '%s'", name);
-
-	if (property->set == NULL)
-		return g_dbus_create_error(message,
-					DBUS_ERROR_PROPERTY_READ_ONLY,
-					"Property '%s' is not writable", name);
-
-	if (property->exists != NULL &&
-			!property->exists(property, iface->user_data))
-		return g_dbus_create_error(message,
-						DBUS_ERROR_UNKNOWN_PROPERTY,
-						"No such property '%s'", name);
-
-	propdata = g_new(struct property_data, 1);
-	propdata->id = next_pending_property++;
-	propdata->message = dbus_message_ref(message);
-	pending_property_set = g_slist_prepend(pending_property_set, propdata);
-
-	property->set(property, &sub, propdata->id, iface->user_data);
-
-	return NULL;
+	return property_set(iface, message, name, &sub);
 }
 
 static const GDBusMethodTable properties_methods[] = {
@@ -1022,10 +1030,42 @@ static DBusMessage *get_properties(DBusConnection *connection,
 	return reply;
 }
 
+static DBusMessage *set_property(DBusConnection *connection,
+					DBusMessage *message, void *user_data)
+{
+	struct interface_data *iface = user_data;
+	DBusMessageIter iter, sub;
+	const char *name;
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
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Invalid argument type: '%c'",
+					dbus_message_iter_get_arg_type(&iter));
+
+	dbus_message_iter_recurse(&iter, &sub);
+
+	return property_set(iface, message, name, &sub);
+}
+
 static const GDBusMethodTable fallback_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
 			get_properties) },
+	{ GDBUS_ASYNC_METHOD("SetProperty",
+			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
+			set_property) },
 	{ }
 };
 
-- 
1.7.11.4

