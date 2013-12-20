Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix valgrind memory warnings
Date: Fri, 20 Dec 2013 11:00:35 +0200
Message-Id: <1387530035-26542-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1387529782-26462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1387529782-26462-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Free device structure allocated during open_bluetooth().

==26231== 80 bytes in 1 blocks are definitely lost in loss record 25 of
31
==26231==    at 0x4C2A2DB: malloc (in
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==26231==    by 0x40F153: open_bluetooth (hal-bluetooth.c:800)
==26231==    by 0x40C8D8: setup (android-tester.c:835)
==26231==    by 0x40CB20: setup_socket_interface_enabled
(android-tester.c:1166)
==26231==    by 0x409C15: setup_callback (tester.c:373)
==26231==    by 0x4E7C3B5: g_main_context_dispatch (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==26231==    by 0x4E7C707: ??? (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==26231==    by 0x4E7CB09: g_main_loop_run (in
/lib/x86_64-linux-gnu/libglib-2.0.so.0.3800.1)
==26231==    by 0x40A83C: tester_run (tester.c:784)
==26231==    by 0x40362A: main (android-tester.c:1643)
---
 android/android-tester.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 7d7ed88..6007797 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -109,6 +109,7 @@ struct test_data {
 	const void *test_data;
 	pid_t bluetoothd_pid;
 
+	hw_device_t *device;
 	const bt_interface_t *if_bluetooth;
 	const btsock_interface_t *if_sock;
 
@@ -838,6 +839,8 @@ static void setup(struct test_data *data)
 		return;
 	}
 
+	data->device = device;
+
 	data->if_bluetooth = ((bluetooth_device_t *)
 					device)->get_bluetooth_interface();
 	if (!data->if_bluetooth) {
@@ -882,6 +885,9 @@ static void teardown(const void *test_data)
 		data->if_bluetooth = NULL;
 	}
 
+	if (data->device)
+		free(data->device);
+
 	if (data->bluetoothd_pid)
 		waitpid(data->bluetoothd_pid, NULL, 0);
 
-- 
1.8.3.2

