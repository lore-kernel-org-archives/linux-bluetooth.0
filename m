Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/7] android/bluetooth: Refactor mgmt_discovering_event
Date: Fri, 18 Apr 2014 15:04:42 +0200
Message-Id: <1397826284-11118-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
References: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This make funtion simpler and fix bogus discovery restart (which
should only happen for LE scanning triggered by GATT HAL).
---
 android/bluetooth.c | 55 +++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 68bfb12..add507a 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1059,56 +1059,49 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 {
 	const struct mgmt_ev_discovering *ev = param;
 	struct hal_ev_discovery_state_changed cp;
-	bool is_discovering = adapter.cur_discovery_type;
+	uint8_t type;
 
 	if (length < sizeof(*ev)) {
 		error("Too small discovering event");
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", index, ev->type,
-							ev->discovering);
+	DBG("type %u discovering %u", ev->type, ev->discovering);
 
-	if (is_discovering == !!ev->discovering)
+	if (!!adapter.cur_discovery_type == !!ev->discovering)
 		return;
 
-	adapter.cur_discovery_type = ev->discovering ?
-						ev->type : SCAN_TYPE_NONE;
-
-	DBG("new discovering state %u", ev->discovering);
-
-	if (adapter.cur_discovery_type != SCAN_TYPE_NONE) {
+	if (ev->discovering) {
+		adapter.cur_discovery_type = ev->type;
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
-	} else {
-		g_slist_foreach(bonded_devices, clear_device_found, NULL);
-		g_slist_foreach(cached_devices, clear_device_found, NULL);
-		cp.state = HAL_DISCOVERY_STATE_STOPPED;
+
+		goto done;
 	}
 
-	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
-			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
+	adapter.cur_discovery_type = SCAN_TYPE_NONE;
+	cp.state = HAL_DISCOVERY_STATE_STOPPED;
+
+	g_slist_foreach(bonded_devices, clear_device_found, NULL);
+	g_slist_foreach(cached_devices, clear_device_found, NULL);
 
-	if (gatt_discovery_stopped_cb &&
-			(adapter.cur_discovery_type == SCAN_TYPE_NONE)) {
-		/* One shot notification about discovery stopped send to gatt*/
+	/* One shot notification about discovery stopped */
+	if (gatt_discovery_stopped_cb) {
 		gatt_discovery_stopped_cb();
 		gatt_discovery_stopped_cb = NULL;
 	}
 
-	/* If discovery is ON or there is no expected next discovery session
-	 * then just return
-	 */
-	if ((adapter.cur_discovery_type != SCAN_TYPE_NONE) ||
-		(adapter.exp_discovery_type == SCAN_TYPE_NONE))
-		return;
+	type = adapter.exp_discovery_type;
+	adapter.exp_discovery_type = SCAN_TYPE_NONE;
 
-	start_discovery(adapter.exp_discovery_type);
+	if (type == SCAN_TYPE_NONE && gatt_device_found_cb)
+		type = SCAN_TYPE_LE;
 
-	/* Maintain expected discovery type if there is gatt client
-	 * registered
-	 */
-	adapter.exp_discovery_type = gatt_device_found_cb ?
-						SCAN_TYPE_LE : SCAN_TYPE_NONE;
+	if (type != SCAN_TYPE_NONE)
+		start_discovery(type);
+
+done:
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_BLUETOOTH,
+			HAL_EV_DISCOVERY_STATE_CHANGED, sizeof(cp), &cp);
 }
 
 static void confirm_device_name_cb(uint8_t status, uint16_t length,
-- 
1.9.1

