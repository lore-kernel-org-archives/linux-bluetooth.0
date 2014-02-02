Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/13] android/handsfree: Add initial code for AT commands processing
Date: Sun,  2 Feb 2014 22:09:19 +0100
Message-Id: <1391375364-27106-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently always reply with error and disconnect connection.
---
 android/Makefile.am |  2 ++
 android/handsfree.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/android/Makefile.am b/android/Makefile.am
index 23e30c9..41bbbcb 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -27,6 +27,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/queue.h src/shared/queue.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/ringbuf.h src/shared/ringbuf.c \
+				src/shared/hfp.h src/shared/hfp.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc.h android/ipc.c \
diff --git a/android/handsfree.c b/android/handsfree.c
index ad4c0ff..a4ce398 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -37,6 +37,7 @@
 #include "lib/uuid.h"
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
+#include "src/shared/hfp.h"
 #include "btio/btio.h"
 #include "handsfree.h"
 #include "bluetooth.h"
@@ -53,6 +54,7 @@ static struct {
 	uint8_t state;
 	GIOChannel *io;
 	guint watch;
+	struct hfp_gw *gw;
 } device;
 
 static bdaddr_t adapter_addr;
@@ -89,6 +91,11 @@ static void device_init(const bdaddr_t *bdaddr)
 
 static void device_cleanup(void)
 {
+	if (device.gw) {
+		hfp_gw_unref(device.gw);
+		device.gw = NULL;
+	}
+
 	if (device.watch) {
 		g_source_remove(device.watch);
 		device.watch = 0;
@@ -116,6 +123,13 @@ static gboolean watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static void at_command_handler(const char *command, void *user_data)
+{
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+
+	g_io_channel_shutdown(device.io, TRUE, NULL);
+}
+
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	DBG("");
@@ -127,6 +141,13 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	g_io_channel_set_close_on_unref(chan, TRUE);
 
+	device.gw = hfp_gw_new(g_io_channel_unix_get_fd(chan));
+	if (!device.gw)
+		goto failed;
+
+	hfp_gw_set_close_on_unref(device.gw, true);
+	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
+
 	device.watch = g_io_add_watch(chan,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					watch_cb, NULL);
-- 
1.8.5.3

