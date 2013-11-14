Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] android/a2dp: Add initial implementation of HAL_OP_A2DP_DISCONNECT
Date: Thu, 14 Nov 2013 12:18:21 +0200
Message-Id: <1384424301-31265-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
References: <1384424301-31265-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/a2dp.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index adbad05..6d2f8a3 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -178,9 +178,30 @@ static uint8_t bt_a2dp_connect(struct hal_cmd_a2dp_connect *cmd, uint16_t len)
 static uint8_t bt_a2dp_disconnect(struct hal_cmd_a2dp_connect *cmd,
 								uint16_t len)
 {
-	DBG("Not Implemented");
+	struct a2dp_device *dev;
+	GSList *l;
+	bdaddr_t dst;
+
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(devices, &dst, device_cmp);
+	if (!l)
+		return HAL_STATUS_FAILED;
+
+	dev = l->data;
 
-	return HAL_STATUS_FAILED;
+	/* Wait signaling channel to HUP */
+	if (dev->io)
+		g_io_channel_shutdown(dev->io, TRUE, NULL);
+
+	bt_a2dp_notify_state(dev, HAL_A2DP_STATE_DISCONNECTING);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 void bt_a2dp_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
-- 
1.8.3.1

