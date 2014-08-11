Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] android/tester: Add A2DP connect - Success test case
Date: Mon, 11 Aug 2014 13:06:27 +0300
Message-Id: <1407751590-6301-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407751590-6301-1-git-send-email-luiz.dentz@gmail.com>
References: <1407751590-6301-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/tester-a2dp.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c |  14 ++++++-
 android/tester-main.h |   8 ++++
 3 files changed, 134 insertions(+), 2 deletions(-)

diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
index d2b6516..a86dcec 100644
--- a/android/tester-a2dp.c
+++ b/android/tester-a2dp.c
@@ -18,15 +18,129 @@
 #include <stdbool.h>
 
 #include "emulator/bthost.h"
+#include "src/shared/util.h"
+
 #include "tester-main.h"
 #include "android/utils.h"
 
 static struct queue *list;
 
+struct emu_cid_data {
+	uint16_t handle;
+	uint16_t cid;
+};
+
+static struct emu_cid_data cid_data;
+
+static const uint8_t req_dsc[] = { 0x00, 0x01 };
+static const uint8_t rsp_dsc[] = { 0x02, 0x01, 0x04, 0x08 };
+static const uint8_t req_get[] = { 0x10, 0x02, 0x04 };
+static const uint8_t rsp_get[] = { 0x12, 0x02, 0x01, 0x00, 0x07, 0x06, 0x00,
+						0x00, 0xff, 0xff, 0x02, 0x40 };
+static const uint8_t req_cfg[] = { 0x20, 0x03, 0x04, 0x04, 0x01, 0x00, 0x07,
+					0x06, 0x00, 0x00, 0x21, 0x15, 0x02,
+					0x40 };
+static const uint8_t rsp_cfg[] = { 0x22, 0x03 };
+static const uint8_t req_open[] = { 0x30, 0x06, 0x04 };
+static const uint8_t rsp_open[] = { 0x32, 0x06 };
+
+const struct pdu {
+	const uint8_t *req;
+	size_t req_len;
+	const uint8_t *rsp;
+	size_t rsp_len;
+} pdus[] = {
+	{ req_dsc, sizeof(req_dsc), rsp_dsc, sizeof(rsp_dsc) },
+	{ req_get, sizeof(req_get), rsp_get, sizeof(rsp_get) },
+	{ req_cfg, sizeof(req_cfg), rsp_cfg, sizeof(rsp_cfg) },
+	{ req_open, sizeof(req_open), rsp_open, sizeof(rsp_open) },
+	{ },
+};
+
+static void print_data(const char *str, void *user_data)
+{
+	tester_debug("a2dp: %s", str);
+}
+
+static void a2dp_cid_hook_cb(const void *data, uint16_t len, void *user_data)
+{
+	struct emu_cid_data *cid_data = user_data;
+	struct test_data *t_data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(t_data->hciemu);
+	int i;
+
+	util_hexdump('>', data, len, print_data, NULL);
+
+	for (i = 0; pdus[i].req; i++) {
+		if (pdus[i].req_len != len)
+			continue;
+
+		if (memcmp(pdus[i].req, data, len))
+			continue;
+
+		util_hexdump('<', pdus[i].rsp, pdus[i].rsp_len, print_data,
+									NULL);
+
+		bthost_send_cid(bthost, cid_data->handle, cid_data->cid,
+						pdus[i].rsp, pdus[i].rsp_len);
+	}
+}
+
+static void a2dp_connect_request_cb(uint16_t handle, uint16_t cid,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+
+	if (cid_data.handle)
+		return;
+
+	cid_data.handle = handle;
+	cid_data.cid = cid;
+
+	bthost_add_cid_hook(bthost, handle, cid, a2dp_cid_hook_cb, &cid_data);
+}
+
+static struct emu_set_l2cap_data l2cap_setup_data = {
+	.psm = 25,
+	.func = a2dp_connect_request_cb,
+	.user_data = NULL,
+};
+
+static void a2dp_connect_action(void)
+{
+	struct test_data *data = tester_get_data();
+	const uint8_t *addr = hciemu_get_client_bdaddr(data->hciemu);
+	struct step *step = g_new0(struct step, 1);
+	bt_bdaddr_t bdaddr;
+
+	bdaddr2android((const bdaddr_t *) addr, &bdaddr);
+
+	step->action_status = data->if_a2dp->connect(&bdaddr);
+
+	schedule_action_verification(step);
+}
+
 static struct test_case test_cases[] = {
 	TEST_CASE_BREDRLE("A2DP Init",
 		ACTION_SUCCESS(dummy_action, NULL),
 	),
+	TEST_CASE_BREDRLE("A2DP Connect - Success",
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
+		ACTION_SUCCESS(bluetooth_disable_action, NULL),
+		CALLBACK_AV_CONN_STATE(CB_A2DP_CONN_STATE,
+					BTAV_CONNECTION_STATE_DISCONNECTED),
+		CALLBACK_STATE(CB_BT_ADAPTER_STATE_CHANGED, BT_STATE_OFF),
+	),
 };
 
 struct queue *get_a2dp_tests(void)
diff --git a/android/tester-main.c b/android/tester-main.c
index 6a250a3..d834964 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1060,8 +1060,6 @@ static void hdp_app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
 	step->callback = CB_HDP_APP_REG_STATE;
 	step->callback_result.app_id = app_id;
 	step->callback_result.app_state = state;
-
-	schedule_callback_call(step);
 }
 
 static void hdp_channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
@@ -1085,8 +1083,20 @@ static bthl_callbacks_t bthl_callbacks = {
 	.channel_state_cb = hdp_channel_state_cb,
 };
 
+static void a2dp_connection_state_cb(btav_connection_state_t state,
+							bt_bdaddr_t *bd_addr)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_A2DP_CONN_STATE;
+	step->callback_result.state = state;
+
+	schedule_callback_call(step);
+}
+
 static btav_callbacks_t bta2dp_callbacks = {
 	.size = sizeof(bta2dp_callbacks),
+	.connection_state_cb = a2dp_connection_state_cb,
 };
 
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
diff --git a/android/tester-main.h b/android/tester-main.h
index 2cefe5c..32f173b 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -180,6 +180,11 @@
 		.callback_result.channel_state = cb_state, \
 	}
 
+#define CALLBACK_AV_CONN_STATE(cb, cb_state) { \
+		.callback = cb, \
+		.callback_result.state = cb_state, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -243,6 +248,9 @@ typedef enum {
 	CB_HDP_APP_REG_STATE,
 	CB_HDP_CHANNEL_STATE,
 
+	/* A2DP cb */
+	CB_A2DP_CONN_STATE,
+
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
 	CB_GATTC_SCAN_RESULT,
-- 
1.9.3

