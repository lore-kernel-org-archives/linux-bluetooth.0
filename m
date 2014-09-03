Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] android/tester: Add AVRCP Disconnect - Success test case
Date: Wed,  3 Sep 2014 12:49:13 +0300
Message-Id: <1409737755-16689-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-avrcp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/tester-avrcp.c b/android/tester-avrcp.c
index 35e9773..337a621 100644
--- a/android/tester-avrcp.c
+++ b/android/tester-avrcp.c
@@ -218,6 +218,20 @@ static void avrcp_connect_action(void)
 	schedule_action_verification(step);
 }
 
+static void avrcp_disconnect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) addr, &bdaddr);
+
+	step->action_status = data->if_a2dp->disconnect(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("AVRCP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -238,6 +252,27 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("AVRCP Disconnect - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &sdp_setup_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &a2dp_setup_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &avrcp_setup_data),
+		ACTION_SUCCESS(avrcp_connect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTED),
+		ACTION_SUCCESS(avrcp_disconnect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_avrcp_tests(void)
-- 
1.9.3

