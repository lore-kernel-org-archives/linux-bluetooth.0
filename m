Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] adapter: Fix not waiting for stop discovery result
Date: Fri, 15 Sep 2017 11:39:15 +0300
Message-Id: <20170915083916.27456-2-luiz.dentz@gmail.com>
In-Reply-To: <20170915083916.27456-1-luiz.dentz@gmail.com>
References: <20170915083916.27456-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

We should not reply until the stop discovery completes otherwise
clients may attempt to start the discovery before it even has stopped.

On top of this it will now block clients so they so not be able to
queue more requests.
---
 src/adapter.c | 214 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 113 insertions(+), 101 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9a8b32066..23b458013 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1729,34 +1729,6 @@ static void discovering_callback(uint16_t index, uint16_t length,
 	}
 }
 
-static void stop_discovery_complete(uint8_t status, uint16_t length,
-					const void *param, void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	DBG("status 0x%02x", status);
-
-	if (status == MGMT_STATUS_SUCCESS) {
-		adapter->discovery_type = 0x00;
-		adapter->discovery_enable = 0x00;
-		adapter->filtered_discovery = false;
-		adapter->no_scan_restart_delay = false;
-		adapter->discovering = false;
-		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-					ADAPTER_INTERFACE, "Discovering");
-
-		trigger_passive_scanning(adapter);
-	}
-}
-
-static int compare_sender(gconstpointer a, gconstpointer b)
-{
-	const struct watch_client *client = a;
-	const char *sender = b;
-
-	return g_strcmp0(client->owner, sender);
-}
-
 static void invalidate_rssi_and_tx_power(gpointer a)
 {
 	struct btd_device *dev = a;
@@ -1793,6 +1765,102 @@ static gboolean remove_temp_devices(gpointer user_data)
 	return FALSE;
 }
 
+static void discovery_destroy(void *user_data)
+{
+	struct watch_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
+
+	DBG("owner %s", client->owner);
+
+	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
+								client);
+
+	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
+								client);
+
+	if (client->watch)
+		g_dbus_remove_watch(dbus_conn, client->watch);
+
+	if (client->discovery_filter) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
+	if (client->msg)
+		dbus_message_unref(client->msg);
+
+	g_free(client->owner);
+	g_free(client);
+
+	/*
+	 * If there are other client discoveries in progress, then leave
+	 * it active. If not, then make sure to stop the restart timeout.
+	 */
+	if (adapter->discovery_list)
+		return;
+
+	adapter->discovery_type = 0x00;
+
+	if (adapter->discovery_idle_timeout > 0) {
+		g_source_remove(adapter->discovery_idle_timeout);
+		adapter->discovery_idle_timeout = 0;
+	}
+
+	if (adapter->temp_devices_timeout > 0) {
+		g_source_remove(adapter->temp_devices_timeout);
+		adapter->temp_devices_timeout = 0;
+	}
+
+	discovery_cleanup(adapter);
+
+	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
+						remove_temp_devices, adapter);
+}
+
+static void stop_discovery_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct watch_client *client = user_data;
+	struct btd_adapter *adapter = client->adapter;
+	DBusMessage *reply;
+
+	DBG("status 0x%02x", status);
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		if (client->msg) {
+			reply = btd_error_busy(client->msg);
+			g_dbus_send_message(dbus_conn, reply);
+		}
+		goto done;
+	}
+
+	if (client->msg) {
+		reply = g_dbus_create_reply(client->msg, DBUS_TYPE_INVALID);
+		g_dbus_send_message(dbus_conn, reply);
+	}
+
+	adapter->discovery_type = 0x00;
+	adapter->discovery_enable = 0x00;
+	adapter->filtered_discovery = false;
+	adapter->no_scan_restart_delay = false;
+	adapter->discovering = false;
+	g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Discovering");
+
+	trigger_passive_scanning(adapter);
+
+done:
+	discovery_destroy(client);
+}
+
+static int compare_sender(gconstpointer a, gconstpointer b)
+{
+	const struct watch_client *client = a;
+	const char *sender = b;
+
+	return g_strcmp0(client->owner, sender);
+}
+
 static gint g_strcmp(gconstpointer a, gconstpointer b)
 {
 	return strcmp(a, b);
@@ -2003,55 +2071,6 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 	return -EINPROGRESS;
 }
 
-static void discovery_destroy(void *user_data)
-{
-	struct watch_client *client = user_data;
-	struct btd_adapter *adapter = client->adapter;
-
-	DBG("owner %s", client->owner);
-
-	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
-								client);
-
-	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
-								client);
-
-	if (client->discovery_filter) {
-		free_discovery_filter(client->discovery_filter);
-		client->discovery_filter = NULL;
-	}
-
-	if (client->msg)
-		dbus_message_unref(client->msg);
-
-	g_free(client->owner);
-	g_free(client);
-
-	/*
-	 * If there are other client discoveries in progress, then leave
-	 * it active. If not, then make sure to stop the restart timeout.
-	 */
-	if (adapter->discovery_list)
-		return;
-
-	adapter->discovery_type = 0x00;
-
-	if (adapter->discovery_idle_timeout > 0) {
-		g_source_remove(adapter->discovery_idle_timeout);
-		adapter->discovery_idle_timeout = 0;
-	}
-
-	if (adapter->temp_devices_timeout > 0) {
-		g_source_remove(adapter->temp_devices_timeout);
-		adapter->temp_devices_timeout = 0;
-	}
-
-	discovery_cleanup(adapter);
-
-	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
-						remove_temp_devices, adapter);
-}
-
 static void discovery_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct watch_client *client = user_data;
@@ -2095,7 +2114,7 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 
 	mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
-				stop_discovery_complete, adapter, NULL);
+				stop_discovery_complete, client, NULL);
 }
 
 /*
@@ -2169,7 +2188,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	client->discovery_filter = NULL;
 	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
 						discovery_disconnect, client,
-						discovery_destroy);
+						NULL);
 	adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
 								client);
 
@@ -2436,7 +2455,7 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 		client->discovery_filter = discovery_filter;
 		client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
 						discovery_disconnect, client,
-						discovery_destroy);
+						NULL);
 		adapter->set_filter_list = g_slist_prepend(
 					     adapter->set_filter_list, client);
 
@@ -2467,24 +2486,23 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 
 	client = list->data;
 
-	cp.type = adapter->discovery_type;
-
-	/*
-	 * The destroy function will cleanup the client information and
-	 * also remove it from the list of discovery clients.
-	 */
-	g_dbus_remove_watch(dbus_conn, client->watch);
+	if (client->msg)
+		return btd_error_busy(msg);
 
-	if (adapter->discovery_list) {
+	if (g_slist_length(adapter->discovery_list) > 1) {
+		discovery_destroy(client);
 		update_discovery_filter(adapter);
 		return dbus_message_new_method_return(msg);
 	}
 
+	cp.type = adapter->discovery_type;
+
 	/*
 	 * In the idle phase of a discovery, there is no need to stop it
 	 * and so it is enough to send out the signal and just return.
 	 */
 	if (adapter->discovery_enable == 0x00) {
+		discovery_destroy(client);
 		adapter->discovering = false;
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
@@ -2494,11 +2512,13 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 		return dbus_message_new_method_return(msg);
 	}
 
+	client->msg = dbus_message_ref(msg);
+
 	mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
-				stop_discovery_complete, adapter, NULL);
+				stop_discovery_complete, client, NULL);
 
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static gboolean property_get_address(const GDBusPropertyTable *property,
@@ -3044,7 +3064,7 @@ static const GDBusMethodTable adapter_methods[] = {
 	{ GDBUS_METHOD("SetDiscoveryFilter",
 				GDBUS_ARGS({ "properties", "a{sv}" }), NULL,
 				set_discovery_filter) },
-	{ GDBUS_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
+	{ GDBUS_ASYNC_METHOD("StopDiscovery", NULL, NULL, stop_discovery) },
 	{ GDBUS_ASYNC_METHOD("RemoveDevice",
 			GDBUS_ARGS({ "device", "o" }), NULL, remove_device) },
 	{ GDBUS_METHOD("GetDiscoveryFilters", NULL,
@@ -5958,11 +5978,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 		client = adapter->set_filter_list->data;
 
-		/* g_dbus_remove_watch will remove the client from the
-		 * adapter's list and free it using the discovery_destroy
-		 * function.
-		 */
-		g_dbus_remove_watch(dbus_conn, client->watch);
+		discovery_destroy(client);
 	}
 
 	while (adapter->discovery_list) {
@@ -5970,11 +5986,7 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 		client = adapter->discovery_list->data;
 
-		/* g_dbus_remove_watch will remove the client from the
-		 * adapter's list and free it using the discovery_destroy
-		 * function.
-		 */
-		g_dbus_remove_watch(dbus_conn, client->watch);
+		discovery_destroy(client);
 	}
 
 	adapter->filtered_discovery = false;
-- 
2.13.5

