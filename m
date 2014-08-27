Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 5/5] android/tester: Add HDP Destroy Sink Streaming Channel test case
Date: Wed, 27 Aug 2014 15:39:00 +0300
Message-Id: <1409143140-19651-6-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hdp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index ca8cb51..bb73681 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -427,6 +427,24 @@ static void hdp_connect_sink_stream_action(void)
 	schedule_action_verification(step);
 }
 
+static void hdp_destroy_sink_reliable_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_hdp->destroy_channel(1);
+	schedule_action_verification(step);
+}
+
+static void hdp_destroy_sink_stream_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+
+	step->action_status = data->if_hdp->destroy_channel(2);
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HDP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -525,6 +543,35 @@ static struct test_case test_cases[] = {
 		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 2, 1,
 						BTHL_CONN_STATE_CONNECTED),
 	),
+	TEST_CASE_BREDRLE("HDP Destroy Sink Streaming Channel",
+		ACTION_SUCCESS(bluetooth_enable_action, NULL),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_ON),
+		ACTION_SUCCESS(emu_setup_powered_remote_action, NULL),
+		ACTION_SUCCESS(emu_set_ssp_mode_action, NULL),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_sdp_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_cc_data),
+		ACTION_SUCCESS(emu_add_l2cap_server_action,
+							&l2cap_setup_dc_data),
+		ACTION_SUCCESS(hdp_register_sink_stream_app_action, NULL),
+		CALLBACK_HDP_APP_REG_STATE(CB_HDP_APP_REG_STATE, 1,
+					BTHL_APP_REG_STATE_REG_SUCCESS),
+		ACTION_SUCCESS(hdp_connect_sink_reliable_action, NULL),
+		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 1, 0,
+						BTHL_CONN_STATE_CONNECTING),
+		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 1, 0,
+						BTHL_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hdp_connect_sink_stream_action, NULL),
+		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 2, 1,
+						BTHL_CONN_STATE_CONNECTED),
+		ACTION_SUCCESS(hdp_destroy_sink_reliable_action, NULL),
+		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 1, 0,
+						BTHL_CONN_STATE_DESTROYED),
+		ACTION_SUCCESS(hdp_destroy_sink_stream_action, NULL),
+		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 2, 1,
+						BTHL_CONN_STATE_DESTROYED),
+	),
 };
 
 struct queue *get_hdp_tests(void)
-- 
1.9.1

