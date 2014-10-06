Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/tester: Add GATT server stop service test cases
Date: Mon,  6 Oct 2014 16:27:44 +0200
Message-Id: <1412605665-13527-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412605665-13527-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds stop service by server test cases.
---
 android/tester-gatt.c | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 16 ++++++++++++-
 android/tester-main.h |  7 ++++++
 3 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 19ba703..1f369c2 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -148,6 +148,11 @@ struct start_srvc_data {
 	int transport;
 };
 
+struct stop_srvc_data {
+	int app_id;
+	int *srvc_handle;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -493,6 +498,16 @@ static struct start_srvc_data start_bad_srvc_data_2 = {
 	.transport = -1
 };
 
+static struct stop_srvc_data stop_srvc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc1_handle
+};
+
+static struct stop_srvc_data stop_bad_srvc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc_bad_handle
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -1271,6 +1286,20 @@ static void gatt_server_start_srvc_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_stop_srvc_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct stop_srvc_data *stop_srvc_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->stop_service(
+						stop_srvc_data->app_id,
+						*stop_srvc_data->srvc_handle);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2745,6 +2774,39 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_FAILURE, APP1_ID,
 								&srvc1_handle),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Stop Service Successful",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_1),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_start_srvc_action,
+							&start_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_stop_srvc_action, &stop_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_STOPPED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Stop Service wrong service handle",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_1),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_start_srvc_action,
+							&start_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_STARTED(GATT_STATUS_SUCCESS, APP1_ID,
+								&srvc1_handle),
+		ACTION_FAIL(gatt_server_stop_srvc_action,
+							&stop_bad_srvc_data_1),
+		CALLBACK_GATTS_SERVICE_STOPPED(GATT_STATUS_FAILURE, APP1_ID,
+									NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 4ffa3c1..253599b 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1622,6 +1622,20 @@ static void gatts_service_started_cb(int status, int server_if, int srvc_handle)
 	schedule_callback_verification(step);
 }
 
+static void gatts_service_stopped_cb(int status, int server_if, int srvc_handle)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_SERVICE_STOPPED;
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
@@ -1750,7 +1764,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.characteristic_added_cb = gatts_characteristic_added_cb,
 	.descriptor_added_cb = gatts_descriptor_added_cb,
 	.service_started_cb = gatts_service_started_cb,
-	.service_stopped_cb = NULL,
+	.service_stopped_cb = gatts_service_stopped_cb,
 	.service_deleted_cb = NULL,
 	.request_read_cb = NULL,
 	.request_write_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 1906a8d..04195a7 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -304,6 +304,13 @@ struct pdu_set {
 		.callback_result.srvc_handle = cb_srvc_handle, \
 	}
 
+#define CALLBACK_GATTS_SERVICE_STOPPED(cb_res, cb_server_id, cb_srvc_handle) { \
+		.callback = CB_GATTS_SERVICE_STOPPED, \
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

