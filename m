Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/tester: Add GATT server delete service test cases
Date: Mon,  6 Oct 2014 16:27:45 +0200
Message-Id: <1412605665-13527-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds delete service by server test cases.
---
 android/tester-gatt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 16 ++++++++++++++-
 android/tester-main.h |  7 +++++++
 3 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 1f369c2..d4516ef 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -153,6 +153,11 @@ struct stop_srvc_data {
 	int *srvc_handle;
 };
 
+struct delete_srvc_data {
+	int app_id;
+	int *srvc_handle;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -508,6 +513,15 @@ static struct stop_srvc_data stop_bad_srvc_data_1 = {
 	.srvc_handle = &srvc_bad_handle
 };
 
+static struct delete_srvc_data delete_srvc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc1_handle
+};
+
+static struct delete_srvc_data delete_bad_srvc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc_bad_handle
+};
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -1300,6 +1314,20 @@ static void gatt_server_stop_srvc_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_delete_srvc_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct delete_srvc_data *delete_srvc_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->delete_service(
+						delete_srvc_data->app_id,
+						*delete_srvc_data->srvc_handle);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2807,6 +2835,32 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_SERVICE_STOPPED(GATT_STATUS_FAILURE, APP1_ID,
 									NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Delete Service Successful",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_1),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_delete_srvc_action,
+							&delete_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_DELETED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Delete Service wrong handle",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_1),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_FAIL(gatt_server_delete_srvc_action,
+						&delete_bad_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_DELETED(GATT_STATUS_FAILURE, APP1_ID,
+									NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 253599b..a804f11 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1636,6 +1636,20 @@ static void gatts_service_stopped_cb(int status, int server_if, int srvc_handle)
 	schedule_callback_verification(step);
 }
 
+static void gatts_service_deleted_cb(int status, int server_if, int srvc_handle)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_SERVICE_DELETED;
+
+	step->callback_result.status = status;
+	step->callback_result.gatt_app_id = server_if;
+	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
+							sizeof(srvc_handle));
+
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1765,7 +1779,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.descriptor_added_cb = gatts_descriptor_added_cb,
 	.service_started_cb = gatts_service_started_cb,
 	.service_stopped_cb = gatts_service_stopped_cb,
-	.service_deleted_cb = NULL,
+	.service_deleted_cb = gatts_service_deleted_cb,
 	.request_read_cb = NULL,
 	.request_write_cb = NULL,
 	.request_exec_write_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 04195a7..22c5c8b 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -311,6 +311,13 @@ struct pdu_set {
 		.callback_result.srvc_handle = cb_srvc_handle, \
 	}
 
+#define CALLBACK_GATTS_SERVICE_DELETED(cb_res, cb_server_id, cb_srvc_handle) { \
+		.callback = CB_GATTS_SERVICE_DELETED, \
+		.callback_result.status = cb_res, \
+		.callback_result.gatt_app_id = cb_server_id, \
+		.callback_result.srvc_handle = cb_srvc_handle, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
-- 
1.9.3

