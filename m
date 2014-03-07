Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android/handsfree: Handle connect_audio call
Date: Fri,  7 Mar 2014 21:23:18 +0100
Message-Id: <1394223800-11961-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This change handle connect_audio and start connect procedure.
---
 android/handsfree.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 40f3652..a3c684e 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -813,12 +813,53 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
 }
 
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
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
+	const struct hal_cmd_handsfree_connect_audio *cmd = buf;
+	bdaddr_t bdaddr;
+	uint8_t status;
+
 	DBG("");
 
+	android2bdaddr(cmd->bdaddr, &bdaddr);
+
+	if (device.audio_state != HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED ||
+			bacmp(&device.bdaddr, &bdaddr)) {
+		status = HAL_STATUS_FAILED;
+		goto done;
+	}
+
+	status = connect_sco() ? HAL_STATUS_SUCCESS : HAL_STATUS_FAILED;
+
+done:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
-			HAL_OP_HANDSFREE_CONNECT_AUDIO, HAL_STATUS_FAILED);
+				HAL_OP_HANDSFREE_CONNECT_AUDIO, status);
 }
 
 static void handle_disconnect_audio(const void *buf, uint16_t len)
-- 
1.8.3.1

