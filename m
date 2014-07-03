Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/19] android/tester-hidhost: Initial hidhost tester
Date: Thu,  3 Jul 2014 18:00:13 +0200
Message-Id: <1404403222-26911-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial patch for android hidhost HAL tester. It'll contain test
cases for hidhost hal.
---
 android/Makefile.am      |  1 +
 android/tester-hidhost.c | 32 ++++++++++++++++++++++++++
 android/tester-main.c    | 59 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h    | 12 ++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 android/tester-hidhost.c

diff --git a/android/Makefile.am b/android/Makefile.am
index e351485..f98facc 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -180,6 +180,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/hardware/hardware.c \
 				android/tester-bluetooth.c \
 				android/tester-socket.c \
+				android/tester-hidhost.c \
 				android/tester-main.h android/tester-main.c
 
 android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/tester-hidhost.c b/android/tester-hidhost.c
new file mode 100644
index 0000000..1df7e7c
--- /dev/null
+++ b/android/tester-hidhost.c
@@ -0,0 +1,32 @@
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
+#include "tester-main.h"
+
+static struct queue *list; /* List of hidhost test cases */
+
+struct queue *get_hidhost_tests(void)
+{
+	list = queue_new();
+
+	return list;
+}
+
+void remove_hidhost_tests(void)
+{
+	queue_destroy(list, NULL);
+}
diff --git a/android/tester-main.c b/android/tester-main.c
index bbf7f2e..3a30d60 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -476,6 +476,16 @@ static bt_callbacks_t bt_callbacks = {
 	.le_test_mode_cb = NULL
 };
 
+static bthh_callbacks_t bthh_callbacks = {
+	.size = sizeof(bthh_callbacks),
+	.connection_state_cb = NULL,
+	.hid_info_cb = NULL,
+	.protocol_mode_cb = NULL,
+	.idle_time_cb = NULL,
+	.get_report_cb = NULL,
+	.virtual_unplug_cb = NULL
+};
+
 static bool setup_base(struct test_data *data)
 {
 	const hw_module_t *module;
@@ -588,6 +598,42 @@ static void setup_socket(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_hidhost(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *hid;
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
+	hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
+	if (!hid) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_hid = hid;
+
+	status = data->if_hid->init(&bthh_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_hid = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -595,6 +641,11 @@ static void teardown(const void *test_data)
 	queue_destroy(data->steps, NULL);
 	data->steps = NULL;
 
+	if (data->if_hid) {
+		data->if_hid->cleanup();
+		data->if_hid = NULL;
+	}
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -690,6 +741,13 @@ static void add_socket_tests(void *data, void *user_data)
 	test_bredrle(tc, setup_socket, generic_test_function, teardown);
 }
 
+static void add_hidhost_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test_bredrle(tc, setup_hidhost, generic_test_function, teardown);
+}
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -698,6 +756,7 @@ int main(int argc, char *argv[])
 
 	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
 	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
+	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
 
 	if (tester_run())
 		return 1;
diff --git a/android/tester-main.h b/android/tester-main.h
index 37b3fd4..9ce19ca 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -45,6 +45,7 @@
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
+#include <hardware/bt_hh.h>
 
 #define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
 
@@ -66,6 +67,14 @@ typedef enum {
 	CB_BT_THREAD_EVT,
 	CB_BT_DUT_MODE_RECV,
 	CB_BT_LE_TEST_MODE,
+
+	/* Hidhost cb */
+	CB_HH_CONNECTION_STATE,
+	CB_HH_HID_INFO,
+	CB_HH_PROTOCOL_MODE,
+	CB_HH_IDLE_TIME,
+	CB_HH_GET_REPORT,
+	CB_HH_VIRTUAL_UNPLUG,
 } expected_bt_callback_t;
 
 struct test_data {
@@ -76,6 +85,7 @@ struct test_data {
 
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
+	const bthh_interface_t *if_hid;
 
 	const void *test_data;
 	struct queue *steps;
@@ -124,6 +134,8 @@ struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
 struct queue *get_socket_tests(void);
 void remove_socket_tests(void);
+struct queue *get_hidhost_tests(void);
+void remove_hidhost_tests(void);
 
 /* Actions */
 void dummy_action(void);
-- 
1.9.3

