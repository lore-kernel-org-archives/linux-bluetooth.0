Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/tester: Make tester debug logs verbose.
Date: Thu, 25 Sep 2014 16:03:12 +0200
Message-Id: <1411653793-5254-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds additional logs to match function. In case if compared values
doesn't match, tester will print those values.
---
 android/tester-main.c | 167 ++++++++++++++++++++++++++++++++++++++++++++------
 android/tester-main.h |   2 +
 2 files changed, 150 insertions(+), 19 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 31b27d4..7901ed0 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -28,6 +28,79 @@ static gint scheduled_cbacks_num;
 #define EMULATOR_SIGNAL_TIMEOUT 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
+static struct {
+	uint16_t cb_num;
+	const char *str;
+} cb_table[] = {
+	DBG_CB(CB_BT_ADAPTER_STATE_CHANGED),
+	DBG_CB(CB_BT_ADAPTER_PROPERTIES),
+	DBG_CB(CB_BT_REMOTE_DEVICE_PROPERTIES),
+	DBG_CB(CB_BT_DEVICE_FOUND),
+	DBG_CB(CB_BT_DISCOVERY_STATE_CHANGED),
+	DBG_CB(CB_BT_PIN_REQUEST),
+	DBG_CB(CB_BT_SSP_REQUEST),
+	DBG_CB(CB_BT_BOND_STATE_CHANGED),
+	DBG_CB(CB_BT_ACL_STATE_CHANGED),
+	DBG_CB(CB_BT_THREAD_EVT),
+	DBG_CB(CB_BT_DUT_MODE_RECV),
+	DBG_CB(CB_BT_LE_TEST_MODE),
+
+	/* Hidhost cb */
+	DBG_CB(CB_HH_CONNECTION_STATE),
+	DBG_CB(CB_HH_HID_INFO),
+	DBG_CB(CB_HH_PROTOCOL_MODE),
+	DBG_CB(CB_HH_IDLE_TIME),
+	DBG_CB(CB_HH_GET_REPORT),
+	DBG_CB(CB_HH_VIRTUAL_UNPLUG),
+
+	/* PAN cb */
+	DBG_CB(CB_PAN_CONTROL_STATE),
+	DBG_CB(CB_PAN_CONNECTION_STATE),
+
+	/* HDP cb */
+	DBG_CB(CB_HDP_APP_REG_STATE),
+	DBG_CB(CB_HDP_CHANNEL_STATE),
+
+	/* A2DP cb */
+	DBG_CB(CB_A2DP_CONN_STATE),
+	DBG_CB(CB_A2DP_AUDIO_STATE),
+
+	/* Gatt client */
+	DBG_CB(CB_GATTC_REGISTER_CLIENT),
+	DBG_CB(CB_GATTC_SCAN_RESULT),
+	DBG_CB(CB_GATTC_OPEN),
+	DBG_CB(CB_GATTC_CLOSE),
+	DBG_CB(CB_GATTC_SEARCH_COMPLETE),
+	DBG_CB(CB_GATTC_SEARCH_RESULT),
+	DBG_CB(CB_GATTC_GET_CHARACTERISTIC),
+	DBG_CB(CB_GATTC_GET_DESCRIPTOR),
+	DBG_CB(CB_GATTC_GET_INCLUDED_SERVICE),
+	DBG_CB(CB_GATTC_REGISTER_FOR_NOTIFICATION),
+	DBG_CB(CB_GATTC_NOTIFY),
+	DBG_CB(CB_GATTC_READ_CHARACTERISTIC),
+	DBG_CB(CB_GATTC_WRITE_CHARACTERISTIC),
+	DBG_CB(CB_GATTC_READ_DESCRIPTOR),
+	DBG_CB(CB_GATTC_WRITE_DESCRIPTOR),
+	DBG_CB(CB_GATTC_EXECUTE_WRITE),
+	DBG_CB(CB_GATTC_READ_REMOTE_RSSI),
+	DBG_CB(CB_GATTC_LISTEN),
+
+	/* Gatt server */
+	DBG_CB(CB_GATTS_REGISTER_SERVER),
+	DBG_CB(CB_GATTS_CONNECTION),
+	DBG_CB(CB_GATTS_SERVICE_ADDED),
+	DBG_CB(CB_GATTS_INCLUDED_SERVICE_ADDED),
+	DBG_CB(CB_GATTS_CHARACTERISTIC_ADDED),
+	DBG_CB(CB_GATTS_DESCRIPTOR_ADDED),
+	DBG_CB(CB_GATTS_SERVICE_STARTED),
+	DBG_CB(CB_GATTS_SERVICE_STOPPED),
+	DBG_CB(CB_GATTS_SERVICE_DELETED),
+	DBG_CB(CB_GATTS_REQUEST_READ),
+	DBG_CB(CB_GATTS_REQUEST_WRITE),
+	DBG_CB(CB_GATTS_REQUEST_EXEC_WRITE),
+	DBG_CB(CB_GATTS_RESPONSE_CONFIRMATION),
+};
+
 static gboolean check_callbacks_called(gpointer user_data)
 {
 	/*
@@ -436,107 +509,160 @@ static bool match_data(struct step *step)
 
 	if (exp->callback || step->callback) {
 		if (exp->callback != step->callback) {
-			tester_debug("Callback type don't match");
+			tester_debug("Callback type don't match - is = %s,"
+				" exp = %s", cb_table[step->callback].str,
+				cb_table[exp->callback].str);
 			return false;
 		}
 
 		if (exp->callback_result.state != step->callback_result.state) {
-			tester_debug("Callback state don't match");
+			tester_debug("Callback state don't match - is = %d,"
+						" exp = %d",
+						step->callback_result.state,
+						exp->callback_result.state);
 			return false;
 		}
 
 		if (exp->callback_result.status !=
 						step->callback_result.status) {
-			tester_debug("Callback status don't match");
+			tester_debug("Callback status don't match - is = %d,"
+						" exp = %d",
+						step->callback_result.status,
+						exp->callback_result.status);
 			return false;
 		}
 
 		if (exp->callback_result.mode != step->callback_result.mode) {
-			tester_debug("Callback mode don't match");
+			tester_debug("Callback mode don't match - is = %02x,"
+						" exp = %02x",
+						step->callback_result.mode,
+						exp->callback_result.mode);
 			return false;
 		}
 
 		if (exp->callback_result.report_size !=
 					step->callback_result.report_size) {
-			tester_debug("Callback report size don't match");
+			tester_debug("Callback report size don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.report_size,
+					exp->callback_result.report_size);
 			return false;
 		}
 
 		if (exp->callback_result.ctrl_state !=
 					step->callback_result.ctrl_state) {
-			tester_debug("Callback ctrl state don't match");
+			tester_debug("Callback ctrl state don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.ctrl_state,
+					exp->callback_result.ctrl_state);
 			return false;
 		}
 
 		if (exp->callback_result.conn_state !=
 					step->callback_result.conn_state) {
-			tester_debug("Callback connection state don't match");
+			tester_debug("Callback connection state don't match"
+					"- is = %d, exp = %d",
+					step->callback_result.conn_state,
+					exp->callback_result.conn_state);
 			return false;
 		}
 
 		if (exp->callback_result.local_role !=
 					step->callback_result.local_role) {
-			tester_debug("Callback local_role don't match");
+			tester_debug("Callback local_role don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.local_role,
+					exp->callback_result.local_role);
 			return false;
 		}
 
 		if (exp->callback_result.remote_role !=
 					step->callback_result.remote_role) {
-			tester_debug("Callback remote_role don't match");
+			tester_debug("Callback remote_role don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.remote_role,
+					exp->callback_result.remote_role);
 			return false;
 		}
 
 		if (exp->callback_result.app_id !=
 						step->callback_result.app_id) {
-			tester_debug("Callback app_id don't match");
+			tester_debug("Callback app_id don't match - is = %d,"
+						" exp = %d",
+						step->callback_result.app_id,
+						exp->callback_result.app_id);
 			return false;
 		}
 
 		if (exp->callback_result.channel_id !=
 					step->callback_result.channel_id) {
-			tester_debug("Callback channel_id don't match");
+			tester_debug("Callback channel_id don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.channel_id,
+					exp->callback_result.channel_id);
 			return false;
 		}
 
 		if (exp->callback_result.mdep_cfg_index !=
 					step->callback_result.mdep_cfg_index) {
-			tester_debug("Callback mdep_cfg_index don't match");
+			tester_debug("Callback mdep_cfg_index don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.mdep_cfg_index,
+					exp->callback_result.mdep_cfg_index);
 			return false;
 		}
 
 		if (exp->callback_result.app_state !=
 					step->callback_result.app_state) {
-			tester_debug("Callback app_state don't match");
+			tester_debug("Callback app_state don't match - is = %d"
+						", exp = %d",
+						step->callback_result.app_state,
+						exp->callback_result.app_state);
 			return false;
 		}
 
 		if (exp->callback_result.channel_state !=
 					step->callback_result.channel_state) {
-			tester_debug("Callback channel_state don't match");
+			tester_debug("Callback channel_state don't match - "
+					"is = %d, ext = %d",
+					step->callback_result.channel_state,
+					exp->callback_result.channel_state);
 			return false;
 		}
 
 		if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
-			tester_debug("Callback pairing result don't match");
+			tester_debug("Callback pairing result don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.pairing_variant,
+					exp->callback_result.pairing_variant);
 			return false;
 		}
 
 		if (exp->callback_result.adv_data !=
 					step->callback_result.adv_data) {
-			tester_debug("Callback adv. data status don't match");
+			tester_debug("Callback adv. data status don't match - "
+						"is = %d, exp = %d",
+						step->callback_result.adv_data,
+						exp->callback_result.adv_data);
 			return false;
 		}
 
 		if (exp->callback_result.conn_id !=
 						step->callback_result.conn_id) {
-			tester_debug("Callback conn_id don't match");
+			tester_debug("Callback conn_id don't match - is = %d,"
+						" exp = %d",
+						step->callback_result.conn_id,
+						exp->callback_result.conn_id);
 			return false;
 		}
 
 		if (exp->callback_result.gatt_app_id !=
 					step->callback_result.gatt_app_id) {
-			tester_debug("Callback gatt_app_id don't match");
+			tester_debug("Callback gatt_app_id don't match - "
+					"is = %d, exp = %d",
+					step->callback_result.gatt_app_id,
+					exp->callback_result.gatt_app_id);
 			return false;
 		}
 
@@ -570,7 +696,10 @@ static bool match_data(struct step *step)
 
 		if (exp->callback_result.char_prop !=
 					step->callback_result.char_prop) {
-			tester_debug("Gatt char prop doesn't match");
+			tester_debug("Gatt char prop doesn't match - is = %d"
+						", exp = %d",
+						step->callback_result.char_prop,
+						exp->callback_result.char_prop);
 			return false;
 		}
 
diff --git a/android/tester-main.h b/android/tester-main.h
index cd4a0d0..6b36a3c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -290,6 +290,8 @@
 		.callback_result.num_properties = prop_cnt, \
 	}
 
+#define DBG_CB(cb) { cb, #cb }
+
 /*
  * NOTICE:
  * Callback enum sections should be
-- 
1.9.3

