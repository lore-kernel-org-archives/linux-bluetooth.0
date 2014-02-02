Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/13] android/handsfree: Add disconnect command handling
Date: Sun,  2 Feb 2014 22:09:21 +0100
Message-Id: <1391375364-27106-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 79e61b4..5fe7638 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -311,10 +311,38 @@ failed:
 
 static void handle_disconnect(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_disconnect *cmd = buf;
+	bdaddr_t bdaddr;
+	uint8_t status;
+
 	DBG("");
 
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED ||
+			bacmp(&device.bdaddr, &bdaddr)) {
+		status = HAL_STATUS_FAILED;
+		goto failed;
+
+	}
+
+	if (device.state == HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING) {
+		status = HAL_STATUS_SUCCESS;
+		goto failed;
+	}
+
+	if (device.io) {
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTING);
+		g_io_channel_shutdown(device.io, TRUE, NULL);
+	} else {
+		device_cleanup();
+	}
+
+	status = HAL_STATUS_SUCCESS;
+
+failed:
 	ipc_send_rsp(HAL_SERVICE_ID_HANDSFREE, HAL_OP_HANDSFREE_DISCONNECT,
-							HAL_STATUS_FAILED);
+									status);
 }
 
 static void handle_connect_audio(const void *buf, uint16_t len)
-- 
1.8.5.3

