Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] android/tester: Add GATT server send indication test cases
Date: Fri, 17 Oct 2014 15:38:17 +0200
Message-Id: <1413553099-19689-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds send indication by server test cases.
---
 android/tester-gatt.c | 160 +++++++++++++++++++++++++++++++++++++++++++++++++-
 android/tester-main.c |   2 +
 android/tester-main.h |   2 +
 3 files changed, 162 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index c0065a7..2ceb295 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -23,6 +23,8 @@
 
 #define L2CAP_ATT_EXCHANGE_MTU_REQ	0x02
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
+#define L2CAP_ATT_HANDLE_VALUE_NOTIFY	0x1b
+#define L2CAP_ATT_HANDLE_VALUE_IND	0x1d
 
 #define GATT_STATUS_SUCCESS	0x00000000
 #define GATT_STATUS_FAILURE	0x00000101
@@ -61,6 +63,8 @@ static bt_uuid_t app2_uuid = {
 				0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02 },
 };
 
+static uint8_t value_1[] = {0x01};
+
 struct gatt_connect_data {
 	const int app_id;
 	const int conn_id;
@@ -174,6 +178,15 @@ struct delete_srvc_data {
 	int *srvc_handle;
 };
 
+struct send_indication_data {
+	int app_id;
+	int *attr_handle;
+	int conn_id;
+	int len;
+	int confirm;
+	char *p_value;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -560,6 +573,36 @@ static struct delete_srvc_data delete_bad_srvc_data_1 = {
 	.app_id = APP1_ID,
 	.srvc_handle = &srvc_bad_handle
 };
+
+static int srvc_indication_handle_1 = 0x01;
+
+static struct send_indication_data send_indication_data_1 = {
+	.app_id = APP1_ID,
+	.attr_handle = &srvc_indication_handle_1,
+	.conn_id = CONN1_ID,
+	.len = sizeof(value_2),
+	.p_value = value_2,
+	.confirm = 1
+};
+
+static struct send_indication_data send_indication_data_2 = {
+	.app_id = APP1_ID,
+	.attr_handle = &srvc_indication_handle_1,
+	.conn_id = CONN1_ID,
+	.len = sizeof(value_2),
+	.p_value = value_2,
+	.confirm = 0
+};
+
+static struct send_indication_data send_bad_indication_data_1 = {
+	.app_id = APP1_ID,
+	.attr_handle = &srvc_indication_handle_1,
+	.conn_id = CONN2_ID,
+	.len = sizeof(value_2),
+	.p_value = value_2,
+	.confirm = 0
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -589,8 +632,6 @@ struct set_notify_params {
 	bt_bdaddr_t *bdaddr;
 };
 
-static uint8_t value_1[] = {0x01};
-
 static struct set_read_params set_read_param_1 = {
 	.params = &read_params_1,
 	.srvc_id = &service_1,
@@ -1004,6 +1045,17 @@ static struct iovec notification_3[] = {
 	end_pdu
 };
 
+static struct iovec send_indication_1[] = {
+	raw_pdu(0x1d, 0x01, 0x00, 0x00, 0x01, 0x02, 0x03),
+	raw_pdu(0x1e),
+	end_pdu
+};
+
+static struct iovec send_notification_1[] = {
+	raw_pdu(0x1b, 0x01, 0x00, 0x00, 0x01, 0x02, 0x03),
+	end_pdu
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -1449,6 +1501,25 @@ static void gatt_server_delete_srvc_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_send_indication_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct send_indication_data *send_indication_data =
+						current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->send_indication(
+					send_indication_data->app_id,
+					*send_indication_data->attr_handle,
+					send_indication_data->conn_id,
+					send_indication_data->len,
+					send_indication_data->confirm,
+					send_indication_data->p_value);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -1456,6 +1527,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 	struct emu_l2cap_cid_data *cid_data = user_data;
 	const uint8_t *pdu = data;
 	struct iovec *gatt_pdu = queue_peek_head(t_data->pdus);
+	struct step *step;
 
 	tester_debug("Received att pdu with opcode 0x%02x", pdu[0]);
 
@@ -1473,6 +1545,20 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 		tester_print("Exchange MTU response received.");
 
 		break;
+	case L2CAP_ATT_HANDLE_VALUE_IND:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_VALUE_INDICATION;
+
+		schedule_callback_verification(step);
+		break;
+	case L2CAP_ATT_HANDLE_VALUE_NOTIFY:
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_VALUE_NOTIFICATION;
+
+		schedule_callback_verification(step);
+		break;
 	default:
 		if (!gatt_pdu || !gatt_pdu->iov_base) {
 			tester_print("Unknown ATT packet.");
@@ -3091,6 +3177,76 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_SERVICE_DELETED(GATT_STATUS_FAILURE, APP1_ID,
 									NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Send Indication",
+		ACTION_SUCCESS(init_pdus, send_indication_1),
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
+		ACTION_SUCCESS(gatt_server_send_indication_action,
+						&send_indication_data_1),
+		CALLBACK(CB_EMU_VALUE_INDICATION),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Send Notification",
+		ACTION_SUCCESS(init_pdus, send_notification_1),
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
+		ACTION_SUCCESS(gatt_server_send_indication_action,
+						&send_indication_data_2),
+		CALLBACK(CB_EMU_VALUE_NOTIFICATION),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Send Notification, wrong conn id",
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
+		ACTION_FAIL(gatt_server_send_indication_action,
+						&send_bad_indication_data_1),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index a804f11..1018cae 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -107,6 +107,8 @@ static struct {
 	DBG_CB(CB_EMU_ENCRYPTION_ENABLED),
 	DBG_CB(CB_EMU_ENCRYPTION_DISABLED),
 	DBG_CB(CB_EMU_CONNECTION_REJECTED),
+	DBG_CB(CB_EMU_VALUE_INDICATION),
+	DBG_CB(CB_EMU_VALUE_NOTIFICATION),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
diff --git a/android/tester-main.h b/android/tester-main.h
index 22c5c8b..31d271a 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -469,6 +469,8 @@ typedef enum {
 	CB_EMU_ENCRYPTION_ENABLED,
 	CB_EMU_ENCRYPTION_DISABLED,
 	CB_EMU_CONNECTION_REJECTED,
+	CB_EMU_VALUE_INDICATION,
+	CB_EMU_VALUE_NOTIFICATION,
 } expected_bt_callback_t;
 
 struct test_data {
-- 
1.9.3

