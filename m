Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 7/8] android/bluetooth: Fix sending discovery state changed events
Date: Sun, 27 Apr 2014 16:54:57 +0200
Message-Id: <1398610498-1112-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
References: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those events should be send only if discovery was started/stoped from
bluetooth HAL.
---
 android/bluetooth.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index e60b6ff..d6bc013 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1057,11 +1057,36 @@ static bool start_discovery(uint8_t type)
 	return false;
 }
 
+/* send discovery state change event only if it is related to dual type
+ * discovery session (triggered by start/cancel discovery commands)
+ */
+static void check_discovery_state(uint8_t new_type, uint8_t old_type)
+{
+	struct hal_ev_discovery_state_changed ev;
+
+	DBG("%u %u", new_type, old_type);
+
+	if (new_type == get_adapter_discovering_type()) {
+		g_slist_foreach(bonded_devices, clear_device_found, NULL);
+		g_slist_foreach(cached_devices, clear_device_found, NULL);
+		ev.state = HAL_DISCOVERY_STATE_STARTED;
+		goto done;
+	}
+
+	if (old_type != get_adapter_discovering_type())
+		return;
+
+	ev.state = HAL_DISCOVERY_STATE_STOPPED;
+
+done:
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(ev), &ev);
+}
+
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_ev_discovering *ev = param;
-	struct hal_ev_discovery_state_changed cp;
 	uint8_t type;
 
 	if (length < sizeof(*ev)) {
@@ -1074,18 +1099,14 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 	if (!!adapter.cur_discovery_type == !!ev->discovering)
 		return;
 
-	if (ev->discovering) {
-		adapter.cur_discovery_type = ev->type;
-		cp.state = HAL_DISCOVERY_STATE_STARTED;
+	type = ev->discovering ? ev->type : SCAN_TYPE_NONE;
 
-		goto done;
-	}
+	check_discovery_state(type, adapter.cur_discovery_type);
 
-	adapter.cur_discovery_type = SCAN_TYPE_NONE;
-	cp.state = HAL_DISCOVERY_STATE_STOPPED;
+	adapter.cur_discovery_type = type;
 
-	g_slist_foreach(bonded_devices, clear_device_found, NULL);
-	g_slist_foreach(cached_devices, clear_device_found, NULL);
+	if (ev->discovering)
+		return;
 
 	/* One shot notification about discovery stopped */
 	if (gatt_discovery_stopped_cb) {
@@ -1101,10 +1122,6 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	if (type != SCAN_TYPE_NONE)
 		start_discovery(type);
-
-done:
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
 static void confirm_device_name_cb(uint8_t status, uint16_t length,
-- 
1.9.1

