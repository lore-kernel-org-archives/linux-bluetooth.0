Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 10/11] android: Add initial code for handling HAL commands
Date: Mon, 21 Oct 2013 20:56:50 +0200
Message-Id: <1382381811-28123-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This enable watch for input and do basic sanity checks on received
command. If there is protocol error mainloop is stopped and daemon
exits.
---
 android/main.c | 43 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/android/main.c b/android/main.c
index 04e8a48..72a1272 100644
--- a/android/main.c
+++ b/android/main.c
@@ -48,6 +48,7 @@
 
 #include "adapter.h"
 #include "hal-msg.h"
+#include "ipc.h"
 #include "main.h"
 
 static GMainLoop *event_loop;
@@ -66,9 +67,45 @@ static volatile sig_atomic_t __terminated = 0;
 static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-	info("HAL command socket closed, terminating");
-	g_main_loop_quit(event_loop);
+	int fd;
+	ssize_t ret;
+	char buf[BLUEZ_HAL_MTU];
+	struct hal_msg_hdr *msg = (void *) buf;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		info("HAL command socket closed, terminating");
+		goto fail;
+	}
+
+	fd = g_io_channel_unix_get_fd(io);
+
+	ret = read(fd, buf, sizeof(buf));
+	if (ret < 0) {
+		error("HAL command read failed, terminating (%s)",
+							strerror(errno));
+		goto fail;
+	}
+
+	if (ret < (ssize_t) sizeof(*msg)) {
+		error("HAL command too small, terminating (%zd)", ret);
+		goto fail;
+	}
+
+	if (ret != (ssize_t) (sizeof(*msg) + msg->len)) {
+		error("Malformed HAL command (%zd bytes), terminating", ret);
+		goto fail;
+	}
+
+	switch (msg->service_id) {
+	default:
+		ipc_send_error(hal_cmd_io, msg->service_id, 0x01);
+		break;
+	}
+
+	return TRUE;
 
+fail:
+	g_main_loop_quit(event_loop);
 	return FALSE;
 }
 
@@ -152,7 +189,7 @@ static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+	cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
 	g_io_add_watch(io, cond, cmd_watch_cb, NULL);
 
-- 
1.8.4

