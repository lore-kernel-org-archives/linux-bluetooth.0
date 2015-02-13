Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/2] android/tester: Add test for GATT server app indication confirmation
Date: Fri, 13 Feb 2015 14:17:40 +0100
Message-Id: <1423833460-19400-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1423833460-19400-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1423833460-19400-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds checking if sent indication or notification has been confirmed
over HAL.
---
 android/tester-gatt.c |  5 ++++-
 android/tester-main.c | 17 ++++++++++++++++-
 android/tester-main.h |  7 +++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 38dfe42..1c0397e 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1612,7 +1612,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 		step->callback = CB_EMU_VALUE_INDICATION;
 
 		schedule_callback_verification(step);
-		break;
+		goto respond;
 	case L2CAP_ATT_HANDLE_VALUE_NOTIFY:
 		step = g_new0(struct step, 1);
 
@@ -1649,6 +1649,7 @@ static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 			break;
 		}
 
+respond:
 		if (memcmp(gatt_pdu->iov_base, data, len)) {
 			tester_print("Incoming data mismatch");
 			break;
@@ -3258,6 +3259,7 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(gatt_server_send_indication_action,
 						&send_indication_data_1),
 		CALLBACK(CB_EMU_VALUE_INDICATION),
+		CALLBACK_GATTS_NOTIF_CONF(CONN1_ID, GATT_STATUS_SUCCESS),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
@@ -3281,6 +3283,7 @@ static struct test_case test_cases[] = {
 						CONN1_ID, APP1_ID),
 		ACTION_SUCCESS(gatt_server_send_indication_action,
 						&send_indication_data_2),
+		CALLBACK_GATTS_NOTIF_CONF(CONN1_ID, GATT_STATUS_SUCCESS),
 		CALLBACK(CB_EMU_VALUE_NOTIFICATION),
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
diff --git a/android/tester-main.c b/android/tester-main.c
index c13f056..2506548 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -121,6 +121,7 @@ static struct {
 	DBG_CB(CB_GATTS_REQUEST_WRITE),
 	DBG_CB(CB_GATTS_REQUEST_EXEC_WRITE),
 	DBG_CB(CB_GATTS_RESPONSE_CONFIRMATION),
+	DBG_CB(CB_GATTS_INDICATION_SEND),
 
 	/* Map client */
 	DBG_CB(CB_MAP_CLIENT_REMOTE_MAS_INSTANCES),
@@ -2000,6 +2001,18 @@ static void gatts_request_write_cb(int conn_id, int trans_id, bt_bdaddr_t *bda,
 	schedule_callback_verification(step);
 }
 
+static void gatts_indication_send_cb(int conn_id, int status)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_INDICATION_SEND;
+
+	step->callback_result.conn_id = conn_id;
+	step->callback_result.status = status;
+
+	schedule_callback_verification(step);
+}
+
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.register_server_cb = gatts_register_server_cb,
 	.connection_cb = gatts_connection_cb,
@@ -2013,7 +2026,9 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.request_read_cb = gatts_request_read_cb,
 	.request_write_cb = gatts_request_write_cb,
 	.request_exec_write_cb = NULL,
-	.response_confirmation_cb = NULL
+	.response_confirmation_cb = NULL,
+	.indication_sent_cb = gatts_indication_send_cb,
+	.congestion_cb = NULL,
 };
 
 static const btgatt_callbacks_t btgatt_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index 3d97b72..8a7384c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -253,6 +253,12 @@ struct pdu_set {
 		.callback_result.gatt_app_id = cb_server_id, \
 	}
 
+#define CALLBACK_GATTS_NOTIF_CONF(cb_conn_id, cb_status) { \
+		.callback = CB_GATTS_INDICATION_SEND, \
+		.callback_result.conn_id = cb_conn_id, \
+		.callback_result.status = cb_status, \
+	}
+
 #define CALLBACK_GATTS_SERVICE_ADDED(cb_res, cb_server_id, cb_service, \
 						cb_srvc_handle, \
 						cb_store_srvc_handle) { \
@@ -540,6 +546,7 @@ typedef enum {
 	CB_GATTS_REQUEST_WRITE,
 	CB_GATTS_REQUEST_EXEC_WRITE,
 	CB_GATTS_RESPONSE_CONFIRMATION,
+	CB_GATTS_INDICATION_SEND,
 
 	/* Map client */
 	CB_MAP_CLIENT_REMOTE_MAS_INSTANCES,
-- 
1.9.1

