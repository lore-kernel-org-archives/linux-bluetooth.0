Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v6 1/5] android/pan: shutdown io channel on disconnect call
Date: Thu, 19 Dec 2013 16:39:39 +0200
Message-Id: <1387463983-6373-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Shutdown io channel and send DISCONNECTING notification and send
DISCONNECTED notification and free the device on callback.
---
 android/pan.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b83f534..187953b 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -284,14 +284,16 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	}
 
 	dev = l->data;
-	if (dev->watch) {
-		g_source_remove(dev->watch);
-		dev->watch = 0;
+
+	if (dev->io)
+		g_io_channel_shutdown(dev->io, TRUE, NULL);
+
+	if (dev->conn_state == HAL_PAN_STATE_CONNECTED) {
+		bnep_if_down(dev->iface);
+		bnep_conndel(&dst);
 	}
 
-	bnep_if_down(dev->iface);
-	bnep_conndel(&dst);
-	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTING);
 	status = HAL_STATUS_SUCCESS;
 
 failed:
-- 
1.8.3.2

