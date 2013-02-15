Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 7/7] AVRCP: Fix parsing of SetBrowsedPlayer response
Date: Fri, 15 Feb 2013 16:02:52 +0200
Message-Id: <1360936972-12952-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
References: <1360936972-12952-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Folder depth is actually the byte 13 not 14 of the response.
---
 profiles/audio/avrcp.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9833a3a..9be977e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1928,29 +1928,30 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct media_player *mp = player->user_data;
+	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint32_t items;
 	char **folders, *path;
 	uint8_t depth, count;
 	int i;
 
-	if (operands[3] != AVRCP_STATUS_SUCCESS || operand_count < 13)
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 13)
 		return FALSE;
 
-	player->uid_counter = bt_get_be16(&operands[4]);
+	player->uid_counter = bt_get_be16(&pdu->params[1]);
 
-	items = bt_get_be32(&operands[6]);
+	items = bt_get_be32(&pdu->params[3]);
 
-	depth = operands[13];
+	depth = operands[9];
 
 	folders = g_new0(char *, depth + 2);
 	folders[0] = g_strdup("/Filesystem");
 
-	for (i = 14, count = 1; count - 1 < depth; count++) {
+	for (i = 10, count = 1; count - 1 < depth; count++) {
 		char *part;
 		uint8_t len;
 
-		len = operands[i++];
-		part = g_memdup(&operands[i], len);
+		len = pdu->params[i++];
+		part = g_memdup(&pdu->params[i], len);
 		i += len;
 		folders[count] = part;
 	}
-- 
1.8.1.2

