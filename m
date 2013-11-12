Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/7] android: Rename bluetooth service functions to match service name
Date: Tue, 12 Nov 2013 00:24:17 +0000
Message-Id: <1384215857-19679-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
References: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make public functions match service name.
---
 android/bluetooth.c | 16 ++++++++--------
 android/bluetooth.h | 16 ++++++++--------
 android/main.c      | 13 +++++++------
 3 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b3a6e20..9545ec4 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -61,7 +61,7 @@ static GSList *browse_reqs;
 static uint16_t option_index = MGMT_INDEX_NONE;
 static uint16_t adapter_index = MGMT_INDEX_NONE;
 static struct mgmt *mgmt_if = NULL;
-static bt_adapter_ready adapter_ready = NULL;
+static bt_bluetooth_ready adapter_ready = NULL;
 static bdaddr_t adapter_bdaddr;
 static uint32_t adapter_dev_class = 0;
 static char *adapter_name = NULL;
@@ -1272,7 +1272,7 @@ failed:
 	adapter_ready(-EIO, NULL);
 }
 
-bool bt_adapter_start(int index, bt_adapter_ready cb)
+bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
 {
 	DBG("index %d", index);
 
@@ -1303,7 +1303,7 @@ bool bt_adapter_start(int index, bt_adapter_ready cb)
 static void shutdown_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	bt_adapter_stopped cb = user_data;
+	bt_bluetooth_stopped cb = user_data;
 
 	if (status != MGMT_STATUS_SUCCESS)
 		error("Clean controller shutdown failed");
@@ -1311,7 +1311,7 @@ static void shutdown_complete(uint8_t status, uint16_t length,
 	cb();
 }
 
-bool bt_adapter_stop(bt_adapter_stopped cb)
+bool bt_bluetooth_stop(bt_bluetooth_stopped cb)
 {
 	struct mgmt_mode cp;
 
@@ -1327,7 +1327,7 @@ bool bt_adapter_stop(bt_adapter_stopped cb)
 				NULL) > 0;
 }
 
-void bt_adapter_cleanup(void)
+void bt_bluetooth_cleanup(void)
 {
 	g_free(adapter_name);
 	adapter_name = NULL;
@@ -1849,7 +1849,7 @@ static uint8_t get_remote_services(void *buf, uint16_t len)
 	return browse_remote_sdp(&addr);
 }
 
-void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
+void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -1968,7 +1968,7 @@ error:
 	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
-bool bt_adapter_register(int sk)
+bool bt_bluetooth_register(int sk)
 {
 	DBG("");
 
@@ -1977,7 +1977,7 @@ bool bt_adapter_register(int sk)
 	return true;
 }
 
-void bt_adapter_unregister(void)
+void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 94c97ac..88ec326 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -21,15 +21,15 @@
  *
  */
 
-typedef void (*bt_adapter_ready)(int err, const bdaddr_t *addr);
-bool bt_adapter_start(int index, bt_adapter_ready cb);
+typedef void (*bt_bluetooth_ready)(int err, const bdaddr_t *addr);
+bool bt_bluetooth_start(int index, bt_bluetooth_ready cb);
 
-typedef void (*bt_adapter_stopped)(void);
-bool bt_adapter_stop(bt_adapter_stopped cb);
+typedef void (*bt_bluetooth_stopped)(void);
+bool bt_bluetooth_stop(bt_bluetooth_stopped cb);
 
-void bt_adapter_cleanup(void);
+void bt_bluetooth_cleanup(void);
 
-void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
+void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len);
 
-bool bt_adapter_register(int sk);
-void bt_adapter_unregister(void);
+bool bt_bluetooth_register(int sk);
+void bt_bluetooth_unregister(void);
diff --git a/android/main.c b/android/main.c
index e4c93ec..cbbfc06 100644
--- a/android/main.c
+++ b/android/main.c
@@ -84,7 +84,7 @@ static void service_register(void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		if (!bt_adapter_register(sk))
+		if (!bt_bluetooth_register(sk))
 			goto failed;
 
 		break;
@@ -134,7 +134,7 @@ static void service_unregister(void *buf, uint16_t len)
 
 	switch (m->service_id) {
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_adapter_unregister();
+		bt_bluetooth_unregister();
 		break;
 	case HAL_SERVICE_ID_SOCK:
 		bt_socket_unregister();
@@ -203,7 +203,7 @@ static void stop_bluetooth(void)
 
 	__stop = true;
 
-	if (!bt_adapter_stop(bluetooth_stopped)) {
+	if (!bt_bluetooth_stop(bluetooth_stopped)) {
 		g_main_loop_quit(event_loop);
 		return;
 	}
@@ -251,7 +251,8 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		handle_service_core(msg->opcode, msg->payload, msg->len);
 		break;
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_adapter_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
+		bt_bluetooth_handle_cmd(fd, msg->opcode, msg->payload,
+								msg->len);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
 		bt_hid_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
@@ -560,7 +561,7 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
-	if (!bt_adapter_start(option_index, adapter_ready))
+	if (!bt_bluetooth_start(option_index, adapter_ready))
 		return EXIT_FAILURE;
 
 	/* Use params: mtu = 0, flags = 0 */
@@ -574,7 +575,7 @@ int main(int argc, char *argv[])
 
 	cleanup_hal_connection();
 	stop_sdp_server();
-	bt_adapter_cleanup();
+	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
 
 	info("Exit");
-- 
1.8.4.2

