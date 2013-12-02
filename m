Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 2/9] android/main: Use generic IPC message handling for core service
Date: Mon,  2 Dec 2013 13:20:41 +0100
Message-Id: <1385986848-8023-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
References: <1385986848-8023-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on daemon start and unregistered on shutdown.
---
 android/main.c | 83 +++++++++++-----------------------------------------------
 1 file changed, 16 insertions(+), 67 deletions(-)

diff --git a/android/main.c b/android/main.c
index eedca58..0816ec7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -74,9 +74,9 @@ static GIOChannel *hal_notif_io = NULL;
 
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
-static void service_register(void *buf, uint16_t len)
+static void service_register(const void *buf, uint16_t len)
 {
-	struct hal_cmd_register_module *m = buf;
+	const struct hal_cmd_register_module *m = buf;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
 		goto failed;
@@ -122,9 +122,9 @@ failed:
 							HAL_STATUS_FAILED);
 }
 
-static void service_unregister(void *buf, uint16_t len)
+static void service_unregister(const void *buf, uint16_t len)
 {
-	struct hal_cmd_unregister_module *m = buf;
+	const struct hal_cmd_unregister_module *m = buf;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id])
 		goto failed;
@@ -164,20 +164,12 @@ failed:
 							HAL_STATUS_FAILED);
 }
 
-static void handle_service_core(uint8_t opcode, void *buf, uint16_t len)
-{
-	switch (opcode) {
-	case HAL_OP_REGISTER_MODULE:
-		service_register(buf, len);
-		break;
-	case HAL_OP_UNREGISTER_MODULE:
-		service_unregister(buf, len);
-		break;
-	default:
-		ipc_send_rsp(HAL_SERVICE_ID_CORE, opcode, HAL_STATUS_FAILED);
-		break;
-	}
-}
+static const struct ipc_handler cmd_handlers[] = {
+	/* HAL_OP_REGISTER_MODULE */
+	{ service_register, false, sizeof(struct hal_cmd_register_module) },
+	/* HAL_OP_UNREGISTER_MODULE */
+	{ service_unregister, false, sizeof(struct hal_cmd_unregister_module) },
+};
 
 static void bluetooth_stopped(void)
 {
@@ -211,7 +203,6 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	char buf[BLUEZ_HAL_MTU];
-	struct hal_hdr *msg = (void *) buf;
 	ssize_t ret;
 	int fd;
 
@@ -229,51 +220,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		goto fail;
 	}
 
-	if (ret < (ssize_t) sizeof(*msg)) {
-		error("HAL command too small, terminating (%zd)", ret);
-		goto fail;
-	}
-
-	if (ret != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("Malformed HAL command (%zd bytes), terminating", ret);
-		goto fail;
-	}
-
-	DBG("service_id %u opcode %u len %u", msg->service_id, msg->opcode,
-								msg->len);
-
-	if (msg->service_id > HAL_SERVICE_ID_MAX ||
-						!services[msg->service_id]) {
-		error("HAL command for unregistered service %u, terminating",
-							msg->service_id);
-		goto fail;
-	}
-
-	switch (msg->service_id) {
-	case HAL_SERVICE_ID_CORE:
-		handle_service_core(msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_bluetooth_handle_cmd(fd, msg->opcode, msg->payload,
-								msg->len);
-		break;
-	case HAL_SERVICE_ID_HIDHOST:
-		bt_hid_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_SOCK:
-		bt_sock_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_A2DP:
-		bt_a2dp_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
-		break;
-	case HAL_SERVICE_ID_PAN:
-		bt_pan_handle_cmd(fd, msg->opcode, msg->payload, msg->len);
-		break;
-	default:
-		ipc_send_rsp(msg->service_id, msg->opcode, HAL_STATUS_FAILED);
-		break;
-	}
-
+	ipc_handle_msg(buf, ret);
 	return TRUE;
 
 fail:
@@ -568,9 +515,6 @@ int main(int argc, char *argv[])
 	GError *err = NULL;
 	guint signal;
 
-	/* Core Service (ID=0) should always be considered registered */
-	services[0] = true;
-
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -622,6 +566,9 @@ int main(int argc, char *argv[])
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
 
+	ipc_register(HAL_SERVICE_ID_CORE, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	DBG("Entering main loop");
 
 	event_loop = g_main_loop_new(NULL, FALSE);
@@ -640,6 +587,8 @@ int main(int argc, char *argv[])
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
 
+	ipc_unregister(HAL_SERVICE_ID_CORE);
+
 	info("Exit");
 
 	__btd_log_cleanup();
-- 
1.8.3.2

