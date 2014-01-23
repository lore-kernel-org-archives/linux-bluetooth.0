Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/4] android/tester: Fix crash on failure inside setup()
Date: Thu, 23 Jan 2014 17:24:38 -0400
Message-Id: <1390512281-26541-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The various setup_* functions were still continuing even though setup()
failed and did not initialize data->if_bluetooth properly.

Also do a little refactoring by moving tester_setup_failed() calls to
the setup() callers, so they stay close to the other failure points and
not hidden deep into a helper function.

Crash detected by Valgrind:

==4959== Invalid read of size 4
==4959==    at 0x805967A: setup_base (android-tester.c:2029)
==4959==    by 0x8055541: setup_callback (tester.c:373)
==4959==    by 0x408348F: g_idle_dispatch (gmain.c:5250)
==4959==    by 0x4086A75: g_main_context_dispatch (gmain.c:3065)
==4959==    by 0x4086E14: g_main_context_iterate.isra.23 (gmain.c:3712)
==4959==    by 0x40872FA: g_main_loop_run (gmain.c:3906)
==4959==    by 0x41744D2: (below main) (libc-start.c:226)
==4959==  Address 0x4 is not stack'd, malloc'd or (recently) free'd
---
 android/android-tester.c |   85 +++++++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 39 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index aa953bf..e4f95ce 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1951,8 +1951,7 @@ static bt_callbacks_t bt_callbacks = {
 	.le_test_mode_cb = NULL
 };
 
-
-static void setup(struct test_data *data)
+static bool setup(struct test_data *data)
 {
 	const hw_module_t *module;
 	hw_device_t *device;
@@ -1962,18 +1961,15 @@ static void setup(struct test_data *data)
 	int len;
 	int err;
 
-	if (pipe(signal_fd)) {
-		tester_setup_failed();
-		return;
-	}
+	if (pipe(signal_fd))
+		return false;
 
 	pid = fork();
 
 	if (pid < 0) {
 		close(signal_fd[0]);
 		close(signal_fd[1]);
-		tester_setup_failed();
-		return;
+		return false;
 	}
 
 	if (pid == 0) {
@@ -1991,32 +1987,27 @@ static void setup(struct test_data *data)
 	len = read(signal_fd[0], buf, sizeof(buf));
 	if (len <= 0 || (strcmp(buf, EMULATOR_SIGNAL))) {
 		close(signal_fd[0]);
-		tester_setup_failed();
-		return;
+		return false;
 	}
 
 	close(signal_fd[0]);
 
 	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
-	if (err) {
-		tester_setup_failed();
-		return;
-	}
+	if (err)
+		return false;
 
 	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &device);
-	if (err) {
-		tester_setup_failed();
-		return;
-	}
+	if (err)
+		return false;
 
 	data->device = device;
 
 	data->if_bluetooth = ((bluetooth_device_t *)
 					device)->get_bluetooth_interface();
-	if (!data->if_bluetooth) {
-		tester_setup_failed();
-		return;
-	}
+	if (!data->if_bluetooth)
+		return false;
+
+	return true;
 }
 
 static void setup_base(const void *test_data)
@@ -2024,7 +2015,10 @@ static void setup_base(const void *test_data)
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 
-	setup(data);
+	if (!setup(data)) {
+		tester_setup_failed();
+		return;
+	}
 
 	status = data->if_bluetooth->init(&bt_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
@@ -2040,7 +2034,10 @@ static void setup_enabled_adapter(const void *test_data)
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 
-	setup(data);
+	if (!setup(data)) {
+		tester_setup_failed();
+		return;
+	}
 
 	status = data->if_bluetooth->init(&bt_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
@@ -2786,7 +2783,10 @@ static void setup_socket_interface(const void *test_data)
 	bt_status_t status;
 	const void *sock;
 
-	setup(data);
+	if (!setup(data)) {
+		tester_setup_failed();
+		return;
+	}
 
 	status = data->if_bluetooth->init(&bt_socket_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
@@ -2812,7 +2812,10 @@ static void setup_socket_interface_enabled(const void *test_data)
 	bt_status_t status;
 	const void *sock;
 
-	setup(data);
+	if (!setup(data)) {
+		tester_setup_failed();
+		return;
+	}
 
 	status = data->if_bluetooth->init(&bt_socket_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
@@ -3158,41 +3161,42 @@ static bthh_callbacks_t bthh_callbacks = {
 	.virtual_unplug_cb = hidhost_virual_unplug_cb
 };
 
-static void setup_hidhost(const void *test_data)
+static bool setup_hidhost(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 	bt_status_t status;
 	const void *hid;
 
-	setup(data);
+	if (!setup(data))
+		return false;
 
 	status = data->if_bluetooth->init(&bt_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_bluetooth = NULL;
-		tester_setup_failed();
-		return;
+		return false;
 	}
 
 	hid = data->if_bluetooth->get_profile_interface(BT_PROFILE_HIDHOST_ID);
-	if (!hid) {
-		tester_setup_failed();
-		return;
-	}
+	if (!hid)
+		return false;
 
 	data->if_hid = hid;
 
 	status = data->if_hid->init(&bthh_callbacks);
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_hid = NULL;
-		tester_setup_failed();
-		return;
+		return false;
 	}
+
+	return true;
 }
 
 static void setup_hidhost_interface(const void *test_data)
 {
-	setup_hidhost(test_data);
-	tester_setup_complete();
+	if (setup_hidhost(test_data))
+		tester_setup_complete();
+	else
+		tester_setup_failed();
 }
 
 #define HID_GET_REPORT_PROTOCOL		0x60
@@ -3437,7 +3441,10 @@ static void setup_hidhost_connect(const void *test_data)
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost;
 
-	setup_hidhost(test_data);
+	if (!setup_hidhost(test_data)) {
+		tester_setup_failed();
+		return;
+	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
 
-- 
1.7.9.5

