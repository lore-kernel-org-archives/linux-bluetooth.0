Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/13] android/main: Use generic IPC message handling for core service
Date: Wed, 27 Nov 2013 12:54:54 +0100
Message-Id: <1385553305-5807-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
References: <1385553305-5807-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handlers are registered on daemon start and unregistered on shutdown.
---
 android/main.c | 93 +++++++++++++++-------------------------------------------
 1 file changed, 23 insertions(+), 70 deletions(-)

diff --git a/android/main.c b/android/main.c
index c9733f3..6139ed7 100644
--- a/android/main.c
+++ b/android/main.c
@@ -74,9 +74,9 @@ static GIOChannel *hal_notif_io = NULL;
 
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
-static void service_register(void *buf, uint16_t len)
+static void service_register(const void *buf, uint16_t len)
 {
-	struct hal_cmd_register_module *m = buf;
+	const struct hal_cmd_register_module *m = buf;
 	int sk = g_io_channel_unix_get_fd(hal_notif_io);
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || services[m->service_id])
@@ -126,9 +126,9 @@ failed:
 				HAL_STATUS_FAILED);
 }
 
-static void service_unregister(void *buf, uint16_t len)
+static void service_unregister(const void *buf, uint16_t len)
 {
-	struct hal_cmd_unregister_module *m = buf;
+	const struct hal_cmd_unregister_module *m = buf;
 
 	if (m->service_id > HAL_SERVICE_ID_MAX || !services[m->service_id])
 		goto failed;
@@ -169,22 +169,19 @@ failed:
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
-		ipc_send_rsp(g_io_channel_unix_get_fd(hal_cmd_io),
-						HAL_SERVICE_ID_CORE, opcode,
-						HAL_STATUS_FAILED);
-		break;
-	}
-}
+static const struct ipc_handler cmd_handlers[] = {
+	{	/* HAL_OP_REGISTER_MODULE */
+		.handler = service_register,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_register_module)
+	},
+	{	/* HAL_OP_UNREGISTER_MODULE */
+		.handler = service_unregister,
+		.var_len = false,
+		.data_len = sizeof(struct hal_cmd_unregister_module)
+	},
+};
+
 
 static void bluetooth_stopped(void)
 {
@@ -218,7 +215,6 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
 	char buf[BLUEZ_HAL_MTU];
-	struct hal_hdr *msg = (void *) buf;
 	ssize_t ret;
 	int fd;
 
@@ -236,52 +232,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
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
-		ipc_send_rsp(fd, msg->service_id, msg->opcode,
-							HAL_STATUS_FAILED);
-		break;
-	}
-
+	ipc_handle_msg(buf, ret);
 	return TRUE;
 
 fail:
@@ -535,9 +486,6 @@ int main(int argc, char *argv[])
 	GError *err = NULL;
 	guint signal;
 
-	/* Core Service (ID=0) should always be considered registered */
-	services[0] = true;
-
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
 
@@ -581,6 +529,9 @@ int main(int argc, char *argv[])
 	/* Use params: mtu = 0, flags = 0 */
 	start_sdp_server(0, 0);
 
+	ipc_register(HAL_SERVICE_ID_CORE, cmd_handlers,
+				sizeof(cmd_handlers)/sizeof(cmd_handlers[0]));
+
 	DBG("Entering main loop");
 
 	g_main_loop_run(event_loop);
@@ -592,6 +543,8 @@ int main(int argc, char *argv[])
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
 
+	ipc_unregister(HAL_SERVICE_ID_CORE);
+
 	info("Exit");
 
 	__btd_log_cleanup();
-- 
1.8.3.2

