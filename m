Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/4] android/tester: Add Gatt Client basic test cases
Date: Mon,  4 Aug 2014 12:53:34 +0200
Message-Id: <1407149616-2224-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds basic tests for client register, unregister and scan.
---
 android/tester-gatt.c | 96 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 46 ++++++++++++++++++++++--
 android/tester-main.h |  9 +++++
 3 files changed, 149 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index bdfbd8b..2ee999c 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -19,13 +19,109 @@
 
 #include "emulator/bthost.h"
 #include "tester-main.h"
+#include "src/shared/util.h"
+
+#define CLIENT1_ID	1
 
 static struct queue *list; /* List of gatt test cases */
 
+static bt_uuid_t client_app_uuid = {
+	.uu = { 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01,
+				0x01, 0x01, 0x01, 0x01, 0x01, 0x01, 0x01 },
+};
+
+static bt_bdaddr_t emu_remote_bdaddr_val = {
+	.address = { 0x00, 0xaa, 0x01, 0x01, 0x00, 0x00 },
+};
+static bt_property_t prop_emu_remotes_default_set[] = {
+	{ BT_PROPERTY_BDADDR, sizeof(emu_remote_bdaddr_val),
+						&emu_remote_bdaddr_val },
+};
+
+static void gatt_client_register_action(void)
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
+	step->action_status = data->if_gatt->client->register_client(app_uuid);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_client_unregister_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	int32_t cl_id = PTR_TO_INT(current_data_step->set_data);
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->unregister_client(cl_id);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_client_start_scan_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	int32_t cl_id = PTR_TO_INT(current_data_step->set_data);
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->scan(cl_id, TRUE);
+
+	schedule_action_verification(step);
+}
+
+static void gatt_client_stop_scan_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *current_data_step = queue_peek_head(data->steps);
+	int32_t cl_id = PTR_TO_INT(current_data_step->set_data);
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_gatt->client->scan(cl_id, FALSE);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("Gatt Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
+	TEST_CASE_BREDRLE("Gatt Client - Register",
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+	),
+	TEST_CASE_BREDRLE("Gatt Client - Unregister",
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_unregister_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+	),
+	TEST_CASE_BREDRLE("Gatt Client - Scan",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(gatt_client_register_action, &client_app_uuid),
+		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
+		ACTION_SUCCESS(gatt_client_start_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		CLLBACK_GATTC_SCAN_RES(prop_emu_remotes_default_set, 1, TRUE),
+		ACTION_SUCCESS(gatt_client_stop_scan_action,
+							INT_TO_PTR(CLIENT1_ID)),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_gatt_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 8800ad3..df608fc 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -449,6 +449,12 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.adv_data !=
+					step->callback_result.adv_data) {
+			tester_debug("Callback adv. data status don't match");
+			return false;
+		}
+
 		if (exp->callback_result.properties &&
 				verify_property(exp->callback_result.properties,
 				exp->callback_result.num_properties,
@@ -853,9 +859,45 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = hidhost_virual_unplug_cb
 };
 
+static void gattc_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_REGISTER_CLIENT;
+
+	step->callback_result.status = status;
+
+	schedule_callback_call(step);
+}
+
+static void gattc_scan_result_cb(bt_bdaddr_t *bda, int rssi, uint8_t *adv_data)
+{
+	struct step *step = g_new0(struct step, 1);
+	bt_property_t *props[2];
+
+	step->callback = CB_GATTC_SCAN_RESULT;
+	step->callback_result.adv_data = adv_data ? TRUE : FALSE;
+
+	/* Utilize property verification mechanism for those */
+	props[0] = create_property(BT_PROPERTY_BDADDR, bda, sizeof(*bda));
+	props[1] = create_property(BT_PROPERTY_REMOTE_RSSI, &rssi,
+								sizeof(rssi));
+
+	step->callback_result.num_properties = 2;
+	step->callback_result.properties = repack_properties(2, props);
+
+	g_free(props[0]->val);
+	g_free(props[0]);
+	g_free(props[1]->val);
+	g_free(props[1]);
+
+	schedule_callback_call(step);
+}
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
-	.register_client_cb = NULL,
-	.scan_result_cb = NULL,
+	.register_client_cb = gattc_register_client_cb,
+	.scan_result_cb = gattc_scan_result_cb,
 	.open_cb = NULL,
 	.close_cb = NULL,
 	.search_complete_cb = NULL,
diff --git a/android/tester-main.h b/android/tester-main.h
index de9061a..9fb3034 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -120,6 +120,13 @@
 		.callback_result.report_size = cb_rep_size, \
 	}
 
+#define CLLBACK_GATTC_SCAN_RES(props, prop_cnt, cb_adv_data) {\
+		.callback = CB_GATTC_SCAN_RESULT, \
+		.callback_result.properties = props, \
+		.callback_result.num_properties = prop_cnt, \
+		.callback_result.adv_data = cb_adv_data, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -280,6 +287,8 @@ struct bt_callback_data {
 
 	bthh_protocol_mode_t mode;
 	int report_size;
+
+	bool adv_data;
 };
 
 /*
-- 
1.9.1

