Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 4/5] android/tester: Add HDP Connect Sink Streaming Channel test case
Date: Wed, 27 Aug 2014 15:38:59 +0300
Message-Id: <1409143140-19651-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1409143140-19651-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-hdp.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/android/tester-hdp.c b/android/tester-hdp.c
index 7609683..ca8cb51 100644
--- a/android/tester-hdp.c
+++ b/android/tester-hdp.c
@@ -391,6 +391,42 @@ static void hdp_destroy_source_reliable_action(void)
 	schedule_action_verification(step);
 }
 
+static void hdp_connect_sink_reliable_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+	int app_id, channel_id, mdep_cfg_index;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	app_id = 1;
+	mdep_cfg_index = 0;
+	channel_id = 0;
+	step->action_status = data->if_hdp->connect_channel(app_id, &bdaddr,
+						mdep_cfg_index, &channel_id);
+
+	schedule_action_verification(step);
+}
+
+static void hdp_connect_sink_stream_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *hid_addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+	int app_id, channel_id, mdep_cfg_index;
+
+	bdaddr2android((const bdaddr_t *) hid_addr, &bdaddr);
+	app_id = 1;
+	mdep_cfg_index = 1;
+	channel_id = 0;
+	step->action_status = data->if_hdp->connect_channel(app_id, &bdaddr,
+						mdep_cfg_index, &channel_id);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("HDP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -466,6 +502,29 @@ static struct test_case test_cases[] = {
 		CALLBACK_HDP_CHANNEL_STATE(CB_HDP_CHANNEL_STATE, 1, 1, 0,
 						BTHL_CONN_STATE_DESTROYED),
 	),
+	TEST_CASE_BREDRLE("HDP Connect Sink Streaming Channel",
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
+	),
 };
 
 struct queue *get_hdp_tests(void)
-- 
1.9.1

