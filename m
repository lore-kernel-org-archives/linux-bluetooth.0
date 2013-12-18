Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 3/7] android/pan: shutdown io channel on disconnect call
Date: Wed, 18 Dec 2013 16:53:12 +0200
Message-Id: <1387378396-6259-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Shutdown io channel and send DISCONNECTING notification and send
DISCONNECTED notification and free the device on callback.
---
 android/pan.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b83f534..f64b09a 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -269,7 +269,7 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_pan_disconnect *cmd = buf;
 	struct pan_device *dev;
-	uint8_t status;
+	uint8_t status = HAL_STATUS_FAILED;
 	GSList *l;
 	bdaddr_t dst;
 
@@ -278,20 +278,20 @@ static void bt_pan_disconnect(const void *buf, uint16_t len)
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
-	if (!l) {
-		status = HAL_STATUS_FAILED;
+	if (!l)
 		goto failed;
-	}
 
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

