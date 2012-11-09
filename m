Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/4] proximity: Convert monitor properties to DBus.Properties
Date: Fri, 9 Nov 2012 13:33:19 +0100
Message-ID: <1352464401-12702-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/monitor.c | 214 ++++++++++++++++++++++---------------------
 1 file changed, 111 insertions(+), 103 deletions(-)

diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index e45fa4a..ba61e1b 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -160,9 +160,8 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Link Loss Alert Level written");
 
-	emit_property_changed(path,
-				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
-				DBUS_TYPE_STRING, &monitor->linklosslevel);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+				PROXIMITY_INTERFACE, "LinkLossAlertLevel");
 }
 
 static void char_discovered_cb(GSList *characteristics, guint8 status,
@@ -289,9 +288,10 @@ static gboolean immediate_timeout(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(path,
-				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
-				DBUS_TYPE_STRING, &monitor->immediatelevel);
+
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel");
 
 	return FALSE;
 }
@@ -304,9 +304,9 @@ static void immediate_written(gpointer user_data)
 	g_free(monitor->fallbacklevel);
 	monitor->fallbacklevel = NULL;
 
-	emit_property_changed(path,
-				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
-				DBUS_TYPE_STRING, &monitor->immediatelevel);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel");
 
 	monitor->immediateto = g_timeout_add_seconds(IMMEDIATE_TIMEOUT,
 						immediate_timeout, monitor);
@@ -390,9 +390,9 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(path,
-				PROXIMITY_INTERFACE, "ImmediateAlertLevel",
-				DBUS_TYPE_STRING, &monitor->immediatelevel);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+				PROXIMITY_INTERFACE, "ImmediateAlertLevel");
 }
 
 static gboolean level_is_valid(const char *level)
@@ -402,17 +402,38 @@ static gboolean level_is_valid(const char *level)
 			g_str_equal("high", level));
 }
 
-static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
-						const char *level, void *data)
+static gboolean property_get_link_loss_level(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct monitor *monitor = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&monitor->linklosslevel);
+
+	return TRUE;
+}
+
+static void property_set_link_loss_level(const GDBusPropertyTable *property,
+		DBusMessageIter *iter, GDBusPendingPropertySet id, void *data)
 {
 	struct monitor *monitor = data;
 	struct btd_device *device = monitor->device;
+	const char *level;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &level);
 
 	if (!level_is_valid(level))
-		return btd_error_invalid_args(msg);
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	if (g_strcmp0(monitor->linklosslevel, level) == 0)
-		return dbus_message_new_method_return(msg);
+		goto done;
 
 	g_free(monitor->linklosslevel);
 	monitor->linklosslevel = g_strdup(level);
@@ -424,19 +445,55 @@ static DBusMessage *set_link_loss_alert(DBusConnection *conn, DBusMessage *msg,
 	if (monitor->attrib)
 		write_alert_level(monitor);
 
-	return dbus_message_new_method_return(msg);
+done:
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean property_exists_link_loss_level(
+				const GDBusPropertyTable *property, void *data)
+{
+	struct monitor *monitor = data;
+
+	if (!monitor->enabled.linkloss)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean property_get_immediate_alert_level(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct monitor *monitor = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&monitor->immediatelevel);
+
+	return TRUE;
 }
 
-static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
-						const char *level, void *data)
+static void property_set_immediate_alert_level(
+		const GDBusPropertyTable *property, DBusMessageIter *iter,
+		GDBusPendingPropertySet id, void *data)
 {
 	struct monitor *monitor = data;
+	struct btd_device *device = monitor->device;
+	const char *level;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(iter, &level);
 
 	if (!level_is_valid(level))
-		return btd_error_invalid_args(msg);
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	if (g_strcmp0(monitor->immediatelevel, level) == 0)
-		return dbus_message_new_method_return(msg);
+		goto done;
 
 	if (monitor->immediateto) {
 		g_source_remove(monitor->immediateto);
@@ -456,109 +513,60 @@ static DBusMessage *set_immediate_alert(DBusConnection *conn, DBusMessage *msg,
 	 * when the Proximity Monitor starts.
 	 */
 	if (monitor->attioid == 0)
-		monitor->attioid = btd_device_add_attio_callback(monitor->device,
+		monitor->attioid = btd_device_add_attio_callback(device,
 							attio_connected_cb,
 							attio_disconnected_cb,
 							monitor);
 	else if (monitor->attrib)
 		write_immediate_alert(monitor);
 
-	return dbus_message_new_method_return(msg);
+done:
+	g_dbus_pending_property_success(id);
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean property_exists_immediate_alert_level(
+				const GDBusPropertyTable *property, void *data)
 {
 	struct monitor *monitor = data;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *reply;
-
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	dbus_message_iter_init_append(reply, &iter);
-
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
 
-	if (monitor->enabled.linkloss)
-		dict_append_entry(&dict, "LinkLossAlertLevel",
-				DBUS_TYPE_STRING, &monitor->linklosslevel);
-
-	if (monitor->enabled.findme || monitor->enabled.pathloss)
-		dict_append_entry(&dict, "ImmediateAlertLevel",
-				DBUS_TYPE_STRING, &monitor->immediatelevel);
-
-	if (monitor->enabled.pathloss)
-		dict_append_entry(&dict, "SignalLevel",
-				DBUS_TYPE_STRING, &monitor->signallevel);
-
-	dbus_message_iter_close_container(&iter, &dict);
+	if (!(monitor->enabled.findme || monitor->enabled.pathloss))
+		return FALSE;
 
-	return reply;
+	return TRUE;
 }
 
-static DBusMessage *set_property(DBusConnection *conn,
-					DBusMessage *msg, void *data)
+static gboolean property_get_signal_level(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct monitor *monitor = data;
-	const char *property;
-	DBusMessageIter iter;
-	DBusMessageIter sub;
-	const char *level;
 
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+						&monitor->signallevel);
 
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &property);
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_recurse(&iter, &sub);
-
-	if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&sub, &level);
-
-	if (g_str_equal("ImmediateAlertLevel", property)) {
-		if (monitor->enabled.findme == FALSE &&
-				monitor->enabled.pathloss == FALSE)
-			return btd_error_not_available(msg);
+	return TRUE;
+}
 
-		return set_immediate_alert(conn, msg, level, data);
-	} else if (g_str_equal("LinkLossAlertLevel", property)) {
-		if (monitor->enabled.linkloss == FALSE)
-			return btd_error_not_available(msg);
+static gboolean property_exists_signal_level(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct monitor *monitor = data;
 
-		return set_link_loss_alert(conn, msg, level, data);
-	}
+	if (!monitor->enabled.pathloss)
+		return FALSE;
 
-	return btd_error_invalid_args(msg);
+	return TRUE;
 }
 
-static const GDBusMethodTable monitor_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			set_property) },
-	{ }
-};
-
-static const GDBusSignalTable monitor_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable monitor_device_properties[] = {
+	{ "LinkLossAlertLevel", "s", property_get_link_loss_level,
+					property_set_link_loss_level,
+					property_exists_link_loss_level },
+	{ "ImmediateAlertLevel", "s", property_get_immediate_alert_level,
+					property_set_immediate_alert_level,
+					property_exists_immediate_alert_level },
+	{ "SignalLevel", "s", property_get_signal_level, NULL,
+					property_exists_signal_level },
 	{ }
 };
 
@@ -605,8 +613,8 @@ int monitor_register(struct btd_device *device,
 
 	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 				PROXIMITY_INTERFACE,
-				monitor_methods, monitor_signals,
-				NULL, monitor, monitor_destroy) == FALSE) {
+				NULL, NULL, monitor_device_properties,
+				monitor, monitor_destroy) == FALSE) {
 		error("D-Bus failed to register %s interface",
 						PROXIMITY_INTERFACE);
 		monitor_destroy(monitor);
-- 
1.8.0

