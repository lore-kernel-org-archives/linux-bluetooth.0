Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ v2 6/6] core: adapter: Implement internals of StartFilteredDiscovery
Date: Thu, 12 Feb 2015 19:50:23 -0800
Message-Id: <1423799423-28986-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
References: <1423799423-28986-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implement guts of StartFilteredDiscovery method. It adds new
structure, discovery_filter to client_watch that might contain
information about filter for given client.
---
 src/adapter.c | 417 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 401 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cf4cf0a..01d5dbd 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -82,6 +82,7 @@
 #define TEMP_DEV_TIMEOUT (3 * 60)
 #define BONDING_TIMEOUT (2 * 60)
 
+#define	HCI_RSSI_INVALID	127
 #define	DISTNACE_VAL_INVALID	0x7FFF
 
 static DBusConnection *dbus_conn = NULL;
@@ -137,10 +138,18 @@ struct conn_param {
 	uint16_t timeout;
 };
 
+struct discovery_filter {
+	uint8_t type;
+	uint16_t pathloss;
+	int16_t rssi;
+	GSList *uuids;
+};
+
 struct watch_client {
 	struct btd_adapter *adapter;
 	char *owner;
 	guint watch;
+	struct discovery_filter *discovery_filter;
 };
 
 struct service_auth {
@@ -193,6 +202,8 @@ struct btd_adapter {
 	GSList *discovery_list;		/* list of discovery clients */
 	GSList *discovery_found;	/* list of found devices */
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
+	guint filtered_discovery_idle_timeout;
+				/* timeout between filtered discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
 	guint temp_devices_timeout;	/* timeout for temporary devices */
 
@@ -1385,7 +1396,8 @@ static gboolean start_discovery_timeout(gpointer user_data)
 		 * If there is an already running discovery and it has the
 		 * same type, then just keep it.
 		 */
-		if (adapter->discovery_type == new_type) {
+		if (adapter->discovery_type == new_type &&
+			adapter->filtered_discovery == false) {
 			if (adapter->discovering)
 				return FALSE;
 
@@ -1395,6 +1407,13 @@ static gboolean start_discovery_timeout(gpointer user_data)
 			return FALSE;
 		}
 
+
+		if (adapter->filtered_discovery) {
+			adapter->filtered_discovery = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "FilteredDiscovery");
+		}
+
 		/*
 		 * Otherwise the current discovery must be stopped. So
 		 * queue up a stop discovery command.
@@ -1430,6 +1449,11 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->filtered_discovery_idle_timeout > 0) {
+		g_source_remove(adapter->filtered_discovery_idle_timeout);
+		adapter->filtered_discovery_idle_timeout = 0;
+	}
+
 	/*
 	 * If the controller got powered down in between, then ensure
 	 * that we do not keep trying to restart discovery.
@@ -1443,6 +1467,203 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 					start_discovery_timeout, adapter);
 }
 
+static void trigger_start_filtered_discovery(struct btd_adapter *adapter,
+					     guint delay);
+
+static void start_filtered_discovery_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const int *type = param;
+
+	DBG("status 0x%02x", status);
+	if (length < 1) {
+		error("Wrong size of return parameters");
+		return;
+	}
+
+	if (status == MGMT_STATUS_SUCCESS) {
+		adapter->discovery_enable = 0x01;
+		adapter->discovery_type = *type;
+
+		if (adapter->discovering) {
+			adapter->discovering = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					     ADAPTER_INTERFACE, "Discovering");
+		}
+
+		if (adapter->filtered_discovery)
+			return;
+
+		adapter->filtered_discovery = true;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "FilteredDiscovery");
+		return;
+	}
+
+	/*
+	 * In case the restart of the discovery failed, then just trigger
+	 * it for the next idle timeout again.
+	 */
+	trigger_start_filtered_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
+}
+
+/* This method merges all filters into one that will be send to kernel.
+ * empty_uuid variable determines wether there was any filter with no uuids. In
+ * this case someone might be looking for all devices in certain proximity, and
+ * we need to have empty uuids in kernel filter.
+ */
+static struct mgmt_cp_start_service_discovery *discovery_filter_to_mgmt_cp(
+						struct btd_adapter *adapter)
+{
+	GSList *l, *m;
+	struct mgmt_cp_start_service_discovery *cp;
+	int rssi = DISTNACE_VAL_INVALID;
+	int uuid_count = 0;
+	uint8_t discovery_type = 0;
+	uint8_t (*current_uuid)[16];
+	bool empty_uuid = false;
+
+	for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+		int curr_uuid_count;
+
+		if (item == NULL) {
+			/* We should be running regular, not filtered discov */
+			error("item == NULL this should never happen!!");
+			continue;
+		}
+
+		discovery_type |= item->type;
+
+		if (item->rssi != DISTNACE_VAL_INVALID &&
+		    rssi != HCI_RSSI_INVALID && rssi >= item->rssi)
+			rssi = item->rssi;
+		else if (item->pathloss != DISTNACE_VAL_INVALID)
+			/* if we're doing pathloss filtering, or no range
+			 * filtering, we disable RSSI filter.
+			 */
+			rssi = HCI_RSSI_INVALID;
+
+		curr_uuid_count = g_slist_length(item->uuids);
+
+		if (curr_uuid_count == 0)
+			empty_uuid = true;
+
+		uuid_count += curr_uuid_count;
+	}
+
+	/* if no proximity filtering is set, disable it */
+	if (rssi == DISTNACE_VAL_INVALID)
+		rssi = HCI_RSSI_INVALID;
+
+	if (empty_uuid == true)
+		uuid_count = 0;
+
+	cp = g_try_malloc(sizeof(cp) + 16*uuid_count);
+	if (cp == NULL)
+		return NULL;
+
+	cp->type = discovery_type;
+	cp->rssi = rssi;
+	cp->uuid_count = uuid_count;
+
+	if (empty_uuid)
+		return cp;
+
+	current_uuid = cp->uuids;
+	for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+
+		for (m = item->uuids; m != NULL; m = g_slist_next(m)) {
+			char *uuid_str = m->data;
+			uuid_t uuid_tmp;
+			uint128_t uint128;
+			uuid_t uuid128;
+
+			bt_string2uuid(&uuid_tmp, uuid_str);
+
+			uuid_to_uuid128(&uuid128, &uuid_tmp);
+			ntoh128((uint128_t *) uuid128.value.uuid128.data,
+				&uint128);
+			htob128(&uint128, (uint128_t *) current_uuid);
+
+			current_uuid++;
+		}
+	}
+	return cp;
+}
+
+static void free_discovery_filter(struct discovery_filter *discovery_filter)
+{
+	g_slist_free_full(discovery_filter->uuids, g_free);
+	g_free(discovery_filter);
+}
+
+static gboolean start_filtered_discovery_timeout(gpointer user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	struct mgmt_cp_start_service_discovery *cp;
+
+	DBG("");
+
+	adapter->filtered_discovery_idle_timeout = 0;
+
+	/* if there's any scan running, stop it. */
+	if (adapter->discovery_enable == 0x01) {
+		struct mgmt_cp_stop_discovery cp;
+
+		cp.type = adapter->discovery_type;
+		mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
+			  adapter->dev_id, sizeof(cp), &cp,
+			  NULL, NULL, NULL);
+	}
+
+	cp = discovery_filter_to_mgmt_cp(adapter);
+	if (cp == NULL) {
+		error("discovery_filter_to_mgmt_cp returned NULL");
+		return FALSE;
+	}
+
+	mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
+		  adapter->dev_id, sizeof(*cp) + cp->uuid_count * 16, cp,
+		  start_filtered_discovery_complete, adapter, NULL);
+
+	g_free(cp);
+	return FALSE;
+}
+
+static void trigger_start_filtered_discovery(struct btd_adapter *adapter,
+					     guint delay)
+{
+	DBG("");
+	cancel_passive_scanning(adapter);
+
+	if (adapter->discovery_idle_timeout > 0) {
+		g_source_remove(adapter->discovery_idle_timeout);
+		adapter->discovery_idle_timeout = 0;
+	}
+
+	if (adapter->filtered_discovery_idle_timeout > 0) {
+		g_source_remove(adapter->filtered_discovery_idle_timeout);
+		adapter->filtered_discovery_idle_timeout = 0;
+	}
+
+	/*
+	 * If the controller got powered down in between, then ensure
+	 * that we do not keep trying to restart discovery.
+	 *
+	 * This is safe-guard and should actually never trigger.
+	 */
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return;
+
+	adapter->filtered_discovery_idle_timeout = g_timeout_add_seconds(delay,
+				start_filtered_discovery_timeout, adapter);
+}
+
 static void suspend_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1483,6 +1704,12 @@ static void suspend_discovery(struct btd_adapter *adapter)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->filtered_discovery_idle_timeout > 0) {
+		g_source_remove(adapter->filtered_discovery_idle_timeout);
+		adapter->filtered_discovery_idle_timeout = 0;
+	}
+
+
 	if (adapter->discovery_enable == 0x00)
 		return;
 
@@ -1525,8 +1752,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", adapter->dev_id,
-					ev->type, ev->discovering);
+	DBG("hci%u type %u discovering %u method %d", adapter->dev_id, ev->type,
+				ev->discovering, adapter->filtered_discovery);
 
 	if (adapter->discovery_enable == ev->discovering)
 		return;
@@ -1552,7 +1779,13 @@ static void discovering_callback(uint16_t index, uint16_t length,
 
 	switch (adapter->discovery_enable) {
 	case 0x00:
-		trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		if (adapter->discovering)
+			trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		else if (adapter->filtered_discovery)
+			trigger_start_filtered_discovery(adapter, 0);
+		else
+			error("Wrong discovery state!");
+
 		break;
 
 	case 0x01:
@@ -1560,10 +1793,23 @@ static void discovering_callback(uint16_t index, uint16_t length,
 			g_source_remove(adapter->discovery_idle_timeout);
 			adapter->discovery_idle_timeout = 0;
 		}
+		if (adapter->filtered_discovery_idle_timeout > 0) {
+			g_source_remove(
+				     adapter->filtered_discovery_idle_timeout);
+			adapter->filtered_discovery_idle_timeout = 0;
+		}
+
 		break;
 	}
 }
 
+static int find_regular_scan(gconstpointer a, gconstpointer b)
+{
+	const struct watch_client *client = a;
+
+	return client->discovery_filter != NULL;
+}
+
 static void stop_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1574,12 +1820,26 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS) {
 		adapter->discovery_type = 0x00;
 		adapter->discovery_enable = 0x00;
+		if (adapter->discovering) {
+			adapter->discovering = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					     ADAPTER_INTERFACE, "Discovering");
+		}
+		if (adapter->filtered_discovery) {
+			adapter->filtered_discovery = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+				       ADAPTER_INTERFACE, "FilteredDiscovery");
+		}
 
-		adapter->discovering = false;
-		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-					ADAPTER_INTERFACE, "Discovering");
-
-		trigger_passive_scanning(adapter);
+		/* if we just finished last reglar scan, and there's some
+		 * filtered scan left, bring it back
+		 */
+		if (adapter->discovery_list != NULL &&
+		   g_slist_find_custom(adapter->discovery_list, NULL,
+						  find_regular_scan) == NULL)
+			trigger_start_filtered_discovery(adapter, 0);
+		else
+			trigger_passive_scanning(adapter);
 	}
 }
 
@@ -1635,6 +1895,11 @@ static void discovery_destroy(void *user_data)
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
+	if (client->discovery_filter != NULL) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
 	g_free(client->owner);
 	g_free(client);
 
@@ -1652,6 +1917,12 @@ static void discovery_destroy(void *user_data)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->filtered_discovery_idle_timeout > 0) {
+		g_source_remove(adapter->filtered_discovery_idle_timeout);
+		adapter->filtered_discovery_idle_timeout = 0;
+	}
+
+
 	if (adapter->temp_devices_timeout > 0) {
 		g_source_remove(adapter->temp_devices_timeout);
 		adapter->temp_devices_timeout = 0;
@@ -1730,6 +2001,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 
 	client->adapter = adapter;
 	client->owner = g_strdup(sender);
+	client->discovery_filter = NULL;
 	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
 						discovery_disconnect, client,
 						discovery_destroy);
@@ -1818,7 +2090,9 @@ static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	struct watch_client *client;
 	const char *sender = dbus_message_get_sender(msg);
+	struct discovery_filter *discovery_filter;
 	DBusMessageIter iter, subiter, dictiter, variantiter;
 	uint16_t pathloss = DISTNACE_VAL_INVALID;
 	int16_t rssi = DISTNACE_VAL_INVALID;
@@ -1887,8 +2161,37 @@ static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 
 	DBG("filtered discovery params: type: %d rssi: %d pathloss: %d",
 						  discov_type, rssi, pathloss);
-	g_slist_free_full(uuids, g_free);
-	return btd_error_failed(msg, "Not implemented yet");
+
+	discovery_filter = g_try_malloc(sizeof(discovery_filter));
+	if (discovery_filter == NULL) {
+		g_slist_free_full(uuids, g_free);
+		return btd_error_failed(msg, "Not enough memory.");
+	}
+
+	discovery_filter->type = discov_type;
+	discovery_filter->pathloss = pathloss;
+	discovery_filter->rssi = rssi;
+	discovery_filter->uuids = uuids;
+
+	client = g_new0(struct watch_client, 1);
+
+	client->adapter = adapter;
+	client->owner = g_strdup(sender);
+	client->discovery_filter = discovery_filter;
+	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
+						discovery_disconnect, client,
+						discovery_destroy);
+
+	adapter->discovery_list = g_slist_prepend(adapter->discovery_list,
+								client);
+	/*
+	 * Just trigger the filtered discovery here. In case an already running
+	 * discovery in idle phase exists, it will be restarted right
+	 * away.
+	 */
+	trigger_start_filtered_discovery(adapter, 0);
+
+	return dbus_message_new_method_return(msg);
 
 invalid_args:
 	g_slist_free_full(uuids, g_free);
@@ -1928,17 +2231,32 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	 * As long as other discovery clients are still active, just
 	 * return success.
 	 */
-	if (adapter->discovery_list)
+	if (adapter->discovery_list) {
+		/* if only filtered scans are left, first kill regular scan */
+		if (g_slist_find_custom(adapter->discovery_list, NULL,
+						find_regular_scan) == NULL) {
+			mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
+				adapter->dev_id, sizeof(cp), &cp,
+				stop_discovery_complete, adapter, NULL);
+		}
+
 		return dbus_message_new_method_return(msg);
+	}
 
 	/*
 	 * In the idle phase of a discovery, there is no need to stop it
 	 * and so it is enough to send out the signal and just return.
 	 */
 	if (adapter->discovery_enable == 0x00) {
-		adapter->discovering = false;
-		g_dbus_emit_property_changed(dbus_conn, adapter->path,
-					ADAPTER_INTERFACE, "Discovering");
+		if (adapter->discovering) {
+			adapter->discovering = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					     ADAPTER_INTERFACE, "Discovering");
+		} else if (adapter->filtered_discovery) {
+			adapter->filtered_discovery = false;
+			g_dbus_emit_property_changed(dbus_conn, adapter->path,
+				       ADAPTER_INTERFACE, "FilteredDiscovery");
+		}
 
 		trigger_passive_scanning(adapter);
 
@@ -4699,6 +5017,11 @@ static void adapter_remove(struct btd_adapter *adapter)
 		adapter->discovery_idle_timeout = 0;
 	}
 
+	if (adapter->filtered_discovery_idle_timeout > 0) {
+		g_source_remove(adapter->filtered_discovery_idle_timeout);
+		adapter->filtered_discovery_idle_timeout = 0;
+	}
+
 	if (adapter->temp_devices_timeout > 0) {
 		g_source_remove(adapter->temp_devices_timeout);
 		adapter->temp_devices_timeout = 0;
@@ -4844,6 +5167,58 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
 	}
 }
 
+static gint g_strcmp(gconstpointer a, gconstpointer b)
+{
+	return strcmp(a, b);
+}
+
+static bool is_filter_match(GSList *discovery_filter, struct eir_data *eir_data,
+								int8_t rssi)
+{
+	GSList *l, *m;
+	bool got_match = false;
+
+	for (l = discovery_filter; l != NULL && got_match != true;
+							l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+
+		if (item == NULL) {
+			/** we should be running regular scan */
+			error("empty filter - this should never happen!");
+			continue;
+		}
+
+		/* if someone started discovery with empty uuids, he wants all
+		 * devices in given proximity.
+		 */
+		if (item->uuids == NULL)
+			got_match = true;
+		else
+			for (m = item->uuids; m != NULL && got_match != true;
+							   m = g_slist_next(m))
+				/* m->data is string representation of uuid. */
+				if (g_slist_find_custom(eir_data->services,
+						    m->data, g_strcmp) != NULL)
+					got_match = true;
+
+		if (got_match) {
+			if (item->rssi != DISTNACE_VAL_INVALID &&
+			    item->rssi > rssi)
+				return false;
+			if (item->pathloss != DISTNACE_VAL_INVALID &&
+			   (eir_data->tx_power == 127 ||
+			   eir_data->tx_power - rssi > item->pathloss))
+				return false;
+		}
+	}
+
+	if (!got_match)
+		return false;
+
+	return true;
+}
+
 static void update_found_devices(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
@@ -4910,8 +5285,18 @@ static void update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
+	if (adapter->filtered_discovery &&
+	    !is_filter_match(adapter->discovery_list, &eir_data, rssi)) {
+		eir_data_free(&eir_data);
+		return;
+	}
+
 	device_set_legacy(dev, legacy);
-	device_set_rssi(dev, rssi);
+
+	if (adapter->filtered_discovery)
+		device_set_rssi_no_delta(dev, rssi, false);
+	else
+		device_set_rssi(dev, rssi);
 
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
-- 
2.2.0.rc0.207.ga3a616c

