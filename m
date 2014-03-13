Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/handsfree: Move connect_sco() to more appropriate place
Date: Thu, 13 Mar 2014 15:04:36 +0100
Message-Id: <1394719477-7590-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394719477-7590-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394719477-7590-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move connect_sco as it will be used in at_cmd_bcc()
---
 android/handsfree.c | 122 ++++++++++++++++++++++++++--------------------------
 1 file changed, 61 insertions(+), 61 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 44d1f32..1aee695 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -810,6 +810,67 @@ static void at_cmd_btrh(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 }
 
+static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	g_io_channel_shutdown(device.sco, TRUE, NULL);
+	g_io_channel_unref(device.sco);
+	device.sco = NULL;
+
+	device.sco_watch = 0;
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	if (err) {
+		uint8_t status;
+
+		error("SCO: connect failed (%s)", err->message);
+		status = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
+		device_set_audio_state(status);
+
+		return;
+	}
+
+	g_io_channel_set_close_on_unref(chan, TRUE);
+
+	device.sco = g_io_channel_ref(chan);
+	device.sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							sco_watch_cb, NULL);
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+}
+
+static bool connect_sco(void)
+{
+	GIOChannel *io;
+	GError *gerr = NULL;
+
+	if (device.sco)
+		return false;
+
+	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
+				BT_IO_OPT_INVALID);
+
+	if (!io) {
+		error("SCO: unable to connect: %s", gerr->message);
+		g_error_free(gerr);
+		return false;
+	}
+
+	g_io_channel_unref(io);
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+
+	return true;
+}
+
 static void at_cmd_bcc(struct hfp_gw_result *result, enum hfp_gw_cmd_type type,
 							void *user_data)
 {
@@ -1461,67 +1522,6 @@ failed:
 					HAL_OP_HANDSFREE_DISCONNECT, status);
 }
 
-static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
-							gpointer user_data)
-{
-	g_io_channel_shutdown(device.sco, TRUE, NULL);
-	g_io_channel_unref(device.sco);
-	device.sco = NULL;
-
-	device.sco_watch = 0;
-
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
-
-	return FALSE;
-}
-
-static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
-{
-	if (err) {
-		uint8_t status;
-
-		error("SCO: connect failed (%s)", err->message);
-		status = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
-		device_set_audio_state(status);
-
-		return;
-	}
-
-	g_io_channel_set_close_on_unref(chan, TRUE);
-
-	device.sco = g_io_channel_ref(chan);
-	device.sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-							sco_watch_cb, NULL);
-
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
-}
-
-static bool connect_sco(void)
-{
-	GIOChannel *io;
-	GError *gerr = NULL;
-
-	if (device.sco)
-		return false;
-
-	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
-				BT_IO_OPT_DEST_BDADDR, &device.bdaddr,
-				BT_IO_OPT_INVALID);
-
-	if (!io) {
-		error("SCO: unable to connect: %s", gerr->message);
-		g_error_free(gerr);
-		return false;
-	}
-
-	g_io_channel_unref(io);
-
-	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
-
-	return true;
-}
-
 static bool disconnect_sco(void)
 {
 	if (!device.sco)
-- 
1.8.3.1

