Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 12/13] AVRCP: Add support for AddToNowPlaying command
Date: Tue, 28 May 2013 15:51:30 +0300
Message-Id: <1369745491-23897-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for AddToNowPlaying command via player callback.
---
 profiles/audio/avrcp.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |  2 ++
 2 files changed, 50 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index e9e2645..234cd3a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -105,6 +105,7 @@
 #define AVRCP_CHANGE_PATH		0x72
 #define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_PLAY_ITEM			0x74
+#define AVRCP_ADD_TO_NOW_PLAYING	0x90
 #define AVRCP_GENERAL_REJECT		0xA0
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
@@ -2580,6 +2581,52 @@ static int ct_play_item(struct media_player *mp, const char *name,
 	return 0;
 }
 
+static void avrcp_add_to_nowplaying(struct avrcp *session, uint64_t uid)
+{
+	uint8_t buf[AVRCP_HEADER_LENGTH + 11];
+	struct avrcp_player *player = session->player;
+	struct avrcp_header *pdu = (void *) buf;
+	uint16_t length;
+
+	memset(buf, 0, sizeof(buf));
+
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
+	pdu->pdu_id = AVRCP_ADD_TO_NOW_PLAYING;
+	pdu->params_len = htons(11);
+	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+
+	pdu->params[0] = player->scope;
+	bt_put_be64(uid, &pdu->params[1]);
+	bt_put_be16(player->uid_counter, &pdu->params[9]);
+
+	length = AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+
+	avctp_send_vendordep_req(session->conn, AVC_CTYPE_STATUS,
+					AVC_SUBUNIT_PANEL, buf, length,
+					NULL, session);
+}
+
+static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
+						uint64_t uid, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp *session;
+
+	if (player->p != NULL)
+		return -EBUSY;
+
+	session = player->sessions->data;
+
+	if (g_strrstr(name, "/NowPlaying"))
+		player->scope = 0x03;
+	else
+		player->scope = 0x01;
+
+	avrcp_add_to_nowplaying(session, uid);
+
+	return 0;
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= ct_set_setting,
 	.play		= ct_play,
@@ -2592,6 +2639,7 @@ static const struct media_player_callback ct_cbs = {
 	.list_items	= ct_list_items,
 	.change_folder	= ct_change_folder,
 	.play_item	= ct_play_item,
+	.add_to_nowplaying = ct_add_to_nowplaying,
 };
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index a8732f5..259110f 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -60,6 +60,8 @@ struct media_player_callback {
 						uint64_t uid, void *user_data);
 	int (*play_item) (struct media_player *mp, const char *name,
 					uint64_t uid, void *user_data);
+	int (*add_to_nowplaying) (struct media_player *mp, const char *name,
+					uint64_t uid, void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path,
-- 
1.8.1.4

