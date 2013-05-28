Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 08/13] AVRCP: Add support for ChangePath command
Date: Tue, 28 May 2013 15:51:26 +0300
Message-Id: <1369745491-23897-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for ChangePath command via player callback.
---
 profiles/audio/avrcp.c  | 77 +++++++++++++++++++++++++++++++++++++++++++++----
 profiles/audio/player.h |  2 ++
 2 files changed, 73 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c141d24..e44ab3c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -101,8 +101,9 @@
 #define AVRCP_ABORT_CONTINUING		0x41
 #define AVRCP_SET_ABSOLUTE_VOLUME	0x50
 #define AVRCP_SET_BROWSED_PLAYER	0x70
-#define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_GET_FOLDER_ITEMS		0x71
+#define AVRCP_CHANGE_PATH		0x72
+#define AVRCP_GET_ITEM_ATTRIBUTES	0x73
 #define AVRCP_GENERAL_REJECT		0xA0
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
@@ -192,8 +193,10 @@ struct avrcp_player {
 	uint16_t uid_counter;
 	bool browsed;
 	uint8_t *features;
+	char *path;
 
 	struct pending_list_items *p;
+	char *change_path;
 
 	struct avrcp_player_cb *cb;
 	void *user_data;
@@ -2187,6 +2190,32 @@ static void avrcp_list_items(struct avrcp *session, uint32_t start,
 					avrcp_list_items_rsp, session);
 }
 
+static gboolean avrcp_change_path_rsp(struct avctp *conn,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
+{
+	struct avrcp_browsing_header *pdu = (void *)operands;
+	struct avrcp *session = (void *)user_data;
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint8_t status;
+	uint32_t num_of_items;
+
+	status = pdu->params[0];
+	if (status != AVRCP_STATUS_SUCCESS)
+		return FALSE;
+
+	num_of_items = bt_get_be32(&pdu->params[1]);
+
+	g_free(player->path);
+	player->path = player->change_path;
+	player->change_path = NULL;
+
+	media_player_set_folder(mp, player->path, num_of_items);
+
+	return FALSE;
+}
+
 static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 						uint8_t *operands,
 						size_t operand_count,
@@ -2197,7 +2226,7 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 	struct media_player *mp = player->user_data;
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	uint32_t items;
-	char **folders, *path;
+	char **folders;
 	uint8_t depth, count;
 	size_t i;
 
@@ -2229,12 +2258,10 @@ static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 		i += len;
 	}
 
-	path = g_build_pathv("/", folders);
+	player->path = g_build_pathv("/", folders);
 	g_strfreev(folders);
 
-	media_player_set_folder(mp, path, items);
-
-	g_free(path);
+	media_player_set_folder(mp, player->path, items);
 
 	return FALSE;
 }
@@ -2471,6 +2498,41 @@ static int ct_list_items(struct media_player *mp, const char *name,
 	return 0;
 }
 
+static void avrcp_change_path(struct avrcp *session, uint8_t direction,
+								uint64_t uid)
+{
+	struct avrcp_player *player = session->player;
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 11];
+	struct avrcp_browsing_header *pdu = (void *) buf;
+
+	memset(buf, 0, sizeof(buf));
+	bt_put_be16(player->uid_counter, &pdu->params[0]);
+	pdu->params[2] = direction;
+	bt_put_be64(uid, &pdu->params[3]);
+	pdu->pdu_id = AVRCP_CHANGE_PATH;
+	pdu->param_len = htons(11);
+
+	avctp_send_browsing_req(session->conn, buf, sizeof(buf),
+					avrcp_change_path_rsp, session);
+}
+
+static int ct_change_folder(struct media_player *mp, const char *path,
+					uint64_t uid, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp *session;
+	uint8_t direction;
+
+	session = player->sessions->data;
+	player->change_path = g_strdup(path);
+
+	direction = g_str_has_prefix(path, player->path) ? 0x01 : 0x00;
+
+	avrcp_change_path(session, direction, uid);
+
+	return 0;
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= ct_set_setting,
 	.play		= ct_play,
@@ -2481,6 +2543,7 @@ static const struct media_player_callback ct_cbs = {
 	.fast_forward	= ct_fast_forward,
 	.rewind		= ct_rewind,
 	.list_items	= ct_list_items,
+	.change_folder	= ct_change_folder,
 };
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
@@ -2593,6 +2656,8 @@ static void player_destroy(gpointer data)
 		player->destroy(player->user_data);
 
 	g_slist_free(player->sessions);
+	g_free(player->path);
+	g_free(player->change_path);
 	g_free(player->features);
 	g_free(player);
 }
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 4e15c36..75ce36b 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -56,6 +56,8 @@ struct media_player_callback {
 	int (*rewind) (struct media_player *mp, void *user_data);
 	int (*list_items) (struct media_player *mp, const char *name,
 				uint32_t start, uint32_t end, void *user_data);
+	int (*change_folder) (struct media_player *mp, const char *path,
+						uint64_t uid, void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path,
-- 
1.8.1.4

