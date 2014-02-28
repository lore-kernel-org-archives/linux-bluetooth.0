Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] android: Add support for disabling notifications in IPC
Date: Fri, 28 Feb 2014 14:09:27 +0100
Message-Id: <1393592969-4451-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
References: <1393592969-4451-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c      | 29 ++++++++++++++++++++---------
 android/ipc.h      |  1 +
 android/main.c     |  3 ++-
 android/test-ipc.c |  8 ++++----
 4 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index a996935..fa44e3f 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -50,6 +50,7 @@ struct ipc {
 	GIOChannel *cmd_io;
 	guint cmd_watch;
 
+	bool notifications;
 	GIOChannel *notif_io;
 	guint notif_watch;
 
@@ -249,7 +250,7 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	ipc->cmd_watch = g_io_add_watch(ipc->cmd_io, cond, cmd_watch_cb, ipc);
 
-	info("IPC: successfully connected");
+	info("IPC: successfully connected (with notifications)");
 
 	return FALSE;
 }
@@ -263,23 +264,31 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
 		error("IPC: command socket connect failed");
-		goto failed;
+		ipc_disconnect(ipc, false);
+
+		return FALSE;
 	}
 
-	ipc->notif_io = ipc_connect(ipc->path, ipc->size, notif_connect_cb,
-									ipc);
-	if (!ipc->notif_io)
-		goto failed;
+	if (ipc->notifications) {
+		ipc->notif_io = ipc_connect(ipc->path, ipc->size,
+							notif_connect_cb, ipc);
+		if (!ipc->notif_io)
+			ipc_disconnect(ipc, false);
 
-	return FALSE;
+		return FALSE;
+	}
 
-failed:
-	ipc_disconnect(ipc, false);
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	ipc->cmd_watch = g_io_add_watch(ipc->cmd_io, cond, cmd_watch_cb, ipc);
+
+	info("IPC: successfully connected (without notifications)");
 
 	return FALSE;
 }
 
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
+					bool notifications,
 					ipc_disconnect_cb cb, void *cb_data)
 {
 	struct ipc *ipc;
@@ -292,6 +301,8 @@ struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
 	ipc->path = path;
 	ipc->size = size;
 
+	ipc->notifications = notifications;
+
 	ipc->cmd_io = ipc_connect(path, size, cmd_connect_cb, ipc);
 	if (!ipc->cmd_io) {
 		g_free(ipc->services);
diff --git a/android/ipc.h b/android/ipc.h
index 63b751d..d46dbbf 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -37,6 +37,7 @@ struct ipc;
 typedef void (*ipc_disconnect_cb) (void *data);
 
 struct ipc *ipc_init(const char *path, size_t size, int max_service_id,
+					bool notifications,
 					ipc_disconnect_cb cb, void *cb_data);
 void ipc_cleanup(struct ipc *ipc);
 
diff --git a/android/main.c b/android/main.c
index 01f0b92..bd1bcb9 100644
--- a/android/main.c
+++ b/android/main.c
@@ -250,7 +250,8 @@ static void adapter_ready(int err, const bdaddr_t *addr)
 	info("Adapter initialized");
 
 	hal_ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-				HAL_SERVICE_ID_MAX, ipc_disconnected, NULL);
+						HAL_SERVICE_ID_MAX, true,
+						ipc_disconnected, NULL);
 	if (!hal_ipc) {
 		error("Failed to initialize IPC");
 		exit(EXIT_FAILURE);
diff --git a/android/test-ipc.c b/android/test-ipc.c
index 2f211fd..6172991 100644
--- a/android/test-ipc.c
+++ b/android/test-ipc.c
@@ -237,7 +237,7 @@ static void test_init(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-						HAL_SERVICE_ID_MAX, NULL, NULL);
+					HAL_SERVICE_ID_MAX, true, NULL, NULL);
 
 	g_assert(ipc);
 
@@ -288,7 +288,7 @@ static void test_cmd(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-				HAL_SERVICE_ID_MAX, disconnected, context);
+			HAL_SERVICE_ID_MAX, true, disconnected, context);
 
 	g_assert(ipc);
 
@@ -306,7 +306,7 @@ static void test_cmd_reg(gconstpointer data)
 	const struct test_data *test_data = context->data;
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-				HAL_SERVICE_ID_MAX, disconnected, context);
+			HAL_SERVICE_ID_MAX, true, disconnected, context);
 
 	g_assert(ipc);
 
@@ -326,7 +326,7 @@ static void test_cmd_reg_1(gconstpointer data)
 	struct context *context = create_context(data);
 
 	ipc = ipc_init(BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH),
-				HAL_SERVICE_ID_MAX, disconnected, context);
+			HAL_SERVICE_ID_MAX, true, disconnected, context);
 
 	g_assert(ipc);
 
-- 
1.8.3.2

