Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 4/7] android/tester: Add stack initialization of stack in setup
Date: Tue, 10 Dec 2013 15:00:48 +0100
Message-Id: <1386684051-31748-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386684051-31748-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386684051-31748-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add stack initialization and cleanup in setup/teardown.
---
 android/Makefile.am      | 10 ++++++--
 android/android-tester.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+), 2 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index 5364c2e..f3e77c3 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -91,9 +91,15 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				src/shared/hciemu.h src/shared/hciemu.c \
 				src/shared/tester.h src/shared/tester.c \
-				android/android-tester.c
+				android/hal-utils.h android/hal-utils.c \
+				android/client/hwmodule.c android/android-tester.c
 
-android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+android_android_tester_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android
+
+android_android_tester_LDADD = lib/libbluetooth-internal.la \
+				android/libhal-internal.la @GLIB_LIBS@
+
+android_android_tester_LDFLAGS = -pthread
 
 endif
 
diff --git a/android/android-tester.c b/android/android-tester.c
index 301b96a..ace7427 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -31,6 +31,12 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#include <hardware/hardware.h>
+#include <hardware/bluetooth.h>
+
+#define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
+#define EMULATOR_SIGNAL "emulator_started"
+
 struct generic_data {
 };
 
@@ -44,6 +50,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	const struct generic_data *test_data;
 	pid_t bluetoothd_pid;
+	const bt_interface_t *if_bluetooth;
 };
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -240,12 +247,32 @@ failed:
 	close(fd);
 }
 
+static bt_callbacks_t bt_callbacks = {
+	.size = sizeof(bt_callbacks),
+	.adapter_state_changed_cb = NULL,
+	.adapter_properties_cb = NULL,
+	.remote_device_properties_cb = NULL,
+	.device_found_cb = NULL,
+	.discovery_state_changed_cb = NULL,
+	.pin_request_cb = NULL,
+	.ssp_request_cb = NULL,
+	.bond_state_changed_cb = NULL,
+	.acl_state_changed_cb = NULL,
+	.thread_evt_cb = NULL,
+	.dut_mode_recv_cb = NULL,
+	.le_test_mode_cb = NULL
+};
+
 static void setup(struct test_data *data)
 {
+	const hw_module_t *module;
+	hw_device_t *device;
+	bt_status_t status;
 	int signal_fd[2];
 	char buf[1024];
 	pid_t pid;
 	int len;
+	int err;
 
 	if (pipe(signal_fd)) {
 		tester_setup_failed();
@@ -279,6 +306,33 @@ static void setup(struct test_data *data)
 		tester_setup_failed();
 		return;
 	}
+
+	close(signal_fd[0]);
+
+	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
+	if (err) {
+		tester_setup_failed();
+		return;
+	}
+
+	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &device);
+	if (err) {
+		tester_setup_failed();
+		return;
+	}
+
+	data->if_bluetooth = ((bluetooth_device_t *)
+					device)->get_bluetooth_interface();
+	if (!data->if_bluetooth) {
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+	}
 }
 
 static void setup_base(const void *test_data)
@@ -294,6 +348,11 @@ static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->if_bluetooth) {
+		data->if_bluetooth->cleanup();
+		data->if_bluetooth = NULL;
+	}
+
 	if (data->bluetoothd_pid)
 		waitpid(data->bluetoothd_pid, NULL, 0);
 
@@ -302,6 +361,7 @@ static void teardown(const void *test_data)
 
 static void controller_setup(const void *test_data)
 {
+	tester_test_passed();
 }
 
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
-- 
1.8.3.1

