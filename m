Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 1/5] android/tester: Add case for GATT prep. and exec. write on ccc descr.
Date: Wed, 14 Jan 2015 10:19:37 +0100
Message-Id: <1421227181-1498-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1421227181-1498-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should support prepare and execute write also on Service Changed
characteristic.
---
 android/tester-gatt.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  2 ++
 android/tester-main.h |  2 ++
 3 files changed, 66 insertions(+)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 23c6609..7cb6629 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -34,6 +34,10 @@
 #define L2CAP_ATT_WRITE_RSP		0x13
 #define L2CAP_ATT_HANDLE_VALUE_NOTIFY	0x1b
 #define L2CAP_ATT_HANDLE_VALUE_IND	0x1d
+#define L2CAP_ATT_PREP_WRITE_REQ	0x16
+#define L2CAP_ATT_PREP_WRITE_RSP	0x17
+#define L2CAP_ATT_EXEC_WRITE_REQ	0x18
+#define L2CAP_ATT_EXEC_WRITE_RSP	0x19
 
 #define GATT_STATUS_SUCCESS	0x00000000
 #define GATT_STATUS_FAILURE	0x00000101
@@ -1083,10 +1087,16 @@ static struct iovec send_notification_1[] = {
 /* att commands define raw pdus */
 static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
 static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
+static struct iovec att_prep_write_req_op_v = raw_pdu(L2CAP_ATT_PREP_WRITE_REQ);
+static struct iovec att_exec_write_req_op_v = raw_pdu(L2CAP_ATT_EXEC_WRITE_REQ);
 
 static struct iovec svc_change_ccc_handle_v = raw_pdu(0x1a, 0x00);
 static struct iovec svc_change_ccc_value_v = raw_pdu(0x00, 0x01);
 
+static struct iovec svc_change_ccc_prep_value_v = raw_pdu(0x00, 0x00,
+								0x00, 0x01);
+static struct iovec att_prep_write_exec_v = raw_pdu(0x01);
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1618,6 +1628,20 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 		schedule_callback_verification(step);
 		break;
+	case L2CAP_ATT_PREP_WRITE_RSP:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_PREP_WRITE_RESPONSE;
+
+		schedule_callback_verification(step);
+		break;
+	case L2CAP_ATT_EXEC_WRITE_RSP:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_EXEC_WRITE_RESPONSE;
+
+		schedule_callback_verification(step);
+		break;
 	default:
 		if (!gatt_pdu || !gatt_pdu->iov_base) {
 			tester_print("Unknown ATT packet.");
@@ -3412,6 +3436,44 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+TEST_CASE_BREDRLE("Gatt Server - Srvc change prep/exec write success",
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
+						gatt_remote_send_raw_pdu_action,
+						&att_prep_write_req_op_v,
+						&svc_change_ccc_handle_v,
+						&svc_change_ccc_prep_value_v),
+		CALLBACK(CB_EMU_PREP_WRITE_RESPONSE),
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+						gatt_remote_send_raw_pdu_action,
+						&att_exec_write_req_op_v,
+						&att_prep_write_exec_v, NULL),
+		CALLBACK(CB_EMU_EXEC_WRITE_RESPONSE),
+		/* Shutdown */
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 336a9a8..1d61cfb 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -134,6 +134,8 @@ static struct {
 	DBG_CB(CB_EMU_VALUE_NOTIFICATION),
 	DBG_CB(CB_EMU_READ_RESPONSE),
 	DBG_CB(CB_EMU_WRITE_RESPONSE),
+	DBG_CB(CB_EMU_PREP_WRITE_RESPONSE),
+	DBG_CB(CB_EMU_EXEC_WRITE_RESPONSE),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
diff --git a/android/tester-main.h b/android/tester-main.h
index e35feec..ec9a20f 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -548,6 +548,8 @@ typedef enum {
 	CB_EMU_VALUE_NOTIFICATION,
 	CB_EMU_READ_RESPONSE,
 	CB_EMU_WRITE_RESPONSE,
+	CB_EMU_PREP_WRITE_RESPONSE,
+	CB_EMU_EXEC_WRITE_RESPONSE,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.1

