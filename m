Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/6] android: Add support for registering disconnect callback in IPC
Date: Fri, 28 Feb 2014 14:09:25 +0100
Message-Id: <1393592969-4451-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
References: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow to register callback which is called in case of IPC failure
(eg malformed message) or disconnection. This makes caller responsible
for performing expected action in such case.
---
 android/ipc.c      | 106 ++++++++++++++++++++++++++++++++++-------------------
 android/ipc.h      |   5 ++-
 android/main.c     |   7 +++-
 android/test-ipc.c |   8 ++--
 4 files changed, 83 insertions(+), 43 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 3d6e2a3..a996935 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -52,8 +52,42 @@ struct ipc {
 
 	GIOChannel *notif_io;
 	guint notif_watch;
+
+	ipc_disconnect_cb disconnect_cb;
+	void *disconnect_cb_data;
 };
 
+static void ipc_disconnect(struct ipc *ipc, bool in_cleanup)
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
+	if (in_cleanup)
+		return;
+
+	if (ipc->disconnect_cb)
+		ipc->disconnect_cb(ipc->disconnect_cb_data);
+}
+
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
 {
@@ -116,7 +150,9 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 	int fd, err;
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		info("IPC: command socket closed, terminating");
+		info("IPC: command socket closed");
+
+		ipc->cmd_watch = 0;
 		goto fail;
 	}
 
@@ -124,30 +160,34 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 
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
+	ipc_disconnect(ipc, false);
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
+	ipc_disconnect(ipc, false);
 
 	return FALSE;
 }
@@ -194,8 +234,10 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 	DBG("");
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
-		error("IPC: notification socket connect failed, terminating");
-		raise(SIGTERM);
+		error("IPC: notification socket connect failed");
+
+		ipc_disconnect(ipc, false);
+
 		return FALSE;
 	}
 
@@ -220,20 +262,25 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
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
+	ipc_disconnect(ipc, false);
 
 	return FALSE;
 }
 
-struct ipc *ipc_init(const char *path, size_t size, int max_service_id)
+struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
+					ipc_disconnect_cb cb, void *cb_data)
 {
 	struct ipc *ipc;
 
@@ -252,32 +299,15 @@ struct ipc *ipc_init(const char *path, size_t size, int max_service_id)
 		return NULL;
 	}
 
+	ipc->disconnect_cb = cb;
+	ipc->disconnect_cb_data = cb_data;
+
 	return ipc;
 }
 
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
+	ipc_disconnect(ipc, true);
 
 	g_free(ipc->services);
 	g_free(ipc);
@@ -323,7 +353,9 @@ void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
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
index 601301c..63b751d 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -34,7 +34,10 @@ struct service_handler {
 
 struct ipc;
 
-struct ipc *ipc_init(const char *path, size_t size, int max_service_id);
+typedef void (*ipc_disconnect_cb) (void *data);
+
+struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
+					ipc_disconnect_cb cb, void *cb_data);
 void ipc_cleanup(struct ipc *ipc);
 
 GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
diff --git a/android/main.c b/android/main.c
index 9f22486..01f0b92 100644
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
@@ -245,7 +250,7 @@ static void adapter_ready(int err, const bdaddr_t *addr)
 	info("Adapter initialized");
 
 	hal_ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							HAL_SERVICE_ID_MAX);
+				HAL_SERVICE_ID_MAX, ipc_disconnected, NULL);
 	if (!hal_ipc) {
 		error("Failed to initialize IPC");
 		exit(EXIT_FAILURE);
diff --git a/android/test-ipc.c b/android/test-ipc.c
index 054af84..9b736a2 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -286,7 +286,7 @@ static void test_init(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							HAL_SERVICE_ID_MAX);
+						HAL_SERVICE_ID_MAX, NULL, NULL);
 
 	g_assert(ipc);
 
@@ -337,7 +337,7 @@ static void test_cmd(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							HAL_SERVICE_ID_MAX);
+						HAL_SERVICE_ID_MAX, NULL, NULL);
 
 	g_assert(ipc);
 
@@ -355,7 +355,7 @@ static void test_cmd_reg(gconstpointer data)
 	const struct test_data *test_data = context->data;
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							HAL_SERVICE_ID_MAX);
+						HAL_SERVICE_ID_MAX, NULL, NULL);
 
 	g_assert(ipc);
 
@@ -375,7 +375,7 @@ static void test_cmd_reg_1(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-							HAL_SERVICE_ID_MAX);
+						HAL_SERVICE_ID_MAX, NULL, NULL);
 
 	g_assert(ipc);
 
-- 
1.8.3.2

