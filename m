Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Test Socket Init
Date: Thu, 12 Dec 2013 11:00:20 +0200
Message-Id: <1386838820-12458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

The first test for testing socket init (get socket interface)
---
 android/android-tester.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index a36c10a..b864483 100644
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
@@ -625,6 +628,22 @@ static void setup_enabled_adapter(const void *test_data)
 	data->if_bluetooth->enable();
 }
 
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
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -707,5 +726,8 @@ int main(int argc, char *argv[])
 	test_bredrle("Test Disable - Success", &bluetooth_disable_success_test,
 			setup_enabled_adapter, test_disable, teardown);
 
+	test_bredrle("Test Socket Init", NULL, setup_socket_interface,
+						controller_setup, teardown);
+
 	return tester_run();
 }
-- 
1.8.3.2

