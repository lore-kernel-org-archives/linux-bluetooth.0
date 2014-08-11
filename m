Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 6/7]  android/tester: Add A2DP Resume - Success test case
Date: Mon, 11 Aug 2014 13:13:35 +0300
Message-Id: <1407752016-14863-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
References: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-a2dp.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 16 ++++++++++++++++
 android/tester-main.h |  7 +++++++
 3 files changed, 69 insertions(+)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index ecb0740..6757d75 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -45,6 +45,8 @@ static const uint8_t req_open[] = { 0x30, 0x06, 0x04 };
 static const uint8_t rsp_open[] = { 0x32, 0x06 };
 static const uint8_t req_close[] = { 0x40, 0x08, 0x04 };
 static const uint8_t rsp_close[] = { 0x42, 0x08 };
+static const uint8_t req_start[] = { 0x40, 0x07, 0x04 };
+static const uint8_t rsp_start[] = { 0x42, 0x07 };
 
 const struct pdu {
 	const uint8_t *req;
@@ -57,6 +59,7 @@ const struct pdu {
 	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
 	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
 	{ req_close, sizeof(req_close), rsp_close, sizeof(rsp_close) },
+	{ req_start, sizeof(req_start), rsp_start, sizeof(rsp_start) },
 	{ },
 };
 
@@ -141,6 +144,30 @@ static void a2dp_disconnect_action(void)
 	schedule_action_verification(step);
 }
 
+static void audio_resume_action(void)
+{
+	struct test_data *data = tester_get_data();
+	struct step *step = g_new0(struct step, 1);
+	int err;
+
+	err = data->audio->open_output_stream(data->audio,
+						0,
+						AUDIO_DEVICE_OUT_ALL_A2DP,
+						AUDIO_OUTPUT_FLAG_NONE,
+						NULL,
+						&data->if_stream);
+	if (err < 0) {
+		step->action_status = BT_STATUS_FAIL;
+		goto done;
+	}
+
+	/* Write something to force resume */
+	data->if_stream->write(data->if_stream, &err, sizeof(err));
+
+done:
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("A2DP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
@@ -180,6 +207,25 @@ static struct test_case test_cases[] = {
 		ACTION_SUCCESS(bluetooth_disable_action, NULL),
 		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
 	),
+	TEST_CASE_BREDRLE("A2DP Resume - Success",
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
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_a2dp_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 51820cf..5f41ff1 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1096,9 +1096,20 @@ static void a2dp_connection_state_cb(btav_connection_state_t state,
 	schedule_callback_call(step);
 }
 
+static void a2dp_audio_state_cb(btav_audio_state_t state, bt_bdaddr_t *bd_addr)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_A2DP_AUDIO_STATE;
+	step->callback_result.state = state;
+
+	schedule_callback_call(step);
+}
+
 static btav_callbacks_t bta2dp_callbacks = {
 	.size = sizeof(bta2dp_callbacks),
 	.connection_state_cb = a2dp_connection_state_cb,
+	.audio_state_cb = a2dp_audio_state_cb,
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
@@ -1475,6 +1486,11 @@ static void teardown(const void *test_data)
 		data->if_hdp = NULL;
 	}
 
+	if (data->if_stream) {
+		data->audio->close_output_stream(data->audio, data->if_stream);
+		data->if_stream = NULL;
+	}
+
 	if (data->if_a2dp) {
 		data->if_a2dp->cleanup();
 		data->if_a2dp = NULL;
diff --git a/android/tester-main.h b/android/tester-main.h
index 32f173b..ad87878 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -185,6 +185,11 @@
 		.callback_result.state = cb_state, \
 	}
 
+#define CALLBACK_AV_AUDIO_STATE(cb, cb_state) { \
+		.callback = cb, \
+		.callback_result.state = cb_state, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -250,6 +255,7 @@ typedef enum {
 
 	/* A2DP cb */
 	CB_A2DP_CONN_STATE,
+	CB_A2DP_AUDIO_STATE,
 
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
@@ -300,6 +306,7 @@ struct test_data {
 	const btpan_interface_t *if_pan;
 	const bthl_interface_t *if_hdp;
 	const btav_interface_t *if_a2dp;
+	struct audio_stream_out *if_stream;
 	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
-- 
1.9.3

