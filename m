Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 2/9] android/tester-ng: Add HIDHost virtual unplug test case
Date: Tue, 29 Jul 2014 09:18:25 +0200
Message-Id: <1406618312-15059-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1406618312-15059-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hidhost.c | 32 ++++++++++++++++++++++++++++++++
 android/tester-main.c    | 23 +++++++++++++++++++++--
 android/tester-main.h    |  4 ++++
 3 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
index 2a61984..f77d5c0 100644
--- a/android/tester-hidhost.c
+++ b/android/tester-hidhost.c
@@ -294,6 +294,20 @@ static void hidhost_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void hidhost_virtual_unplug_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+
+	step->action_status = data->if_hid->virtual_unplug(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HidHost Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -335,6 +349,24 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
 						BTHH_CONN_STATE_DISCONNECTED),
 	),
+	TEST_CASE_BREDRLE("HidHost VirtualUnplug Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_ic_data),
+		ACTION_SUCCESS(hidhost_connect_action, NULL),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hidhost_virtual_unplug_action, NULL),
+		CALLBACK_STATE(CB_HH_CONNECTION_STATE,
+						BTHH_CONN_STATE_DISCONNECTED),
+	),
 };
 
 struct queue *get_hidhost_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 9eb10c7..f1e8a2c 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -781,14 +781,33 @@ static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
 	schedule_callback_call(step);
 }
 
+static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_VIRTUAL_UNPLUG;
+	step->callback_result.status = status;
+
+	schedule_callback_call(step);
+}
+
+static void hidhost_hid_info_cb(bt_bdaddr_t *bd_addr, bthh_hid_info_t hid)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HH_HID_INFO;
+
+	schedule_callback_call(step);
+}
+
 static bthh_callbacks_t bthh_callbacks = {
 	.size = sizeof(bthh_callbacks),
 	.connection_state_cb = hidhost_connection_state_cb,
-	.hid_info_cb = NULL,
+	.hid_info_cb = hidhost_hid_info_cb,
 	.protocol_mode_cb = NULL,
 	.idle_time_cb = NULL,
 	.get_report_cb = NULL,
-	.virtual_unplug_cb = NULL
+	.virtual_unplug_cb = hidhost_virual_unplug_cb
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index e2ecaab..7efc966 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -82,6 +82,10 @@
 		.set_data = data_set, \
 	}
 
+#define CALLBACK(cb) { \
+		.callback = cb, \
+	}
+
 #define CALLBACK_STATE(cb, cb_res) { \
 		.callback = cb, \
 		.callback_result.state = cb_res, \
-- 
1.9.1

