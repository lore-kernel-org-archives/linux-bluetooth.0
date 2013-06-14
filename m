Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 15/16] audio/player: Add implementation of MediaFolder.Search
Date: Fri, 14 Jun 2013 15:41:49 +0300
Message-Id: <1371213710-16607-16-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
References: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c  |  20 +++++++--
 profiles/audio/player.c | 113 +++++++++++++++++++++++++++++++++++++++---------
 profiles/audio/player.h |   1 +
 3 files changed, 110 insertions(+), 24 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4dce600..135dcc7 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2585,6 +2585,8 @@ static int ct_list_items(struct media_player *mp, const char *name,
 
 	if (g_str_has_prefix(name, "/NowPlaying"))
 		player->scope = 0x03;
+	else if (g_str_has_suffix(name, "/search"))
+		player->scope = 0x02;
 	else
 		player->scope = 0x01;
 
@@ -2639,12 +2641,24 @@ static gboolean avrcp_search_rsp(struct avctp *conn, uint8_t *operands,
 	struct avrcp_browsing_header *pdu = (void *) operands;
 	struct avrcp *session = (void *) user_data;
 	struct avrcp_player *player = session->player;
+	struct media_player *mp = player->user_data;
+	int ret;
 
-	if (pdu == NULL || pdu->params[0] != AVRCP_STATUS_SUCCESS ||
-							operand_count < 7)
-		return FALSE;
+	if (pdu == NULL) {
+		ret = -ETIMEDOUT;
+		goto done;
+	}
+
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS || operand_count < 7) {
+		ret = -EINVAL;
+		goto done;
+	}
 
 	player->uid_counter = bt_get_be16(&pdu->params[1]);
+	ret = bt_get_be32(&pdu->params[3]);
+
+done:
+	media_player_search_complete(mp, ret);
 
 	return FALSE;
 }
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 701d366..a502a2d 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -87,6 +87,7 @@ struct media_player {
 	bool			searchable;	/* Player searching feature */
 	struct media_folder	*scope;		/* Player current scope */
 	struct media_folder	*folder;	/* Player current folder */
+	struct media_folder	*search;	/* Player search folder */
 	struct media_folder	*playlist;	/* Player current playlist */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
@@ -654,6 +655,57 @@ done:
 	folder->msg = NULL;
 }
 
+static struct media_item *
+media_player_create_subfolder(struct media_player *mp, const char *name,
+								uint64_t uid)
+{
+	struct media_folder *folder = mp->scope;
+	struct media_item *item;
+	char *path;
+
+	path = g_strdup_printf("%s/%s", folder->item->name, name);
+
+	DBG("%s", path);
+
+	item = media_player_create_item(mp, path, PLAYER_ITEM_TYPE_FOLDER,
+									uid);
+	g_free(path);
+
+	return item;
+}
+
+void media_player_search_complete(struct media_player *mp, int ret)
+{
+	struct media_folder *folder = mp->scope;
+	struct media_folder *search = mp->search;
+	DBusMessage *reply;
+
+	if (folder == NULL || folder->msg == NULL)
+		return;
+
+	if (ret < 0) {
+		reply = btd_error_failed(folder->msg, strerror(-ret));
+		goto done;
+	}
+
+	if (search == NULL) {
+		search = g_new0(struct media_folder, 1);
+		search->item = media_player_create_subfolder(mp, "search", 0);
+		mp->search = search;
+	}
+
+	search->number_of_items = ret;
+
+	reply = g_dbus_create_reply(folder->msg,
+				DBUS_TYPE_OBJECT_PATH, &search->item->path,
+				DBUS_TYPE_INVALID);
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(folder->msg);
+	folder->msg = NULL;
+}
+
 static const GDBusMethodTable media_player_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL, media_player_play) },
 	{ GDBUS_EXPERIMENTAL_METHOD("Pause", NULL, NULL, media_player_pause) },
@@ -707,7 +759,36 @@ static const GDBusPropertyTable media_player_properties[] = {
 static DBusMessage *media_folder_search(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
-	return btd_error_failed(msg, strerror(ENOTSUP));
+	struct media_player *mp = data;
+	struct media_folder *folder = mp->scope;
+	struct player_callback *cb = mp->cb;
+	DBusMessageIter iter;
+	const char *string;
+	int err;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	dbus_message_iter_get_basic(&iter, &string);
+
+	if (!mp->searchable || folder == mp->playlist)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	if (folder->msg != NULL)
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	if (cb->cbs->search == NULL)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	err = cb->cbs->search(mp, string, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	folder->msg = dbus_message_ref(msg);
+
+	return NULL;
 }
 
 static int parse_filters(struct media_player *player, DBusMessageIter *iter,
@@ -852,6 +933,12 @@ cleanup:
 	g_slist_free_full(mp->scope->items, media_item_destroy);
 	mp->scope->items = NULL;
 
+	/* Destroy search folder if it exists */
+	if (mp->search != NULL) {
+		media_folder_destroy(mp->search);
+		mp->search = NULL;
+	}
+
 done:
 	mp->scope = folder;
 
@@ -984,7 +1071,7 @@ static gboolean get_items(const GDBusPropertyTable *property,
 }
 
 static const GDBusMethodTable media_folder_methods[] = {
-	{ GDBUS_EXPERIMENTAL_METHOD("Search",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("Search",
 			GDBUS_ARGS({ "string", "s" }, { "filter", "a{sv}" }),
 			GDBUS_ARGS({ "folder", "o" }),
 			media_folder_search) },
@@ -1047,6 +1134,9 @@ void media_player_destroy(struct media_player *mp)
 						mp->path,
 						MEDIA_FOLDER_INTERFACE);
 
+	if (mp->search)
+		media_folder_destroy(mp->search);
+
 	g_slist_free_full(mp->pending, g_free);
 	g_slist_free_full(mp->folders, media_folder_destroy);
 
@@ -1660,25 +1750,6 @@ struct media_item *media_player_create_item(struct media_player *mp,
 	return item;
 }
 
-static struct media_item *
-media_player_create_subfolder(struct media_player *mp, const char *name,
-								uint64_t uid)
-{
-	struct media_folder *folder = mp->scope;
-	struct media_item *item;
-	char *path;
-
-	path = g_strdup_printf("%s/%s", folder->item->name, name);
-
-	DBG("%s", path);
-
-	item = media_player_create_item(mp, path, PLAYER_ITEM_TYPE_FOLDER,
-									uid);
-	g_free(path);
-
-	return item;
-}
-
 static struct media_folder *
 media_player_find_folder_by_uid(struct media_player *mp, uint64_t uid)
 {
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index eecab1b..9edc51b 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -101,6 +101,7 @@ void media_player_list_complete(struct media_player *mp, GSList *items,
 								int err);
 void media_player_change_folder_complete(struct media_player *player,
 						const char *path, int ret);
+void media_player_search_complete(struct media_player *mp, int ret);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1.4

