Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/A2DP: Fix disconnecting after AVDTP session creation
Date: Thu, 19 Dec 2013 17:15:56 +0200
Message-Id: <1387466156-14100-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
References: <1387466156-14100-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Once the connection is handover to AVDTP code the GIOChannel can be
unref but it should not close the connection.
---
 android/a2dp.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index 2de2f66..9087c62 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -73,8 +73,10 @@ static void a2dp_device_free(struct a2dp_device *dev)
 	if (dev->session)
 		avdtp_unref(dev->session);
 
-	if (dev->io)
+	if (dev->io) {
+		g_io_channel_shutdown(dev->io, FALSE, NULL);
 		g_io_channel_unref(dev->io);
+	}
 
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
@@ -148,11 +150,18 @@ static void signaling_connect_cb(GIOChannel *chan, GError *err,
 		return;
 	}
 
-	/* FIXME: Add proper version */
+	g_io_channel_set_close_on_unref(chan, FALSE);
 	fd = g_io_channel_unix_get_fd(chan);
+
+	/* FIXME: Add proper version */
 	dev->session = avdtp_new(fd, imtu, omtu, 0x0100);
 	avdtp_add_disconnect_cb(dev->session, disconnect_cb, dev);
 
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
+
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_CONNECTED);
 }
 
@@ -221,15 +230,17 @@ static void bt_a2dp_disconnect(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
+	status = HAL_STATUS_SUCCESS;
 
-	/* Wait signaling channel to HUP */
-	if (dev->io)
-		g_io_channel_shutdown(dev->io, TRUE, NULL);
+	if (dev->io) {
+		bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTED);
+		goto failed;
+	}
 
+	/* Wait AVDTP session to shutdown */
+	avdtp_shutdown(dev->session);
 	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTING);
 
-	status = HAL_STATUS_SUCCESS;
-
 failed:
 	ipc_send_rsp(HAL_SERVICE_ID_A2DP, HAL_OP_A2DP_DISCONNECT, status);
 }
-- 
1.8.3.1

