Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/10] android/hal-ipc: Split IPC init and accept to separate functions
Date: Wed, 11 Jun 2014 16:32:49 +0200
Message-Id: <1402497172-12436-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
References: <1402497172-12436-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to perform custom action between listening and accepting
eg starting bluetoothd.
---
 android/hal-bluetooth.c | 10 ++++--
 android/hal-ipc.c       | 88 ++++++++++++++++++++++++++++---------------------
 android/hal-ipc.h       |  1 +
 3 files changed, 58 insertions(+), 41 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index c2a1085..a220328 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -415,12 +415,16 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready())
 		return BT_STATUS_DONE;
 
-	bt_hal_cbacks = callbacks;
-
 	hal_ipc_register(HAL_SERVICE_ID_BLUETOOTH, ev_handlers,
 				sizeof(ev_handlers)/sizeof(ev_handlers[0]));
 
-	if (!hal_ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH))) {
+	if (!hal_ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH)))
+		return BT_STATUS_FAIL;
+
+	bt_hal_cbacks = callbacks;
+
+	if (!hal_ipc_accept()) {
+		hal_ipc_cleanup();
 		bt_hal_cbacks = NULL;
 		return BT_STATUS_FAIL;
 	}
diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 59bc3dc..b1b85b0 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -35,6 +35,7 @@
 
 #define CONNECT_TIMEOUT (10 * 1000)
 
+static int listen_sk = -1;
 static int cmd_sk = -1;
 static int notif_sk = -1;
 
@@ -233,6 +234,44 @@ static int accept_connection(int sk)
 	return new_sk;
 }
 
+bool hal_ipc_accept(void)
+{
+	int err;
+
+	/* Start Android Bluetooth daemon service */
+	if (property_set("bluetooth.start", "daemon") < 0) {
+		error("Failed to set bluetooth.start=daemon");
+		return false;
+	}
+
+	cmd_sk = accept_connection(listen_sk);
+	if (cmd_sk < 0)
+		return false;
+
+	notif_sk = accept_connection(listen_sk);
+	if (notif_sk < 0) {
+		close(cmd_sk);
+		cmd_sk = -1;
+		return false;
+	}
+
+	err = pthread_create(&notif_th, NULL, notification_handler, NULL);
+	if (err) {
+		notif_th = 0;
+		error("Failed to start notification thread: %d (%s)", err,
+							strerror(err));
+		close(cmd_sk);
+		cmd_sk = -1;
+		close(notif_sk);
+		notif_sk = -1;
+		return false;
+	}
+
+	info("IPC connected");
+
+	return true;
+}
+
 bool hal_ipc_init(const char *path, size_t size)
 {
 	struct sockaddr_un addr;
@@ -267,53 +306,26 @@ bool hal_ipc_init(const char *path, size_t size)
 		return false;
 	}
 
-	/* Start Android Bluetooth daemon service */
-	if (property_set("bluetooth.start", "daemon") < 0) {
-		error("Failed to set bluetooth.start=daemon");
-		close(sk);
-		return false;
-	}
-
-	cmd_sk = accept_connection(sk);
-	if (cmd_sk < 0) {
-		close(sk);
-		return false;
-	}
-
-	notif_sk = accept_connection(sk);
-	if (notif_sk < 0) {
-		close(sk);
-		close(cmd_sk);
-		cmd_sk = -1;
-		return false;
-	}
-
-	info("bluetoothd connected");
-
-	close(sk);
-
-	err = pthread_create(&notif_th, NULL, notification_handler, NULL);
-	if (err) {
-		notif_th = 0;
-		error("Failed to start notification thread: %d (%s)", err,
-							strerror(err));
-		close(cmd_sk);
-		cmd_sk = -1;
-		close(notif_sk);
-		notif_sk = -1;
-		return false;
-	}
+	listen_sk = sk;
 
 	return true;
 }
 
 void hal_ipc_cleanup(void)
 {
+	close(listen_sk);
+	listen_sk = -1;
+
 	pthread_mutex_lock(&cmd_sk_mutex);
-	close(cmd_sk);
-	cmd_sk = -1;
+	if (cmd_sk >= 0) {
+		close(cmd_sk);
+		cmd_sk = -1;
+	}
 	pthread_mutex_unlock(&cmd_sk_mutex);
 
+	if (notif_sk < 0)
+		return;
+
 	shutdown(notif_sk, SHUT_RD);
 
 	pthread_join(notif_th, NULL);
diff --git a/android/hal-ipc.h b/android/hal-ipc.h
index 0d16cdb..b61d557 100644
--- a/android/hal-ipc.h
+++ b/android/hal-ipc.h
@@ -22,6 +22,7 @@ struct hal_ipc_handler {
 };
 
 bool hal_ipc_init(const char *path, size_t size);
+bool hal_ipc_accept(void);
 void hal_ipc_cleanup(void);
 
 int hal_ipc_cmd(uint8_t service_id, uint8_t opcode, uint16_t len, void *param,
-- 
1.9.1

