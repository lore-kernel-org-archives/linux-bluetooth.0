Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] audio/avrcp: Reduce the interval of position changed
Date: Fri,  8 May 2015 16:58:19 +0300
Message-Id: <1431093499-25762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Using UINT32_MAX overflow in Android implementation as it multiple the
value by 1000 to get the interval in miliseconds which seem to truncate
the value causing it to send position changed too frequently flooding
the channel.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 245b3fc..60f8cbf 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3228,7 +3228,7 @@ static void avrcp_register_notification(struct avrcp *session, uint8_t event)
 	 * use it to resync.
 	 */
 	if (event == AVRCP_EVENT_PLAYBACK_POS_CHANGED)
-		bt_put_be32(UINT32_MAX, &pdu->params[1]);
+		bt_put_be32(UINT32_MAX / 1000, &pdu->params[1]);
 
 	pdu->params_len = htons(AVRCP_REGISTER_NOTIFICATION_PARAM_LENGTH);
 
-- 
2.1.0

