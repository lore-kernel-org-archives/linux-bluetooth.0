Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 5/7] android/tester: Add A2DP Disconnect - Success test case
Date: Mon, 11 Aug 2014 13:13:34 +0300
Message-Id: <1407752016-14863-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
References: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-a2dp.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index a86dcec..ecb0740 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -43,6 +43,8 @@ static const uint8_t req_cfg[] = { 0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07,
 static const uint8_t rsp_cfg[] = { 0x22, 0x03 };
 static const uint8_t req_open[] = { 0x30, 0x06, 0x04 };
 static const uint8_t rsp_open[] = { 0x32, 0x06 };
+static const uint8_t req_close[] = { 0x40, 0x08, 0x04 };
+static const uint8_t rsp_close[] = { 0x42, 0x08 };
 
 const struct pdu {
 	const uint8_t *req;
@@ -54,6 +56,7 @@ const struct pdu {
 	{ req_get, sizeof(req_get), rsp_get, sizeof(rsp_get) },
 	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
 	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
+	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
 	{ },
 };
 
@@ -114,6 +117,9 @@ static void a2dp_connect_action(void)
 	struct step *step = g_new0(struct step, 1);
 	bt_bdaddr_t bdaddr;
 
+	cid_data.handle = 0;
+	cid_data.cid = 0;
+
 	bdaddr2android((const bdaddr_t *) addr, &bdaddr);
 
 	step->action_status = data->if_a2dp->connect(&bdaddr);
@@ -121,6 +127,20 @@ static void a2dp_connect_action(void)
 	schedule_action_verification(step);
 }
 
+static void a2dp_disconnect_action(void)
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
 	TEST_CASE_BREDRLE("A2DP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -141,6 +161,25 @@ static struct test_case test_cases[] = {
 					BTAV_CONNECTION_STATE_DISCONNECTED),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("A2DP Disconnect - Success",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action, &l2cap_setup_data),
+		ACTION_SUCCESS(a2dp_connect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_CONNECTED),
+		ACTION_SUCCESS(a2dp_disconnect_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTING),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_a2dp_tests(void)
-- 
1.9.3

