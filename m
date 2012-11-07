Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] AVRCP: Add support for GetCapabilities PDU when acting as controller
Date: Wed,  7 Nov 2012 12:34:02 +0200
Message-Id: <1352284442-6855-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352284442-6855-1-git-send-email-luiz.dentz@gmail.com>
References: <1352284442-6855-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GetCapabilities PDU id to controller handlers vtable so it is
able to respond it properly.
---
 audio/avrcp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index ab9ffbf..e3ce2fb 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1412,6 +1412,8 @@ static const struct control_pdu_handler tg_control_handlers[] = {
 };
 
 static const struct control_pdu_handler ct_control_handlers[] = {
+		{ AVRCP_GET_CAPABILITIES, AVC_CTYPE_STATUS,
+					avrcp_handle_get_capabilities },
 		{ },
 };
 
-- 
1.7.11.7

