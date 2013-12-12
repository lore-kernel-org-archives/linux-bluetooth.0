Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] android/tester: Add basic Socket Init test
Date: Thu, 12 Dec 2013 12:49:08 +0200
Message-Id: <1386845350-13982-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Test get_socket_interface() and basic setup
---
 android/android-tester.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 7ecc80d..185f57b 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -34,6 +34,7 @@
 
 #include <hardware/hardware.h>
 #include <hardware/bluetooth.h>
+#include <hardware/bt_sock.h>
 
 #define adapter_props adapter_prop_bdaddr, adapter_prop_bdname, \
 			adapter_prop_uuids, adapter_prop_cod, \
@@ -76,7 +77,9 @@ struct test_data {
 	enum hciemu_type hciemu_type;
 	const struct generic_data *test_data;
 	pid_t bluetoothd_pid;
+
 	const bt_interface_t *if_bluetooth;
+	const btsock_interface_t *if_sock;
 
 	bool mgmt_settings_set;
 	bool hal_cb_called;
@@ -677,6 +680,24 @@ static void test_dummy(const void *test_data)
 	tester_test_passed();
 }
 
+/* Test Socket HAL */
+
+static void setup_socket_interface(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	const void *sock;
+
+	setup(data);
+
+	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
+	if (!sock)
+		tester_setup_failed();
+
+	data->if_sock = sock;
+
+	tester_setup_complete();
+}
+
 #define test_bredrle(name, data, test_setup, test, test_teardown) \
 	do { \
 		struct test_data *user; \
@@ -707,5 +728,8 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Disable - Success", &bluetooth_disable_success_test,
 			setup_enabled_adapter, test_disable, teardown);
 
+	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
+						test_dummy, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

