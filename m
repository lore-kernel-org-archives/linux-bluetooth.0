Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] android/tester: Add A2DP init - Success test case
Date: Mon, 11 Aug 2014 13:06:26 +0300
Message-Id: <1407751590-6301-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407751590-6301-1-git-send-email-luiz.dentz@gmail.com>
References: <1407751590-6301-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Makefile.am   |  1 +
 android/tester-a2dp.c | 48 +++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  4 ++++
 4 files changed, 109 insertions(+)
 create mode 100644 android/tester-a2dp.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 263a506..4b93c5b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -159,6 +159,7 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/tester-hidhost.c \
 				android/tester-pan.c \
 				android/tester-hdp.c \
+				android/tester-a2dp.c \
 				android/tester-gatt.c \
 				android/tester-main.h android/tester-main.c
 
diff --git a/android/tester-a2dp.c b/android/tester-a2dp.c
new file mode 100644
index 0000000..d2b6516
--- /dev/null
+++ b/android/tester-a2dp.c
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
+static struct queue *list;
+
+static struct test_case test_cases[] = {
+	TEST_CASE_BREDRLE("A2DP Init",
+		ACTION_SUCCESS(dummy_action, NULL),
+	),
+};
+
+struct queue *get_a2dp_tests(void)
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
+void remove_a2dp_tests(void)
+{
+	queue_destroy(list, NULL);
+}
diff --git a/android/tester-main.c b/android/tester-main.c
index 7d17470..6a250a3 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1085,6 +1085,10 @@ static bthl_callbacks_t bthl_callbacks = {
 	.channel_state_cb = hdp_channel_state_cb,
 };
 
+static btav_callbacks_t bta2dp_callbacks = {
+	.size = sizeof(bta2dp_callbacks),
+};
+
 static const btgatt_client_callbacks_t btgatt_client_callbacks = {
 	.register_client_cb = gattc_register_client_cb,
 	.scan_result_cb = gattc_scan_result_cb,
@@ -1356,6 +1360,45 @@ static void setup_hdp(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_a2dp(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const bt_interface_t *if_bt;
+	bt_status_t status;
+	const void *a2dp;
+
+	if (!setup_base(data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	if_bt = data->if_bluetooth;
+
+	status = if_bt->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	a2dp = if_bt->get_profile_interface(BT_PROFILE_ADVANCED_AUDIO_ID);
+	if (!a2dp) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_a2dp = a2dp;
+
+	status = data->if_a2dp->init(&bta2dp_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_a2dp = NULL;
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
@@ -1420,6 +1463,11 @@ static void teardown(const void *test_data)
 		data->if_hdp = NULL;
 	}
 
+	if (data->if_a2dp) {
+		data->if_a2dp->cleanup();
+		data->if_a2dp = NULL;
+	}
+
 	if (data->if_bluetooth) {
 		data->if_bluetooth->cleanup();
 		data->if_bluetooth = NULL;
@@ -1877,6 +1925,13 @@ static void add_hdp_tests(void *data, void *user_data)
 	test(tc, setup_hdp, generic_test_function, teardown);
 }
 
+static void add_a2dp_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test(tc, setup_a2dp, generic_test_function, teardown);
+}
+
 static void add_gatt_tests(void *data, void *user_data)
 {
 	struct test_case *tc = data;
@@ -1895,6 +1950,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
 	queue_foreach(get_pan_tests(), add_pan_tests, NULL);
 	queue_foreach(get_hdp_tests(), add_hdp_tests, NULL);
+	queue_foreach(get_a2dp_tests(), add_a2dp_tests, NULL);
 	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
 
 	if (tester_run())
diff --git a/android/tester-main.h b/android/tester-main.h
index ddca69c..2cefe5c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -49,6 +49,7 @@
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
 #include <hardware/bt_hl.h>
+#include <hardware/bt_av.h>
 #include <hardware/bt_gatt.h>
 #include <hardware/bt_gatt_client.h>
 #include <hardware/bt_gatt_server.h>
@@ -290,6 +291,7 @@ struct test_data {
 	const bthh_interface_t *if_hid;
 	const btpan_interface_t *if_pan;
 	const bthl_interface_t *if_hdp;
+	const btav_interface_t *if_a2dp;
 	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
@@ -401,6 +403,8 @@ struct queue *get_pan_tests(void);
 void remove_pan_tests(void);
 struct queue *get_hdp_tests(void);
 void remove_hdp_tests(void);
+struct queue *get_a2dp_tests(void);
+void remove_a2dp_tests(void);
 struct queue *get_gatt_tests(void);
 void remove_gatt_tests(void);
 
-- 
1.9.3

