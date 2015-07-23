Return-Path: <cyrus@holtmann.org>
From: Bharat Panda <bharat.panda@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: cpgs@samsung.com, Bharat Panda <bharat.panda@samsung.com>
Subject: [PATCH v3] audio/avrcp: Add support for GetTotalNumberOfItems
Date: Thu, 23 Jul 2015 15:27:51 +0530
Message-id: <1437645471-4751-1-git-send-email-bharat.panda@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added support for AVRCP GetTotalNumberOfItems command to get
total num of items in a folder(with a given scope) prior calling
GetFolderItems to retrieve the content of the folder.

On response, emit PropertyChanged for "NumberOfItems" property on
MediaPlayer1 interface.
---
 profiles/audio/avrcp.c  | 69 +++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.c | 33 +++++++++++++++++++++--
 profiles/audio/player.h |  4 +++
 3 files changed, 104 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 60f8cbf..82ed4a9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -108,6 +108,7 @@
 #define AVRCP_CHANGE_PATH		0x72
 #define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_PLAY_ITEM			0x74
+#define AVRCP_GET_TOTAL_NUMBER_OF_ITEMS	0x75
 #define AVRCP_SEARCH			0x80
 #define AVRCP_ADD_TO_NOW_PLAYING	0x90
 #define AVRCP_GENERAL_REJECT		0xA0
@@ -2821,6 +2822,73 @@ static int ct_add_to_nowplaying(struct media_player *mp, const char *name,
 	return 0;
 }
 
+static gboolean avrcp_get_total_numberofitems_rsp(struct avctp *conn,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->controller->player;
+	struct media_player *mp = player->user_data;
+	uint32_t num_of_items;
+
+	if (pdu == NULL)
+		return -ETIMEDOUT;
+
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7)
+		return -EINVAL;
+
+	if (pdu->params[0] == AVRCP_STATUS_OUT_OF_BOUNDS)
+		goto done;
+
+	player->uid_counter = get_be16(&pdu->params[1]);
+	num_of_items = get_be32(&pdu->params[3]);
+
+	if (!num_of_items)
+		return -EINVAL;
+
+done:
+	media_player_total_items_complete(mp, num_of_items);
+	return FALSE;
+}
+
+static void avrcp_get_total_numberofitems(struct avrcp *session)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 7];
+	struct avrcp_player *player = session->controller->player;
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_TOTAL_NUMBER_OF_ITEMS;
+	pdu->param_len = htons(7 + sizeof(uint32_t));
+
+	pdu->params[0] = player->scope;
+
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+				avrcp_get_total_numberofitems_rsp, session);
+}
+
+static int ct_get_total_numberofitems(struct media_player *mp, const char *name,
+						void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp *session;
+
+	session = player->sessions->data;
+
+	if (g_str_has_prefix(name, "/NowPlaying"))
+		player->scope = 0x03;
+	else if (g_str_has_suffix(name, "/search"))
+		player->scope = 0x02;
+	else
+		player->scope = 0x01;
+
+	avrcp_get_total_numberofitems(session);
+
+	return 0;
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= ct_set_setting,
 	.play		= ct_play,
@@ -2835,6 +2903,7 @@ static const struct media_player_callback ct_cbs = {
 	.search		= ct_search,
 	.play_item	= ct_play_item,
 	.add_to_nowplaying = ct_add_to_nowplaying,
+	.total_items = ct_get_total_numberofitems,
 };
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 94eb2eb..147bcbf 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -702,6 +702,23 @@ done:
 	folder->msg = NULL;
 }
 
+void media_player_total_items_complete(struct media_player *mp,
+							uint32_t num_of_items)
+{
+	struct media_folder *folder = mp->scope;
+
+	if (folder == NULL || folder->msg == NULL)
+		return;
+
+	if (folder->number_of_items != num_of_items) {
+		folder->number_of_items = num_of_items;
+
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				mp->path, MEDIA_FOLDER_INTERFACE,
+				"NumberOfItems");
+	}
+}
+
 static const GDBusMethodTable media_player_methods[] = {
 	{ GDBUS_METHOD("Play", NULL, NULL, media_player_play) },
 	{ GDBUS_METHOD("Pause", NULL, NULL, media_player_pause) },
@@ -891,6 +908,9 @@ static void media_folder_destroy(void *data)
 static void media_player_change_scope(struct media_player *mp,
 						struct media_folder *folder)
 {
+	struct player_callback *cb = mp->cb;
+	int err;
+
 	if (mp->scope == folder)
 		return;
 
@@ -920,10 +940,19 @@ cleanup:
 done:
 	mp->scope = folder;
 
+	if (cb->cbs->total_items) {
+		err = cb->cbs->total_items(mp, folder->item->name,
+							cb->user_data);
+		if (err < 0)
+			DBG("Failed to get total num of items");
+	} else {
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				mp->path, MEDIA_FOLDER_INTERFACE,
+				"NumberOfItems");
+	}
+
 	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
 				MEDIA_FOLDER_INTERFACE, "Name");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
-				MEDIA_FOLDER_INTERFACE, "NumberOfItems");
 }
 
 static struct media_folder *find_folder(GSList *folders, const char *pattern)
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index ac2a3da..0871904 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -64,6 +64,8 @@ struct media_player_callback {
 					uint64_t uid, void *user_data);
 	int (*add_to_nowplaying) (struct media_player *mp, const char *name,
 					uint64_t uid, void *user_data);
+	int (*total_items) (struct media_player *mp, const char *name,
+						void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path,
@@ -104,6 +106,8 @@ void media_player_list_complete(struct media_player *mp, GSList *items,
 void media_player_change_folder_complete(struct media_player *player,
 						const char *path, int ret);
 void media_player_search_complete(struct media_player *mp, int ret);
+void media_player_total_items_complete(struct media_player *mp,
+						uint32_t num_of_items);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.9.1

