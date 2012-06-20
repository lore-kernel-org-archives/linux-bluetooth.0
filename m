Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 4/5] adapter: Add DBus API for Broadcaster GAP Role
Date: Wed, 20 Jun 2012 14:05:17 -0400
Message-Id: <1340215518-6694-5-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement dummy calls for register or unregister Broadcaster.
---
 src/adapter.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 0df8790..324765b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -138,6 +138,7 @@ struct btd_adapter {
 	gboolean discovering;		/* Discovery active */
 	gboolean discov_suspended;	/* Discovery suspended */
 	gboolean observing;		/* Observer active */
+	gboolean broadcasting;		/* Broadcaster active */
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -1145,6 +1146,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Observing", DBUS_TYPE_BOOLEAN,
 							&adapter->observing);
 
+	/* Broadcasting */
+	dict_append_entry(&dict, "Broadcasting", DBUS_TYPE_BOOLEAN,
+							&adapter->broadcasting);
+
 	/* Devices */
 	devices = g_new0(char *, g_slist_length(adapter->devices) + 1);
 	for (i = 0, l = adapter->devices; l; l = l->next, i++) {
@@ -1664,6 +1669,24 @@ static DBusMessage *unregister_observer(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *register_broadcaster(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *update_broadcast_data(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_broadcaster(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1715,6 +1738,14 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("UnregisterObserver",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_observer) },
+	{ GDBUS_METHOD("RegisterBroadcaster", GDBUS_ARGS({ "field_name", "s" },
+					{ "values", "a{sv}" }), NULL,
+			register_broadcaster) },
+	{ GDBUS_METHOD("UpdateBroadcastData", GDBUS_ARGS({ "field_name", "s" },
+					{ "values", "a{sv}" }), NULL,
+			update_broadcast_data) },
+	{ GDBUS_METHOD("UnregisterBroadcaster", NULL, NULL,
+			unregister_broadcaster) },
 	{ }
 };
 
@@ -2376,11 +2407,17 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 					ADAPTER_INTERFACE, "Observing",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
+	if (adapter->broadcasting)
+		emit_property_changed(connection, adapter->path,
+					ADAPTER_INTERFACE, "Broadcasting",
+					DBUS_TYPE_BOOLEAN, &prop_false);
+
 	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Powered", DBUS_TYPE_BOOLEAN, &prop_false);
 
 	adapter->discovering = FALSE;
 	adapter->observing = FALSE;
+	adapter->broadcasting = FALSE;
 	adapter->scan_mode = SCAN_DISABLED;
 	adapter->mode = MODE_OFF;
 	adapter->off_requested = FALSE;
@@ -2621,6 +2658,17 @@ void adapter_set_observing(struct btd_adapter *adapter, gboolean observing)
 						DBUS_TYPE_BOOLEAN, &observing);
 }
 
+void adapter_set_broadcasting(struct btd_adapter *adapter,
+							gboolean broadcasting)
+{
+	const char *path = adapter->path;
+
+	adapter->broadcasting = broadcasting;
+
+	emit_property_changed(connection, path, ADAPTER_INTERFACE,
+			"Broadcasting", DBUS_TYPE_BOOLEAN, &broadcasting);
+}
+
 static int found_device_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct remote_dev_info *d = a;
diff --git a/src/adapter.h b/src/adapter.h
index 9e2dd08..e0317d3 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -104,6 +104,8 @@ void adapter_set_allow_name_changes(struct btd_adapter *adapter,
 void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering);
 void adapter_set_observing(struct btd_adapter *adapter, gboolean observing);
+void adapter_set_broadcasting(struct btd_adapter *adapter,
+							gboolean broadcasting);
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
 void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
-- 
1.7.11

