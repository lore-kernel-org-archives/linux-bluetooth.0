Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Move sockets handling from main to IPC code
Date: Mon,  2 Dec 2013 15:55:38 +0100
Message-Id: <1385996138-17313-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This moves IO handling to IPC code making it fully responsible for
creating and veryfing IPC messages exchange.
---

This should be applied on top of IPC daemon improvements.

 android/ipc.c  | 273 ++++++++++++++++++++++++++++++++++++++++++---------------
 android/ipc.h  |   4 +-
 android/main.c | 151 +------------------------------
 3 files changed, 207 insertions(+), 221 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 56f328b..1d369a8 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -32,6 +32,10 @@
 #include <signal.h>
 #include <stdbool.h>
 #include <sys/socket.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <glib.h>
 
 #include "hal-msg.h"
 #include "ipc.h"
@@ -44,19 +48,202 @@ struct service_handler {
 
 static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
 
-static int cmd_sk = -1;
-static int notif_sk = -1;
+static GIOChannel *cmd_io = NULL;
+static GIOChannel *notif_io = NULL;
 
-void ipc_init(int command_sk, int notification_sk)
+static void ipc_handle_msg(const void *buf, ssize_t len)
 {
-	cmd_sk = command_sk;
-	notif_sk = notification_sk;
+	const struct hal_hdr *msg = buf;
+	const struct ipc_handler *handler;
+
+	if (len < (ssize_t) sizeof(*msg)) {
+		error("IPC: message too small (%zd bytes), terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
+		error("IPC: message malformed (%zd bytes), terminating", len);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if service is valid */
+	if (msg->service_id > HAL_SERVICE_ID_MAX) {
+		error("IPC: unknown service (0x%x), terminating",
+							msg->service_id);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if service is registered */
+	if (!services[msg->service_id].handler) {
+		error("IPC: unregistered service (0x%x), terminating",
+							msg->service_id);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* if opcode is valid */
+	if (msg->opcode == HAL_OP_STATUS ||
+			msg->opcode > services[msg->service_id].size) {
+		error("IPC: invalid opcode 0x%x for service 0x%x, terminating",
+						msg->opcode, msg->service_id);
+		raise(SIGTERM);
+		return;
+	}
+
+	/* opcode is table offset + 1 */
+	handler = &services[msg->service_id].handler[msg->opcode - 1];
+
+	/* if payload size is valid */
+	if ((handler->var_len && handler->data_len > msg->len) ||
+			(!handler->var_len && handler->data_len != msg->len)) {
+		error("IPC: size invalid opcode 0x%x service 0x%x, terminating",
+						msg->service_id, msg->opcode);
+		raise(SIGTERM);
+		return;
+	}
+
+	handler->handler(msg->payload, msg->len);
+}
+
+static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	char buf[BLUEZ_HAL_MTU];
+	ssize_t ret;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		info("IPC: command socket closed, terminating");
+		goto fail;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0) {
+		error("IPC: command read failed, terminating (%s)",
+							strerror(errno));
+		goto fail;
+	}
+
+	ipc_handle_msg(buf, ret);
+	return TRUE;
+
+fail:
+	raise(SIGTERM);
+	return FALSE;
+}
+
+static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	info("IPC: notification socket closed, terminating");
+	raise(SIGTERM);
+
+	return FALSE;
+}
+
+static GIOChannel *connect_hal(GIOFunc connect_cb)
+{
+	struct sockaddr_un addr;
+	GIOCondition cond;
+	GIOChannel *io;
+	int sk;
+
+	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		error("IPC: failed to create socket: %d (%s)", errno,
+							strerror(errno));
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(sk);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+
+	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		error("IPC: failed to connect HAL socket: %d (%s)", errno,
+							strerror(errno));
+		g_io_channel_unref(io);
+		return NULL;
+	}
+
+	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(io, cond, connect_cb, NULL);
+
+	return io;
+}
+
+static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		error("IPC: notification socket connect failed, terminating");
+		raise(SIGTERM);
+		return FALSE;
+	}
+
+	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(io, cond, notif_watch_cb, NULL);
+
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
+
+	info("IPC: successfully connected");
+
+	return FALSE;
+}
+
+static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		error("IPC: command socket connect failed, terminating");
+		raise(SIGTERM);
+		return FALSE;
+	}
+
+	notif_io = connect_hal(notif_connect_cb);
+	if (!notif_io)
+		raise(SIGTERM);
+
+	return FALSE;
+}
+
+void ipc_init(void)
+{
+	cmd_io = connect_hal(cmd_connect_cb);
 }
 
 void ipc_cleanup(void)
 {
-	cmd_sk = -1;
-	notif_sk = -1;
+	if (cmd_io) {
+		g_io_channel_shutdown(cmd_io, TRUE, NULL);
+		g_io_channel_unref(cmd_io);
+		cmd_io = NULL;
+	}
+
+	if (notif_io) {
+		g_io_channel_shutdown(notif_io, TRUE, NULL);
+		g_io_channel_unref(notif_io);
+		notif_io = NULL;
+	}
 }
 
 static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
@@ -107,30 +294,35 @@ static void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status)
 {
 	struct hal_status s;
+	int sk;
+
+	sk = g_io_channel_unix_get_fd(cmd_io);
 
 	if (status == HAL_STATUS_SUCCESS) {
-		ipc_send(cmd_sk, service_id, opcode, 0, NULL, -1);
+		ipc_send(sk, service_id, opcode, 0, NULL, -1);
 		return;
 	}
 
 	s.code = status;
 
-	ipc_send(cmd_sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
+	ipc_send(sk, service_id, HAL_OP_STATUS, sizeof(s), &s, -1);
 }
 
 void ipc_send_rsp_full(uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
-	ipc_send(cmd_sk, service_id, opcode, len, param, fd);
+	ipc_send(g_io_channel_unix_get_fd(cmd_io), service_id, opcode, len,
+								param, fd);
 }
 
 void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 								void *param)
 {
-	if (notif_sk < 0)
+	if (!notif_io)
 		return;
 
-	ipc_send(notif_sk, service_id, opcode, len, param, -1);
+	ipc_send(g_io_channel_unix_get_fd(notif_io), service_id, opcode, len,
+								param, -1);
 }
 
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
@@ -145,60 +337,3 @@ void ipc_unregister(uint8_t service)
 	services[service].handler = NULL;
 	services[service].size = 0;
 }
-
-void ipc_handle_msg(const void *buf, ssize_t len)
-{
-	const struct hal_hdr *msg = buf;
-	const struct ipc_handler *handler;
-
-	if (len < (ssize_t) sizeof(*msg)) {
-		error("IPC: message too small (%zd bytes), terminating", len);
-		raise(SIGTERM);
-		return;
-	}
-
-	if (len != (ssize_t) (sizeof(*msg) + msg->len)) {
-		error("IPC: message malformed (%zd bytes), terminating", len);
-		raise(SIGTERM);
-		return;
-	}
-
-	/* if service is valid */
-	if (msg->service_id > HAL_SERVICE_ID_MAX) {
-		error("IPC: unknown service (0x%x), terminating",
-							msg->service_id);
-		raise(SIGTERM);
-		return;
-	}
-
-	/* if service is registered */
-	if (!services[msg->service_id].handler) {
-		error("IPC: unregistered service (0x%x), terminating",
-							msg->service_id);
-		raise(SIGTERM);
-		return;
-	}
-
-	/* if opcode is valid */
-	if (msg->opcode == HAL_OP_STATUS ||
-			msg->opcode > services[msg->service_id].size) {
-		error("IPC: invalid opcode 0x%x for service 0x%x, terminating",
-						msg->opcode, msg->service_id);
-		raise(SIGTERM);
-		return;
-	}
-
-	/* opcode is table offset + 1 */
-	handler = &services[msg->service_id].handler[msg->opcode - 1];
-
-	/* if payload size is valid */
-	if ((handler->var_len && handler->data_len > msg->len) ||
-			(!handler->var_len && handler->data_len != msg->len)) {
-		error("IPC: size invalid opcode 0x%x service 0x%x, terminating",
-						msg->service_id, msg->opcode);
-		raise(SIGTERM);
-		return;
-	}
-
-	handler->handler(msg->payload, msg->len);
-}
diff --git a/android/ipc.h b/android/ipc.h
index 9d0c5e1..6cd102b 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -26,7 +26,7 @@ struct ipc_handler {
 	bool var_len;
 	size_t data_len;
 };
-void ipc_init(int command_sk, int notification_sk);
+void ipc_init(void);
 void ipc_cleanup(void);
 
 void ipc_send_rsp(uint8_t service_id, uint8_t opcode, uint8_t status);
@@ -37,5 +37,3 @@ void ipc_send_notif(uint8_t service_id, uint8_t opcode,  uint16_t len,
 void ipc_register(uint8_t service, const struct ipc_handler *handlers,
 								uint8_t size);
 void ipc_unregister(uint8_t service);
-
-void ipc_handle_msg(const void *buf, ssize_t len);
diff --git a/android/main.c b/android/main.c
index c0f8901..b9655c5 100644
--- a/android/main.c
+++ b/android/main.c
@@ -36,8 +36,6 @@
 #include <unistd.h>
 
 #include <sys/signalfd.h>
-#include <sys/socket.h>
-#include <sys/un.h>
 
 #include <glib.h>
 
@@ -69,9 +67,6 @@ static bdaddr_t adapter_bdaddr;
 
 static GMainLoop *event_loop;
 
-static GIOChannel *hal_cmd_io = NULL;
-static GIOChannel *hal_notif_io = NULL;
-
 static bool services[HAL_SERVICE_ID_MAX + 1] = { false };
 
 static void service_register(const void *buf, uint16_t len)
@@ -209,127 +204,6 @@ static void stop_bluetooth(void)
 	g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS, quit_eventloop, NULL);
 }
 
-static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	char buf[BLUEZ_HAL_MTU];
-	ssize_t ret;
-	int fd;
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		info("HAL command socket closed, terminating");
-		goto fail;
-	}
-
-	fd = g_io_channel_unix_get_fd(io);
-
-	ret = read(fd, buf, sizeof(buf));
-	if (ret < 0) {
-		error("HAL command read failed, terminating (%s)",
-							strerror(errno));
-		goto fail;
-	}
-
-	ipc_handle_msg(buf, ret);
-	return TRUE;
-
-fail:
-	stop_bluetooth();
-	return FALSE;
-}
-
-static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	info("HAL notification socket closed, terminating");
-	stop_bluetooth();
-
-	return FALSE;
-}
-
-static GIOChannel *connect_hal(GIOFunc connect_cb)
-{
-	struct sockaddr_un addr;
-	GIOCondition cond;
-	GIOChannel *io;
-	int sk;
-
-	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
-	if (sk < 0) {
-		error("Failed to create socket: %d (%s)", errno,
-							strerror(errno));
-		return NULL;
-	}
-
-	io = g_io_channel_unix_new(sk);
-
-	g_io_channel_set_close_on_unref(io, TRUE);
-	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
-
-	memset(&addr, 0, sizeof(addr));
-	addr.sun_family = AF_UNIX;
-
-	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
-
-	if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		error("Failed to connect HAL socket: %d (%s)", errno,
-							strerror(errno));
-		g_io_channel_unref(io);
-		return NULL;
-	}
-
-	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-
-	g_io_add_watch(io, cond, connect_cb, NULL);
-
-	return io;
-}
-
-static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	DBG("");
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		stop_bluetooth();
-		return FALSE;
-	}
-
-	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-
-	g_io_add_watch(io, cond, notif_watch_cb, NULL);
-
-	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
-
-	g_io_add_watch(hal_cmd_io, cond, cmd_watch_cb, NULL);
-
-	ipc_init(g_io_channel_unix_get_fd(hal_cmd_io),
-				g_io_channel_unix_get_fd(hal_notif_io));
-
-	info("Successfully connected to HAL");
-
-	return FALSE;
-}
-
-static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	DBG("");
-
-	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		stop_bluetooth();
-		return FALSE;
-	}
-
-	hal_notif_io = connect_hal(notif_connect_cb);
-	if (!hal_notif_io) {
-		error("Cannot connect to HAL, terminating");
-		stop_bluetooth();
-	}
-
-	return FALSE;
-}
-
 static void adapter_ready(int err, const bdaddr_t *addr)
 {
 	if (err < 0) {
@@ -346,11 +220,7 @@ static void adapter_ready(int err, const bdaddr_t *addr)
 
 	info("Adapter initialized");
 
-	hal_cmd_io = connect_hal(cmd_connect_cb);
-	if (!hal_cmd_io) {
-		error("Cannot connect to HAL, terminating");
-		stop_bluetooth();
-	}
+	ipc_init();
 }
 
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
@@ -433,23 +303,6 @@ static GOptionEntry options[] = {
 	{ NULL }
 };
 
-static void cleanup_hal_connection(void)
-{
-	if (hal_cmd_io) {
-		g_io_channel_shutdown(hal_cmd_io, TRUE, NULL);
-		g_io_channel_unref(hal_cmd_io);
-		hal_cmd_io = NULL;
-	}
-
-	if (hal_notif_io) {
-		g_io_channel_shutdown(hal_notif_io, TRUE, NULL);
-		g_io_channel_unref(hal_notif_io);
-		hal_notif_io = NULL;
-	}
-
-	ipc_cleanup();
-}
-
 static void cleanup_services(void)
 {
 	int i;
@@ -592,7 +445,7 @@ int main(int argc, char *argv[])
 
 	cleanup_services();
 
-	cleanup_hal_connection();
+	ipc_cleanup();
 	stop_sdp_server();
 	bt_bluetooth_cleanup();
 	g_main_loop_unref(event_loop);
-- 
1.8.3.2

