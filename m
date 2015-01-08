Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/11] android/tester: Add GATT case for Svc. change invalid offset write
Date: Thu,  8 Jan 2015 10:17:48 +0100
Message-Id: <1420708669-32600-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is to check whether we allow only values with proper length to be
written to Service Change CCC descriptor.
---
 android/tester-gatt.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 6226018..5c5c8d1 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -44,6 +44,7 @@
 #define GATT_STATUS_FAILURE	0x00000101
 #define GATT_STATUS_INS_AUTH	0x08
 
+#define GATT_ERR_INVAL_OFFSET		0x07
 #define GATT_ERR_INVAL_ATTR_VALUE_LEN	0x0D
 
 #define GATT_SERVER_DISCONNECTED	0
@@ -1107,6 +1108,8 @@ static struct iovec svc_change_ccc_prep_value_v = raw_pdu(0x00, 0x00,
 								0x00, 0x01);
 static struct iovec svc_change_ccc_prep_value_inv_v = raw_pdu(0x00, 0x00, 0x00,
 								0x00, 0x01);
+static struct iovec svc_change_ccc_prep_offset_inv_v = raw_pdu(0xff, 0xff,
+								0x00, 0x01);
 static struct iovec att_prep_write_exec_v = raw_pdu(0x01);
 
 static void gatt_client_register_action(void)
@@ -3573,6 +3576,38 @@ TEST_CASE_BREDRLE("Gatt Server - Srvc change prep/exec write inv. len.",
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+TEST_CASE_BREDRLE("Gatt Server - Srvc change prep/exec write inv. off.",
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
+					&svc_change_ccc_prep_offset_inv_v),
+		CALLBACK_ERROR(CB_EMU_ATT_ERROR, GATT_ERR_INVAL_OFFSET),
+		/* Shutdown */
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
-- 
1.9.1

