Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] adapter: Refactor code around discovery
Date: Thu, 14 Sep 2017 16:15:09 +0300
Message-Id: <20170914131509.13624-3-luiz.dentz@gmail.com>
In-Reply-To: <20170914131509.13624-1-luiz.dentz@gmail.com>
References: <20170914131509.13624-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make it reuse more code by having helpers to stop, remove and free
clients.
---
 src/adapter.c | 162 +++++++++++++++++++++++++---------------------------------
 1 file changed, 69 insertions(+), 93 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 872167c73..ecb7b1d87 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1720,13 +1720,6 @@ static void invalidate_rssi_and_tx_power(gpointer a)
 	device_set_tx_power(dev, 127);
 }
 
-static void discovery_cleanup(struct btd_adapter *adapter)
-{
-	g_slist_free_full(adapter->discovery_found,
-						invalidate_rssi_and_tx_power);
-	adapter->discovery_found = NULL;
-}
-
 static gboolean remove_temp_devices(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -1748,18 +1741,31 @@ static gboolean remove_temp_devices(gpointer user_data)
 	return FALSE;
 }
 
-static void discovery_destroy(void *user_data)
+static void discovery_cleanup(struct btd_adapter *adapter)
 {
-	struct watch_client *client = user_data;
-	struct btd_adapter *adapter = client->adapter;
+	adapter->discovery_type = 0x00;
 
-	DBG("owner %s", client->owner);
+	if (adapter->discovery_idle_timeout > 0) {
+		g_source_remove(adapter->discovery_idle_timeout);
+		adapter->discovery_idle_timeout = 0;
+	}
 
-	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
-								client);
+	if (adapter->temp_devices_timeout > 0) {
+		g_source_remove(adapter->temp_devices_timeout);
+		adapter->temp_devices_timeout = 0;
+	}
 
-	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
-								client);
+	g_slist_free_full(adapter->discovery_found,
+						invalidate_rssi_and_tx_power);
+	adapter->discovery_found = NULL;
+
+	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
+						remove_temp_devices, adapter);
+}
+
+static void discovery_free(void *user_data)
+{
+	struct watch_client *client = user_data;
 
 	if (client->watch)
 		g_dbus_remove_watch(dbus_conn, client->watch);
@@ -1774,6 +1780,21 @@ static void discovery_destroy(void *user_data)
 
 	g_free(client->owner);
 	g_free(client);
+}
+
+static void discovery_remove(struct watch_client *client)
+{
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
+	discovery_free(client);
 
 	/*
 	 * If there are other client discoveries in progress, then leave
@@ -1782,22 +1803,7 @@ static void discovery_destroy(void *user_data)
 	if (adapter->discovery_list)
 		return;
 
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
 	discovery_cleanup(adapter);
-
-	adapter->temp_devices_timeout = g_timeout_add_seconds(TEMP_DEV_TIMEOUT,
-						remove_temp_devices, adapter);
 }
 
 static void stop_discovery_complete(uint8_t status, uint16_t length,
@@ -1833,7 +1839,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	trigger_passive_scanning(adapter);
 
 done:
-	discovery_destroy(client);
+	discovery_remove(client);
 }
 
 static int compare_sender(gconstpointer a, gconstpointer b)
@@ -2054,30 +2060,16 @@ static int update_discovery_filter(struct btd_adapter *adapter)
 	return -EINPROGRESS;
 }
 
-static void discovery_disconnect(DBusConnection *conn, void *user_data)
+static int discovery_stop(struct watch_client *client)
 {
-	struct watch_client *client = user_data;
 	struct btd_adapter *adapter = client->adapter;
 	struct mgmt_cp_stop_discovery cp;
 
-	DBG("owner %s", client->owner);
-
-	adapter->set_filter_list = g_slist_remove(adapter->set_filter_list,
-								client);
-
-	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
-								client);
-
-	/*
-	 * There is no need for extra cleanup of the client since that
-	 * will be done by the destroy callback.
-	 *
-	 * However in case this is the last client, the discovery in
-	 * the kernel needs to be disabled.
-	 */
-	if (adapter->discovery_list) {
+	/* Check if there are more client discovering */
+	if (g_slist_next(adapter->discovery_list)) {
+		discovery_remove(client);
 		update_discovery_filter(adapter);
-		return;
+		return 0;
 	}
 
 	/*
@@ -2085,12 +2077,14 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 	 * and so it is enough to send out the signal and just return.
 	 */
 	if (adapter->discovery_enable == 0x00) {
+		discovery_remove(client);
 		adapter->discovering = false;
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
 
 		trigger_passive_scanning(adapter);
-		return;
+
+		return 0;
 	}
 
 	cp.type = adapter->discovery_type;
@@ -2098,6 +2092,17 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 	mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
 				stop_discovery_complete, client, NULL);
+
+	return -EINPROGRESS;
+}
+
+static void discovery_disconnect(DBusConnection *conn, void *user_data)
+{
+	struct watch_client *client = user_data;
+
+	DBG("owner %s", client->owner);
+
+	discovery_stop(client);
 }
 
 /*
@@ -2453,9 +2458,9 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 {
 	struct btd_adapter *adapter = user_data;
 	const char *sender = dbus_message_get_sender(msg);
-	struct mgmt_cp_stop_discovery cp;
 	struct watch_client *client;
 	GSList *list;
+	int err;
 
 	DBG("sender %s", sender);
 
@@ -2472,36 +2477,15 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	if (client->msg)
 		return btd_error_busy(msg);
 
-	if (g_slist_length(adapter->discovery_list) > 1) {
-		discovery_destroy(client);
-		update_discovery_filter(adapter);
-		return dbus_message_new_method_return(msg);
-	}
-
-	cp.type = adapter->discovery_type;
-
-	/*
-	 * In the idle phase of a discovery, there is no need to stop it
-	 * and so it is enough to send out the signal and just return.
-	 */
-	if (adapter->discovery_enable == 0x00) {
-		discovery_destroy(client);
-		adapter->discovering = false;
-		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-					ADAPTER_INTERFACE, "Discovering");
-
-		trigger_passive_scanning(adapter);
-
+	err = discovery_stop(client);
+	switch (err) {
+	case 0:
 		return dbus_message_new_method_return(msg);
+	case -EINPROGRESS:
+		return NULL;
+	default:
+		return btd_error_failed(msg, strerror(-err));
 	}
-
-	client->msg = dbus_message_ref(msg);
-
-	mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
-				adapter->dev_id, sizeof(cp), &cp,
-				stop_discovery_complete, client, NULL);
-
-	return NULL;
 }
 
 static gboolean property_get_address(const GDBusPropertyTable *property,
@@ -5956,21 +5940,13 @@ static void adapter_stop(struct btd_adapter *adapter)
 
 	cancel_passive_scanning(adapter);
 
-	while (adapter->set_filter_list) {
-		struct watch_client *client;
-
-		client = adapter->set_filter_list->data;
-
-		discovery_destroy(client);
-	}
+	g_slist_free_full(adapter->set_filter_list, discovery_free);
+	adapter->set_filter_list = NULL;
 
-	while (adapter->discovery_list) {
-		struct watch_client *client;
+	g_slist_free_full(adapter->discovery_list, discovery_free);
+	adapter->discovery_list = NULL;
 
-		client = adapter->discovery_list->data;
-
-		discovery_destroy(client);
-	}
+	discovery_cleanup(adapter);
 
 	adapter->filtered_discovery = false;
 	adapter->no_scan_restart_delay = false;
-- 
2.13.5

