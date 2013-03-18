Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4 v2] AVRCP: Fallback to GetElementAttributes if GetItemAttributes fails
Date: Mon, 18 Mar 2013 10:14:40 -0300
Message-Id: <1363612480-8330-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
References: <1363612480-8330-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If GetItemAttributes fails with error set to player not browsable
fallback to GetElementAttributes.
---
 profiles/audio/avrcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5b5f491..409cf5b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -74,6 +74,7 @@
 #define AVRCP_STATUS_INTERNAL_ERROR		0x03
 #define AVRCP_STATUS_SUCCESS			0x04
 #define AVRCP_STATUS_INVALID_PLAYER_ID		0x11
+#define AVRCP_STATUS_PLAYER_NOT_BROWSABLE	0x12
 #define AVRCP_STATUS_NO_AVAILABLE_PLAYERS	0x15
 #define AVRCP_STATUS_ADDRESSED_PLAYER_CHANGED	0x16
 
@@ -2002,8 +2003,11 @@ static gboolean avrcp_get_item_attributes_rsp(struct avctp *conn,
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint8_t count;
 
-	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4)
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 4) {
+		if (pdu->params[0] == AVRCP_STATUS_PLAYER_NOT_BROWSABLE)
+			avrcp_get_element_attributes(session);
 		return FALSE;
+	}
 
 	count = pdu->params[1];
 
-- 
1.8.1.4

