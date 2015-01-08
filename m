Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 05/11] android/tester: Add case for GATT embeded attributes writes
Date: Thu,  8 Jan 2015 10:17:43 +0100
Message-Id: <1420708669-32600-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This tests if Service Changed CCC descriptor write request is properly
handled.
---
 android/tester-gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 644e204..23c6609 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -264,6 +264,12 @@ static bt_property_t prop_emu_remotes_default_le_set[] = {
 						&emu_remote_ble_device_type },
 };
 
+static struct bt_action_data prop_test_remote_ble_bdaddr_req = {
+	.addr = &emu_remote_bdaddr_val,
+	.prop_type = BT_PROPERTY_BDADDR,
+	.prop = &prop_emu_remotes_default_set[0],
+};
+
 static bt_scan_mode_t setprop_scan_mode_conn_val =
 					BT_SCAN_MODE_CONNECTABLE_DISCOVERABLE;
 
@@ -1078,6 +1084,9 @@ static struct iovec send_notification_1[] = {
 static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
 static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
 
+static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1a, 0x00);
+static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -3370,6 +3379,39 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	/* This tests embeded ccc */
+	TEST_CASE_BREDRLE("Gatt Server - Srvc change write req. success",
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
+		/* Write and receive confirmation */
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+				gatt_remote_send_raw_pdu_action,
+				&att_write_req_op_v, &svc_change_ccc_handle_v,
+				&svc_change_ccc_value_v),
+		CALLBACK(CB_EMU_WRITE_RESPONSE),
+		/* Shutdown */
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.1

