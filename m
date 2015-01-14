Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/5] android/tester: Add GATT Server test for invalid value length for ccc
Date: Wed, 14 Jan 2015 10:19:38 +0100
Message-Id: <1421227181-1498-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to verify that we check for the length of value that is to be
written to Service Change CCC descriptor.
---
 android/tester-gatt.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  8 ++++++++
 android/tester-main.h |  7 +++++++
 3 files changed, 60 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 7cb6629..c98791b 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -26,6 +26,7 @@
 
 #define ATT_HANDLE_SIZE	2
 
+#define L2CAP_ATT_ERROR			0x01
 #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
 #define L2CAP_ATT_READ_REQ		0x0a
@@ -43,6 +44,8 @@
 #define GATT_STATUS_FAILURE	0x00000101
 #define GATT_STATUS_INS_AUTH	0x08
 
+#define GATT_ERR_INVAL_ATTR_VALUE_LEN	0x0D
+
 #define GATT_SERVER_DISCONNECTED	0
 #define GATT_SERVER_CONNECTED		1
 
@@ -1095,6 +1098,8 @@ static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
 
 static struct iovec svc_change_ccc_prep_value_v = raw_pdu(0x00, 0x00,
 								0x00, 0x01);
+static struct iovec svc_change_ccc_prep_value_inv_v = raw_pdu(0x00, 0x00, 0x00,
+								0x00, 0x01);
 static struct iovec att_prep_write_exec_v = raw_pdu(0x01);
 
 static void gatt_client_register_action(void)
@@ -1585,6 +1590,14 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	tester_debug("Received att pdu with opcode 0x%02x", pdu[0]);
 
 	switch (pdu[0]) {
+	case L2CAP_ATT_ERROR:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_ATT_ERROR;
+		step->callback_result.error = pdu[4];
+
+		schedule_callback_verification(step);
+		break;
 	case L2CAP_ATT_EXCHANGE_MTU_REQ:
 		tester_print("Exchange MTU request received.");
 
@@ -3474,6 +3487,38 @@ TEST_CASE_BREDRLE("Gatt Server - Srvc change prep/exec write success",
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+TEST_CASE_BREDRLE("Gatt Server - Srvc change prep/exec write inv. len.",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		/* For CCC we need to be bonded */
+		ACTION_SUCCESS(bt_create_bond_action,
+					&prop_test_remote_ble_bdaddr_req),
+		CALLBACK_BOND_STATE(BT_BOND_STATE_BONDED,
+					&prop_emu_remotes_default_set[0], 1),
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+					gatt_remote_send_raw_pdu_action,
+					&att_prep_write_req_op_v,
+					&svc_change_ccc_handle_v,
+					&svc_change_ccc_prep_value_inv_v),
+		CALLBACK_ERROR(CB_EMU_ATT_ERROR, GATT_ERR_INVAL_ATTR_VALUE_LEN),
+		/* Shutdown */
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 1d61cfb..2cc0c18 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -126,6 +126,7 @@ static struct {
 	DBG_CB(CB_MAP_CLIENT_REMOTE_MAS_INSTANCES),
 
 	/* Emulator callbacks */
+	DBG_CB(CB_EMU_ATT_ERROR),
 	DBG_CB(CB_EMU_CONFIRM_SEND_DATA),
 	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
 	DBG_CB(CB_EMU_ENCRYPTION_DISABLED),
@@ -1038,6 +1039,13 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.error != step->callback_result.error) {
+		tester_debug("Err mismatch: %d vs %d",
+				exp->callback_result.error,
+				step->callback_result.error);
+		return false;
+	}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
diff --git a/android/tester-main.h b/android/tester-main.h
index ec9a20f..c266359 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -106,6 +106,11 @@ struct pdu_set {
 		.callback_result.status = cb_res, \
 	}
 
+#define CALLBACK_ERROR(cb, cb_err) { \
+		.callback = cb, \
+		.callback_result.error = cb_err, \
+	}
+
 #define CALLBACK_ADAPTER_PROPS(props, prop_cnt) { \
 		.callback = CB_BT_ADAPTER_PROPERTIES, \
 		.callback_result.properties = props, \
@@ -540,6 +545,7 @@ typedef enum {
 	CB_MAP_CLIENT_REMOTE_MAS_INSTANCES,
 
 	/* Emulator callbacks */
+	CB_EMU_ATT_ERROR,
 	CB_EMU_CONFIRM_SEND_DATA,
 	CB_EMU_ENCRYPTION_ENABLED,
 	CB_EMU_ENCRYPTION_DISABLED,
@@ -679,6 +685,7 @@ struct bt_callback_data {
 	uint8_t *value;
 	bool need_rsp;
 	bool is_prep;
+	uint8_t error;
 
 	btpan_control_state_t ctrl_state;
 	btpan_connection_state_t conn_state;
-- 
1.9.1

