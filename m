Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android: Connect daemon to HAL library
Date: Sat, 19 Oct 2013 01:01:40 +0200
Message-Id: <1382137302-17237-4-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
References: <1382137302-17237-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

Connect to HAL when adapter initialization is finished. If any problem
with connection occurs or connected socket is closed by remote daemon
shutdowns.
---
 android/main.c | 133 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/android/main.c b/android/main.c
index c3fb80e..5b71265 100644
--- a/android/main.c
+++ b/android/main.c
@@ -32,7 +32,10 @@
 #include <stdlib.h>
 #include <stdbool.h>
 #include <string.h>
+#include <errno.h>
 #include <sys/signalfd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
 #include <glib.h>
 
@@ -44,6 +47,7 @@
 #include "src/shared/mgmt.h"
 
 #include "adapter.h"
+#include "hal-msg.h"
 
 #define SHUTDOWN_GRACE_SECONDS 10
 
@@ -55,8 +59,135 @@ static uint8_t mgmt_revision = 0;
 
 static uint16_t adapter_index = MGMT_INDEX_NONE;
 
+static GIOChannel *hal_cmd_io = NULL;
+static GIOChannel *hal_notif_io = NULL;
+
 static volatile sig_atomic_t __terminated = 0;
 
+static gboolean watch_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	info("HAL socket closed, terminating");
+	g_main_loop_quit(event_loop);
+
+	return FALSE;
+}
+
+static GIOChannel *create_io(void)
+{
+	int sk;
+	int err;
+	GIOChannel *io;
+
+	sk = socket(PF_LOCAL, SOCK_SEQPACKET, 0);
+	if (sk < 0) {
+		err = errno;
+		error("Failed to create socket: %d (%s)", err, strerror(err));
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(sk);
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+	g_io_channel_set_flags(io, G_IO_FLAG_NONBLOCK, NULL);
+
+	return io;
+}
+
+static int connect_io(GIOChannel *io, GIOFunc connect_cb)
+{
+	int err;
+	struct sockaddr_un addr;
+	GIOCondition cond;
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	/* Use abstract sockets so first byte needs to be \0 */
+	strcpy(addr.sun_path + 1, BLUEZ_HAL_SK_PATH);
+
+	err = connect(g_io_channel_unix_get_fd(io),
+				(struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		err = -errno;
+		error("Failed to connect HAL socket: %d (%s)", -err,
+							strerror(-err));
+		return err;
+	}
+
+	cond = G_IO_OUT | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(io, cond, connect_cb, NULL);
+
+	return 0;
+}
+
+static gboolean notif_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_main_loop_quit(event_loop);
+		return FALSE;
+	}
+
+	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(io, cond, watch_cb, NULL);
+
+	info("Successfully connected to HAL");
+
+	/* TODO start handling commands */
+
+	return FALSE;
+}
+
+static void connect_notification_socket(void)
+{
+	DBG("");
+
+	hal_notif_io = create_io();
+
+	if (hal_notif_io && connect_io(hal_notif_io, notif_connect_cb) == 0)
+		return;
+
+	error("Cannot connect to HAL, terminating");
+	g_main_loop_quit(event_loop);
+}
+
+static gboolean cmd_connect_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) {
+		g_main_loop_quit(event_loop);
+		return FALSE;
+	}
+
+	cond = G_IO_ERR | G_IO_HUP | G_IO_NVAL;
+
+	g_io_add_watch(io, cond, watch_cb, NULL);
+
+	connect_notification_socket();
+
+	return FALSE;
+}
+
+static void connect_cmd_socket(void)
+{
+	DBG("");
+
+	hal_cmd_io = create_io();
+
+	if (hal_cmd_io && connect_io(hal_cmd_io, cmd_connect_cb) == 0)
+		return;
+
+	error("Cannot connect to HAL, terminating");
+	g_main_loop_quit(event_loop);
+}
+
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -141,6 +272,8 @@ static void adapter_ready(struct bt_adapter *adapter, int err)
 	}
 
 	info("Adapter initialized");
+
+	connect_cmd_socket();
 }
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
-- 
1.8.4.rc3

