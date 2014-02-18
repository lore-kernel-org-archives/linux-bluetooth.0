Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/13] android/hal-avrcp: Add .get_play_status implementation
Date: Tue, 18 Feb 2014 16:24:20 +0200
Message-Id: <1392733470-22736-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
References: <1392733470-22736-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-avrcp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/android/hal-avrcp.c b/android/hal-avrcp.c
index 01d233b..9937a11 100644
--- a/android/hal-avrcp.c
+++ b/android/hal-avrcp.c
@@ -56,6 +56,24 @@ static bt_status_t init(btrc_callbacks_t *callbacks)
 	return ret;
 }
 
+static bt_status_t get_play_status_rsp(btrc_play_status_t status,
+					uint32_t song_len, uint32_t song_pos)
+{
+	struct hal_cmd_avrcp_get_play_status cmd;
+
+	DBG("");
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	cmd.status = status;
+	cmd.duration = song_len;
+	cmd.position = song_pos;
+
+	return hal_ipc_cmd(HAL_SERVICE_ID_AVRCP, HAL_OP_AVRCP_GET_PLAY_STATUS,
+					sizeof(cmd), &cmd, 0, NULL, NULL);
+}
+
 static void cleanup()
 {
 	struct hal_cmd_unregister_module cmd;
@@ -78,6 +96,7 @@ static void cleanup()
 static btrc_interface_t iface = {
 	.size = sizeof(iface),
 	.init = init,
+	.get_play_status_rsp = get_play_status_rsp,
 	.cleanup = cleanup
 };
 
-- 
1.8.5.3

