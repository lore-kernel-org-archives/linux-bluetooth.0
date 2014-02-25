Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/7] android: Add support for registering failure callback in IPC
Date: Tue, 25 Feb 2014 11:50:14 +0100
Message-Id: <1393325419-16544-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
References: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow to register callback which is called in case of IPC failure
(eg malformed message) or disconnection. This makes caller responsible
for performing expected action in such case.
---
 android/ipc.c  | 103 +++++++++++++++++++++++++++++++++++++--------------------
 android/ipc.h  |   3 ++
 android/main.c |   7 ++++
 3 files changed, 77 insertions(+), 36 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 3d6e2a3..4bddb58 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -52,8 +52,39 @@ struct ipc {
 
 	GIOChannel *notif_io;
 	guint notif_watch;
+
+	ipc_failed_cb failed_cb;
+	void *failed_cb_data;
 };
 
+static void ipc_disconnect(struct ipc *ipc, bool failed)
+{
+	if (ipc->cmd_watch) {
+		g_source_remove(ipc->cmd_watch);
+		ipc->cmd_watch = 0;
+	}
+
+	if (ipc->cmd_io) {
+		g_io_channel_shutdown(ipc->cmd_io, TRUE, NULL);
+		g_io_channel_unref(ipc->cmd_io);
+		ipc->cmd_io = NULL;
+	}
+
+	if (ipc->notif_watch) {
+		g_source_remove(ipc->notif_watch);
+		ipc->notif_watch = 0;
+	}
+
+	if (ipc->notif_io) {
+		g_io_channel_shutdown(ipc->notif_io, TRUE, NULL);
+		g_io_channel_unref(ipc->notif_io);
+		ipc->notif_io = NULL;
+	}
+
+	if (ipc->failed_cb && failed)
+		ipc->failed_cb(ipc->failed_cb_data);
+}
+
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
 {
@@ -116,7 +147,9 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		info("IPC: command socket closed, terminating");
+		info("IPC: command socket closed");
+
+		ipc->cmd_watch = 0;
 		goto fail;
 	}
 
@@ -124,30 +157,34 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 
 	ret = read(fd, buf, sizeof(buf));
 	if (ret < 0) {
-		error("IPC: command read failed, terminating (%s)",
-							strerror(errno));
+		error("IPC: command read failed (%s)", strerror(errno));
 		goto fail;
 	}
 
 	err = ipc_handle_msg(ipc->services, ipc->service_max, buf, ret);
 	if (err < 0) {
-		error("IPC: failed to handle message, terminating (%s)",
-							strerror(-err));
+		error("IPC: failed to handle message (%s)", strerror(-err));
 		goto fail;
 	}
 
 	return TRUE;
 
 fail:
-	raise(SIGTERM);
+	ipc_disconnect(ipc, true);
+
 	return FALSE;
 }
 
 static gboolean notif_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	info("IPC: notification socket closed, terminating");
-	raise(SIGTERM);
+	struct ipc *ipc = user_data;
+
+	info("IPC: notification socket closed");
+
+	ipc->notif_watch = 0;
+
+	ipc_disconnect(ipc, true);
 
 	return FALSE;
 }
@@ -194,8 +231,10 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		error("IPC: notification socket connect failed, terminating");
-		raise(SIGTERM);
+		error("IPC: notification socket connect failed");
+
+		ipc_disconnect(ipc, true);
+
 		return FALSE;
 	}
 
@@ -220,15 +259,19 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		error("IPC: command socket connect failed, terminating");
-		raise(SIGTERM);
-		return FALSE;
+		error("IPC: command socket connect failed");
+		goto failed;
 	}
 
 	ipc->notif_io = ipc_connect(ipc->path, ipc->size, notif_connect_cb,
 									ipc);
 	if (!ipc->notif_io)
-		raise(SIGTERM);
+		goto failed;
+
+	return FALSE;
+
+failed:
+	ipc_disconnect(ipc, true);
 
 	return FALSE;
 }
@@ -257,32 +300,18 @@ struct ipc *ipc_init(const char *path, size_t size, int max_service_id)
 
 void ipc_cleanup(struct ipc *ipc)
 {
-	if (ipc->cmd_watch) {
-		g_source_remove(ipc->cmd_watch);
-		ipc->cmd_watch = 0;
-	}
-
-	if (ipc->cmd_io) {
-		g_io_channel_shutdown(ipc->cmd_io, TRUE, NULL);
-		g_io_channel_unref(ipc->cmd_io);
-		ipc->cmd_io = NULL;
-	}
-
-	if (ipc->notif_watch) {
-		g_source_remove(ipc->notif_watch);
-		ipc->notif_watch = 0;
-	}
-
-	if (ipc->notif_io) {
-		g_io_channel_shutdown(ipc->notif_io, TRUE, NULL);
-		g_io_channel_unref(ipc->notif_io);
-		ipc->notif_io = NULL;
-	}
+	ipc_disconnect(ipc, false);
 
 	g_free(ipc->services);
 	g_free(ipc);
 }
 
+void ipc_set_fail_handler(struct ipc *ipc, ipc_failed_cb cb, void *data)
+{
+	ipc->failed_cb = cb;
+	ipc->failed_cb_data = data;
+}
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
@@ -323,7 +352,9 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 	}
 
 	if (sendmsg(sk, &msg, 0) < 0) {
-		error("IPC send failed, terminating :%s", strerror(errno));
+		error("IPC send failed :%s", strerror(errno));
+
+		/* TODO disconnect IPC here when this function becomes static */
 		raise(SIGTERM);
 	}
 }
diff --git a/android/ipc.h b/android/ipc.h
index 601301c..3a6adc8 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -37,6 +37,9 @@ struct ipc;
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id);
 void ipc_cleanup(struct ipc *ipc);
 
+typedef void (*ipc_failed_cb) (void *data);
+void ipc_set_fail_handler(struct ipc *ipc, ipc_failed_cb cb, void *data);
+
 GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
 							void *user_data);
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
diff --git a/android/main.c b/android/main.c
index 9f22486..a821dfa 100644
--- a/android/main.c
+++ b/android/main.c
@@ -228,6 +228,11 @@ static void stop_bluetooth(void)
 	g_timeout_add_seconds(SHUTDOWN_GRACE_SECONDS, quit_eventloop, NULL);
 }
 
+static void ipc_disconnected(void *data)
+{
+	stop_bluetooth();
+}
+
 static void adapter_ready(int err, const bdaddr_t *addr)
 {
 	if (err < 0) {
@@ -251,6 +256,8 @@ static void adapter_ready(int err, const bdaddr_t *addr)
 		exit(EXIT_FAILURE);
 	}
 
+	ipc_set_fail_handler(hal_ipc, ipc_disconnected, NULL);
+
 	ipc_register(hal_ipc, HAL_SERVICE_ID_CORE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
 }
-- 
1.8.3.2

