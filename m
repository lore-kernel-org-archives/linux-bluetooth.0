Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 2/8] adapter: Set Name through DBus.Properties
Date: Tue,  9 Oct 2012 04:59:50 -0300
Message-Id: <1349769596-6050-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 59 +++++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index eb5fc83..512e2df 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -730,9 +730,8 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 	g_free(adapter->name);
 	adapter->name = g_strdup(name);
 
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Name",
-				DBUS_TYPE_STRING, &name);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+						ADAPTER_INTERFACE, "Name");
 
 	if (main_opts.gatt_enabled)
 		attrib_gap_set(adapter, GATT_CHARAC_DEVICE_NAME,
@@ -767,21 +766,30 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
 	return 0;
 }
 
-static DBusMessage *set_name(DBusMessage *msg, const char *name, void *data)
+static void set_name(struct btd_adapter *adapter, const char *name,
+						GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
 	int ret;
 
 	if (adapter->allow_name_changes == FALSE)
-		return btd_error_failed(msg, strerror(EPERM));
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+						id, ERROR_INTERFACE ".Failed",
+						strerror(EPERM));
 
 	ret = adapter_set_name(adapter, name);
-	if (ret == -EINVAL)
-		return btd_error_invalid_args(msg);
-	else if (ret < 0)
-		return btd_error_failed(msg, strerror(-ret));
+	if (ret >= 0) {
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		return;
+	}
 
-	return dbus_message_new_method_return(msg);
+	if (ret == -EINVAL)
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+	else
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+						id, ERROR_INTERFACE ".Failed",
+						strerror(-ret));
 }
 
 struct btd_device *adapter_find_device(struct btd_adapter *adapter,
@@ -1142,6 +1150,24 @@ static gboolean adapter_property_get_name(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void adapter_property_set_name(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	const char *name;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &name);
+
+	set_name(data, name, id);
+}
+
 static gboolean adapter_property_get_class(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1296,15 +1322,8 @@ static DBusMessage *set_property(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 	dbus_message_iter_recurse(&iter, &sub);
 
-	if (g_str_equal("Name", property)) {
-		const char *name;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-			return btd_error_invalid_args(msg);
-		dbus_message_iter_get_basic(&sub, &name);
 
-		return set_name(msg, name, data);
-	} else if (g_str_equal("Powered", property)) {
+	if (g_str_equal("Powered", property)) {
 		gboolean powered;
 
 		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
@@ -1776,7 +1795,7 @@ static const GDBusSignalTable adapter_signals[] = {
 
 static const GDBusPropertyTable adapter_properties[] = {
 	{ "Address", "s", adapter_property_get_address },
-	{ "Name", "s", adapter_property_get_name },
+	{ "Name", "s", adapter_property_get_name, adapter_property_set_name },
 	{ "Class", "u", adapter_property_get_class },
 	{ "Powered", "b", adapter_property_get_powered },
 	{ "Discoverable", "b", adapter_property_get_discoverable },
-- 
1.7.12.2

