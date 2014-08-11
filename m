Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 7/7] android/tester: Add A2DP Suspend - Success test case
Date: Mon, 11 Aug 2014 13:13:36 +0300
Message-Id: <1407752016-14863-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
References: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-a2dp.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index 6757d75..3d006bc 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -47,6 +47,8 @@ static const uint8_t req_close[] = { 0x40, 0x08, 0x04 };
 static const uint8_t rsp_close[] = { 0x42, 0x08 };
 static const uint8_t req_start[] = { 0x40, 0x07, 0x04 };
 static const uint8_t rsp_start[] = { 0x42, 0x07 };
+static const uint8_t req_suspend[] = { 0x50, 0x09, 0x04 };
+static const uint8_t rsp_suspend[] = { 0x52, 0x09 };
 
 const struct pdu {
 	const uint8_t *req;
@@ -60,6 +62,7 @@ const struct pdu {
 	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
 	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
 	{ req_start, sizeof(req_start), rsp_start, sizeof(rsp_start) },
+	{ req_suspend, sizeof(req_suspend), rsp_suspend, sizeof(rsp_start) },
 	{ },
 };
 
@@ -168,6 +171,16 @@ done:
 	schedule_action_verification(step);
 }
 
+static void audio_suspend_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	data->if_stream->common.standby(&data->if_stream->common);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("A2DP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -226,6 +239,28 @@ static struct test_case test_cases[] = {
 					BTAV_CONNECTION_STATE_DISCONNECTED),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("A2DP Suspend - Success",
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
+		ACTION_SUCCESS(audio_resume_action, NULL),
+		CALLBACK_AV_AUDIO_STATE(CB_A2DP_AUDIO_STATE,
+					BTAV_AUDIO_STATE_STARTED),
+		ACTION_SUCCESS(audio_suspend_action, NULL),
+		CALLBACK_AV_AUDIO_STATE(CB_A2DP_AUDIO_STATE,
+					BTAV_AUDIO_STATE_STOPPED),
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_a2dp_tests(void)
-- 
1.9.3

