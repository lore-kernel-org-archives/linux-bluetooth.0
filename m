Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/19] android/tester-socket: Initial socket tester
Date: Thu,  3 Jul 2014 18:00:11 +0200
Message-Id: <1404403222-26911-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is initial patch for android socket HAL tester. It'll contain test
cases for socket hal.
---
 android/Makefile.am     |  1 +
 android/tester-main.c   | 38 ++++++++++++++++++++++++++++++++++++++
 android/tester-main.h   |  4 ++++
 android/tester-socket.c | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 75 insertions(+)
 create mode 100644 android/tester-socket.c

diff --git a/android/Makefile.am b/android/Makefile.am
index 8cb10ab..e351485 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -179,6 +179,7 @@ android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
 				monitor/rfcomm.h \
 				android/hardware/hardware.c \
 				android/tester-bluetooth.c \
+				android/tester-socket.c \
 				android/tester-main.h android/tester-main.c
 
 android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
diff --git a/android/tester-main.c b/android/tester-main.c
index 326853a..bbf7f2e 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -559,6 +559,35 @@ static void setup(const void *test_data)
 	tester_setup_complete();
 }
 
+static void setup_socket(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+	const void *sock;
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
+	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
+	if (!sock) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_sock = sock;
+
+	tester_setup_complete();
+}
+
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -644,6 +673,7 @@ static void generic_test_function(const void *test_data)
 static void tester_testcases_cleanup(void)
 {
 	remove_bluetooth_tests();
+	remove_socket_tests();
 }
 
 static void add_bluetooth_tests(void *data, void *user_data)
@@ -653,6 +683,13 @@ static void add_bluetooth_tests(void *data, void *user_data)
 	test_bredrle(tc, setup, generic_test_function, teardown);
 }
 
+static void add_socket_tests(void *data, void *user_data)
+{
+	struct test_case *tc = data;
+
+	test_bredrle(tc, setup_socket, generic_test_function, teardown);
+}
+
 int main(int argc, char *argv[])
 {
 	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
@@ -660,6 +697,7 @@ int main(int argc, char *argv[])
 	tester_init(&argc, &argv);
 
 	queue_foreach(get_bluetooth_tests(), add_bluetooth_tests, NULL);
+	queue_foreach(get_socket_tests(), add_socket_tests, NULL);
 
 	if (tester_run())
 		return 1;
diff --git a/android/tester-main.h b/android/tester-main.h
index 6ea9603..37b3fd4 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -44,6 +44,7 @@
 
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
 
 #define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
 
@@ -74,6 +75,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 
 	const bt_interface_t *if_bluetooth;
+	const btsock_interface_t *if_sock;
 
 	const void *test_data;
 	struct queue *steps;
@@ -120,6 +122,8 @@ struct step {
 /* Get, remove test cases API */
 struct queue *get_bluetooth_tests(void);
 void remove_bluetooth_tests(void);
+struct queue *get_socket_tests(void);
+void remove_socket_tests(void);
 
 /* Actions */
 void dummy_action(void);
diff --git a/android/tester-socket.c b/android/tester-socket.c
new file mode 100644
index 0000000..4b06b15
--- /dev/null
+++ b/android/tester-socket.c
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
+static struct queue *list; /* List of socket test cases */
+
+struct queue *get_socket_tests(void)
+{
+	list = queue_new();
+
+	return list;
+}
+
+void remove_socket_tests(void)
+{
+	queue_destroy(list, NULL);
+}
-- 
1.9.3

