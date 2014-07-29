Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/8] android/tester-ng: Add PAN init test case
Date: Tue, 29 Jul 2014 15:01:26 +0300
Message-Id: <1406635292-30691-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1406635292-30691-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am   |  1 +
 android/tester-main.c | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  8 ++++++
 android/tester-pan.c  | 48 +++++++++++++++++++++++++++++++
 4 files changed, 137 insertions(+)
 create mode 100644 android/tester-pan.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 84a05a8..66cb8c1 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -181,6 +181,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/tester-bluetooth.c \
 				android/tester-socket.c \
 				android/tester-hidhost.c \
+				android/tester-pan.c \
 				android/tester-gatt.c \
 				android/tester-main.h android/tester-main.c
 
diff --git a/android/tester-main.c b/android/tester-main.c
index 91a79ba..5e71809 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -783,6 +783,37 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = NULL
 };
 
+static void pan_control_state_cb(btpan_control_state_t state,
+					bt_status_t error, int local_role,
+							const char *ifname)
+{
+	struct step *step = g_new0(struct step, 1);
+
+	step->callback = CB_PAN_CONTROL_STATE;
+	step->callback_result.state = state;
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
+	step->callback_result.state = state;
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
 	.register_client_cb = NULL,
 	.scan_result_cb = NULL,
@@ -974,6 +1005,42 @@ static void setup_hidhost(const void *test_data)
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
@@ -1028,6 +1095,11 @@ static void teardown(const void *test_data)
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
@@ -1470,6 +1542,13 @@ static void add_hidhost_tests(void *data, void *user_data)
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
@@ -1486,6 +1565,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
 	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
 	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
+	queue_foreach(get_pan_tests(), add_pan_tests, NULL);
 	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
 
 	if (tester_run())
diff --git a/android/tester-main.h b/android/tester-main.h
index e2ecaab..dabccff 100644
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
@@ -154,6 +155,10 @@ typedef enum {
 	CB_HH_GET_REPORT,
 	CB_HH_VIRTUAL_UNPLUG,
 
+	/* PAN cb */
+	CB_PAN_CONTROL_STATE,
+	CB_PAN_CONNECTION_STATE,
+
 	/* Gatt client */
 	CB_GATTC_REGISTER_CLIENT,
 	CB_GATTC_SCAN_RESULT,
@@ -199,6 +204,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btpan_interface_t *if_pan;
 	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
@@ -284,6 +290,8 @@ struct queue *get_socket_tests(void);
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

