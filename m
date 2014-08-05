Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/8] android/tester: Add PAN init test case
Date: Tue,  5 Aug 2014 14:19:07 +0300
Message-Id: <1407237554-5079-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1407237554-5079-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am   |   1 +
 android/tester-main.c | 109 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  29 ++++++++++++++
 android/tester-pan.c  |  48 ++++++++++++++++++++++
 4 files changed, 187 insertions(+)
 create mode 100644 android/tester-pan.c

diff --git a/android/Makefile.am b/android/Makefile.am
index a3067bb..79f6a0d 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -157,6 +157,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/tester-bluetooth.c \
 				android/tester-socket.c \
 				android/tester-hidhost.c \
+				android/tester-pan.c \
 				android/tester-gatt.c \
 				android/tester-main.h android/tester-main.c
 
diff --git a/android/tester-main.c b/android/tester-main.c
index ba1ae9f..203a1b6 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -443,6 +443,30 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
+		if (exp->callback_result.ctrl_state !=
+					step->callback_result.ctrl_state) {
+			tester_debug("Callback ctrl state don't match");
+			return false;
+		}
+
+		if (exp->callback_result.conn_state !=
+					step->callback_result.conn_state) {
+			tester_debug("Callback connection state don't match");
+			return false;
+		}
+
+		if (exp->callback_result.local_role !=
+					step->callback_result.local_role) {
+			tester_debug("Callback local_role don't match");
+			return false;
+		}
+
+		if (exp->callback_result.remote_role !=
+					step->callback_result.remote_role) {
+			tester_debug("Callback remote_role don't match");
+			return false;
+		}
+
 		if (exp->callback_result.pairing_variant !=
 					step->callback_result.pairing_variant) {
 			tester_debug("Callback pairing result don't match");
@@ -963,6 +987,42 @@ static void gattc_listen_cb(int status, int server_if)
 	schedule_callback_call(step);
 }
 
+static void pan_control_state_cb(btpan_control_state_t state,
+					bt_status_t error, int local_role,
+							const char *ifname)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_PAN_CONTROL_STATE;
+	step->callback_result.state = local_role;
+	step->callback_result.ctrl_state = error;
+	step->callback_result.local_role = state;
+
+	schedule_callback_call(step);
+}
+
+static void pan_connection_state_cb(btpan_connection_state_t state,
+					bt_status_t error,
+					const bt_bdaddr_t *bd_addr,
+					int local_role, int remote_role)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_PAN_CONNECTION_STATE;
+	step->callback_result.state = error;
+	step->callback_result.conn_state = state;
+	step->callback_result.local_role = local_role;
+	step->callback_result.remote_role = remote_role;
+
+	schedule_callback_call(step);
+}
+
+static btpan_callbacks_t btpan_callbacks = {
+	.size = sizeof(btpan_callbacks),
+	.control_state_cb = pan_control_state_cb,
+	.connection_state_cb = pan_connection_state_cb,
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
@@ -1154,6 +1214,42 @@ static void setup_hidhost(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_pan(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *pan;
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
+	pan = data->if_bluetooth->get_profile_interface(BT_PROFILE_PAN_ID);
+	if (!pan) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_pan = pan;
+
+	status = data->if_pan->init(&btpan_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_pan = NULL;
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
@@ -1208,6 +1304,11 @@ static void teardown(const void *test_data)
 		data->if_hid = NULL;
 	}
 
+	if (data->if_pan) {
+		data->if_pan->cleanup();
+		data->if_pan = NULL;
+	}
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -1650,6 +1751,13 @@ static void add_hidhost_tests(void *data, void *user_data)
 	test(tc, setup_hidhost, generic_test_function, teardown);
 }
 
+static void add_pan_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test(tc, setup_pan, generic_test_function, teardown);
+}
+
 static void add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
@@ -1666,6 +1774,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
 	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
 	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
+	queue_foreach(get_pan_tests(), add_pan_tests, NULL);
 	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
 
 	if (tester_run())
diff --git a/android/tester-main.h b/android/tester-main.h
index 778bdc4..5a5cba4 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -46,6 +46,7 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_pan.h>
 #include <hardware/bt_gatt.h>
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
@@ -145,6 +146,22 @@
 		.callback_result.client_id = cb_client_id, \
 	}
 
+#define CALLBACK_PAN_CTRL_STATE(cb, cb_res, cb_state, cb_local_role) { \
+		.callback = cb, \
+		.callback_result.status = cb_res, \
+		.callback_result.ctrl_state = cb_state, \
+		.callback_result.local_role = cb_local_role, \
+	}
+
+#define CALLBACK_PAN_CONN_STATE(cb, cb_res, cb_state, cb_local_role, \
+							cb_remote_role) { \
+		.callback = cb, \
+		.callback_result.status = cb_res, \
+		.callback_result.conn_state = cb_state, \
+		.callback_result.local_role = cb_local_role, \
+		.callback_result.remote_role = cb_remote_role, \
+	}
+
 #define CALLBACK_DEVICE_PROPS(props, prop_cnt) \
 	CALLBACK_PROPS(CB_BT_REMOTE_DEVICE_PROPERTIES, props, prop_cnt)
 
@@ -200,6 +217,10 @@ typedef enum {
 	CB_HH_GET_REPORT,
 	CB_HH_VIRTUAL_UNPLUG,
 
+	/* PAN cb */
+	CB_PAN_CONTROL_STATE,
+	CB_PAN_CONNECTION_STATE,
+
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
 	CB_GATTC_SCAN_RESULT,
@@ -245,6 +266,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btpan_interface_t *if_pan;
 	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
@@ -310,6 +332,11 @@ struct bt_callback_data {
 
 	int client_id;
 	int conn_id;
+
+	btpan_control_state_t ctrl_state;
+	btpan_connection_state_t conn_state;
+	int local_role;
+	int remote_role;
 };
 
 /*
@@ -341,6 +368,8 @@ struct queue *get_socket_tests(void);
 void remove_socket_tests(void);
 struct queue *get_hidhost_tests(void);
 void remove_hidhost_tests(void);
+struct queue *get_pan_tests(void);
+void remove_pan_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
 
diff --git a/android/tester-pan.c b/android/tester-pan.c
new file mode 100644
index 0000000..caead9c
--- /dev/null
+++ b/android/tester-pan.c
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
+static struct queue *list; /* List of pan test cases */
+
+static struct test_case test_cases[] = {
+	TEST_CASE_BREDRLE("PAN Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
+};
+
+struct queue *get_pan_tests(void)
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
+void remove_pan_tests(void)
+{
+	queue_destroy(list, NULL);
+}
-- 
1.9.1

