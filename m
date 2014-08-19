Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 03/11] android/hal-ipc: Allow to set custom thread and disconnect callbacks
Date: Tue, 19 Aug 2014 21:51:04 +0200
Message-Id: <1408477872-24160-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
References: <1408477872-24160-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 23 ++++++++++++++++-------
 android/hal-ipc.c       | 37 ++++++++++++++++++++++++++++++-------
 android/hal-ipc.h       |  7 +++++++
 android/hal.h           |  3 ---
 4 files changed, 53 insertions(+), 17 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 44eddbd..34d115d 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -253,15 +253,14 @@ static void handle_ssp_request(void *buf, uint16_t len, int fd)
 							ev->passkey);
 }
 
-void bt_thread_associate(void)
+static void thread_cb(bool associate)
 {
-	if (bt_hal_cbacks->thread_evt_cb)
-		bt_hal_cbacks->thread_evt_cb(ASSOCIATE_JVM);
-}
+	if (!bt_hal_cbacks->thread_evt_cb)
+		return;
 
-void bt_thread_disassociate(void)
-{
-	if (bt_hal_cbacks->thread_evt_cb)
+	if (associate)
+		bt_hal_cbacks->thread_evt_cb(ASSOCIATE_JVM);
+	else
 		bt_hal_cbacks->thread_evt_cb(DISASSOCIATE_JVM);
 }
 
@@ -405,6 +404,13 @@ static uint8_t get_mode(void)
 	return HAL_MODE_DEFAULT;
 }
 
+static void disconnect_cb(void *data)
+{
+	/* TODO */
+
+	exit(EXIT_FAILURE);
+}
+
 static int init(bt_callbacks_t *callbacks)
 {
 	struct hal_cmd_register_module cmd;
@@ -421,6 +427,9 @@ static int init(bt_callbacks_t *callbacks)
 	if (!hal_ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH)))
 		return BT_STATUS_FAIL;
 
+	hal_ipc_set_thread_cb(thread_cb);
+	hal_ipc_set_disconnect_cb(disconnect_cb, NULL);
+
 	bt_hal_cbacks = callbacks;
 
 	/* Start Android Bluetooth daemon service */
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 4f51c36..7aef971 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -25,9 +25,6 @@
 #include <stdint.h>
 #include <stdlib.h>
 
-#include <cutils/properties.h>
-
-#include "hal.h"
 #include "hal-msg.h"
 #include "hal-log.h"
 #include "ipc-common.h"
@@ -43,6 +40,11 @@ static pthread_mutex_t ipc_mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static pthread_t notif_th = 0;
 
+static hal_ipc_disconnect_t disconnect_cb = NULL;
+static void *disconnect_cb_data = NULL;
+
+static hal_ipc_thread_t thread_cb = NULL;
+
 struct service_handler {
 	const struct hal_ipc_handler *handler;
 	uint8_t size;
@@ -138,7 +140,8 @@ static void *notification_handler(void *data)
 	ssize_t ret;
 	int fd;
 
-	bt_thread_associate();
+	if (thread_cb)
+		thread_cb(true);
 
 	while (true) {
 		memset(&msg, 0, sizeof(msg));
@@ -199,12 +202,17 @@ static void *notification_handler(void *data)
 	notif_sk = -1;
 	pthread_mutex_unlock(&ipc_mutex);
 
-	bt_thread_disassociate();
+	if (thread_cb)
+		thread_cb(false);
 
 	DBG("exit");
 
-	if (failed)
-		exit(EXIT_FAILURE);
+	if (failed) {
+		if (disconnect_cb)
+			disconnect_cb(disconnect_cb_data);
+		else
+			exit(EXIT_FAILURE);
+	}
 
 	return NULL;
 }
@@ -347,6 +355,17 @@ bool hal_ipc_init(const char *path, size_t size)
 	return true;
 }
 
+void hal_ipc_set_disconnect_cb(hal_ipc_disconnect_t cb, void *data)
+{
+	disconnect_cb = cb;
+	disconnect_cb_data = data;
+}
+
+void hal_ipc_set_thread_cb(hal_ipc_thread_t cb)
+{
+	thread_cb = cb;
+}
+
 void hal_ipc_cleanup(void)
 {
 	pthread_t th;
@@ -371,6 +390,10 @@ void hal_ipc_cleanup(void)
 
 	if (th)
 		pthread_join(th, NULL);
+
+	thread_cb = NULL;
+	disconnect_cb = NULL;
+	disconnect_cb_data = NULL;
 }
 
 int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index 08ed7cc..ddfcbd4 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -22,6 +22,13 @@ struct hal_ipc_handler {
 };
 
 bool hal_ipc_init(const char *path, size_t size);
+
+typedef void (*hal_ipc_disconnect_t)(void *data);
+void hal_ipc_set_disconnect_cb(hal_ipc_disconnect_t cb, void *data);
+
+typedef void (*hal_ipc_thread_t)(bool enable);
+void hal_ipc_set_thread_cb(hal_ipc_thread_t cb);
+
 bool hal_ipc_accept(void);
 void hal_ipc_cleanup(void);
 
diff --git a/android/hal.h b/android/hal.h
index 6998e9a..767939e 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -35,6 +35,3 @@ btrc_interface_t *bt_get_avrcp_interface(void);
 bthf_interface_t *bt_get_handsfree_interface(void);
 btgatt_interface_t *bt_get_gatt_interface(void);
 bthl_interface_t *bt_get_health_interface(void);
-
-void bt_thread_associate(void);
-void bt_thread_disassociate(void);
-- 
1.9.3

