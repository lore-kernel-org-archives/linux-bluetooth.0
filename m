Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/3] android/tester: Add HDP init test case
Date: Wed,  6 Aug 2014 16:41:48 +0300
Message-Id: <1407332510-3831-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407332510-3831-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407332510-3831-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am   |   1 +
 android/tester-hdp.c  |  48 ++++++++++++++++++++++
 android/tester-main.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  29 +++++++++++++
 4 files changed, 189 insertions(+)
 create mode 100644 android/tester-hdp.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 79f6a0d..ac3a766 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -158,6 +158,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/tester-socket.c \
 				android/tester-hidhost.c \
 				android/tester-pan.c \
+				android/tester-hdp.c \
 				android/tester-gatt.c \
 				android/tester-main.h android/tester-main.c
 
diff --git a/android/tester-hdp.c b/android/tester-hdp.c
new file mode 100644
index 0000000..0988fec
--- /dev/null
+++ b/android/tester-hdp.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include <stdbool.h>
+
+#include "emulator/bthost.h"
+#include "tester-main.h"
+#include "android/utils.h"
+
+static struct queue *list; /* List of hdp test cases */
+
+static struct test_case test_cases[] = {
+	TEST_CASE_BREDRLE("HDP Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
+};
+
+struct queue *get_hdp_tests(void)
+{
+	uint16_t i = 0;
+
+	list = queue_new();
+
+	for (; i < sizeof(test_cases) / sizeof(test_cases[0]); ++i)
+		if (!queue_push_tail(list, &test_cases[i]))
+			return NULL;
+
+	return list;
+}
+
+void remove_hdp_tests(void)
+{
+	queue_destroy(list, NULL);
+}
diff --git a/android/tester-main.c b/android/tester-main.c
index 203a1b6..a9ccfcd 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -467,6 +467,36 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.app_id !=
+					step->callback_result.app_id) {
+			tester_debug("Callback app_id don't match");
+			return false;
+		}
+
+		if (exp->callback_result.channel_id !=
+					step->callback_result.channel_id) {
+			tester_debug("Callback channel_id don't match");
+			return false;
+		}
+
+		if (exp->callback_result.mdep_cfg_index !=
+					step->callback_result.mdep_cfg_index) {
+			tester_debug("Callback mdep_cfg_index don't match");
+			return false;
+		}
+
+		if (exp->callback_result.app_state !=
+					step->callback_result.app_state) {
+			tester_debug("Callback app_state don't match");
+			return false;
+		}
+
+		if (exp->callback_result.channel_state !=
+					step->callback_result.channel_state) {
+			tester_debug("Callback channel_state don't match");
+			return false;
+		}
+
 		if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 			tester_debug("Callback pairing result don't match");
@@ -1023,6 +1053,38 @@ static btpan_callbacks_t btpan_callbacks = {
 	.connection_state_cb = pan_connection_state_cb,
 };
 
+static void hdp_app_reg_state_cb(int app_id, bthl_app_reg_state_t state)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HDP_APP_REG_STATE;
+	step->callback_result.app_id = app_id;
+	step->callback_result.app_state = state;
+
+	schedule_callback_call(step);
+}
+
+static void hdp_channel_state_cb(int app_id, bt_bdaddr_t *bd_addr,
+				int mdep_cfg_index, int channel_id,
+				bthl_channel_state_t state, int fd)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_HDP_CHANNEL_STATE;
+	step->callback_result.app_id = app_id;
+	step->callback_result.channel_id = channel_id;
+	step->callback_result.mdep_cfg_index = mdep_cfg_index;
+	step->callback_result.channel_state = state;
+
+	schedule_callback_call(step);
+}
+
+static bthl_callbacks_t bthl_callbacks = {
+	.size = sizeof(bthl_callbacks),
+	.app_reg_state_cb = hdp_app_reg_state_cb,
+	.channel_state_cb = hdp_channel_state_cb,
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
@@ -1250,6 +1312,42 @@ static void setup_pan(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_hdp(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *hdp;
+
+	if (!setup_base(data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	hdp = data->if_bluetooth->get_profile_interface(BT_PROFILE_HEALTH_ID);
+	if (!hdp) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_hdp = hdp;
+
+	status = data->if_hdp->init(&bthl_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_hdp = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
 static void setup_gatt(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1309,6 +1407,11 @@ static void teardown(const void *test_data)
 		data->if_pan = NULL;
 	}
 
+	if (data->if_hdp) {
+		data->if_hdp->cleanup();
+		data->if_hdp = NULL;
+	}
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -1758,6 +1861,13 @@ static void add_pan_tests(void *data, void *user_data)
 	test(tc, setup_pan, generic_test_function, teardown);
 }
 
+static void add_hdp_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test(tc, setup_hdp, generic_test_function, teardown);
+}
+
 static void add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
@@ -1775,6 +1885,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
 	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
 	queue_foreach(get_pan_tests(), add_pan_tests, NULL);
+	queue_foreach(get_hdp_tests(), add_hdp_tests, NULL);
 	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
 
 	if (tester_run())
diff --git a/android/tester-main.h b/android/tester-main.h
index 5a5cba4..f0ea095 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -47,6 +47,7 @@
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
+#include <hardware/bt_hl.h>
 #include <hardware/bt_gatt.h>
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
@@ -162,6 +163,21 @@
 		.callback_result.remote_role = cb_remote_role, \
 	}
 
+#define CALLBACK_HDP_APP_REG_STATE(cb, cb_app_id, cb_state) { \
+		.callback = cb, \
+		.callback_result.app_id = cb_app_id, \
+		.callback_result.app_state = cb_state, \
+	}
+
+#define CALLBACK_HDP_CHANNEL_STATE(cb, cb_app_id, cb_channel_id, \
+					cb_mdep_cfg_index, cb_state) { \
+		.callback = cb, \
+		.callback_result.app_id = cb_app_id, \
+		.callback_result.channel_id = cb_channel_id, \
+		.callback_result.mdep_cfg_index = cb_mdep_cfg_index, \
+		.callback_result.channel_state = cb_state, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -221,6 +237,10 @@ typedef enum {
 	CB_PAN_CONTROL_STATE,
 	CB_PAN_CONNECTION_STATE,
 
+	/* HDP cb */
+	CB_HDP_APP_REG_STATE,
+	CB_HDP_CHANNEL_STATE,
+
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
 	CB_GATTC_SCAN_RESULT,
@@ -267,6 +287,7 @@ struct test_data {
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
 	const btpan_interface_t *if_pan;
+	const bthl_interface_t *if_hdp;
 	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
@@ -337,6 +358,12 @@ struct bt_callback_data {
 	btpan_connection_state_t conn_state;
 	int local_role;
 	int remote_role;
+
+	int app_id;
+	int channel_id;
+	int mdep_cfg_index;
+	bthl_app_reg_state_t app_state;
+	bthl_channel_state_t channel_state;
 };
 
 /*
@@ -370,6 +397,8 @@ struct queue *get_hidhost_tests(void);
 void remove_hidhost_tests(void);
 struct queue *get_pan_tests(void);
 void remove_pan_tests(void);
+struct queue *get_hdp_tests(void);
+void remove_hdp_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
 
-- 
1.9.1

