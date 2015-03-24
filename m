Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 6/8] core: adapter: start proper discovery depending on filter type
Date: Tue, 24 Mar 2015 00:57:18 -0700
Message-Id: <1427183840-8089-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1427183840-8089-1-git-send-email-jpawlowski@google.com>
References: <1427183840-8089-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implement starting and updating filtered discovery,
depending on kind of filters used by each client. It also removes
iddle timeout for filtered scans, to make sure that this kind of
scan will run continuously.
---
 src/adapter.c | 269 +++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 248 insertions(+), 21 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cd53c46..8b98c41 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -92,6 +92,7 @@
 #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
 #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
 
+#define	HCI_RSSI_INVALID	127
 #define	DISTANCE_VAL_INVALID	0x7FFF
 #define	PATHLOSS_MAX 137
 
@@ -205,6 +206,9 @@ struct btd_adapter {
 	char *stored_alias;		/* stored adapter name alias */
 
 	bool discovering;		/* discovering property state */
+	bool filtered_discovery;	/* we are doing filtered discovery */
+	bool no_scan_restart_delay;	/* when this flag is set, restart scan
+					 * without delay */
 	uint8_t discovery_type;		/* current active discovery type */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
@@ -212,6 +216,9 @@ struct btd_adapter {
 	GSList *set_filter_list;	/* list of clients that specified
 					 * filter, but don't scan yet
 					 */
+	/* current discovery filter, if any */
+	struct mgmt_cp_start_service_discovery *current_discovery_filter;
+
 	GSList *discovery_found;	/* list of found devices */
 	guint discovery_idle_timeout;	/* timeout between discovery runs */
 	guint passive_scan_timeout;	/* timeout between passive scans */
@@ -1388,6 +1395,11 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 		adapter->discovery_type = rp->type;
 		adapter->discovery_enable = 0x01;
 
+		if (adapter->current_discovery_filter)
+			adapter->filtered_discovery = true;
+		else
+			adapter->filtered_discovery = false;
+
 		if (adapter->discovering)
 			return;
 
@@ -1407,21 +1419,32 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 static gboolean start_discovery_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
-	struct mgmt_cp_start_discovery cp;
+	struct mgmt_cp_start_service_discovery *sd_cp;
 	uint8_t new_type;
 
 	DBG("");
 
 	adapter->discovery_idle_timeout = 0;
 
+	/* If we're doing filtered discovery, it must be quickly restarted */
+	adapter->no_scan_restart_delay = !!adapter->current_discovery_filter;
+
+	DBG("adapter->current_discovery_filter == %d",
+	    !!adapter->current_discovery_filter);
+
 	new_type = get_current_type(adapter);
 
 	if (adapter->discovery_enable == 0x01) {
+		struct mgmt_cp_stop_discovery cp;
+
 		/*
-		 * If there is an already running discovery and it has the
-		 * same type, then just keep it.
+		 * If we're asked to start regular discovery, and there is an
+		 *  already running regular discovery and it has the same type,
+		 * then just keep it.
 		 */
-		if (adapter->discovery_type == new_type) {
+		if (adapter->current_discovery_filter == NULL &&
+		    adapter->filtered_discovery == false &&
+		    adapter->discovery_type == new_type) {
 			if (adapter->discovering)
 				return FALSE;
 
@@ -1436,20 +1459,43 @@ static gboolean start_discovery_timeout(gpointer user_data)
 		 * queue up a stop discovery command.
 		 *
 		 * This can happen if a passive scanning for Low Energy
-		 * devices is ongoing.
+		 * devices is ongoing, or scan type is changed between
+		 * regular and filtered, or filter was updated.
 		 */
 		cp.type = adapter->discovery_type;
-
 		mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
 					adapter->dev_id, sizeof(cp), &cp,
 					NULL, NULL, NULL);
+
+		/* Don't even bother to try to quickly start discovery
+		 * just after stopping it, it would fail with status
+		 * MGMT_BUSY. Instead discovering_callback will take
+		 * care of that.
+		 */
+		return FALSE;
+
 	}
 
-	cp.type = new_type;
+	if (adapter->current_discovery_filter == NULL) {
+		/* Regular discovery is required */
+		struct mgmt_cp_start_discovery cp;
 
-	mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
+		cp.type = new_type;
+		mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
 				start_discovery_complete, adapter, NULL);
+		return FALSE;
+	}
+
+	/* Filtered discovery is required */
+	sd_cp = adapter->current_discovery_filter;
+
+	DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
+	    sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
+
+	mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
+		  adapter->dev_id, sizeof(*sd_cp) + sd_cp->uuid_count * 16,
+		  sd_cp, start_discovery_complete, adapter, NULL);
 
 	return FALSE;
 }
@@ -1561,8 +1607,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", adapter->dev_id,
-					ev->type, ev->discovering);
+	DBG("hci%u type %u discovering %u method %d", adapter->dev_id, ev->type,
+				ev->discovering, adapter->filtered_discovery);
 
 	if (adapter->discovery_enable == ev->discovering)
 		return;
@@ -1588,7 +1634,10 @@ static void discovering_callback(uint16_t index, uint16_t length,
 
 	switch (adapter->discovery_enable) {
 	case 0x00:
-		trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		if (adapter->no_scan_restart_delay)
+			trigger_start_discovery(adapter, 0);
+		else
+			trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
 		break;
 
 	case 0x01:
@@ -1596,6 +1645,7 @@ static void discovering_callback(uint16_t index, uint16_t length,
 			g_source_remove(adapter->discovery_idle_timeout);
 			adapter->discovery_idle_timeout = 0;
 		}
+
 		break;
 	}
 }
@@ -1610,7 +1660,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS) {
 		adapter->discovery_type = 0x00;
 		adapter->discovery_enable = 0x00;
-
+		adapter->filtered_discovery = false;
+		adapter->no_scan_restart_delay = false;
 		adapter->discovering = false;
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
@@ -1661,6 +1712,174 @@ static gboolean remove_temp_devices(gpointer user_data)
 	return FALSE;
 }
 
+/* This method merges all adapter filters into one that will be send to kernel.
+ * cp_ptr is set to null when regular non-filtered discovery is needed,
+ * otherwise it's pointing to filter. Returns 0 on succes, -1 on error
+ */
+static int discovery_filter_to_mgmt_cp(struct btd_adapter *adapter,
+			       struct mgmt_cp_start_service_discovery **cp_ptr)
+{
+	GSList *l, *m;
+	struct mgmt_cp_start_service_discovery *cp;
+	int rssi = DISTANCE_VAL_INVALID;
+	int uuid_count = 0;
+	uint8_t discovery_type = 0;
+	uint8_t (*current_uuid)[16];
+	/* empty_uuid variable determines wether there was any filter with no
+	 * uuids. In this case someone might be looking for all devices in
+	 * certain proximity, and we need to have empty uuids in kernel filter.
+	 */
+	bool empty_uuid = false;
+	bool has_regular_discovery = false;
+	bool has_filtered_discovery = false;
+
+	DBG("");
+	for (l = adapter->discovery_list; l != NULL; l = g_slist_next(l)) {
+		struct watch_client *client = l->data;
+		struct discovery_filter *item = client->discovery_filter;
+		int curr_uuid_count;
+
+		if (item == NULL) {
+			has_regular_discovery = true;
+			continue;
+		}
+
+		has_filtered_discovery = true;
+
+		discovery_type |= item->type;
+
+		if (item->rssi == DISTANCE_VAL_INVALID)
+			rssi = HCI_RSSI_INVALID;
+		else if (rssi != HCI_RSSI_INVALID && rssi >= item->rssi)
+			rssi = item->rssi;
+		else if (item->pathloss != DISTANCE_VAL_INVALID)
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
+	if (rssi == DISTANCE_VAL_INVALID)
+		rssi = HCI_RSSI_INVALID;
+
+	/* if any of filters had empty uuid, do not filter by uuid */
+	if (empty_uuid == true)
+		uuid_count = 0;
+
+	if (has_regular_discovery) {
+		/* It there is both regular and filtered scan running, then
+		 * clear whole fitler to report all devices. If tere are only
+		 * regular scans, run just regular scan.
+		 */
+		if (has_filtered_discovery) {
+			discovery_type = get_current_type(adapter);
+			uuid_count = 0;
+			rssi = HCI_RSSI_INVALID;
+		} else {
+			*cp_ptr = NULL;
+			return 0;
+		}
+	}
+
+	cp = g_try_malloc(sizeof(cp) + 16*uuid_count);
+	*cp_ptr = cp;
+	if (cp == NULL)
+		return -1;
+
+	cp->type = discovery_type;
+	cp->rssi = rssi;
+	cp->uuid_count = uuid_count;
+
+	/* if filter requires no uuids filter, stop processing here. */
+	if (uuid_count == 0)
+		return 0;
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
+	return 0;
+}
+
+static bool filters_equal(struct mgmt_cp_start_service_discovery *a,
+		   struct mgmt_cp_start_service_discovery *b) {
+	if (a == NULL && b == NULL)
+		return true;
+
+	if ((a == NULL && b != NULL) || (a != NULL && b == NULL))
+		return false;
+
+	if (a->type != b->type)
+		return false;
+
+	if (a->rssi != b->rssi)
+		return false;
+
+	/* when we create mgmt_cp_start_service_discovery structure inside
+	 * discovery_filter_to_mgmt_cp, we always keep uuids sorted, and
+	 * unique, so we're safe to compare uuid_count, and uuids like that.
+	 */
+	if (a->uuid_count != b->uuid_count)
+		return false;
+
+	if (memcmp(a->uuids, b->uuids, 16 * a->uuid_count) != 0)
+		return false;
+
+	return true;
+}
+
+static void update_discovery_filter(struct btd_adapter *adapter)
+{
+	struct mgmt_cp_start_service_discovery *sd_cp;
+
+	DBG("");
+
+	if (discovery_filter_to_mgmt_cp(adapter, &sd_cp)) {
+		error("discovery_filter_to_mgmt_cp returned error");
+		return;
+	}
+
+	/* if filters are equal, then don't update scan, except for when
+	 * starting discovery.
+	 */
+	if (filters_equal(adapter->current_discovery_filter, sd_cp) &&
+	    adapter->discovering != 0) {
+		DBG("filters were equal, deciding to not restart the scan.");
+		g_free(sd_cp);
+		return;
+	}
+
+	g_free(adapter->current_discovery_filter);
+	adapter->current_discovery_filter = sd_cp;
+
+	trigger_start_discovery(adapter, 0);
+}
+
 static void discovery_destroy(void *user_data)
 {
 	struct watch_client *client = user_data;
@@ -1728,8 +1947,10 @@ static void discovery_disconnect(DBusConnection *conn, void *user_data)
 	 * However in case this is the last client, the discovery in
 	 * the kernel needs to be disabled.
 	 */
-	if (adapter->discovery_list)
+	if (adapter->discovery_list) {
+		update_discovery_filter(adapter);
 		return;
+	}
 
 	/*
 	 * In the idle phase of a discovery, there is no need to stop it
@@ -1806,8 +2027,8 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 		adapter->set_filter_list = g_slist_remove(
 					     adapter->set_filter_list, client);
 		adapter->discovery_list = g_slist_prepend(
-					     adapter->discovery_list, client);
-		trigger_start_discovery(adapter, 0);
+					      adapter->discovery_list, client);
+		update_discovery_filter(adapter);
 		return dbus_message_new_method_return(msg);
 	}
 
@@ -1827,7 +2048,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	 * discovery in idle phase exists, it will be restarted right
 	 * away.
 	 */
-	trigger_start_discovery(adapter, 0);
+	update_discovery_filter(adapter);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -2010,6 +2231,9 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 		free_discovery_filter(client->discovery_filter);
 		client->discovery_filter = discovery_filter;
 
+		if (is_discovering)
+			update_discovery_filter(adapter);
+
 		if (discovery_filter || is_discovering)
 			return dbus_message_new_method_return(msg);
 
@@ -2067,12 +2291,10 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 	 */
 	g_dbus_remove_watch(dbus_conn, client->watch);
 
-	/*
-	 * As long as other discovery clients are still active, just
-	 * return success.
-	 */
-	if (adapter->discovery_list)
+	if (adapter->discovery_list) {
+		update_discovery_filter(adapter);
 		return dbus_message_new_method_return(msg);
+	}
 
 	/*
 	 * In the idle phase of a discovery, there is no need to stop it
@@ -5284,6 +5506,11 @@ static void adapter_stop(struct btd_adapter *adapter)
 		g_dbus_remove_watch(dbus_conn, client->watch);
 	}
 
+	adapter->filtered_discovery = false;
+	adapter->no_scan_restart_delay = false;
+	g_free(adapter->current_discovery_filter);
+	adapter->current_discovery_filter = NULL;
+
 	adapter->discovering = false;
 
 	while (adapter->connections) {
-- 
2.2.0.rc0.207.ga3a616c

