Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/6] android: Connect daemon to HAL library
Date: Sun, 20 Oct 2013 11:53:56 +0200
Message-Id: <1382262838-25725-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
References: <1382262838-25725-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Connect to HAL when adapter initialization is finished. If any problem
with connection occurs or connected socket is closed by remote daemon
shutdowns.
---
 android/main.c | 122 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 122 insertions(+)

diff --git a/android/main.c b/android/main.c
index cfa728d..2581b87 100644
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
 
@@ -55,8 +59,104 @@ static uint8_t mgmt_revision = 0;
 
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
+static GIOChannel *connect_hal(GIOFunc connect_cb)
+{
+	struct sockaddr_un addr;
+	GIOCondition cond;
+	GIOChannel *io;
+	int err, sk;
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
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+
+	memcpy(addr.sun_path, BLUEZ_HAL_SK_PATH, sizeof(BLUEZ_HAL_SK_PATH));
+
+	err = connect(sk, (struct sockaddr *) &addr, sizeof(addr));
+	if (err < 0) {
+		err = -errno;
+		error("Failed to connect HAL socket: %d (%s)", errno,
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
+	hal_notif_io = connect_hal(notif_connect_cb);
+	if (!hal_notif_io) {
+		error("Cannot connect to HAL, terminating");
+		g_main_loop_quit(event_loop);
+	}
+
+	return FALSE;
+}
+
 static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
 							gpointer user_data)
 {
@@ -141,6 +241,12 @@ static void adapter_ready(struct bt_adapter *adapter, int err)
 	}
 
 	info("Adapter initialized");
+
+	hal_cmd_io = connect_hal(cmd_connect_cb);
+	if (!hal_cmd_io) {
+		error("Cannot connect to HAL, terminating");
+		g_main_loop_quit(event_loop);
+	}
 }
 
 static void mgmt_index_added_event(uint16_t index, uint16_t length,
@@ -290,6 +396,21 @@ static void cleanup_mgmt_interface(void)
 	mgmt_if = NULL;
 }
 
+static void cleanup_hal_connection(void)
+{
+	if (hal_cmd_io) {
+		g_io_channel_shutdown(hal_cmd_io, TRUE, NULL);
+		g_io_channel_unref(hal_cmd_io);
+		hal_cmd_io = NULL;
+	}
+
+	if (hal_notif_io) {
+		g_io_channel_shutdown(hal_notif_io, TRUE, NULL);
+		g_io_channel_unref(hal_notif_io);
+		hal_notif_io = NULL;
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -335,6 +456,7 @@ int main(int argc, char *argv[])
 
 	g_source_remove(signal);
 
+	cleanup_hal_connection();
 	stop_sdp_server();
 	cleanup_mgmt_interface();
 	g_main_loop_unref(event_loop);
-- 
1.8.4

