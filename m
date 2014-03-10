Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] android/avrcp: Fix not handling SetAbsoluteVolume response
Date: Mon, 10 Mar 2014 11:33:08 +0200
Message-Id: <1394443988-6004-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1394443988-6004-1-git-send-email-luiz.dentz@gmail.com>
References: <1394443988-6004-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This follow what is stated in AVRCP specification 1.5 page 83:

" When the volume is changed on the TG by this command the Volume Change
notification shall not be completed."

Therefore the only option is to treat the response and self generate
changed notification.
---
 android/avrcp.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index b9085e6..5891a08 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -330,6 +330,31 @@ done:
 			HAL_OP_AVRCP_REGISTER_NOTIFICATION, status);
 }
 
+static gboolean set_volume_rsp(struct avctp *conn,
+					uint8_t code, uint8_t subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct hal_ev_avrcp_volume_changed ev;
+	uint8_t *params;
+
+	if (code != AVC_CTYPE_INTERIM && code != AVC_CTYPE_CHANGED)
+		return FALSE;
+
+	if (operands == NULL || operand_count < 7)
+		return FALSE;
+
+	params = &operands[7];
+
+	ev.volume = params[0] & 0x7F;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_AVRCP,
+					HAL_EV_AVRCP_VOLUME_CHANGED,
+					sizeof(ev), &ev);
+
+	return FALSE;
+}
+
 static void handle_set_volume(const void *buf, uint16_t len)
 {
 	struct hal_cmd_avrcp_set_volume *cmd = (void *) buf;
@@ -350,7 +375,8 @@ static void handle_set_volume(const void *buf, uint16_t len)
 	 */
 	dev = devices->data;
 
-	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f, NULL, NULL);
+	ret = avrcp_set_volume(dev->session, cmd->value & 0x7f, set_volume_rsp,
+									dev);
 	if (ret < 0) {
 		status = HAL_STATUS_FAILED;
 		goto done;
-- 
1.8.5.3

