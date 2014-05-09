Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/15] android/tester-ng: Add GATT client's register client case
Date: Fri,  9 May 2014 16:42:43 +0200
Message-Id: <1399646568-20742-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

---
 android/android-tester-ng.c | 59 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 58 insertions(+), 1 deletion(-)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 2c4aa21..b76a43c 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -656,8 +656,22 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = NULL
 };
 
+static void gattc_register_client_cb(int status, int client_if,
+							bt_uuid_t *app_uuid)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_GATTC_REGISTER_CLIENT;
+	step->callback_result.status = status;
+
+	step->callback_result.gatt_client_id = client_if;
+	step->callback_result.gatt_app_uuid = *app_uuid;
+
+	schedule_callback_call(step);
+}
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
-	.register_client_cb = NULL,
+	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = NULL,
 	.open_cb = NULL,
 	.close_cb = NULL,
@@ -944,6 +958,24 @@ static void bluetooth_disable_action(void)
 	verify_step(&step, NULL);
 }
 
+static bt_uuid_t register_client_uuid_val = {
+	.uu = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99,
+		0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff },
+};
+
+static void gattc_register_client_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step step;
+
+	memset(&step, 0, sizeof(step));
+	step.action = gattc_register_client_action;
+	step.action_result.status = data->if_gatt->client->register_client(
+						&register_client_uuid_val);
+
+	verify_step(&step, NULL);
+}
+
 static void generic_test_function(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1013,6 +1045,28 @@ static struct step bluetooth_disable_success_steps[] = {
 	},
 };
 
+static struct step gatt_register_client_success_steps[] = {
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = bluetooth_enable_action,
+	},
+	{
+	.callback = CB_BT_ADAPTER_STATE_CHANGED,
+	.callback_result.state = BT_STATE_ON,
+	},
+	{
+	.action_result.status = BT_STATUS_SUCCESS,
+	.action = gattc_register_client_action,
+	},
+	{
+	.callback = CB_GATTC_REGISTER_CLIENT,
+	.callback_result.gatt_client_id = 1,
+	.callback_result.gatt_app_uuid = {
+		.uu = { 0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,
+			0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee, 0xff }},
+	},
+};
+
 #define TEST_DATA_CREATE(step_data) \
 	static struct test_steps step_data##_data = { \
 		.step_num = sizeof(step_data) / sizeof(struct step), \
@@ -1078,5 +1132,8 @@ int main(int argc, char *argv[])
 	test_bredrle("GATT Init", dummy_steps, setup_gatt,
 					generic_test_function, teardown);
 
+	test_bredrle("GATT Register Client", gatt_register_client_success_steps,
+				setup_gatt, generic_test_function, teardown);
+
 	return tester_run();
 }
-- 
1.9.2

