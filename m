Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 6/7] core: adapter: start proper discovery depending on filter type
Date: Mon, 16 Mar 2015 12:51:35 -0700
Message-Id: <1426535496-25996-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426535496-25996-1-git-send-email-jpawlowski@google.com>
References: <1426535496-25996-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implement starting proper discovery, depending on kind
of filters used. It also removes iddle timeout for filtered scans,
to make sure that this kind of scan will run continuously.

Code starting (or restarting) scan is added at end of
SetDiscoveryFilter, to ensure updated results right away.
---
 src/adapter.c | 227 +++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 219 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 59e7c97..15c99ea 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -92,6 +92,7 @@
 #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
 #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
 
+#define	HCI_RSSI_INVALID	127
 #define	DISTNACE_VAL_INVALID	0x7FFF
 
 static DBusConnection *dbus_conn = NULL;
@@ -204,6 +205,9 @@ struct btd_adapter {
 	char *stored_alias;		/* stored adapter name alias */
 
 	bool discovering;		/* discovering property state */
+	bool filtered_discovery;	/* we are doing filtered discovery */
+	bool no_scan_restart_delay;	/* when this flag is set, restart scan
+					 * without delay */
 	uint8_t discovery_type;		/* current active discovery type */
 	uint8_t discovery_enable;	/* discovery enabled/disabled */
 	bool discovery_suspended;	/* discovery has been suspended */
@@ -1359,6 +1363,120 @@ static uint8_t get_current_type(struct btd_adapter *adapter)
 	return type;
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
+	int rssi = DISTNACE_VAL_INVALID;
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
+		if (item->rssi == DISTNACE_VAL_INVALID)
+			rssi = HCI_RSSI_INVALID;
+		else if (rssi != HCI_RSSI_INVALID && rssi >= item->rssi)
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
+	/* if filter requires no uuid filter, stop processing here. */
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
 static void free_discovery_filter(struct discovery_filter *discovery_filter)
 {
 	if (!discovery_filter)
@@ -1388,6 +1506,42 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS) {
 		adapter->discovery_type = rp->type;
 		adapter->discovery_enable = 0x01;
+		adapter->filtered_discovery = false;
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
+	trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
+}
+
+
+static void start_filtered_discovery_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	const uint8_t *type = param;
+
+	DBG("status 0x%02x", status);
+
+	if (length < 1) {
+		error("Wrong size of return parameters");
+		return;
+	}
+
+	if (status == MGMT_STATUS_SUCCESS) {
+		adapter->discovery_type = *type;
+		adapter->discovery_enable = 0x01;
+		adapter->filtered_discovery = true;
 
 		if (adapter->discovering)
 			return;
@@ -1409,20 +1563,72 @@ static gboolean start_discovery_timeout(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
 	struct mgmt_cp_start_discovery cp;
+	struct mgmt_cp_start_service_discovery *sd_cp;
 	uint8_t new_type;
 
 	DBG("");
 
 	adapter->discovery_idle_timeout = 0;
 
+	if (discovery_filter_to_mgmt_cp(adapter, &sd_cp)) {
+		error("discovery_filter_to_mgmt_cp returned error");
+		return TRUE;
+	}
+
+	/* Service Discovery filter was returned, that means that filtered
+	 * discovery is required.
+	 */
+	if (sd_cp != NULL) {
+		DBG("sd_cp != NULL");
+		/* if there's any scan running, stop it. */
+		if (adapter->discovery_enable == 0x01) {
+			struct mgmt_cp_stop_discovery cp;
+
+			DBG("discovery must be restarted");
+
+			/* Make sure that filtered discovery will be quickly
+			 * restarted.
+			 */
+			adapter->no_scan_restart_delay = true;
+
+			cp.type = adapter->discovery_type;
+			mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
+				  adapter->dev_id, sizeof(cp), &cp,
+				  NULL, NULL, NULL);
+			/* Don't even bother to try to quickly start discovery
+			 * just after stopping it, it would fail with status
+			 * MGMT_BUSY. Instead discovering_callback will take
+			 * care of that.
+			 */
+			g_free(sd_cp);
+			return FALSE;
+		}
+
+		DBG("sending MGMT_OP_START_SERVICE_DISCOVERY %d, %d, %d",
+		    sd_cp->rssi, sd_cp->type, sd_cp->uuid_count);
+
+		mgmt_send(adapter->mgmt, MGMT_OP_START_SERVICE_DISCOVERY,
+			  adapter->dev_id,
+			  sizeof(*sd_cp) + sd_cp->uuid_count * 16, sd_cp,
+			  start_filtered_discovery_complete, adapter, NULL);
+
+		g_free(sd_cp);
+		return FALSE;
+	}
+
+	DBG("sd_cp == NULL");
+	/* We're doing regular discovery. */
 	new_type = get_current_type(adapter);
 
+	adapter->no_scan_restart_delay = false;
+
 	if (adapter->discovery_enable == 0x01) {
 		/*
 		 * If there is an already running discovery and it has the
 		 * same type, then just keep it.
 		 */
-		if (adapter->discovery_type == new_type) {
+		if (adapter->discovery_type == new_type &&
+			adapter->filtered_discovery == false) {
 			if (adapter->discovering)
 				return FALSE;
 
@@ -1440,14 +1646,12 @@ static gboolean start_discovery_timeout(gpointer user_data)
 		 * devices is ongoing.
 		 */
 		cp.type = adapter->discovery_type;
-
 		mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
 					adapter->dev_id, sizeof(cp), &cp,
 					NULL, NULL, NULL);
 	}
 
 	cp.type = new_type;
-
 	mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY,
 				adapter->dev_id, sizeof(cp), &cp,
 				start_discovery_complete, adapter, NULL);
@@ -1562,8 +1766,8 @@ static void discovering_callback(uint16_t index, uint16_t length,
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", adapter->dev_id,
-					ev->type, ev->discovering);
+	DBG("hci%u type %u discovering %u method %d", adapter->dev_id, ev->type,
+				ev->discovering, adapter->filtered_discovery);
 
 	if (adapter->discovery_enable == ev->discovering)
 		return;
@@ -1589,7 +1793,10 @@ static void discovering_callback(uint16_t index, uint16_t length,
 
 	switch (adapter->discovery_enable) {
 	case 0x00:
-		trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
+		if (adapter->no_scan_restart_delay)
+			trigger_start_discovery(adapter, 0);
+		else
+			trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT);
 		break;
 
 	case 0x01:
@@ -1597,6 +1804,7 @@ static void discovering_callback(uint16_t index, uint16_t length,
 			g_source_remove(adapter->discovery_idle_timeout);
 			adapter->discovery_idle_timeout = 0;
 		}
+
 		break;
 	}
 }
@@ -1611,7 +1819,8 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	if (status == MGMT_STATUS_SUCCESS) {
 		adapter->discovery_type = 0x00;
 		adapter->discovery_enable = 0x00;
-
+		adapter->filtered_discovery = false;
+		adapter->no_scan_restart_delay = false;
 		adapter->discovering = false;
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
 					ADAPTER_INTERFACE, "Discovering");
@@ -2031,7 +2240,9 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 	free_discovery_filter(client->discovery_filter);
 	client->discovery_filter = discovery_filter;
 
-	return btd_error_failed(msg, "Not implemented yet");
+	trigger_start_discovery(adapter, 0);
+
+	return dbus_message_new_method_return(msg);
 }
 
 static DBusMessage *stop_discovery(DBusConnection *conn,
-- 
2.2.0.rc0.207.ga3a616c

