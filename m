Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 8/8] android: Rename bluetooth service functions to match service name
Date: Tue, 12 Nov 2013 23:48:20 +0000
Message-Id: <1384300100-8941-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
References: <1384300100-8941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make public functions match service name.
---
 android/bluetooth.c | 26 +++++++++++++-------------
 android/bluetooth.h | 16 ++++++++--------
 android/main.c      | 13 +++++++------
 3 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 7a33d4f..39589fa 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -938,7 +938,7 @@ static void register_mgmt_handlers(void)
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	bt_adapter_ready cb = user_data;
+	bt_bluetooth_ready cb = user_data;
 	int err;
 
 	if (status) {
@@ -957,7 +957,7 @@ failed:
 	cb(err, NULL);
 }
 
-static void load_link_keys(GSList *keys, bt_adapter_ready cb)
+static void load_link_keys(GSList *keys, bt_bluetooth_ready cb)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	struct mgmt_link_key_info *key;
@@ -1279,7 +1279,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_read_info *rp = param;
-	bt_adapter_ready cb = user_data;
+	bt_bluetooth_ready cb = user_data;
 	uint32_t missing_settings, supported_settings;
 	int err;
 
@@ -1342,7 +1342,7 @@ failed:
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	bt_adapter_ready cb = user_data;
+	bt_bluetooth_ready cb = user_data;
 
 	DBG("index %u", index);
 
@@ -1379,7 +1379,7 @@ static void read_index_list_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
 	const struct mgmt_rp_read_index_list *rp = param;
-	bt_adapter_ready cb = user_data;
+	bt_bluetooth_ready cb = user_data;
 	uint16_t num;
 	int i;
 
@@ -1433,7 +1433,7 @@ static void read_version_complete(uint8_t status, uint16_t length,
 {
 	const struct mgmt_rp_read_version *rp = param;
 	uint8_t mgmt_version, mgmt_revision;
-	bt_adapter_ready cb = user_data;
+	bt_bluetooth_ready cb = user_data;
 
 	DBG("");
 
@@ -1474,7 +1474,7 @@ failed:
 	cb(-EIO, NULL);
 }
 
-bool bt_adapter_start(int index, bt_adapter_ready cb)
+bool bt_bluetooth_start(int index, bt_bluetooth_ready cb)
 {
 	DBG("index %d", index);
 
@@ -1503,7 +1503,7 @@ bool bt_adapter_start(int index, bt_adapter_ready cb)
 static void shutdown_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	bt_adapter_stopped cb = user_data;
+	bt_bluetooth_stopped cb = user_data;
 
 	if (status != MGMT_STATUS_SUCCESS)
 		error("Clean controller shutdown failed");
@@ -1511,7 +1511,7 @@ static void shutdown_complete(uint8_t status, uint16_t length,
 	cb();
 }
 
-bool bt_adapter_stop(bt_adapter_stopped cb)
+bool bt_bluetooth_stop(bt_bluetooth_stopped cb)
 {
 	struct mgmt_mode cp;
 
@@ -1527,7 +1527,7 @@ bool bt_adapter_stop(bt_adapter_stopped cb)
 				NULL) > 0;
 }
 
-void bt_adapter_cleanup(void)
+void bt_bluetooth_cleanup(void)
 {
 	g_free(adapter.name);
 	adapter.name = NULL;
@@ -2041,7 +2041,7 @@ static uint8_t get_remote_services(void *buf, uint16_t len)
 	return browse_remote_sdp(&addr);
 }
 
-void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
+void bt_bluetooth_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -2160,7 +2160,7 @@ error:
 	ipc_send_rsp(sk, HAL_SERVICE_ID_BLUETOOTH, status);
 }
 
-bool bt_adapter_register(int sk)
+bool bt_bluetooth_register(int sk)
 {
 	DBG("");
 
@@ -2169,7 +2169,7 @@ bool bt_adapter_register(int sk)
 	return true;
 }
 
-void bt_adapter_unregister(void)
+void bt_bluetooth_unregister(void)
 {
 	DBG("");
 
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 99bd85f..44b8e9e 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -21,18 +21,18 @@
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
 
 int bt_adapter_add_record(sdp_record_t *rec, uint8_t svc_hint);
 void bt_adapter_remove_record(uint32_t handle);
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
1.8.4.3

