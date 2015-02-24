Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] android/tester-gatt: Add Find by type test
Date: Tue, 24 Feb 2015 15:21:17 +0100
Message-Id: <1424787677-18412-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds test to check if GATT server response on Find By type
request when there is no matching attribute in the range
---
This should be sent together with this set: [PATCH v2 1/3] android/gatt: Fix, add return check for queue push

 android/tester-gatt.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 1c0397e..eb0ca1e 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -29,6 +29,7 @@
 #define L2CAP_ATT_ERROR			0x01
 #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
+#define L2CAP_ATT_FIND_BY_TYPE_REQ	0x06
 #define L2CAP_ATT_READ_REQ		0x0a
 #define L2CAP_ATT_READ_RSP		0x0b
 #define L2CAP_ATT_WRITE_REQ		0x12
@@ -1090,9 +1091,18 @@ static struct iovec send_notification_1[] = {
 	end_pdu
 };
 
+static struct iovec search_range_1[] = {
+	raw_pdu(0x01, 0xff, 0xff, 0xff),
+	end_pdu
+};
+
+static struct iovec primary_type = raw_pdu(0x00, 0x28);
+
 /* att commands define raw pdus */
 static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
 static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
+static struct iovec att_find_by_type_req_op_v =
+					raw_pdu(L2CAP_ATT_FIND_BY_TYPE_REQ);
 
 static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1c, 0x00);
 static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
@@ -3400,6 +3410,46 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Find By Type - Attribute not found",
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
+						gatt_remote_send_raw_pdu_action,
+						&att_find_by_type_req_op_v,
+						&search_range_1,
+						&primary_type),
+		CALLBACK_ERROR(CB_EMU_ATT_ERROR, 0x0a),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 	/* This tests embeded ccc */
 	TEST_CASE_BREDRLE("Gatt Server - Srvc change write req. success",
 		ACTION_SUCCESS(bluetooth_enable_action, NULL),
-- 
1.8.4

