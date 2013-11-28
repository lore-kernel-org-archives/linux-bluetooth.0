Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 4/6] android: Add stack initialization of stack in setup
Date: Thu, 28 Nov 2013 10:34:54 +0100
Message-Id: <1385631296-2856-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Marcin Kraglak <marcin.kraglak@tieto.com>

This add stack initialization and cleanup in setup/teardown.

Change-Id: I05c622b8e42a5d604e276d0a77d41c9bc7a6045e
---
 android/Makefile.am      |  8 ++++--
 android/android-tester.c | 69 +++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/android/Makefile.am b/android/Makefile.am
index b19ab4e..e71857e 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -90,9 +90,13 @@ android_android_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
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
 
 android_android_tester_LDFLAGS = -pthread
 
diff --git a/android/android-tester.c b/android/android-tester.c
index 16e8ec0..5e5afe0 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -32,6 +32,9 @@
 #include "src/shared/mgmt.h"
 #include "src/shared/hciemu.h"
 
+#include <hardware/hardware.h>
+#include <hardware/bluetooth.h>
+
 #define WAIT_FOR_CONDITION_TIME 2 /* in seconds */
 
 static pthread_cond_t emulator_cond = PTHREAD_COND_INITIALIZER;
@@ -44,6 +47,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	void *test_data;
 	pthread_t emulator_thread;
+	const bt_interface_t *if_bluetooth;
 };
 
 static void read_info_callback(uint8_t status, uint16_t length,
@@ -253,10 +257,30 @@ static void *emulator(void *user_data)
 	return NULL;
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
 	struct timespec ts;
+	int err;
 
 	clock_gettime(CLOCK_REALTIME, &ts);
 	ts.tv_sec += WAIT_FOR_CONDITION_TIME;
@@ -269,19 +293,56 @@ static void setup(const void *test_data)
 	}
 
 	if (pthread_cond_timedwait(&emulator_cond, &emulator_mutex,
-								&ts))
+								&ts)) {
 		tester_setup_failed();
-	else
-		tester_setup_complete();
+		pthread_mutex_unlock(&emulator_mutex);
+		return;
+	}
 
 	pthread_mutex_unlock(&emulator_mutex);
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
+	tester_setup_complete();
 }
 
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
-	pthread_join(data->emulator_thread, NULL);
+	if (data->if_bluetooth) {
+		data->if_bluetooth->cleanup();
+		data->if_bluetooth = NULL;
+	}
+
+	if (data->emulator_thread) {
+		pthread_join(data->emulator_thread, NULL);
+		data->emulator_thread = 0;
+	}
+
 	tester_teardown_complete();
 }
 
-- 
1.8.4.2

