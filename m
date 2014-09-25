Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/tester: Add GATT Server basic test cases
Date: Thu, 25 Sep 2014 16:03:10 +0200
Message-Id: <1411653793-5254-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds basic tests for server register, unregister.
---
 android/tester-gatt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 14 +++++++++++++-
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 26470d5..693a8a3 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -836,6 +836,35 @@ static void gatt_client_write_characteristic_action(void)
 	schedule_action_verification(step);
 }
 
+static void gatt_server_register_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	bt_uuid_t *app_uuid = current_data_step->set_data;
+	struct step *step = g_new0(struct step, 1);
+
+	if (!app_uuid) {
+		tester_warn("No app uuid provided for register action.");
+		return;
+	}
+
+	step->action_status = data->if_gatt->server->register_server(app_uuid);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_server_unregister_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	int32_t sr_id = PTR_TO_INT(current_data_step->set_data);
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->server->unregister_server(sr_id);
+
+	schedule_action_verification(step);
+}
+
 static void gatt_cid_hook_cb(const void *data, uint16_t len, void *user_data)
 {
 	struct test_data *t_data = tester_get_data();
@@ -1822,6 +1851,19 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+
+	TEST_CASE_BREDRLE("Gatt Server - Register",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+	),
+	TEST_CASE_BREDRLE("Gatt Server - Unregister",
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_server_unregister_action,
+							INT_TO_PTR(APP1_ID)),
+		ACTION_SUCCESS(gatt_server_register_action, &app1_uuid),
+		CALLBACK_STATUS(CB_GATTS_REGISTER_SERVER, BT_STATUS_SUCCESS),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 61a6bcd..93807cd 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1253,6 +1253,18 @@ static void gattc_write_descriptor_cb(int conn_id, int status,
 	schedule_callback_call(step);
 }
 
+static void gatts_register_server_cb(int status, int server_if,
+							bt_uuid_t *app_uuid)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTS_REGISTER_SERVER;
+
+	step->callback_result.status = status;
+
+	schedule_callback_call(step);
+}
+
 static void pan_control_state_cb(btpan_control_state_t state,
 					bt_status_t error, int local_role,
 							const char *ifname)
@@ -1374,7 +1386,7 @@ static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 };
 
 static const btgatt_server_callbacks_t btgatt_server_callbacks = {
-	.register_server_cb = NULL,
+	.register_server_cb = gatts_register_server_cb,
 	.connection_cb = NULL,
 	.service_added_cb = NULL,
 	.included_service_added_cb = NULL,
-- 
1.9.3

