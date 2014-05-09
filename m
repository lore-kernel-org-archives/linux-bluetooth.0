Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 08/15] android/tester-ng: Add initial hid test case
Date: Fri,  9 May 2014 16:42:41 +0200
Message-Id: <1399646568-20742-8-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester-ng.c | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index c296ad9..57c93da 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -39,6 +39,7 @@
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
+#include <hardware/bt_hh.h>
 
 /*
  * NOTICE:
@@ -101,6 +102,7 @@ struct test_data {
 
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
+	const bthh_interface_t *if_hid;
 
 	const void *test_data;
 	struct queue *steps;
@@ -581,6 +583,16 @@ static bt_callbacks_t bt_callbacks = {
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
@@ -693,6 +705,42 @@ static void setup_socket(const void *test_data)
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
@@ -700,6 +748,11 @@ static void teardown(const void *test_data)
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
@@ -871,5 +924,8 @@ int main(int argc, char *argv[])
 	test_bredrle("Socket Init", dummy_steps, setup_socket,
 					generic_test_function, teardown);
 
+	test_bredrle("HIDHost Init", dummy_steps, setup_hidhost,
+					generic_test_function, teardown);
+
 	return tester_run();
 }
-- 
1.9.2

