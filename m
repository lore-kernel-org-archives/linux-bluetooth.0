Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/tester: Fix valgrind memory warnings
Date: Fri, 20 Dec 2013 11:49:47 +0200
Message-Id: <1387532987-30041-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Make device structure static, fixes valgrind memory leak warnings in
android-tester and haltest.

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
 android/hal-bluetooth.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 7cac15c..738c189 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -797,18 +797,17 @@ static int close_bluetooth(struct hw_device_t *device)
 static int open_bluetooth(const struct hw_module_t *module, char const *name,
 					struct hw_device_t **device)
 {
-	bluetooth_device_t *dev = malloc(sizeof(bluetooth_device_t));
+	static bluetooth_device_t dev;
 
 	DBG("");
 
-	memset(dev, 0, sizeof(bluetooth_device_t));
-	dev->common.tag = HARDWARE_DEVICE_TAG;
-	dev->common.version = 0;
-	dev->common.module = (struct hw_module_t *) module;
-	dev->common.close = close_bluetooth;
-	dev->get_bluetooth_interface = get_bluetooth_interface;
+	dev.common.tag = HARDWARE_DEVICE_TAG;
+	dev.common.version = 0;
+	dev.common.module = (struct hw_module_t *) module;
+	dev.common.close = close_bluetooth;
+	dev.get_bluetooth_interface = get_bluetooth_interface;
 
-	*device = (struct hw_device_t *) dev;
+	*device = (struct hw_device_t *) &dev;
 
 	return 0;
 }
-- 
1.8.3.2

