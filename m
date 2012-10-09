Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 3/8] adapter: Set *Timeout through DBus.Properties
Date: Tue,  9 Oct 2012 04:59:51 -0300
Message-Id: <1349769596-6050-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c | 93 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 49 insertions(+), 44 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 512e2df..cc0ec3b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -644,14 +644,13 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 		session_unref(req);
 }
 
-static DBusMessage *set_discoverable_timeout(DBusMessage *msg,
-						uint32_t timeout, void *data)
+static void set_discoverable_timeout(struct btd_adapter *adapter,
+				uint32_t timeout, GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
-	const char *path;
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (adapter->discov_timeout == timeout && timeout == 0)
-		return dbus_message_new_method_return(msg);
+		return g_dbus_pending_property_success(conn, id);
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
 		mgmt_set_discoverable(adapter->dev_id, TRUE, timeout);
@@ -660,23 +659,18 @@ static DBusMessage *set_discoverable_timeout(DBusMessage *msg,
 
 	write_discoverable_timeout(&adapter->bdaddr, timeout);
 
-	path = dbus_message_get_path(msg);
-
-	emit_property_changed(path,
-				ADAPTER_INTERFACE, "DiscoverableTimeout",
-				DBUS_TYPE_UINT32, &timeout);
-
-	return dbus_message_new_method_return(msg);
+	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
+						"DiscoverableTimeout");
+	g_dbus_pending_property_success(conn, id);
 }
 
-static DBusMessage *set_pairable_timeout(DBusMessage *msg,
-						uint32_t timeout, void *data)
+static void set_pairable_timeout(struct btd_adapter *adapter,
+				uint32_t timeout, GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
-	const char *path;
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (adapter->pairable_timeout == timeout && timeout == 0)
-		return dbus_message_new_method_return(msg);
+		return g_dbus_pending_property_success(conn, id);
 
 	if (adapter->pairable)
 		adapter_set_pairable_timeout(adapter, timeout);
@@ -685,13 +679,9 @@ static DBusMessage *set_pairable_timeout(DBusMessage *msg,
 
 	write_pairable_timeout(&adapter->bdaddr, timeout);
 
-	path = dbus_message_get_path(msg);
-
-	emit_property_changed(path,
-				ADAPTER_INTERFACE, "PairableTimeout",
-				DBUS_TYPE_UINT32, &timeout);
-
-	return dbus_message_new_method_return(msg);
+	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
+							"PairableTimeout");
+	g_dbus_pending_property_success(conn, id);
 }
 
 void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
@@ -1228,6 +1218,22 @@ static gboolean adapter_property_get_discoverable_timeout(
 	return TRUE;
 }
 
+
+static void adapter_property_set_discoverable_timeout(
+		const GDBusPropertyTable *property, DBusMessageIter *value,
+		GDBusPendingPropertySet id, void *data)
+{
+	uint32_t timeout;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(value, &timeout);
+	set_discoverable_timeout(data, timeout, id);
+}
+
 static gboolean adapter_property_get_pairable_timeout(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -1240,6 +1246,21 @@ static gboolean adapter_property_get_pairable_timeout(
 	return TRUE;
 }
 
+static void adapter_property_set_pairable_timeout(
+		const GDBusPropertyTable *property, DBusMessageIter *value,
+		GDBusPendingPropertySet id, void *data)
+{
+	uint32_t timeout;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(value, &timeout);
+	set_pairable_timeout(data, timeout, id);
+}
+
 static gboolean adapter_property_get_discovering(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -1341,15 +1362,6 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &discoverable);
 
 		return set_discoverable(msg, discoverable, data);
-	} else if (g_str_equal("DiscoverableTimeout", property)) {
-		uint32_t timeout;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &timeout);
-
-		return set_discoverable_timeout(msg, timeout, data);
 	} else if (g_str_equal("Pairable", property)) {
 		gboolean pairable;
 
@@ -1359,15 +1371,6 @@ static DBusMessage *set_property(DBusConnection *conn,
 		dbus_message_iter_get_basic(&sub, &pairable);
 
 		return set_pairable(msg, pairable, data);
-	} else if (g_str_equal("PairableTimeout", property)) {
-		uint32_t timeout;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_UINT32)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &timeout);
-
-		return set_pairable_timeout(msg, timeout, data);
 	}
 
 	return btd_error_invalid_args(msg);
@@ -1801,8 +1804,10 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Discoverable", "b", adapter_property_get_discoverable },
 	{ "Pairable", "b", adapter_property_get_pairable },
 	{ "DiscoverableTimeout", "u",
-			adapter_property_get_discoverable_timeout },
-	{ "PairableTimeout", "u", adapter_property_get_pairable_timeout },
+			adapter_property_get_discoverable_timeout,
+			adapter_property_set_discoverable_timeout },
+	{ "PairableTimeout", "u", adapter_property_get_pairable_timeout,
+				adapter_property_set_pairable_timeout },
 	{ "Discovering", "b", adapter_property_get_discovering },
 	{ "Devices", "ao", adapter_property_get_devices },
 	{ "UUIDs", "as", adapter_property_get_uuids },
-- 
1.7.12.2

