Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/handsfree: Handle disconnect_audio call
Date: Fri,  7 Mar 2014 21:23:19 +0100
Message-Id: <1394223800-11961-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change adds handling of disconnect_audio call.
---
 android/handsfree.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a3c684e..69de670 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -839,6 +839,27 @@ static bool connect_sco(void)
 	return true;
 }
 
+static bool disconnect_sco(void)
+{
+	if (!device.sco)
+		return false;
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTING);
+
+	if (device.sco_watch) {
+		g_source_remove(device.sco_watch);
+		device.sco_watch = 0;
+	}
+
+	g_io_channel_shutdown(device.sco, TRUE, NULL);
+	g_io_channel_unref(device.sco);
+	device.sco = NULL;
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+
+	return true;
+}
+
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	const struct hal_cmd_handsfree_connect_audio *cmd = buf;
@@ -864,10 +885,25 @@ done:
 
 static void handle_disconnect_audio(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_disconnect_audio *cmd = buf;
+	bdaddr_t bdaddr;
+	uint8_t status;
+
 	DBG("");
 
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED ||
+			bacmp(&device.bdaddr, &bdaddr)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = disconnect_sco() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_DISCONNECT_AUDIO, HAL_STATUS_FAILED);
+				HAL_OP_HANDSFREE_DISCONNECT_AUDIO, status);
 }
 
 static void handle_start_vr(const void *buf, uint16_t len)
-- 
1.8.3.1

