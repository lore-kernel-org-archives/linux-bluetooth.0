Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] android/tester: Add GATT server send response to write req test cases
Date: Fri, 17 Oct 2014 15:38:19 +0200
Message-Id: <1413553099-19689-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds send response by server to write request test cases.
---
 android/tester-gatt.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  73 +++++++++++++++++++++++++++-
 android/tester-main.h |  22 +++++++++
 3 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 6655f2d..f99100d 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -27,6 +27,8 @@
 #define L2CAP_ATT_EXCHANGE_MTU_RSP	0x03
 #define L2CAP_ATT_READ_REQ		0x0a
 #define L2CAP_ATT_READ_RSP		0x0b
+#define L2CAP_ATT_WRITE_REQ		0x12
+#define L2CAP_ATT_WRITE_RSP		0x13
 #define L2CAP_ATT_HANDLE_VALUE_NOTIFY	0x1b
 #define L2CAP_ATT_HANDLE_VALUE_IND	0x1d
 
@@ -54,6 +56,24 @@
 #define GATT_WRITE_TYPE_PREPARE		0x03
 #define GATT_WRITE_TYPE_SIGNED		0x04
 
+#define CHAR_PROP_BROADCAST			0x01
+#define CHAR_PROP_READ				0x02
+#define CHAR_PROP_WRITE_WITHOUT_RESPONSE	0x04
+#define CHAR_PROP_WRITE				0x08
+#define CHAR_PROP_NOTIFY			0x10
+#define CHAR_PROP_INDICATE			0x20
+#define CHAR_PROP_AUTHENTICATED_SIGNED_WRITES	0x40
+#define CHAR_PROP_EXTENDED_PROPERTIES		0x80
+
+#define CHAR_PERM_READ			0x0001
+#define CHAR_PERM_READ_ENCRYPTED	0x0002
+#define CHAR_PERM_READ_ENCRYPTED_MITM	0x0004
+#define CHAR_PERM_WRITE			0x0010
+#define CHAR_PERM_WRITE_ENCRYPTED	0x0020
+#define CHAR_PERM_WRITE_ENCRYPTED_MITM	0x0040
+#define CHAR_PERM_WRITE_SIGNED		0x0080
+#define CHAR_PERM_WRITE_SIGNED_MITM	0x0100
+
 static struct queue *list; /* List of gatt test cases */
 
 static int srvc1_handle;
@@ -66,6 +86,11 @@ struct set_att_data {
 	int len;
 };
 
+struct att_write_req_data {
+	int *attr_handle;
+	uint8_t *value;
+};
+
 static bt_uuid_t app1_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
@@ -78,6 +103,8 @@ static bt_uuid_t app2_uuid = {
 
 static uint8_t value_1[] = {0x01};
 
+static uint8_t att_write_req_value_1[] = {0x00, 0x01, 0x02, 0x03};
+
 struct gatt_connect_data {
 	const int app_id;
 	const int conn_id;
@@ -521,6 +548,14 @@ static struct add_char_data add_char_data_1 = {
 	.permissions = 0
 };
 
+static struct add_char_data add_char_data_2 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc1_handle,
+	.uuid = &app1_uuid,
+	.properties = CHAR_PROP_WRITE,
+	.permissions = CHAR_PERM_WRITE
+};
+
 static struct add_char_data add_bad_char_data_1 = {
 	.app_id = APP1_ID,
 	.srvc_handle = &srvc_bad_handle,
@@ -774,6 +809,14 @@ static btgatt_response_t response_1 = {
 	.attr_value.offset = 0,
 };
 
+static btgatt_response_t response_2 = {
+	.handle = 0x1c,
+	.attr_value.auth_req = 0,
+	.attr_value.handle = 0x1d,
+	.attr_value.len = sizeof(att_write_req_value_1),
+	.attr_value.offset = 0,
+};
+
 static struct send_resp_data send_resp_data_1 = {
 	.conn_id = CONN1_ID,
 	.trans_id = TRANS1_ID,
@@ -781,6 +824,13 @@ static struct send_resp_data send_resp_data_1 = {
 	.response = &response_1,
 };
 
+static struct send_resp_data send_resp_data_2 = {
+	.conn_id = CONN1_ID,
+	.trans_id = TRANS1_ID,
+	.status = BT_STATUS_SUCCESS,
+	.response = &response_2,
+};
+
 static struct iovec search_service[] = {
 	raw_pdu(0x10, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28),
 	raw_pdu(0x11, 0x06, 0x01, 0x00, 0x10, 0x00, 0x00, 0x18),
@@ -1091,8 +1141,15 @@ static struct iovec send_notification_1[] = {
 	end_pdu
 };
 
+static struct att_write_req_data att_write_req_data_1  = {
+	.attr_handle = &char1_handle,
+	.value = att_write_req_value_1,
+};
+
 /* att commands define raw pdus */
 static struct iovec att_read_req = raw_pdu(0x0a, 0x00, 0x00);
+static struct iovec att_write_req_1 = raw_pdu(0x12, 0x00, 0x00, 0x00, 0x00,
+								0x00, 0x00);
 
 static void gatt_att_pdu_modify(void)
 {
@@ -1114,7 +1171,21 @@ static void gatt_att_pdu_modify(void)
 		break;
 	}
 
+	case L2CAP_ATT_WRITE_REQ: {
+		struct att_write_req_data *pdu_set_data =
+						current_data_step->set_data;
+		uint16_t handle = *((int *)(pdu_set_data->attr_handle));
+		uint8_t *value = pdu_set_data->value;
+
+		memcpy(raw_pdu + 1, &handle, sizeof(handle));
+		memcpy(raw_pdu + 3, value, set_data_len - sizeof(handle));
+
+		break;
+	}
 	default:
+		tester_debug("modify att pdu with opcode 0x%02x not handled",
+								raw_pdu[0]);
+
 		break;
 	}
 
@@ -1648,6 +1719,14 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 
 		schedule_callback_verification(step);
 		break;
+	case L2CAP_ATT_WRITE_RSP:
+		/* TODO - More complicated cases should also verify pdu data */
+		step = g_new0(struct step, 1);
+
+		step->callback = CB_EMU_WRITE_RESPONSE;
+
+		schedule_callback_verification(step);
+		break;
 	default:
 		if (!gatt_pdu || !gatt_pdu->iov_base) {
 			tester_print("Unknown ATT packet.");
@@ -3400,6 +3479,55 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Send response to write char request",
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
+		MODIFY_DATA(GATT_STATUS_SUCCESS, gatt_att_pdu_modify,
+					&att_write_req_data_1, &att_write_req_1,
+					sizeof(att_write_req_value_1) +
+					ATT_HANDLE_SIZE),
+		ACTION_SUCCESS(gatt_remote_send_raw_pdu_action,
+							&att_write_req_1),
+		CALLBACK_GATTS_REQUEST_WRITE(CONN1_ID, TRANS1_ID,
+						prop_emu_remotes_default_set,
+						&char1_handle, 0,
+						sizeof(att_write_req_value_1),
+						true, false,
+						att_write_req_value_1),
+		ACTION_SUCCESS(gatt_server_send_response_action,
+							&send_resp_data_2),
+		CALLBACK(CB_EMU_WRITE_RESPONSE),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index e9ebfdd..270be18 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -110,6 +110,7 @@ static struct {
 	DBG_CB(CB_EMU_VALUE_INDICATION),
 	DBG_CB(CB_EMU_VALUE_NOTIFICATION),
 	DBG_CB(CB_EMU_READ_RESPONSE),
+	DBG_CB(CB_EMU_WRITE_RESPONSE),
 };
 
 static gboolean check_callbacks_called(gpointer user_data)
@@ -835,6 +836,41 @@ static bool match_data(struct step *step)
 		return false;
 	}
 
+	if (exp->callback_result.length > 0) {
+		if (exp->callback_result.length !=
+						step->callback_result.length) {
+			tester_debug("Gatt attr length mismatch: %d vs %d",
+						exp->callback_result.length,
+						step->callback_result.length);
+			return false;
+		}
+		if (!exp->callback_result.value ||
+						!step->callback_result.value) {
+			tester_debug("Gatt attr values are wrong set");
+			return false;
+		}
+		if (!memcmp(exp->callback_result.value,
+						step->callback_result.value,
+						exp->callback_result.length)) {
+			tester_debug("Gatt attr value mismatch");
+			return false;
+		}
+	}
+
+	if (exp->callback_result.need_rsp != step->callback_result.need_rsp) {
+		tester_debug("Gatt need response value flag mismatch: %d vs %d",
+						exp->callback_result.need_rsp,
+						step->callback_result.need_rsp);
+		return false;
+	}
+
+	if (exp->callback_result.is_prep != step->callback_result.is_prep) {
+		tester_debug("Gatt is prepared value flag mismatch: %d vs %d",
+						exp->callback_result.is_prep,
+						step->callback_result.is_prep);
+		return false;
+	}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
@@ -966,6 +1002,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.attr_handle)
 		free(step->callback_result.attr_handle);
 
+	if (step->callback_result.value)
+		free(step->callback_result.value);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1715,6 +1754,38 @@ static void gatts_request_read_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 	schedule_callback_verification(step);
 }
 
+static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
+						int attr_handle, int offset,
+						int length, bool need_rsp,
+						bool is_prep, uint8_t *value)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[1];
+
+	step->callback = CB_GATTS_REQUEST_WRITE;
+
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.trans_id = trans_id;
+	step->callback_result.attr_handle = g_memdup(&attr_handle,
+							sizeof(attr_handle));
+	step->callback_result.offset = offset;
+	step->callback_result.length = length;
+	step->callback_result.need_rsp = need_rsp;
+	step->callback_result.is_prep = is_prep;
+	step->callback_result.value = g_memdup(&value, length);
+
+	/* Utilize property verification mechanism for bdaddr */
+	props[0] = create_property(BT_PROPERTY_BDADDR, bda, sizeof(*bda));
+
+	step->callback_result.num_properties = 1;
+	step->callback_result.properties = repack_properties(1, props);
+
+	g_free(props[0]->val);
+	g_free(props[0]);
+
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1846,7 +1917,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.service_stopped_cb = gatts_service_stopped_cb,
 	.service_deleted_cb = gatts_service_deleted_cb,
 	.request_read_cb = gatts_request_read_cb,
-	.request_write_cb = NULL,
+	.request_write_cb = gatts_request_write_cb,
 	.request_exec_write_cb = NULL,
 	.response_confirmation_cb = NULL
 };
diff --git a/android/tester-main.h b/android/tester-main.h
index e710a03..c938d44 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -339,6 +339,23 @@ struct pdu_set {
 		.callback_result.is_long = cb_is_long, \
 	}
 
+#define CALLBACK_GATTS_REQUEST_WRITE(cb_conn_id, cb_trans_id, cb_prop, \
+						cb_attr_handle, cb_offset, \
+						cb_length, cb_need_rsp, \
+						cb_is_prep, cb_value) { \
+		.callback = CB_GATTS_REQUEST_WRITE, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.trans_id = cb_trans_id, \
+		.callback_result.properties = cb_prop, \
+		.callback_result.num_properties = 1, \
+		.callback_result.attr_handle = cb_attr_handle, \
+		.callback_result.offset = cb_offset, \
+		.callback_result.length = cb_length, \
+		.callback_result.need_rsp = cb_need_rsp, \
+		.callback_result.is_prep = cb_is_prep, \
+		.callback_result.value = cb_value, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -493,6 +510,7 @@ typedef enum {
 	CB_EMU_VALUE_INDICATION,
 	CB_EMU_VALUE_NOTIFICATION,
 	CB_EMU_READ_RESPONSE,
+	CB_EMU_WRITE_RESPONSE,
 } expected_bt_callback_t;
 
 struct test_data {
@@ -608,6 +626,10 @@ struct bt_callback_data {
 	btgatt_notify_params_t *notify_params;
 	int notification_registered;
 	int char_prop;
+	int length;
+	uint8_t *value;
+	bool need_rsp;
+	bool is_prep;
 
 	btpan_control_state_t ctrl_state;
 	btpan_connection_state_t conn_state;
-- 
1.9.3

