Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/11] android/tester: Use multiple iovecs instead of one large buffer
Date: Thu,  8 Jan 2015 10:17:42 +0100
Message-Id: <1420708669-32600-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1420708669-32600-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This simplifies sending pdus which are made of header ond few other parts
by using multiple iovectors instead of copying buffers and aggregating
data in some additional structures.
---
 android/tester-gatt.c | 80 ++++++++++++---------------------------------------
 1 file changed, 18 insertions(+), 62 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index a8dbd35..644e204 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -85,6 +85,11 @@ static uint16_t srvc1_handle;
 static uint16_t inc_srvc1_handle;
 static uint16_t char1_handle;
 
+static struct iovec char1_handle_v = {
+	.iov_base = &char1_handle,
+	.iov_len = sizeof(char1_handle),
+};
+
 struct set_att_data {
 	char *to;
 	char *from;
@@ -109,6 +114,10 @@ static bt_uuid_t app2_uuid = {
 static uint8_t value_1[] = {0x01};
 
 static uint8_t att_write_req_value_1[] = {0x00, 0x01, 0x02, 0x03};
+static struct iovec att_write_req_value_1_v = {
+	.iov_base = att_write_req_value_1,
+	.iov_len = sizeof(att_write_req_value_1),
+};
 
 struct gatt_connect_data {
 	const int app_id;
@@ -1065,59 +1074,9 @@ static struct iovec send_notification_1[] = {
 	end_pdu
 };
 
-static struct att_write_req_data att_write_req_data_1  = {
-	.attr_handle = &char1_handle,
-	.value = att_write_req_value_1,
-};
-
 /* att commands define raw pdus */
-static struct iovec att_read_req = raw_pdu(0x0a, 0x00, 0x00);
-static struct iovec att_write_req_1 = raw_pdu(0x12, 0x00, 0x00, 0x00, 0x00,
-								0x00, 0x00);
-
-static void gatt_att_pdu_modify(void)
-{
-	struct test_data *data = tester_get_data();
-	struct step *current_data_step = queue_peek_head(data->steps);
-	struct iovec *store_pdu = current_data_step->set_data_2;
-	struct step *step = g_new0(struct step, 1);
-	unsigned char *raw_pdu = store_pdu->iov_base;
-	int set_data_len = current_data_step->set_data_len;
-
-	switch (raw_pdu[0]) {
-	case L2CAP_ATT_READ_REQ: {
-		uint16_t handle = *((int *)current_data_step->set_data);
-
-		memcpy(raw_pdu + 1, &handle, set_data_len);
-		tester_debug("gatt: modify pdu read request handle to 0x%02x",
-									handle);
-
-		break;
-	}
-
-	case L2CAP_ATT_WRITE_REQ: {
-		struct att_write_req_data *pdu_set_data =
-						current_data_step->set_data;
-		uint16_t handle = *((int *)(pdu_set_data->attr_handle));
-		uint8_t *value = pdu_set_data->value;
-
-		memcpy(raw_pdu + 1, &handle, sizeof(handle));
-		memcpy(raw_pdu + 3, value, set_data_len - sizeof(handle));
-
-		tester_debug("gatt: modify pdu write request handle to 0x%02x",
-									handle);
-
-		break;
-	}
-	default:
-		tester_debug("modify att pdu with opcode 0x%02x not handled",
-								raw_pdu[0]);
-
-		break;
-	}
-
-	schedule_action_verification(step);
-}
+static struct iovec att_read_req_op_v = raw_pdu(L2CAP_ATT_READ_REQ);
+static struct iovec att_write_req_op_v = raw_pdu(L2CAP_ATT_WRITE_REQ);
 
 static void gatt_client_register_action(void)
 {
@@ -3352,10 +3311,9 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
 						prop_emu_remotes_default_set,
 						CONN1_ID, APP1_ID),
-		MODIFY_DATA(GATT_STATUS_SUCCESS, gatt_att_pdu_modify,
-						&char1_handle, &att_read_req,
-						ATT_HANDLE_SIZE),
-		ACTION_SUCCESS(gatt_remote_send_raw_pdu_action, &att_read_req),
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+				gatt_remote_send_raw_pdu_action,
+				&att_read_req_op_v, &char1_handle_v, NULL),
 		CALLBACK_GATTS_REQUEST_READ(CONN1_ID, TRANS1_ID,
 						prop_emu_remotes_default_set,
 						&char1_handle, 0, false),
@@ -3396,12 +3354,10 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_CONNECTION(GATT_SERVER_CONNECTED,
 						prop_emu_remotes_default_set,
 						CONN1_ID, APP1_ID),
-		MODIFY_DATA(GATT_STATUS_SUCCESS, gatt_att_pdu_modify,
-					&att_write_req_data_1, &att_write_req_1,
-					sizeof(att_write_req_value_1) +
-					ATT_HANDLE_SIZE),
-		ACTION_SUCCESS(gatt_remote_send_raw_pdu_action,
-							&att_write_req_1),
+		PROCESS_DATA(GATT_STATUS_SUCCESS,
+					gatt_remote_send_raw_pdu_action,
+					&att_write_req_op_v, &char1_handle_v,
+					&att_write_req_value_1_v),
 		CALLBACK_GATTS_REQUEST_WRITE(CONN1_ID, TRANS1_ID,
 						prop_emu_remotes_default_set,
 						&char1_handle, 0,
-- 
1.9.1

