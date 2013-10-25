Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal: Associate thread to Java
Date: Fri, 25 Oct 2013 14:34:46 +0300
Message-Id: <1382700886-6289-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Without thread assiciation callbacks are not received by Java.
They are blocked by JNI:
E/BluetoothServiceJni( 2844): Callback env check fail: env: 0x0, callback: 0x0
E/BluetoothServiceJni( 2844): Callback: 'adapter_state_change_callback' is not
called on the correct thread
---
 android/hal-bluetooth.c |   12 ++++++++++++
 android/hal-ipc.c       |    4 ++++
 android/hal.h           |    2 ++
 3 files changed, 18 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index f8ecec5..26f4fd9 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -40,6 +40,18 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+void bt_thread_associate(void)
+{
+	if (bt_hal_cbacks->thread_evt_cb)
+		bt_hal_cbacks->thread_evt_cb(ASSOCIATE_JVM);
+}
+
+void bt_thread_disassociate(void)
+{
+	if (bt_hal_cbacks->thread_evt_cb)
+		bt_hal_cbacks->thread_evt_cb(DISASSOCIATE_JVM);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 20421db..240ac9d 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -67,6 +67,8 @@ static void *notification_handler(void *data)
 	ssize_t ret;
 	int fd;
 
+	bt_thread_associate();
+
 	while (true) {
 		memset(&msg, 0, sizeof(msg));
 		memset(buf, 0, sizeof(buf));
@@ -133,6 +135,8 @@ static void *notification_handler(void *data)
 	close(notif_sk);
 	notif_sk = -1;
 
+	bt_thread_disassociate();
+
 	DBG("exit");
 
 	return NULL;
diff --git a/android/hal.h b/android/hal.h
index ef9a107..5cd5cab 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -27,3 +27,5 @@ btpan_interface_t *bt_get_pan_interface(void);
 btav_interface_t *bt_get_av_interface(void);
 
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len);
+void bt_thread_associate(void);
+void bt_thread_disassociate(void);
-- 
1.7.10.4

