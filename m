Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ v4 04/15] gdbus: Implement DBus.Properties.Get method
Date: Thu,  4 Oct 2012 04:26:28 -0300
Message-Id: <1349335599-12443-5-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349335599-12443-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.demarchi@profusion.mobi>

---
 gdbus/gdbus.h  |  8 ++++++++
 gdbus/object.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index 34e3cb3..b2e78c4 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -66,6 +66,12 @@ typedef void (* GDBusDestroyFunction) (void *user_data);
 typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 					DBusMessage *message, void *user_data);
 
+typedef gboolean (*GDBusPropertyGetter)(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data);
+
+typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
+								void *data);
+
 typedef guint32 GDBusPendingReply;
 
 typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
@@ -116,6 +122,8 @@ struct GDBusSignalTable {
 struct GDBusPropertyTable {
 	const char *name;
 	const char *type;
+	GDBusPropertyGetter get;
+	GDBusPropertyExists exists;
 	GDBusPropertyFlags flags;
 };
 
diff --git a/gdbus/object.c b/gdbus/object.c
index 6c11528..89138f7 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -507,10 +507,70 @@ static const GDBusMethodTable introspect_methods[] = {
 	{ }
 };
 
+static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *properties,
+							const char *name)
+{
+	const GDBusPropertyTable *p;
+
+	for (p = properties; p && p->name; p++) {
+		if (strcmp(name, p->name) == 0)
+			return p;
+	}
+
+	return NULL;
+}
+
 static DBusMessage *properties_get(DBusConnection *connection,
 					DBusMessage *message, void *user_data)
 {
-	return NULL;
+	struct generic_data *data = user_data;
+	struct interface_data *iface;
+	const GDBusPropertyTable *property;
+	const char *interface, *name;
+	DBusMessageIter iter, value;
+	DBusMessage *reply;
+
+	if (!dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &interface,
+					DBUS_TYPE_STRING, &name,
+					DBUS_TYPE_INVALID))
+		return NULL;
+
+	iface = find_interface(data->interfaces, interface);
+	if (iface == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+				"No such interface '%s'", interface);
+
+	property = find_property(iface->properties, name);
+	if (property == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+				"No such property '%s'", name);
+
+	if (property->exists != NULL &&
+			!property->exists(property, iface->user_data))
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"No such property '%s'", name);
+
+	if (property->get == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+				"Property '%s' is not readable", name);
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+						property->type, &value);
+
+	if (!property->get(property, &value, iface->user_data)) {
+		dbus_message_unref(reply);
+		return NULL;
+	}
+
+	dbus_message_iter_close_container(&iter, &value);
+
+	return reply;
 }
 
 static DBusMessage *properties_get_all(DBusConnection *connection,
-- 
1.7.12.2

