Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/15] AVRCP: Fix crash when registering unsupported notification
Date: Mon, 10 Jun 2013 13:36:56 +0300
Message-Id: <1370860630-30359-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Reject command if notification is not supported otherwise this can
cause crashes.
---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4558407..5bddd08 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1355,7 +1355,7 @@ static uint8_t avrcp_handle_register_notification(struct avrcp *session,
 	 * one is applicable only for EVENT_PLAYBACK_POS_CHANGED. See AVRCP
 	 * 1.3 spec, section 5.4.2.
 	 */
-	if (len != 5)
+	if (len != 5 || !(session->supported_events & (1 << pdu->params[0])))
 		goto err;
 
 	switch (pdu->params[0]) {
-- 
1.8.1.4

