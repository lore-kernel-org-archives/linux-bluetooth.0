Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/tester: Add GATT server add characteristic test cases
Date: Mon,  6 Oct 2014 14:54:02 +0200
Message-Id: <1412600046-9865-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1412600046-9865-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds characteristic add by server test cases.
---
 android/tester-gatt.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 41 +++++++++++++++++++++++++++-
 android/tester-main.h | 16 +++++++++++
 3 files changed, 130 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 98b5077..0f084ed 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -133,6 +133,14 @@ struct add_included_service_data {
 	int *srvc_handle;
 };
 
+struct add_char_data {
+	int app_id;
+	int *srvc_handle;
+	bt_uuid_t *uuid;
+	int properties;
+	int permissions;
+};
+
 static bt_bdaddr_t emu_remote_bdaddr_val = {
 	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
 };
@@ -379,6 +387,12 @@ static struct add_service_data add_service_data_4 = {
 	.num_handles = 2
 };
 
+static struct add_service_data add_service_data_5 = {
+	.app_id = APP1_ID,
+	.service = &service_add_1,
+	.num_handles = 3
+};
+
 static struct add_service_data add_bad_service_data_1 = {
 	.app_id = APP1_ID,
 	.service = &service_add_1,
@@ -405,6 +419,22 @@ static struct add_included_service_data add_bad_inc_service_data_1 = {
 	.srvc_handle = &srvc1_handle
 };
 
+static struct add_char_data add_char_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc1_handle,
+	.uuid = &app1_uuid,
+	.properties = 0,
+	.permissions = 0
+};
+
+static struct add_char_data add_bad_char_data_1 = {
+	.app_id = APP1_ID,
+	.srvc_handle = &srvc_bad_handle,
+	.uuid = &app1_uuid,
+	.properties = 0,
+	.permissions = 0
+};
+
 struct set_read_params {
 	btgatt_read_params_t *params;
 	btgatt_srvc_id_t *srvc_id;
@@ -1135,6 +1165,23 @@ static void gatt_server_add_inc_service_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_add_char_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct add_char_data *add_char_data = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->add_characteristic(
+						add_char_data->app_id,
+						*add_char_data->srvc_handle,
+						add_char_data->uuid,
+						add_char_data->properties,
+						add_char_data->permissions);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -2479,6 +2526,33 @@ static struct test_case test_cases[] = {
 		CALLBACK_GATTS_INC_SERVICE_ADDED(GATT_STATUS_FAILURE, APP1_ID,
 							&srvc1_handle, NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Single Characteristic Successful",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_5),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_SUCCESS(gatt_server_add_char_action, &add_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_SUCCESS,
+							APP1_ID, &app1_uuid,
+							&srvc1_handle, NULL,
+							NULL),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Add Char. wrong service handle",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_add_service_action,
+							&add_service_data_5),
+		CALLBACK_GATTS_SERVICE_ADDED(GATT_STATUS_SUCCESS, APP1_ID,
+							&service_add_1, NULL,
+							&srvc1_handle),
+		ACTION_FAIL(gatt_server_add_char_action, &add_bad_char_data_1),
+		CALLBACK_GATTS_CHARACTERISTIC_ADDED(GATT_STATUS_FAILURE,
+							APP1_ID, &app1_uuid,
+							NULL, NULL, NULL),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index f2eac79..8ba4947 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -793,11 +793,24 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+	if (exp->callback_result.uuid && step->callback_result.uuid)
+		if (memcmp(exp->callback_result.uuid,
+					step->callback_result.uuid,
+					sizeof(*exp->callback_result.uuid))) {
+			tester_debug("Uuid mismatch");
+			return false;
+		}
+
 	if (exp->store_srvc_handle)
 		memcpy(exp->store_srvc_handle,
 					step->callback_result.srvc_handle,
 					sizeof(*exp->store_srvc_handle));
 
+	if (exp->store_char_handle)
+		memcpy(exp->store_char_handle,
+					step->callback_result.char_handle,
+					sizeof(*exp->store_char_handle));
+
 	return true;
 }
 
@@ -907,6 +920,12 @@ static void destroy_callback_step(void *data)
 	if (step->callback_result.inc_srvc_handle)
 		free(step->callback_result.inc_srvc_handle);
 
+	if (step->callback_result.uuid)
+		free(step->callback_result.uuid);
+
+	if (step->callback_result.char_handle)
+		free(step->callback_result.char_handle);
+
 	g_free(step);
 	g_atomic_int_dec_and_test(&scheduled_cbacks_num);
 }
@@ -1546,6 +1565,26 @@ static void gatts_included_service_added_cb(int status, int server_if,
 	schedule_callback_verification(step);
 }
 
+static void gatts_characteristic_added_cb(int status, int server_if,
+								bt_uuid_t *uuid,
+								int srvc_handle,
+								int char_handle)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_CHARACTERISTIC_ADDED;
+
+	step->callback_result.status = status;
+	step->callback_result.gatt_app_id = server_if;
+	step->callback_result.srvc_handle = g_memdup(&srvc_handle,
+							sizeof(srvc_handle));
+	step->callback_result.uuid = g_memdup(uuid, sizeof(*uuid));
+	step->callback_result.char_handle = g_memdup(&char_handle,
+							sizeof(char_handle));
+
+	schedule_callback_verification(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1671,7 +1710,7 @@ static const btgatt_server_callbacks_t btgatt_server_callbacks = {
 	.connection_cb = gatts_connection_cb,
 	.service_added_cb = gatts_service_added_cb,
 	.included_service_added_cb = gatts_included_service_added_cb,
-	.characteristic_added_cb = NULL,
+	.characteristic_added_cb = gatts_characteristic_added_cb,
 	.descriptor_added_cb = NULL,
 	.service_started_cb = NULL,
 	.service_stopped_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index 14adb65..2400824 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -272,6 +272,19 @@ struct pdu_set {
 		.callback_result.inc_srvc_handle = cb_inc_srvc_handle, \
 	}
 
+#define CALLBACK_GATTS_CHARACTERISTIC_ADDED(cb_res, cb_server_id, cb_uuid, \
+						cb_srvc_handle, \
+						cb_char_handle, \
+						cb_store_char_handle) { \
+		.callback = CB_GATTS_CHARACTERISTIC_ADDED, \
+		.callback_result.status = cb_res, \
+		.callback_result.gatt_app_id = cb_server_id, \
+		.callback_result.uuid = cb_uuid, \
+		.callback_result.srvc_handle = cb_srvc_handle, \
+		.callback_result.char_handle = cb_char_handle, \
+		.store_char_handle = cb_store_char_handle, \
+	}
+
 #define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
 		.callback = cb, \
 		.callback_result.status = cb_res, \
@@ -509,6 +522,7 @@ struct bt_callback_data {
 	bt_status_t status;
 	int num_properties;
 	bt_property_t *properties;
+	bt_uuid_t *uuid;
 
 	bt_ssp_variant_t pairing_variant;
 
@@ -522,6 +536,7 @@ struct bt_callback_data {
 	int connected;
 	int *srvc_handle;
 	int *inc_srvc_handle;
+	int *char_handle;
 	btgatt_srvc_id_t *service;
 	btgatt_gatt_id_t *characteristic;
 	btgatt_gatt_id_t *descriptor;
@@ -559,6 +574,7 @@ struct step {
 	int set_data_len;
 
 	int *store_srvc_handle;
+	int *store_char_handle;
 };
 
 struct test_case {
-- 
1.9.3

