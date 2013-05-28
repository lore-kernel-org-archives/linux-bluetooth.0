Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 03/13] AVRCP: Add support for GetFolderItems command
Date: Tue, 28 May 2013 15:51:21 +0300
Message-Id: <1369745491-23897-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for GetFolderItems command via player callback.
---
 profiles/audio/avrcp.c  | 197 +++++++++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/player.h |   2 +
 2 files changed, 195 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5477016..9b54ae9 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -177,14 +177,24 @@ struct pending_pdu {
 	uint16_t offset;
 };
 
+struct pending_list_items {
+	GSList *items;
+	uint32_t start;
+	uint32_t end;
+};
+
 struct avrcp_player {
 	struct avrcp_server *server;
 	GSList *sessions;
 	uint16_t id;
+	uint8_t scope;
+	uint64_t uid;
 	uint16_t uid_counter;
 	bool browsed;
 	uint8_t *features;
 
+	struct pending_list_items *p;
+
 	struct avrcp_player_cb *cb;
 	void *user_data;
 	GDestroyNotify destroy;
@@ -2013,6 +2023,158 @@ static const char *subtype_to_string(uint32_t subtype)
 	return "None";
 }
 
+static struct media_item *parse_media_element(struct avrcp *session,
+					uint8_t *operands, uint16_t len)
+{
+	struct avrcp_player *player;
+	struct media_player *mp;
+	uint16_t namelen;
+	char name[255];
+	uint64_t uid;
+
+	if (len < 13)
+		return NULL;
+
+	uid = bt_get_be64(&operands[0]);
+
+	namelen = MIN(bt_get_be16(&operands[11]), sizeof(name) - 1);
+	if (namelen > 0) {
+		memcpy(name, &operands[13], namelen);
+		name[namelen] = '\0';
+	}
+
+	player = session->player;
+	mp = player->user_data;
+
+	return media_player_create_item(mp, name, PLAYER_ITEM_TYPE_AUDIO, uid);
+}
+
+static struct media_item *parse_media_folder(struct avrcp *session,
+					uint8_t *operands, uint16_t len)
+{
+	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	uint16_t namelen;
+	char name[255];
+	uint64_t uid;
+	uint8_t type;
+
+	if (len < 12)
+		return NULL;
+
+	uid = bt_get_be64(&operands[0]);
+	type = operands[9];
+
+	namelen = MIN(bt_get_be16(&operands[12]), sizeof(name) - 1);
+	if (namelen > 0) {
+		memcpy(name, &operands[14], namelen);
+		name[namelen] = '\0';
+	}
+
+	return media_player_create_folder(mp, name, type, uid);
+}
+
+static void avrcp_list_items(struct avrcp *session, uint32_t start,
+								uint32_t end);
+static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	struct avrcp_browsing_header *pdu = (void *) operands;
+	struct avrcp *session = user_data;
+	struct avrcp_player *player = session->player;
+	struct pending_list_items *p = player->p;
+	uint16_t count;
+	uint32_t items, total;
+	size_t i;
+
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 5)
+		goto done;
+
+	count = bt_get_be16(&operands[6]);
+	if (count == 0)
+		goto done;
+
+	for (i = 8; count && i + 3 < operand_count; count--) {
+		struct media_item *item;
+		uint8_t type;
+		uint16_t len;
+
+		type = operands[i++];
+		len = bt_get_be16(&operands[i]);
+		i += 2;
+
+		if (type != 0x03 && type != 0x02) {
+			i += len;
+			continue;
+		}
+
+		if (i + len > operand_count) {
+			error("Invalid item length");
+			break;
+		}
+
+		if (type == 0x03)
+			item = parse_media_element(session, &operands[i], len);
+		else if (type == 0x02)
+			item = parse_media_folder(session, &operands[i], len);
+
+		if (item) {
+			if (g_slist_find(p->items, item))
+				goto done;
+			p->items = g_slist_append(p->items, item);
+		}
+
+		i += len;
+	}
+
+	items = g_slist_length(p->items);
+	total = p->end - p->start;
+	if (items < total) {
+		avrcp_list_items(session, p->start + items + 1, p->end);
+		return FALSE;
+	}
+
+done:
+	g_slist_free(p->items);
+	g_free(p);
+	player->p = NULL;
+
+	return FALSE;
+}
+
+static void avrcp_list_items(struct avrcp *session, uint32_t start,
+								uint32_t end)
+{
+	uint8_t buf[AVRCP_BROWSING_HEADER_LENGTH + 10 +
+			AVRCP_MEDIA_ATTRIBUTE_LAST * sizeof(uint32_t)];
+	struct avrcp_player *player = session->player;
+	struct avrcp_browsing_header *pdu = (void *) buf;
+	uint16_t length = AVRCP_BROWSING_HEADER_LENGTH + 10;
+	uint32_t attribute;
+
+	memset(buf, 0, sizeof(buf));
+
+	pdu->pdu_id = AVRCP_GET_FOLDER_ITEMS;
+	pdu->param_len = htons(10 + sizeof(uint32_t));
+
+	pdu->params[0] = player->scope;
+
+	bt_put_be32(start, &pdu->params[1]);
+	bt_put_be32(end, &pdu->params[5]);
+
+	pdu->params[9] = 1;
+
+	/* Only the title (0x01) is mandatory. This can be extended to
+	 * support AVRCP_MEDIA_ATTRIBUTE_* attributes */
+	attribute = htonl(AVRCP_MEDIA_ATTRIBUTE_TITLE);
+	memcpy(&pdu->params[10], &attribute, sizeof(uint32_t));
+
+	length += sizeof(uint32_t);
+
+	avctp_send_browsing_req(session->conn, buf, length,
+					avrcp_list_items_rsp, session);
+}
+
 static gboolean avrcp_set_browsed_player_rsp(struct avctp *conn,
 						uint8_t *operands,
 						size_t operand_count,
@@ -2270,6 +2432,33 @@ static int ct_rewind(struct media_player *mp, void *user_data)
 	return ct_press(player, AVC_REWIND);
 }
 
+static int ct_list_items(struct media_player *mp, const char *name,
+				uint32_t start, uint32_t end, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+	struct avrcp *session;
+	struct pending_list_items *p;
+
+	if (player->p != NULL)
+		return -EBUSY;
+
+	session = player->sessions->data;
+
+	if (g_str_has_prefix(name, "/NowPlaying"))
+		player->scope = 0x03;
+	else
+		player->scope = 0x01;
+
+	avrcp_list_items(session, start, end);
+
+	p = g_new0(struct pending_list_items, 1);
+	p->start = start;
+	p->end = end;
+	player->p = p;
+
+	return 0;
+}
+
 static const struct media_player_callback ct_cbs = {
 	.set_setting	= ct_set_setting,
 	.play		= ct_play,
@@ -2279,6 +2468,7 @@ static const struct media_player_callback ct_cbs = {
 	.previous	= ct_previous,
 	.fast_forward	= ct_fast_forward,
 	.rewind		= ct_rewind,
+	.list_items	= ct_list_items,
 };
 
 static struct avrcp_player *create_ct_player(struct avrcp *session,
@@ -2495,11 +2685,10 @@ static void avrcp_status_changed(struct avrcp *session,
 static void avrcp_track_changed(struct avrcp *session,
 						struct avrcp_header *pdu)
 {
-	uint64_t uid;
-
 	if (session->browsing_id) {
-		uid = bt_get_be64(&pdu->params[1]);
-		avrcp_get_item_attributes(session, uid);
+		struct avrcp_player *player = session->player;
+		player->uid = bt_get_be64(&pdu->params[1]);
+		avrcp_get_item_attributes(session, player->uid);
 	} else
 		avrcp_get_element_attributes(session);
 }
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 6e44308..e7a885e 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -54,6 +54,8 @@ struct media_player_callback {
 	int (*previous) (struct media_player *mp, void *user_data);
 	int (*fast_forward) (struct media_player *mp, void *user_data);
 	int (*rewind) (struct media_player *mp, void *user_data);
+	int (*list_items) (struct media_player *mp, const char *name,
+				uint32_t start, uint32_t end, void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path,
-- 
1.8.1.4

