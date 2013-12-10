Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] android/tester: Add stack initialization of stack in setup
Date: Tue, 10 Dec 2013 11:45:42 +0100
Message-Id: <1386672344-13438-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
References: <1386672344-13438-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add stack initialization and cleanup in setup/teardown.
---
 android/Makefile.am      | 10 +++++++--
 android/android-tester.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 2 deletions(-)

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
index 6af7bd4..2df5bdb 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -31,6 +31,9 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#include <hardware/hardware.h>
+#include <hardware/bluetooth.h>
+
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
@@ -41,6 +44,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	void *test_data;
 	pid_t bluetoothd_pid;
+	const bt_interface_t *if_bluetooth;
 };
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -237,13 +241,33 @@ failed:
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
 static void setup(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
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
@@ -278,6 +302,33 @@ static void setup(const void *test_data)
 		return;
 	}
 
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
+
 	tester_setup_complete();
 }
 
@@ -285,6 +336,11 @@ static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->if_bluetooth) {
+		data->if_bluetooth->cleanup();
+		data->if_bluetooth = NULL;
+	}
+
 	if (data->bluetoothd_pid)
 		waitpid(data->bluetoothd_pid, NULL, 0);
 
-- 
1.8.3.1

