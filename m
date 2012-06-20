Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [PATCH BlueZ 2/5] adapter: Add DBus API for Observer GAP Role
Date: Wed, 20 Jun 2012 14:05:15 -0400
Message-Id: <1340215518-6694-3-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1340215518-6694-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implement dummy calls for register or unregister Observer Agents.
---
 src/adapter.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 src/adapter.h      |  1 +
 src/bluetooth.conf |  1 +
 3 files changed, 42 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f922876..0df8790 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -137,6 +137,7 @@ struct btd_adapter {
 	guint discov_id;		/* Discovery timer */
 	gboolean discovering;		/* Discovery active */
 	gboolean discov_suspended;	/* Discovery suspended */
+	gboolean observing;		/* Observer active */
 	guint auto_timeout_id;		/* Automatic connections timeout */
 	sdp_list_t *services;		/* Services associated to adapter */
 
@@ -1140,6 +1141,10 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_entry(&dict, "Discovering", DBUS_TYPE_BOOLEAN,
 							&adapter->discovering);
 
+	/* Observing */
+	dict_append_entry(&dict, "Observing", DBUS_TYPE_BOOLEAN,
+							&adapter->observing);
+
 	/* Devices */
 	devices = g_new0(char *, g_slist_length(adapter->devices) + 1);
 	for (i = 0, l = adapter->devices; l; l = l->next, i++) {
@@ -1647,6 +1652,18 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *register_observer(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *unregister_observer(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("GetProperties",
 			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
@@ -1691,6 +1708,13 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("UnregisterAgent",
 			GDBUS_ARGS({ "agent", "o" }), NULL,
 			unregister_agent) },
+	{ GDBUS_METHOD("RegisterObserver",
+			GDBUS_ARGS({ "agent", "o" }, { "filter_name", "s" },
+					{ "filter_value", "v" }), NULL,
+			register_observer) },
+	{ GDBUS_METHOD("UnregisterObserver",
+			GDBUS_ARGS({ "agent", "o" }), NULL,
+			unregister_observer) },
 	{ }
 };
 
@@ -2347,10 +2371,16 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 					ADAPTER_INTERFACE, "Discovering",
 					DBUS_TYPE_BOOLEAN, &prop_false);
 
+	if (adapter->observing)
+		emit_property_changed(connection, adapter->path,
+					ADAPTER_INTERFACE, "Observing",
+					DBUS_TYPE_BOOLEAN, &prop_false);
+
 	emit_property_changed(connection, adapter->path, ADAPTER_INTERFACE,
 				"Powered", DBUS_TYPE_BOOLEAN, &prop_false);
 
 	adapter->discovering = FALSE;
+	adapter->observing = FALSE;
 	adapter->scan_mode = SCAN_DISABLED;
 	adapter->mode = MODE_OFF;
 	adapter->off_requested = FALSE;
@@ -2581,6 +2611,16 @@ static void suspend_discovery(struct btd_adapter *adapter)
 		adapter_ops->stop_discovery(adapter->dev_id);
 }
 
+void adapter_set_observing(struct btd_adapter *adapter, gboolean observing)
+{
+	const char *path = adapter->path;
+
+	adapter->observing = observing;
+
+	emit_property_changed(connection, path, ADAPTER_INTERFACE, "Observing",
+						DBUS_TYPE_BOOLEAN, &observing);
+}
+
 static int found_device_cmp(gconstpointer a, gconstpointer b)
 {
 	const struct remote_dev_info *d = a;
diff --git a/src/adapter.h b/src/adapter.h
index b7ea62b..9e2dd08 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -103,6 +103,7 @@ void adapter_set_allow_name_changes(struct btd_adapter *adapter,
 						gboolean allow_name_changes);
 void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering);
+void adapter_set_observing(struct btd_adapter *adapter, gboolean observing);
 uint16_t adapter_get_dev_id(struct btd_adapter *adapter);
 const gchar *adapter_get_path(struct btd_adapter *adapter);
 void adapter_get_address(struct btd_adapter *adapter, bdaddr_t *bdaddr);
diff --git a/src/bluetooth.conf b/src/bluetooth.conf
index 664dbd9..a2fef4f 100644
--- a/src/bluetooth.conf
+++ b/src/bluetooth.conf
@@ -14,6 +14,7 @@
     <allow send_interface="org.bluez.HandsfreeAgent"/>
     <allow send_interface="org.bluez.MediaEndpoint"/>
     <allow send_interface="org.bluez.MediaPlayer"/>
+    <allow send_interface="org.bluez.Observer"/>
     <allow send_interface="org.bluez.Watcher"/>
     <allow send_interface="org.bluez.ThermometerWatcher"/>
   </policy>
-- 
1.7.11

