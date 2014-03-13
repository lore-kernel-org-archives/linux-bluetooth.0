Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 5/8] android/bluetooth: Add GATT notifications on LE discovery
Date: Thu, 13 Mar 2014 19:46:12 +0100
Message-ID: <1394736375-22599-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1394736375-22599-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This patch introduce API which GATT can use to start/stop discovery
and register for required events.

This is because GATT needs to get from GAP notifications about
founded devices and also notification when discovery has been stopped.

GATT will need it explicity when GATT client calls scan, and also in
case of connect device, as before le connect is sent we do scan first
to make sure that device is available.

For now on adapter have two variables tracing discovery.
1. cur_discovery_type which show type of ongoing discovery type.
2. exp_discovery_type which shows type of next discovery session.

We need this because of scenarion when GATT is interesting in scan and
in the same time HAL wants to do scanning.
---
 android/bluetooth.c | 130 +++++++++++++++++++++++++++++++++++++++++++++++-----
 android/bluetooth.h |   7 +++
 2 files changed, 125 insertions(+), 12 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a28fb01..ffec791 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -84,6 +84,8 @@
 #define SCAN_TYPE_LE ((1 << BDADDR_LE_PUBLIC) | (1 << BDADDR_LE_RANDOM))
 #define SCAN_TYPE_DUAL (SCAN_TYPE_BREDR | SCAN_TYPE_LE)
 
+#define BDADDR_LE (BDADDR_LE_RANDOM | BDADDR_LE_PUBLIC)
+
 struct device {
 	bdaddr_t bdaddr;
 	uint8_t bdaddr_type;
@@ -122,7 +124,8 @@ static struct {
 
 	uint32_t current_settings;
 
-	bool discovering;
+	uint8_t cur_discovery_type;
+	uint8_t exp_discovery_type;
 	uint32_t discoverable_timeout;
 
 	GSList *uuids;
@@ -131,7 +134,8 @@ static struct {
 	.dev_class = 0,
 	.name = NULL,
 	.current_settings = 0,
-	.discovering = false,
+	.cur_discovery_type = 0,
+	.exp_discovery_type = 0,
 	.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT,
 	.uuids = NULL,
 };
@@ -149,6 +153,10 @@ static struct mgmt *mgmt_if = NULL;
 static GSList *bonded_devices = NULL;
 static GSList *cached_devices = NULL;
 
+
+static bt_le_device_found gatt_device_found_cb = NULL;
+static bt_le_discovery_stopped gatt_discovery_stopped_cb = NULL;
+
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
@@ -999,6 +1007,32 @@ static void clear_device_found(gpointer data, gpointer user_data)
 	dev->found = false;
 }
 
+static void mgmt_start_discovery_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_cp_start_discovery *rp = param;
+	uint8_t hal_status;
+	DBG("status 0x%02x", status);
+
+	/* Send HAL rsp only when interleave scan has been performed */
+	if (rp->type == SCAN_TYPE_LE)
+		return;
+
+	if (length < sizeof(*rp)) {
+		error("Wrong size of start scanning return parameters");
+		return;
+	}
+
+
+	if (status == MGMT_STATUS_SUCCESS)
+		hal_status = HAL_STATUS_SUCCESS;
+	else
+		hal_status = HAL_STATUS_FAILED;
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY,
+								hal_status);
+}
+
 static uint8_t get_adapter_discovering_type(void)
 {
 	uint8_t type;
@@ -1023,7 +1057,8 @@ static bool start_discovery(uint8_t type)
 	DBG("type=0x%x", cp.type);
 
 	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
-				sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+				sizeof(cp), &cp, mgmt_start_discovery_complete,
+								NULL, NULL) > 0)
 		return true;
 
 	error("Failed to start discovery");
@@ -1035,6 +1070,7 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_discovering *ev = param;
 	struct hal_ev_discovery_state_changed cp;
+	bool is_discovering = adapter.cur_discovery_type;
 
 	if (length < sizeof(*ev)) {
 		error("Too small discovering event");
@@ -1044,14 +1080,14 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 	DBG("hci%u type %u discovering %u", index, ev->type,
 							ev->discovering);
 
-	if (adapter.discovering == !!ev->discovering)
+	if (is_discovering == !!ev->discovering)
 		return;
 
-	adapter.discovering = !!ev->discovering;
+	adapter.cur_discovery_type = ev->discovering ? ev->type : 0;
 
 	DBG("new discovering state %u", ev->discovering);
 
-	if (adapter.discovering) {
+	if (adapter.cur_discovery_type) {
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
 	} else {
 		g_slist_foreach(bonded_devices, clear_device_found, NULL);
@@ -1061,6 +1097,23 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
+
+	if (gatt_discovery_stopped_cb && !adapter.cur_discovery_type) {
+		/* One shot notification about discovery stopped send to gatt*/
+		gatt_discovery_stopped_cb();
+		gatt_discovery_stopped_cb = NULL;
+		return;
+	}
+
+	/* If discovery is ON or there is no expected next discovery session
+	 * then just return
+	 */
+	if (adapter.cur_discovery_type || !adapter.exp_discovery_type)
+		return;
+
+	start_discovery(adapter.exp_discovery_type);
+	/* Maintain expected discovery type if there is gatt client registered */
+	adapter.exp_discovery_type = gatt_device_found_cb ? SCAN_TYPE_LE : 0;
 }
 
 static void confirm_device_name_cb(uint8_t status, uint16_t length,
@@ -1142,7 +1195,7 @@ static void update_new_device(struct device *dev, int8_t rssi,
 
 	memset(buf, 0, sizeof(buf));
 
-	if (adapter.discovering)
+	if (adapter.cur_discovery_type)
 		dev->found = true;
 
 	size = sizeof(*ev);
@@ -1250,6 +1303,11 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		update_device(dev, rssi, &eir);
 	}
 
+	/* Notify Gatt if its registered for LE events */
+	if (gatt_device_found_cb && (dev->bdaddr_type & BDADDR_LE))
+		gatt_device_found_cb(&dev->bdaddr, dev->bdaddr_type,
+						dev->rssi, sizeof(eir), &eir);
+
 	eir_data_free(&eir);
 
 	if (dev->bond_state != HAL_BOND_STATE_BONDED)
@@ -2510,6 +2568,38 @@ static bool stop_discovery(uint8_t type)
 	return false;
 }
 
+bool bt_le_discovery_stop(bt_le_discovery_stopped cb)
+{
+	if (!adapter.cur_discovery_type) {
+		if (cb)
+			cb();
+		return true;
+	}
+
+	gatt_discovery_stopped_cb = cb;
+	/* Remove device found callback */
+	gatt_device_found_cb = NULL;
+	adapter.exp_discovery_type &= ~SCAN_TYPE_LE;
+
+	return stop_discovery(adapter.cur_discovery_type);
+}
+
+bool bt_le_discovery_start(bt_le_device_found cb)
+{
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED))
+		return false;
+
+	gatt_device_found_cb = cb;
+
+	adapter.exp_discovery_type |= SCAN_TYPE_LE;
+
+	/* If core is discovering, don't bother */
+	if (adapter.cur_discovery_type)
+		return true;
+
+	return start_discovery(adapter.exp_discovery_type);
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
@@ -3179,7 +3269,8 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 {
 	uint8_t status;
 
-	if (adapter.discovering) {
+	/* Check if there is discovery with BREDR type */
+	if (adapter.cur_discovery_type & SCAN_TYPE_BREDR) {
 		status = HAL_STATUS_SUCCESS;
 		goto reply;
 	}
@@ -3189,12 +3280,24 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!start_discovery(SCAN_TYPE_DUAL)) {
+	adapter.exp_discovery_type |= SCAN_TYPE_DUAL;
+
+	/* If there is no discovery ongoing, try to start discovery */
+	if (!adapter.cur_discovery_type &&
+			!start_discovery(adapter.exp_discovery_type)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
 
-	status = HAL_STATUS_SUCCESS;
+	/* Stop discovery here. Once it is stop we will rester it in continue
+	 * and also will reply then
+	 */
+	if (!stop_discovery(adapter.cur_discovery_type)) {
+		status = HAL_STATUS_FAILED;
+		goto reply;
+	}
+
+	return;
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_START_DISCOVERY,
 									status);
@@ -3204,7 +3307,7 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 {
 	uint8_t status;
 
-	if (!adapter.discovering) {
+	if (!adapter.cur_discovery_type) {
 		status = HAL_STATUS_SUCCESS;
 		goto reply;
 	}
@@ -3214,7 +3317,10 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 		goto reply;
 	}
 
-	if (!stop_discovery(SCAN_TYPE_DUAL)) {
+	/* Take into account that gatt might want to keep discover */
+	adapter.exp_discovery_type = gatt_device_found_cb ? SCAN_TYPE_LE : 0;
+
+	if (!stop_discovery(adapter.cur_discovery_type)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
 	}
diff --git a/android/bluetooth.h b/android/bluetooth.h
index f436178..a03305d 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -34,3 +34,10 @@ void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
 void bt_adapter_remove_record(uint32_t handle);
+
+typedef void (*bt_le_device_found)(bdaddr_t *addr, uint8_t addr_type, int rssi,
+					uint16_t eir_len, const void *eir);
+bool bt_le_discovery_start(bt_le_device_found cb);
+
+typedef void (*bt_le_discovery_stopped)(void);
+bool bt_le_discovery_stop(bt_le_discovery_stopped cb);
-- 
1.8.4

