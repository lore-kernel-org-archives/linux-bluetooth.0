Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/15] android/tester-ng: Add initial socket test case
Date: Fri,  9 May 2014 16:42:40 +0200
Message-Id: <1399646568-20742-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1399646568-20742-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester-ng.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/android/android-tester-ng.c b/android/android-tester-ng.c
index 95a38f6..c296ad9 100644
--- a/android/android-tester-ng.c
+++ b/android/android-tester-ng.c
@@ -38,6 +38,7 @@
 
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
 
 /*
  * NOTICE:
@@ -99,6 +100,7 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 
 	const bt_interface_t *if_bluetooth;
+	const btsock_interface_t *if_sock;
 
 	const void *test_data;
 	struct queue *steps;
@@ -662,6 +664,35 @@ static void setup(const void *test_data)
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
@@ -837,5 +868,8 @@ int main(int argc, char *argv[])
 					bluetooth_disable_success_steps, setup,
 					generic_test_function, teardown);
 
+	test_bredrle("Socket Init", dummy_steps, setup_socket,
+					generic_test_function, teardown);
+
 	return tester_run();
 }
-- 
1.9.2

