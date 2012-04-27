Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [BlueZ RFC 2/5] gdbus: implement DBus.Properties.Get method
Date: Fri, 27 Apr 2012 18:25:19 -0300
Message-Id: <1335561922-3518-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1335561922-3518-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 gdbus/gdbus.h  |   15 +++++++++++--
 gdbus/object.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 78 insertions(+), 3 deletions(-)

diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
index a5843e0..359e8a0 100644
--- a/gdbus/gdbus.h
+++ b/gdbus/gdbus.h
@@ -55,6 +55,15 @@ typedef void (* GDBusDestroyFunction) (void *user_data);
 typedef DBusMessage * (* GDBusMethodFunction) (DBusConnection *connection,
 					DBusMessage *message, void *user_data);
 
+typedef struct GDBusPropertyTable GDBusPropertyTable;
+typedef gboolean (*GDBusPropertyGetter)(DBusConnection *connection,
+					DBusMessage *message,
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data);
+
+typedef gboolean (*GDBusPropertyExists)(const GDBusPropertyTable *property,
+								void *data);
+
 typedef guint32 GDBusPendingReply;
 
 typedef void (* GDBusSecurityFunction) (DBusConnection *connection,
@@ -97,11 +106,13 @@ typedef struct {
 	GDBusSignalFlags flags;
 } GDBusSignalTable;
 
-typedef struct {
+struct GDBusPropertyTable {
 	const char *name;
 	const char *type;
 	GDBusPropertyFlags flags;
-} GDBusPropertyTable;
+	GDBusPropertyGetter get;
+	GDBusPropertyExists exists;
+};
 
 typedef struct {
 	unsigned int privilege;
diff --git a/gdbus/object.c b/gdbus/object.c
index 31113e0..0259f46 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -554,10 +554,74 @@ static const GDBusMethodTable introspect_methods[] = {
 	{ }
 };
 
+static inline const GDBusPropertyTable *find_property(const GDBusPropertyTable *properties,
+							const char *property_name)
+{
+	const GDBusPropertyTable *p;
+
+	for (p = properties; p && p->name; p++) {
+		if (strcmp(property_name, p->name) == 0)
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
+	const char *interface_name, *property_name;
+	DBusMessageIter iter, value;
+	DBusMessage *reply;
+
+	if (!dbus_message_get_args(message, NULL,
+					DBUS_TYPE_STRING, &interface_name,
+					DBUS_TYPE_STRING, &property_name,
+					DBUS_TYPE_INVALID))
+		return NULL;
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
+	if (property->exists != NULL &&
+			!property->exists(property, iface->user_data))
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+						"No such property '%s'",
+						property_name);
+
+	if (property->get == NULL)
+		return g_dbus_create_error(message, DBUS_ERROR_INVALID_ARGS,
+					"Property '%s' is not readable",
+					property_name);
+
+	reply = dbus_message_new_method_return(message);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_VARIANT,
+						property->type, &value);
+
+	if (!property->get(connection, message, property, &value,
+							iface->user_data)) {
+		dbus_message_iter_abandon_container(&iter, &value);
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
1.7.10

