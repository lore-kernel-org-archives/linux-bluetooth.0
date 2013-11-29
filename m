Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 4/6] android/pan: Implement pan disconnect method in daemon
Date: Fri, 29 Nov 2013 16:20:43 +0200
Message-Id: <1385734845-9725-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Disconnect ongoing PANU role connection betweek devices, free
the device and notify the connection state.
---
 android/pan.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 031dfff..7093e4c 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -238,9 +238,35 @@ static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct pan_device *dev;
+	GSList *l;
+	bdaddr_t dst;
 
-	return HAL_STATUS_FAILED;
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(peers, &dst, peer_cmp);
+	if (!l)
+		return HAL_STATUS_FAILED;
+
+	dev = l->data;
+
+	if (dev->watch) {
+		g_source_remove(dev->watch);
+		dev->watch = 0;
+	}
+
+	bnep_if_down(dev->dev);
+	bnep_kill_connection(&dst);
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+	pan_device_free(dev);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
-- 
1.8.3.2

