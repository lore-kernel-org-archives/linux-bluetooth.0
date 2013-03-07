Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5 v2] AVRCP: Fix not checking for invalid player items
Date: Thu,  7 Mar 2013 17:11:59 +0200
Message-Id: <1362669119-10890-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
References: <1362669119-10890-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds checks for invalid size in the media player list returned by
GetFolderItems that could cause crashes.
---
 profiles/audio/avrcp.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 192a466..e3dbb6b 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2108,16 +2108,17 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 						size_t operand_count,
 						void *user_data)
 {
+	struct avrcp_browsing_header *pdu = (void *) operands;
 	struct avrcp *session = user_data;
 	uint16_t count;
-	int i;
+	size_t i;
 
-	if (operands[3] != AVRCP_STATUS_SUCCESS || operand_count < 5)
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 5)
 		return FALSE;
 
 	count = bt_get_be16(&operands[6]);
 
-	for (i = 8; count; count--) {
+	for (i = 8; count && i < operand_count; count--) {
 		uint8_t type;
 		uint16_t len;
 
@@ -2130,7 +2131,14 @@ static gboolean avrcp_get_media_player_list_rsp(struct avctp *conn,
 			continue;
 		}
 
+		if (i + len > operand_count) {
+			error("Invalid player item length");
+			return FALSE;
+		}
+
 		avrcp_parse_media_player_item(session, &operands[i], len);
+
+		i += len;
 	}
 
 	return FALSE;
-- 
1.8.1.4

