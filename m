Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 7/7] android/handsfree: Use HFP code for connection handling
Date: Sat, 22 Feb 2014 22:09:25 +0100
Message-Id: <1393103365-19908-7-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
References: <1393103365-19908-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@tieto.com>

HFP code is now able to handle disconnection on its own so just use
this instead of using own watches.
---
 android/handsfree.c | 50 +++++++++++++-------------------------------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 680345b..60bff91 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -51,8 +51,6 @@
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
-	GIOChannel *io;
-	guint watch;
 	struct hfp_gw *gw;
 } device;
 
@@ -95,38 +93,23 @@ static void device_cleanup(void)
 		device.gw = NULL;
 	}
 
-	if (device.watch) {
-		g_source_remove(device.watch);
-		device.watch = 0;
-	}
-
-	if (device.io) {
-		g_io_channel_unref(device.io);
-		device.io = NULL;
-	}
-
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED);
 
 	memset(&device, 0, sizeof(device));
 }
 
-static gboolean watch_cb(GIOChannel *chan, GIOCondition cond,
-							gpointer user_data)
+static void at_command_handler(const char *command, void *user_data)
 {
-	DBG("");
-
-	device.watch = 0;
-
-	device_cleanup();
+	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 
-	return FALSE;
+	hfp_gw_disconnect(device.gw);
 }
 
-static void at_command_handler(const char *command, void *user_data)
+static void disconnect_watch(void *user_data)
 {
-	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+	DBG("");
 
-	g_io_channel_shutdown(device.io, TRUE, NULL);
+	device_cleanup();
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -138,22 +121,15 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		goto failed;
 	}
 
-	g_io_channel_set_close_on_unref(chan, TRUE);
-
 	device.gw = hfp_gw_new(g_io_channel_unix_get_fd(chan));
 	if (!device.gw)
 		goto failed;
 
+	g_io_channel_set_close_on_unref(chan, FALSE);
+
 	hfp_gw_set_close_on_unref(device.gw, true);
 	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
-
-	device.watch = g_io_add_watch(chan,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					watch_cb, NULL);
-	if (device.watch == 0)
-		goto failed;
-
-	device.io = g_io_channel_ref(chan);
+	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
 
 	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
 
@@ -331,11 +307,11 @@ static void handle_disconnect(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (device.io) {
-		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING);
-		g_io_channel_shutdown(device.io, TRUE, NULL);
-	} else {
+	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING) {
 		device_cleanup();
+	} else {
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING);
+		hfp_gw_disconnect(device.gw);
 	}
 
 	status = HAL_STATUS_SUCCESS;
-- 
1.9.0

