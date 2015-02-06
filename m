Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH BlueZ 4/4] core: adapter: Implement internals of StartFilteredDiscovery
Date: Fri,  6 Feb 2015 15:13:31 -0800
Message-Id: <1423264411-19439-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1423264411-19439-1-git-send-email-jpawlowski@google.com>
References: <1423264411-19439-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implement guts of StartFilteredDiscovery method. It adds new
structure, discovery_filter to client_watch that might contain
information about filter for given client.

It also adds discovery_method field to adapter, that's distinguishing
currently ruing discovery methods.
---
 src/adapter.c | 293 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 284 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index b7d9c77..424cdab 100644
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
@@ -187,6 +196,7 @@ struct btd_adapter {
 
 	bool discovering;		/* discovering property state */
 	uint8_t discovery_type;		/* current active discovery type */
+	uint8_t discovery_method;	/* current active discovery method */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
 	GSList *discovery_list;		/* list of discovery clients */
@@ -1342,6 +1352,7 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 	}
 
 	if (status == MGMT_STATUS_SUCCESS) {
+		adapter->discovery_method = MGMT_OP_START_DISCOVERY;
 		adapter->discovery_type = rp->type;
 		adapter->discovery_enable = 0x01;
 
@@ -1442,6 +1453,174 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
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
+		adapter->discovery_method = MGMT_OP_START_SERVICE_DISCOVERY;
+		adapter->discovery_enable = 0x01;
+		adapter->discovery_type = *type;
+
+		if (adapter->discovering)
+			return;
+
+		adapter->discovering = true;
+		g_dbus_emit_property_changed(dbus_conn, adapter->path,
+					ADAPTER_INTERFACE, "Discovering");
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
+static struct mgmt_cp_start_service_discovery *discovery_filter_to_mgmt_cp(
+						struct btd_adapter *adapter)
+{
+	GSList *l, *m;
+	struct mgmt_cp_start_service_discovery *cp;
+	int rssi = DISTNACE_VAL_INVALID;
+	int uuid_count = 0;
+	uint8_t discovery_type = 0;
+	uint8_t (*current_uuid)[16];
+
+	for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+
+		if (item == NULL) {
+			error("item == NULL this should never happen!!");
+			continue;
+		}
+
+		discovery_type += item->type;
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
+		uuid_count += g_slist_length(item->uuids);
+	}
+
+	/* if no proximity filtering is set, disable it */
+	if (rssi == DISTNACE_VAL_INVALID)
+		rssi = HCI_RSSI_INVALID;
+
+	cp = g_try_malloc(sizeof(cp) + 16*uuid_count);
+	if (cp == NULL)
+		return NULL;
+
+	cp->type = discovery_type;
+	cp->rssi = rssi;
+	cp->uuid_count = uuid_count;
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
+	adapter->discovery_idle_timeout = 0;
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
+	/*
+	 * If the controller got powered down in between, then ensure
+	 * that we do not keep trying to restart discovery.
+	 *
+	 * This is safe-guard and should actually never trigger.
+	 */
+	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+		return;
+
+	adapter->discovery_idle_timeout = g_timeout_add_seconds(delay,
+				start_filtered_discovery_timeout, adapter);
+}
+
 static void suspend_discovery_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -1524,8 +1703,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", adapter->dev_id,
-					ev->type, ev->discovering);
+	DBG("hci%u type %u discovering %u method %d", adapter->dev_id, ev->type,
+				ev->discovering, adapter->discovery_method);
 
 	if (adapter->discovery_enable == ev->discovering)
 		return;
@@ -1551,7 +1730,15 @@ static void discovering_callback(uint16_t index, uint16_t length,
 
 	switch (adapter->discovery_enable) {
 	case 0x00:
-		trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		if (adapter->discovery_method == MGMT_OP_START_DISCOVERY)
+			trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		else if (adapter->discovery_method ==
+						MGMT_OP_START_SERVICE_DISCOVERY)
+			trigger_start_filtered_discovery(adapter, 0);
+		else
+			error("Wrong discovery_method: %d",
+						adapter->discovery_method);
+
 		break;
 
 	case 0x01:
@@ -1571,6 +1758,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	DBG("status 0x%02x", status);
 
 	if (status == MGMT_STATUS_SUCCESS) {
+		adapter->discovery_method = 0x00;
 		adapter->discovery_type = 0x00;
 		adapter->discovery_enable = 0x00;
 
@@ -1634,6 +1822,11 @@ static void discovery_destroy(void *user_data)
 	adapter->discovery_list = g_slist_remove(adapter->discovery_list,
 								client);
 
+	if (client->discovery_filter != NULL) {
+		free_discovery_filter(client->discovery_filter);
+		client->discovery_filter = NULL;
+	}
+
 	g_free(client->owner);
 	g_free(client);
 
@@ -1729,6 +1922,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 
 	client->adapter = adapter;
 	client->owner = g_strdup(sender);
+	client->discovery_filter = NULL;
 	client->watch = g_dbus_add_disconnect_watch(dbus_conn, sender,
 						discovery_disconnect, client,
 						discovery_destroy);
@@ -1747,7 +1941,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 }
 
 static bool parse_filtered_discovery_dict(char *key, DBusMessageIter *value,
-				    GSList *uuids, int16_t *rssi,
+				    GSList **uuids, int16_t *rssi,
 				    uint16_t *pathloss)
 {
 	uint8_t type;
@@ -1774,7 +1968,7 @@ static bool parse_filtered_discovery_dict(char *key, DBusMessageIter *value,
 
 			result_uuid = bt_uuid2string(&uuid_tmp);
 
-			uuids = g_slist_prepend(uuids, result_uuid);
+			*uuids = g_slist_prepend(*uuids, result_uuid);
 
 		dbus_message_iter_next(&arriter);
 		}
@@ -1802,7 +1996,9 @@ static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
 	struct btd_adapter *adapter = user_data;
+	struct watch_client *client;
 	const char *sender = dbus_message_get_sender(msg);
+	struct discovery_filter *discovery_filter;
 	DBusMessageIter iter, subiter, dictiter, variantiter;
 	uint16_t pathloss = DISTNACE_VAL_INVALID;
 	int16_t rssi = DISTNACE_VAL_INVALID;
@@ -1855,7 +2051,7 @@ static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 			dbus_message_iter_recurse(&dictiter, &variantiter);
 
 			if (!parse_filtered_discovery_dict(key, &variantiter,
-						uuids, &rssi, &pathloss))
+						&uuids, &rssi, &pathloss))
 				goto invalid_args;
 		}
 
@@ -1886,8 +2082,37 @@ static DBusMessage *start_filtered_discovery(DBusConnection *conn,
 
 	DBG("filtered discovery params: type: %d rssi: %d pathloss: %d", type,
 							 rssi, pathloss);
-	g_slist_free_full(uuids, g_free);
-	return btd_error_failed(msg, "Not implemented yet");
+
+	discovery_filter = g_try_malloc(sizeof(discovery_filter));
+	if (discovery_filter == NULL) {
+		g_slist_free_full(uuids, g_free);
+		return btd_error_failed(msg, "Not enough memory.");
+	}
+
+	discovery_filter->type = type;
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
@@ -4829,6 +5054,46 @@ static void adapter_msd_notify(struct btd_adapter *adapter,
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
+		for (m = item->uuids; m != NULL && got_match != true;
+							m = g_slist_next(m))
+			/* m->data contains string representation of uuid. */
+			if (g_slist_find_custom(eir_data->services, m->data,
+							g_strcmp) != NULL)
+				got_match = true;
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
@@ -4895,8 +5160,18 @@ static void update_found_devices(struct btd_adapter *adapter,
 		return;
 	}
 
+	if (adapter->discovery_method == MGMT_OP_START_SERVICE_DISCOVERY &&
+	    !is_filter_match(adapter->discovery_list, &eir_data, rssi)) {
+		eir_data_free(&eir_data);
+		return;
+	}
+
 	device_set_legacy(dev, legacy);
-	device_set_rssi(dev, rssi);
+
+	if (adapter->discovery_method == MGMT_OP_START_SERVICE_DISCOVERY)
+		device_set_rssi_no_delta(dev, rssi, false);
+	else
+		device_set_rssi(dev, rssi);
 
 	if (eir_data.appearance != 0)
 		device_set_appearance(dev, eir_data.appearance);
-- 
2.2.0.rc0.207.ga3a616c

