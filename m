Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 4/7] android: Add support for disabling notifications in IPC
Date: Tue, 25 Feb 2014 11:50:16 +0100
Message-Id: <1393325419-16544-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
References: <1393325419-16544-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/ipc.c | 20 ++++++++++++++++++--
 android/ipc.h |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index 4bddb58..e356439 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -50,6 +50,7 @@ struct ipc {
 	GIOChannel *cmd_io;
 	guint cmd_watch;
 
+	bool notif_disabled;
 	GIOChannel *notif_io;
 	guint notif_watch;
 
@@ -246,7 +247,7 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	ipc->cmd_watch = g_io_add_watch(ipc->cmd_io, cond, cmd_watch_cb, ipc);
 
-	info("IPC: successfully connected");
+	info("IPC: successfully connected (with notifications)");
 
 	return FALSE;
 }
@@ -263,13 +264,23 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		goto failed;
 	}
 
+	if (ipc->notif_disabled) {
+		cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+		ipc->cmd_watch = g_io_add_watch(ipc->cmd_io, cond, cmd_watch_cb,
+									ipc);
+
+		info("IPC: successfully connected (without notifications)");
+
+		return FALSE;
+	}
+
 	ipc->notif_io = ipc_connect(ipc->path, ipc->size, notif_connect_cb,
 									ipc);
 	if (!ipc->notif_io)
 		goto failed;
 
 	return FALSE;
-
 failed:
 	ipc_disconnect(ipc, true);
 
@@ -312,6 +323,11 @@ void ipc_set_fail_handler(struct ipc *ipc, ipc_failed_cb cb, void *data)
 	ipc->failed_cb_data = data;
 }
 
+void ipc_disable_notifications(struct ipc *ipc)
+{
+	ipc->notif_disabled = true;
+}
+
 void ipc_send(int sk, uint8_t service_id, uint8_t opcode, uint16_t len,
 							void *param, int fd)
 {
diff --git a/android/ipc.h b/android/ipc.h
index 3a6adc8..c4f8c41 100644
--- a/android/ipc.h
+++ b/android/ipc.h
@@ -40,6 +40,8 @@ void ipc_cleanup(struct ipc *ipc);
 typedef void (*ipc_failed_cb) (void *data);
 void ipc_set_fail_handler(struct ipc *ipc, ipc_failed_cb cb, void *data);
 
+void ipc_disable_notifications(struct ipc *ipc);
+
 GIOChannel *ipc_connect(const char *path, size_t size, GIOFunc connect_cb,
 							void *user_data);
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
-- 
1.8.3.2

