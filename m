Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 14/16] audio/AVRCP: Add support for Search command
Date: Fri, 14 Jun 2013 15:41:48 +0300
Message-Id: <1371213710-16607-15-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
References: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for Search command via player callback.
---
 profiles/audio/avrcp.c  | 54 +++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |  2 ++
 2 files changed, 56 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 31fcaad..4dce600 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -106,6 +106,7 @@
 #define AVRCP_CHANGE_PATH		0x72
 #define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_PLAY_ITEM			0x74
+#define AVRCP_SEARCH			0x80
 #define AVRCP_ADD_TO_NOW_PLAYING	0x90
 #define AVRCP_GENERAL_REJECT		0xA0
 
@@ -2632,6 +2633,58 @@ static int ct_change_folder(struct media_player *mp, const char *path,
 	return 0;
 }
 
+static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct avrcp *session = (void *) user_data;
+	struct avrcp_player *player = session->player;
+
+	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
+							operand_count < 7)
+		return FALSE;
+
+	player->uid_counter = bt_get_be16(&pdu->params[1]);
+
+	return FALSE;
+}
+
+static void avrcp_search(struct avrcp *session, const char *string)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 255];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	uint16_t len;
+
+	len = strlen(string);
+	if (len > 251)
+		len = 251;
+
+	memset(buf, 0, sizeof(buf));
+	bt_put_be16(0x6A, &pdu->params[0]);
+	bt_put_be16(len, &pdu->params[2]);
+	memcpy(&pdu->params[4], string, len);
+	pdu->pdu_id = AVRCP_SEARCH;
+	pdu->param_len = htons(len + 4);
+
+	len = AVRCP_BROWSING_HEADER_LENGTH + len + 4;
+
+	avctp_send_browsing_req(session->conn, buf, len, avrcp_search_rsp,
+								session);
+}
+
+static int ct_search(struct media_player *mp, const char *string,
+							void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp *session;
+
+	session = player->sessions->data;
+
+	avrcp_search(session, string);
+
+	return 0;
+}
+
 static void avrcp_play_item(struct avrcp *session, uint64_t uid)
 {
 	uint8_t buf[AVRCP_HEADER_LENGTH + 11];
@@ -2735,6 +2788,7 @@ static const struct media_player_callback ct_cbs = {
 	.rewind		= ct_rewind,
 	.list_items	= ct_list_items,
 	.change_folder	= ct_change_folder,
+	.search		= ct_search,
 	.play_item	= ct_play_item,
 	.add_to_nowplaying = ct_add_to_nowplaying,
 };
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 150b38a..eecab1b 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -58,6 +58,8 @@ struct media_player_callback {
 				uint32_t start, uint32_t end, void *user_data);
 	int (*change_folder) (struct media_player *mp, const char *path,
 						uint64_t uid, void *user_data);
+	int (*search) (struct media_player *mp, const char *string,
+						void *user_data);
 	int (*play_item) (struct media_player *mp, const char *name,
 					uint64_t uid, void *user_data);
 	int (*add_to_nowplaying) (struct media_player *mp, const char *name,
-- 
1.8.1.4

