Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] android/tester: Add GATT server add include service test cases
Date: Mon,  6 Oct 2014 14:54:01 +0200
Message-Id: <1412600046-9865-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds include service add by server test cases.
---
 android/tester-gatt.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 33 ++++++++++++++++++++-
 android/tester-main.h | 10 +++++++
 3 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 209b556..98b5077 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -48,6 +48,9 @@
 
 static struct queue *list; /* List of gatt test cases */
 
+static int srvc1_handle;
+static int inc_srvc1_handle;
+
 static bt_uuid_t app1_uuid = {
 	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
 				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
@@ -124,6 +127,11 @@ struct add_service_data {
 	int num_handles;
 };
 
+struct add_included_service_data {
+	int app_id;
+	int *inc_srvc_handle;
+	int *srvc_handle;
+};
 
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
@@ -365,6 +373,12 @@ static struct add_service_data add_service_data_3 = {
 	.num_handles = 1
 };
 
+static struct add_service_data add_service_data_4 = {
+	.app_id = APP1_ID,
+	.service = &service_add_1,
+	.num_handles = 2
+};
+
 static struct add_service_data add_bad_service_data_1 = {
 	.app_id = APP1_ID,
 	.service = &service_add_1,
@@ -377,6 +391,20 @@ static struct add_service_data add_sec_service_data_1 = {
 	.num_handles = 1
 };
 
+static int srvc_bad_handle = -1;
+
+static struct add_included_service_data add_inc_service_data_1 = {
+	.app_id = APP1_ID,
+	.inc_srvc_handle = &inc_srvc1_handle,
+	.srvc_handle = &srvc1_handle
+};
+
+static struct add_included_service_data add_bad_inc_service_data_1 = {
+	.app_id = APP1_ID,
+	.inc_srvc_handle = &srvc_bad_handle,
+	.srvc_handle = &srvc1_handle
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -1091,6 +1119,22 @@ static void gatt_server_add_service_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_add_inc_service_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct add_included_service_data *add_inc_srvc_data =
+						current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->add_included_service(
+					add_inc_srvc_data->app_id,
+					*add_inc_srvc_data->srvc_handle,
+					*add_inc_srvc_data->inc_srvc_handle);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2400,6 +2444,41 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
 						&included_1, NULL, NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Included Service Successful",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_4),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_4),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&inc_srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_inc_service_action,
+						&add_inc_service_data_1),
+		CALLBACK_GATTS_INC_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&srvc1_handle, NULL),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Inc. Service with wrong handle",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_4),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_4),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+						&service_add_1, NULL, NULL),
+		ACTION_FAIL(gatt_server_add_inc_service_action,
+						&add_bad_inc_service_data_1),
+		CALLBACK_GATTS_INC_SERVICE_ADDED(GATT_STATUS_FAILURE, APP1_ID,
+							&srvc1_handle, NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 141e4c6..f2eac79 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -783,6 +783,16 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+	if (exp->callback_result.inc_srvc_handle &&
+					step->callback_result.inc_srvc_handle)
+		if (*exp->callback_result.inc_srvc_handle !=
+				*step->callback_result.inc_srvc_handle) {
+			tester_debug("Gatt inc. srvc handle mismatch: %d vs %d",
+					*step->callback_result.inc_srvc_handle,
+					*exp->callback_result.inc_srvc_handle);
+			return false;
+		}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
@@ -894,6 +904,9 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.srvc_handle)
 		free(step->callback_result.srvc_handle);
 
+	if (step->callback_result.inc_srvc_handle)
+		free(step->callback_result.inc_srvc_handle);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1515,6 +1528,24 @@ static void gatts_service_added_cb(int status, int server_if,
 	schedule_callback_verification(step);
 }
 
+static void gatts_included_service_added_cb(int status, int server_if,
+							int srvc_handle,
+							int inc_srvc_handle)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_INCLUDED_SERVICE_ADDED;
+
+	step->callback_result.status = status;
+	step->callback_result.gatt_app_id = server_if;
+	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
+							sizeof(srvc_handle));
+	step->callback_result.inc_srvc_handle = g_memdup(&inc_srvc_handle,
+						sizeof(inc_srvc_handle));
+
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1639,7 +1670,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.register_server_cb = gatts_register_server_cb,
 	.connection_cb = gatts_connection_cb,
 	.service_added_cb = gatts_service_added_cb,
-	.included_service_added_cb = NULL,
+	.included_service_added_cb = gatts_included_service_added_cb,
 	.characteristic_added_cb = NULL,
 	.descriptor_added_cb = NULL,
 	.service_started_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 79df8de..14adb65 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -263,6 +263,15 @@ struct pdu_set {
 		.store_srvc_handle = cb_store_srvc_handle, \
 	}
 
+#define CALLBACK_GATTS_INC_SERVICE_ADDED(cb_res, cb_server_id, cb_srvc_handle, \
+							cb_inc_srvc_handle) { \
+		.callback = CB_GATTS_INCLUDED_SERVICE_ADDED, \
+		.callback_result.status = cb_res, \
+		.callback_result.gatt_app_id = cb_server_id, \
+		.callback_result.srvc_handle = cb_srvc_handle, \
+		.callback_result.inc_srvc_handle = cb_inc_srvc_handle, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -512,6 +521,7 @@ struct bt_callback_data {
 	int conn_id;
 	int connected;
 	int *srvc_handle;
+	int *inc_srvc_handle;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
-- 
1.9.3

