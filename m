Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [RFC 09/11] core: Add API to start/stop connection monitoring
Date: Tue, 20 May 2014 01:44:41 +0200
Message-Id: <1400543083-28811-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400543083-28811-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds Start-/StopConnectionMonitor methods to
org.bluez.Device1 which can be used to request polling of connection
properties, i.e. ConnectionRSSI and ConnectionTXPower.
---
 src/adapter.c |  24 +++++++++
 src/adapter.h |   7 +++
 src/device.c  | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 191 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 585f2e2..a3204d0 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5460,6 +5460,30 @@ static void disconnect_complete(uint8_t status, uint16_t length,
 	dev_disconnected(adapter, &rp->addr, MGMT_DEV_DISCONN_LOCAL_HOST);
 }
 
+int btd_adapter_add_monitored_device(struct btd_adapter *adapter,
+							const bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
+{
+	char addrstr[18];
+
+	ba2str(bdaddr, addrstr);
+	DBG("addr %s type %d", addrstr, bdaddr_type);
+
+	return 0;
+}
+
+int btd_adapter_remove_monitored_device(struct btd_adapter *adapter,
+							const bdaddr_t *bdaddr,
+							uint8_t bdaddr_type)
+{
+	char addrstr[18];
+
+	ba2str(bdaddr, addrstr);
+	DBG("addr %s type %d", addrstr, bdaddr_type);
+
+	return 0;
+}
+
 int btd_adapter_disconnect_device(struct btd_adapter *adapter,
 						const bdaddr_t *bdaddr,
 						uint8_t bdaddr_type)
diff --git a/src/adapter.h b/src/adapter.h
index f88c339..713c3ec 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -207,3 +207,10 @@ gboolean btd_adapter_check_oob_handler(struct btd_adapter *adapter);
 void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void (*cb)(struct btd_device *device, void *data),
 			void *data);
+
+int btd_adapter_add_monitored_device(struct btd_adapter *adapter,
+							const bdaddr_t *bdaddr,
+							uint8_t bdaddr_type);
+int btd_adapter_remove_monitored_device(struct btd_adapter *adapter,
+							const bdaddr_t *bdaddr,
+							uint8_t bdaddr_type);
diff --git a/src/device.c b/src/device.c
index 1891735..4069861 100644
--- a/src/device.c
+++ b/src/device.c
@@ -48,6 +48,8 @@
 #include "btio/btio.h"
 #include "lib/uuid.h"
 #include "lib/mgmt.h"
+#include "src/shared/queue.h"
+#include "src/shared/util.h"
 #include "attrib/att.h"
 #include "hcid.h"
 #include "adapter.h"
@@ -159,6 +161,13 @@ struct bearer_state {
 	bool bonded;
 	bool connected;
 	bool svc_resolved;
+	bool monitored;
+};
+
+struct monitor_client {
+	struct btd_device *device;
+	char *owner;
+	guint watch;
 };
 
 struct btd_device {
@@ -219,6 +228,7 @@ struct btd_device {
 	bool		legacy;
 	int8_t		rssi;
 
+	struct queue	*monitor_list;
 	int8_t		conn_rssi;
 	int8_t		conn_tx_power;
 	int8_t		conn_max_tx_power;
@@ -515,6 +525,13 @@ static void svc_dev_remove(gpointer user_data)
 	g_free(cb);
 }
 
+static void monitor_client_remove(void *data, void *user_data)
+{
+	struct monitor_client *client = data;
+
+	g_dbus_remove_watch(dbus_conn, client->watch);
+}
+
 static void device_free(gpointer user_data)
 {
 	struct btd_device *device = user_data;
@@ -555,6 +572,9 @@ static void device_free(gpointer user_data)
 	if (device->eir_uuids)
 		g_slist_free_full(device->eir_uuids, g_free);
 
+	queue_foreach(device->monitor_list, monitor_client_remove, NULL);
+	queue_destroy(device->monitor_list, NULL);
+
 	g_free(device->path);
 	g_free(device->alias);
 	free(device->modalias);
@@ -1934,6 +1954,134 @@ static DBusMessage *cancel_pairing(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static bool compare_sender(const void *a, const void *b)
+{
+	const struct monitor_client *client = a;
+	const char *sender = b;
+
+	return !strcmp(client->owner, sender);
+}
+
+static void monitor_start(struct btd_device *device)
+{
+	DBG("");
+
+	if (device->bredr_state.connected && !device->bredr_state.monitored) {
+		btd_adapter_add_monitored_device(device->adapter,
+							&device->bdaddr,
+							BDADDR_BREDR);
+		device->bredr_state.monitored = true;
+	}
+
+	if (device->le_state.connected && !device->le_state.monitored) {
+		btd_adapter_add_monitored_device(device->adapter,
+							&device->bdaddr,
+							device->bdaddr_type);
+		device->le_state.monitored = true;
+	}
+}
+
+static void monitor_stop(struct btd_device *device, bool stop_all)
+{
+	DBG("");
+
+	if (device->bredr_state.monitored &&
+				(stop_all || !device->bredr_state.connected)) {
+		btd_adapter_remove_monitored_device(device->adapter,
+							&device->bdaddr,
+							BDADDR_BREDR);
+		device->bredr_state.monitored = false;
+	}
+
+	if (device->le_state.monitored &&
+				(stop_all || !device->le_state.connected)) {
+		btd_adapter_remove_monitored_device(device->adapter,
+							&device->bdaddr,
+							device->bdaddr_type);
+		device->le_state.monitored = false;
+	}
+}
+
+static void monitor_destroy(void *user_data)
+{
+	struct monitor_client *client = user_data;
+	struct btd_device *device = client->device;
+
+	DBG("owner %s", client->owner);
+
+	queue_remove(device->monitor_list, client);
+
+	g_free(client->owner);
+	free(client);
+}
+
+static void monitor_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct monitor_client *client = user_data;
+	struct btd_device *device = client->device;
+
+	DBG("owner %s", client->owner);
+
+	queue_remove(device->monitor_list, client);
+
+	if (queue_length(device->monitor_list))
+		return;
+
+	monitor_stop(device, true);
+}
+
+static DBusMessage *start_conn_monitoring(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_device *device = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct monitor_client *client;
+
+	DBG("sender %s", sender);
+
+	if (!btd_device_is_connected(device))
+		return btd_error_not_connected(msg);
+
+	if (queue_find(device->monitor_list, compare_sender, sender))
+		return btd_error_busy(msg);
+
+	client = new0(struct monitor_client, 1);
+	client->device = device;
+	client->owner = g_strdup(sender);
+	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
+							monitor_disconnect,
+							client,
+							monitor_destroy);
+
+	if (!queue_length(device->monitor_list))
+		monitor_start(device);
+
+	queue_push_head(device->monitor_list, client);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *stop_conn_monitoring(DBusConnection *conn,
+					DBusMessage *msg, void *user_data)
+{
+	struct btd_device *device = user_data;
+	const char *sender = dbus_message_get_sender(msg);
+	struct monitor_client *client;
+
+	DBG("sender %s", sender);
+
+	client = queue_find(device->monitor_list, compare_sender, sender);
+	if (!client)
+		return btd_error_failed(msg, "No monitor started");
+
+	g_dbus_remove_watch(dbus_conn, client->watch);
+
+	if (!queue_length(device->monitor_list))
+		monitor_stop(device, true);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static const GDBusMethodTable device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, dev_disconnect) },
 	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, dev_connect) },
@@ -1943,6 +2091,10 @@ static const GDBusMethodTable device_methods[] = {
 						NULL, disconnect_profile) },
 	{ GDBUS_ASYNC_METHOD("Pair", NULL, NULL, pair_device) },
 	{ GDBUS_METHOD("CancelPairing", NULL, NULL, cancel_pairing) },
+	{ GDBUS_METHOD("StartConnectionMonitor", NULL, NULL,
+						start_conn_monitoring) },
+	{ GDBUS_METHOD("StopConnectionMonitor", NULL, NULL,
+						stop_conn_monitoring) },
 	{ }
 };
 
@@ -1998,6 +2150,8 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 		return;
 	}
 
+	monitor_start(dev);
+
 	/* If this is the first connection over this bearer */
 	if (bdaddr_type == BDADDR_BREDR)
 		device_set_bredr_support(dev);
@@ -2024,6 +2178,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	device->svc_refreshed = false;
 	device->general_connect = FALSE;
 
+	monitor_stop(device, false);
+
 	if (device->disconn_timer > 0) {
 		g_source_remove(device->disconn_timer);
 		device->disconn_timer = 0;
@@ -2044,6 +2200,8 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type)
 	if (device->bredr_state.connected || device->le_state.connected)
 		return;
 
+	queue_foreach(device->monitor_list, monitor_client_remove, NULL);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
 }
@@ -2367,6 +2525,8 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	str2ba(address, &device->bdaddr);
 	device->adapter = adapter;
 
+	device->monitor_list = queue_new();
+
 	device->conn_tx_power = 127; /* invalid */
 	device->conn_max_tx_power = 127; /* invalid */
 
-- 
1.9.3

