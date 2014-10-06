Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] android/tester: Add GATT server add descriptor test cases
Date: Mon,  6 Oct 2014 14:54:03 +0200
Message-Id: <1412600046-9865-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds descriptor add by server test cases.
---
 android/tester-gatt.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  25 ++++++++++++-
 android/tester-main.h |  14 +++++++
 3 files changed, 140 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 0f084ed..d7a8032 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -141,6 +141,13 @@ struct add_char_data {
 	int permissions;
 };
 
+struct add_desc_data {
+	int app_id;
+	int *srvc_handle;
+	bt_uuid_t *uuid;
+	int permissions;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -393,6 +400,12 @@ static struct add_service_data add_service_data_5 = {
 	.num_handles = 3
 };
 
+static struct add_service_data add_service_data_6 = {
+	.app_id = APP1_ID,
+	.service = &service_add_1,
+	.num_handles = 4
+};
+
 static struct add_service_data add_bad_service_data_1 = {
 	.app_id = APP1_ID,
 	.service = &service_add_1,
@@ -435,6 +448,27 @@ static struct add_char_data add_bad_char_data_1 = {
 	.permissions = 0
 };
 
+static struct add_desc_data add_bad_desc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc_bad_handle,
+	.uuid = &app2_uuid,
+	.permissions = 0
+};
+
+static struct add_desc_data add_bad_desc_data_2 = {
+	.app_id = APP2_ID,
+	.srvc_handle = &srvc1_handle,
+	.uuid = &app2_uuid,
+	.permissions = 0
+};
+
+static struct add_desc_data add_desc_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc1_handle,
+	.uuid = &app2_uuid,
+	.permissions = 0
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -1182,6 +1216,22 @@ static void gatt_server_add_char_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_add_desc_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct add_desc_data *add_desc_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->add_descriptor(
+						add_desc_data->app_id,
+						*add_desc_data->srvc_handle,
+						add_desc_data->uuid,
+						add_desc_data->permissions);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2553,6 +2603,58 @@ static struct test_case test_cases[] = {
 							APP1_ID, &app1_uuid,
 							NULL, NULL, NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Single Descriptor Successful",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_6),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							NULL),
+		ACTION_SUCCESS(gatt_server_add_desc_action, &add_desc_data_1),
+		CALLBACK_GATTS_DESCRIPTOR_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+						&app2_uuid, &srvc1_handle,
+						NULL, NULL),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Desc. wrong service handle",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_6),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							NULL),
+		ACTION_FAIL(gatt_server_add_desc_action, &add_bad_desc_data_1),
+		CALLBACK_GATTS_DESCRIPTOR_ADDED(GATT_STATUS_FAILURE, APP1_ID,
+						&app2_uuid, NULL, NULL, NULL),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Desc. wrong app ID",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_6),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							NULL),
+		ACTION_FAIL(gatt_server_add_desc_action, &add_bad_desc_data_2),
+		CALLBACK_GATTS_DESCRIPTOR_ADDED(GATT_STATUS_FAILURE, APP2_ID,
+						&app2_uuid, NULL, NULL, NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 8ba4947..30e1c59 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -926,6 +926,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.char_handle)
 		free(step->callback_result.char_handle);
 
+	if (step->callback_result.desc_handle)
+		free(step->callback_result.desc_handle);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1585,6 +1588,26 @@ static void gatts_characteristic_added_cb(int status, int server_if,
 	schedule_callback_verification(step);
 }
 
+static void gatts_descriptor_added_cb(int status, int server_if,
+								bt_uuid_t *uuid,
+								int srvc_handle,
+								int desc_handle)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_DESCRIPTOR_ADDED;
+
+	step->callback_result.status = status;
+	step->callback_result.gatt_app_id = server_if;
+	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
+							sizeof(srvc_handle));
+	step->callback_result.uuid = g_memdup(uuid, sizeof(*uuid));
+	step->callback_result.desc_handle = g_memdup(&desc_handle,
+							sizeof(desc_handle));
+
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1711,7 +1734,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.service_added_cb = gatts_service_added_cb,
 	.included_service_added_cb = gatts_included_service_added_cb,
 	.characteristic_added_cb = gatts_characteristic_added_cb,
-	.descriptor_added_cb = NULL,
+	.descriptor_added_cb = gatts_descriptor_added_cb,
 	.service_started_cb = NULL,
 	.service_stopped_cb = NULL,
 	.service_deleted_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 2400824..17a6eb3 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -285,6 +285,18 @@ struct pdu_set {
 		.store_char_handle = cb_store_char_handle, \
 	}
 
+#define CALLBACK_GATTS_DESCRIPTOR_ADDED(cb_res, cb_server_id, cb_uuid, \
+					cb_srvc_handle, cb_desc_handle, \
+					cb_store_desc_handle) { \
+		.callback = CB_GATTS_DESCRIPTOR_ADDED, \
+		.callback_result.status = cb_res, \
+		.callback_result.gatt_app_id = cb_server_id, \
+		.callback_result.uuid = cb_uuid, \
+		.callback_result.srvc_handle = cb_srvc_handle, \
+		.callback_result.desc_handle = cb_desc_handle, \
+		.store_desc_handle = cb_store_desc_handle, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -537,6 +549,7 @@ struct bt_callback_data {
 	int *srvc_handle;
 	int *inc_srvc_handle;
 	int *char_handle;
+	int *desc_handle;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
@@ -575,6 +588,7 @@ struct step {
 
 	int *store_srvc_handle;
 	int *store_char_handle;
+	int *store_desc_handle;
 };
 
 struct test_case {
-- 
1.9.3

