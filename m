Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] android/A2DP: Use avdtp_add_disconnect_cb to cleanup on disconnect
Date: Thu, 19 Dec 2013 17:15:54 +0200
Message-Id: <1387466156-14100-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
References: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces the use of g_io_add_watch with avdtp_add_disconnect_cb so
connection tracking stay within AVDTP code.
---
 android/a2dp.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 107cbb8..2de2f66 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -57,7 +57,6 @@ struct a2dp_device {
 	bdaddr_t	dst;
 	uint8_t		state;
 	GIOChannel	*io;
-	guint		watch;
 	struct avdtp	*session;
 };
 
@@ -74,9 +73,6 @@ static void a2dp_device_free(struct a2dp_device *dev)
 	if (dev->session)
 		avdtp_unref(dev->session);
 
-	if (dev->watch > 0)
-		g_source_remove(dev->watch);
-
 	if (dev->io)
 		g_io_channel_unref(dev->io);
 
@@ -120,13 +116,11 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 	a2dp_device_free(dev);
 }
 
-static gboolean watch_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+static void disconnect_cb(void *user_data)
 {
-	struct a2dp_device *dev = data;
+	struct a2dp_device *dev = user_data;
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
-
-	return FALSE;
 }
 
 static void signaling_connect_cb(GIOChannel *chan, GError *err,
@@ -157,9 +151,7 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 	/* FIXME: Add proper version */
 	fd = g_io_channel_unix_get_fd(chan);
 	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
-
-	dev->watch = g_io_add_watch(dev->io, G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-								watch_cb, dev);
+	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
 
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
 }
-- 
1.8.3.1

