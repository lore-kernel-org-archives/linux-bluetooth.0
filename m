Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 12/19] android/tester-gatt: Initial gatt tester
Date: Thu,  3 Jul 2014 18:00:15 +0200
Message-Id: <1404403222-26911-13-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>

This is initial patch for android gatt HAL tester. It'll contain test
cases for gatt hal.
---
 android/Makefile.am   |  1 +
 android/tester-gatt.c | 32 ++++++++++++++++++
 android/tester-main.c | 93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h | 41 +++++++++++++++++++++++
 4 files changed, 167 insertions(+)
 create mode 100644 android/tester-gatt.c

diff --git a/android/Makefile.am b/android/Makefile.am
index f98facc..8b2ec5b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -181,6 +181,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
 				android/tester-bluetooth.c \
 				android/tester-socket.c \
 				android/tester-hidhost.c \
+				android/tester-gatt.c \
 				android/tester-main.h android/tester-main.c
 
 android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/tester-gatt.c b/android/tester-gatt.c
new file mode 100644
index 0000000..b16a844
--- /dev/null
+++ b/android/tester-gatt.c
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
+static struct queue *list; /* List of gatt test cases */
+
+struct queue *get_gatt_tests(void)
+{
+	list = queue_new();
+
+	return list;
+}
+
+void remove_gatt_tests(void)
+{
+	queue_destroy(list, NULL);
+}
diff --git a/android/tester-main.c b/android/tester-main.c
index 3a30d60..6a20eb8 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -486,6 +486,49 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = NULL
 };
 
+static const btgatt_client_callbacks_t btgatt_client_callbacks = {
+	.register_client_cb = NULL,
+	.scan_result_cb = NULL,
+	.open_cb = NULL,
+	.close_cb = NULL,
+	.search_complete_cb = NULL,
+	.search_result_cb = NULL,
+	.get_characteristic_cb = NULL,
+	.get_descriptor_cb = NULL,
+	.get_included_service_cb = NULL,
+	.register_for_notification_cb = NULL,
+	.notify_cb = NULL,
+	.read_characteristic_cb = NULL,
+	.write_characteristic_cb = NULL,
+	.read_descriptor_cb = NULL,
+	.write_descriptor_cb = NULL,
+	.execute_write_cb = NULL,
+	.read_remote_rssi_cb = NULL,
+	.listen_cb = NULL
+};
+
+static const btgatt_server_callbacks_t btgatt_server_callbacks = {
+	.register_server_cb = NULL,
+	.connection_cb = NULL,
+	.service_added_cb = NULL,
+	.included_service_added_cb = NULL,
+	.characteristic_added_cb = NULL,
+	.descriptor_added_cb = NULL,
+	.service_started_cb = NULL,
+	.service_stopped_cb = NULL,
+	.service_deleted_cb = NULL,
+	.request_read_cb = NULL,
+	.request_write_cb = NULL,
+	.request_exec_write_cb = NULL,
+	.response_confirmation_cb = NULL
+};
+
+static const btgatt_callbacks_t btgatt_callbacks = {
+	.size = sizeof(btgatt_callbacks),
+	.client = &btgatt_client_callbacks,
+	.server = &btgatt_server_callbacks
+};
+
 static bool setup_base(struct test_data *data)
 {
 	const hw_module_t *module;
@@ -634,6 +677,43 @@ static void setup_hidhost(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_gatt(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *gatt;
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
+	gatt = data->if_bluetooth->get_profile_interface(BT_PROFILE_GATT_ID);
+	if (!gatt) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_gatt = gatt;
+
+	status = data->if_gatt->init(&btgatt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_gatt = NULL;
+
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
@@ -641,6 +721,11 @@ static void teardown(const void *test_data)
 	queue_destroy(data->steps, NULL);
 	data->steps = NULL;
 
+	if (data->if_gatt) {
+		data->if_gatt->cleanup();
+		data->if_gatt = NULL;
+	}
+
 	if (data->if_hid) {
 		data->if_hid->cleanup();
 		data->if_hid = NULL;
@@ -748,6 +833,13 @@ static void add_hidhost_tests(void *data, void *user_data)
 	test_bredrle(tc, setup_hidhost, generic_test_function, teardown);
 }
 
+static void add_gatt_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test_bredrle(tc, setup_gatt, generic_test_function, teardown);
+}
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -757,6 +849,7 @@ int main(int argc, char *argv[])
 	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
 	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
 	queue_foreach(get_hidhost_tests(), add_hidhost_tests, NULL);
+	queue_foreach(get_gatt_tests(), add_gatt_tests, NULL);
 
 	if (tester_run())
 		return 1;
diff --git a/android/tester-main.h b/android/tester-main.h
index 9ce19ca..2157d8a 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -46,6 +46,9 @@
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
+#include <hardware/bt_gatt.h>
+#include <hardware/bt_gatt_client.h>
+#include <hardware/bt_gatt_server.h>
 
 #define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
 
@@ -75,6 +78,41 @@ typedef enum {
 	CB_HH_IDLE_TIME,
 	CB_HH_GET_REPORT,
 	CB_HH_VIRTUAL_UNPLUG,
+
+	/* Gatt client */
+	CB_GATTC_REGISTER_CLIENT,
+	CB_GATTC_SCAN_RESULT,
+	CB_GATTC_OPEN,
+	CB_GATTC_CLOSE,
+	CB_GATTC_SEARCH_COMPLETE,
+	CB_GATTC_SEARCH_RESULT,
+	CB_GATTC_GET_CHARACTERISTIC,
+	CB_GATTC_GET_DESCRIPTOR,
+	CB_GATTC_GET_INCLUDED_SERVICE,
+	CB_GATTC_REGISTER_FOR_NOTIFICATION,
+	CB_GATTC_NOTIFY,
+	CB_GATTC_READ_CHARACTERISTIC,
+	CB_GATTC_WRITE_CHARACTERISTIC,
+	CB_GATTC_READ_DESCRIPTOR,
+	CB_GATTC_WRITE_DESCRIPTOR,
+	CB_GATTC_EXECUTE_WRITE,
+	CB_GATTC_READ_REMOTE_RSSI,
+	CB_GATTC_LISTEN,
+
+	/* Gatt server */
+	CB_GATTS_REGISTER_SERVER,
+	CB_GATTS_CONNECTION,
+	CB_GATTS_SERVICE_ADDED,
+	CB_GATTS_INCLUDED_SERVICE_ADDED,
+	CB_GATTS_CHARACTERISTIC_ADDED,
+	CB_GATTS_DESCRIPTOR_ADDED,
+	CB_GATTS_SERVICE_STARTED,
+	CB_GATTS_SERVICE_STOPPED,
+	CB_GATTS_SERVICE_DELETED,
+	CB_GATTS_REQUEST_READ,
+	CB_GATTS_REQUEST_WRITE,
+	CB_GATTS_REQUEST_EXEC_WRITE,
+	CB_GATTS_RESPONSE_CONFIRMATION,
 } expected_bt_callback_t;
 
 struct test_data {
@@ -86,6 +124,7 @@ struct test_data {
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 	const bthh_interface_t *if_hid;
+	const btgatt_interface_t *if_gatt;
 
 	const void *test_data;
 	struct queue *steps;
@@ -136,6 +175,8 @@ struct queue *get_socket_tests(void);
 void remove_socket_tests(void);
 struct queue *get_hidhost_tests(void);
 void remove_hidhost_tests(void);
+struct queue *get_gatt_tests(void);
+void remove_gatt_tests(void);
 
 /* Actions */
 void dummy_action(void);
-- 
1.9.3

