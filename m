Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/bluetooth: Add GATT notifications on LE discovery
Date: Wed, 12 Mar 2014 15:43:53 +0100
Message-Id: <1394635435-26646-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows GATT to be notified about scan events.
---
 android/bluetooth.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 android/bluetooth.h |  8 ++++++++
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e614883..5430c8a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -121,6 +121,7 @@ static struct {
 	uint32_t current_settings;
 
 	bool discovering;
+	bool le_discovering;
 	uint32_t discoverable_timeout;
 
 	GSList *uuids;
@@ -130,6 +131,7 @@ static struct {
 	.name = NULL,
 	.current_settings = 0,
 	.discovering = false,
+	.le_discovering = false,
 	.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT,
 	.uuids = NULL,
 };
@@ -147,6 +149,9 @@ static struct mgmt *mgmt_if = NULL;
 static GSList *bonded_devices = NULL;
 static GSList *cached_devices = NULL;
 
+bt_le_device_found_cb_t le_device_found_cb = NULL;
+bt_le_discovering_state_cb_t le_discovering_cb = NULL;
+
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
@@ -999,6 +1004,8 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_discovering *ev = param;
 	struct hal_ev_discovery_state_changed cp;
+	bool notify = false;
+	bool notify_le = false;
 
 	if (length < sizeof(*ev)) {
 		error("Too small discovering event");
@@ -1008,10 +1015,20 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 	DBG("hci%u type %u discovering %u", index, ev->type,
 							ev->discovering);
 
-	if (adapter.discovering == !!ev->discovering)
-		return;
+	if ((ev->type & SCAN_TYPE_BREDR) &&
+				(adapter.discovering != !!ev->discovering)) {
+		adapter.discovering = !!ev->discovering;
+		notify = true;
+	}
+
+	if ((ev->type & SCAN_TYPE_LE) &&
+				(adapter.le_discovering != !!ev->discovering)) {
+		adapter.le_discovering = !!ev->discovering;
+		notify_le = true;
+	}
 
-	adapter.discovering = !!ev->discovering;
+	if (!(notify || notify_le))
+		return;
 
 	DBG("new discovering state %u", ev->discovering);
 
@@ -1023,8 +1040,13 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		cp.state = HAL_DISCOVERY_STATE_STOPPED;
 	}
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
+	if (notify)
+		ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp),
+				&cp);
+
+	if (notify_le && le_discovering_cb)
+		le_discovering_cb(adapter.le_discovering);
 }
 
 static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type,
@@ -1121,6 +1143,12 @@ static void update_new_device(struct device *dev, int8_t rssi,
 
 	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_EV_DEVICE_FOUND,
 								size, buf);
+
+	/* Notify Gatt if its registered for LE events */
+	if (le_device_found_cb && adapter.le_discovering)
+		if (dev->bdaddr_type & (BDADDR_LE_PUBLIC | BDADDR_LE_RANDOM))
+			le_device_found_cb(&dev->bdaddr, dev->bdaddr_type,
+						dev->rssi, sizeof(*eir), eir);
 }
 
 static void update_device(struct device *dev, int8_t rssi,
@@ -2468,6 +2496,16 @@ static bool stop_discovery(uint8_t type)
 	return false;
 }
 
+void bt_set_le_device_found_cb(bt_le_device_found_cb_t cb)
+{
+	le_device_found_cb = cb;
+}
+
+void bt_set_le_discovering_cb(bt_le_discovering_state_cb_t cb)
+{
+	le_discovering_cb = cb;
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index f436178..127b9db 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -34,3 +34,11 @@ void bt_bluetooth_unregister(void);
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
 void bt_adapter_remove_record(uint32_t handle);
+
+typedef void (*bt_le_device_found_cb_t)(bdaddr_t *addr, uint8_t addr_type,
+							int rssi, uint16_t len,
+							const void *data);
+void bt_set_le_device_found_cb(bt_le_device_found_cb_t cb);
+
+typedef void (*bt_le_discovering_state_cb_t)(uint8_t state);
+void bt_set_le_discovering_cb(bt_le_discovering_state_cb_t cb);
-- 
1.9.0

