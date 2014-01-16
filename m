Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 2/5] android/ipc: Remove watches on cleanup
Date: Thu, 16 Jan 2014 11:04:59 +0100
Message-Id: <1389866702-30697-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
References: <1389866702-30697-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Remove watches on cleanup. It will avoid receiving
events after cleanup.
---
 android/ipc.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/android/ipc.c b/android/ipc.c
index ed3ef3c..d6b96e3 100644
--- a/android/ipc.c
+++ b/android/ipc.c
@@ -45,6 +45,9 @@ static struct service_handler services[HAL_SERVICE_ID_MAX + 1];
 static GIOChannel *cmd_io = NULL;
 static GIOChannel *notif_io = NULL;
 
+static guint cmd_watch = 0;
+static guint notif_watch = 0;
+
 int ipc_handle_msg(struct service_handler *handlers, size_t max_index,
 						const void *buf, ssize_t len)
 {
@@ -192,11 +195,11 @@ static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
 
 	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(io, cond, notif_watch_cb, NULL);
+	notif_watch = g_io_add_watch(io, cond, notif_watch_cb, NULL);
 
 	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
+	cmd_watch = g_io_add_watch(cmd_io, cond, cmd_watch_cb, NULL);
 
 	info("IPC: successfully connected");
 
@@ -232,12 +235,22 @@ void ipc_init(void)
 
 void ipc_cleanup(void)
 {
+	if (cmd_watch) {
+		g_source_remove(cmd_watch);
+		cmd_watch = 0;
+	}
+
 	if (cmd_io) {
 		g_io_channel_shutdown(cmd_io, TRUE, NULL);
 		g_io_channel_unref(cmd_io);
 		cmd_io = NULL;
 	}
 
+	if (notif_watch) {
+		g_source_remove(notif_watch);
+		notif_watch = 0;
+	}
+
 	if (notif_io) {
 		g_io_channel_shutdown(notif_io, TRUE, NULL);
 		g_io_channel_unref(notif_io);
-- 
1.8.3.1

