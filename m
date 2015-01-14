Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 3/5] android/tester: Add case for error passing in GATT server responses
Date: Wed, 14 Jan 2015 10:19:39 +0100
Message-Id: <1421227181-1498-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to verify proper error passing from user apps.
---
 android/tester-gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index c98791b..e277f64 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -858,6 +858,13 @@ static struct send_resp_data send_resp_data_2 = {
 	.response = &response_2,
 };
 
+static struct send_resp_data send_resp_data_2_error = {
+	.conn_id = CONN1_ID,
+	.trans_id = TRANS1_ID,
+	.status = GATT_ERR_INVAL_ATTR_VALUE_LEN,
+	.response = &response_2,
+};
+
 #define SEARCH_SERVICE_SINGLE_SUCCESS_PDUS				\
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),		\
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),	\
@@ -3416,6 +3423,53 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Send error resp to write char request",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_set_connect_cb_action, gatt_conn_cb),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_5),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_2),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							&char1_handle),
+		ACTION_SUCCESS(gatt_server_start_srvc_action,
+							&start_srvc_data_2),
+		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+		ACTION_SUCCESS(bt_start_discovery_action, NULL),
+		CALLBACK_STATE(CB_BT_DISCOVERY_STATE_CHANGED,
+							BT_DISCOVERY_STARTED),
+		CALLBACK_DEVICE_FOUND(prop_emu_remotes_default_le_set, 2),
+		ACTION_SUCCESS(bt_cancel_discovery_action, NULL),
+		ACTION_SUCCESS(gatt_server_connect_action, &app1_conn_req),
+		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
+						prop_emu_remotes_default_set,
+						CONN1_ID, APP1_ID),
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+					gatt_remote_send_raw_pdu_action,
+					&att_write_req_op_v, &char1_handle_v,
+					&att_write_req_value_1_v),
+		CALLBACK_GATTS_REQUEST_WRITE(CONN1_ID, TRANS1_ID,
+						prop_emu_remotes_default_set,
+						&char1_handle, 0,
+						sizeof(att_write_req_value_1),
+						true, false,
+						att_write_req_value_1),
+		ACTION_SUCCESS(gatt_server_send_response_action,
+						&send_resp_data_2_error),
+		CALLBACK_ERROR(CB_EMU_ATT_ERROR, GATT_ERR_INVAL_ATTR_VALUE_LEN),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+		),
 	/* This tests embeded ccc */
 	TEST_CASE_BREDRLE("Gatt Server - Srvc change write req. success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.9.1

