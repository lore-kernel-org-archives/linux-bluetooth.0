Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/16] audio/player: Add implementation of MediaFolder.ChangeFolder
Date: Fri, 14 Jun 2013 15:41:43 +0300
Message-Id: <1371213710-16607-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
References: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c  | 31 ++++++++++++++++--------
 profiles/audio/player.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++--
 profiles/audio/player.h |  2 ++
 3 files changed, 85 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 6135d78..a35477e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2279,20 +2279,31 @@ static gboolean avrcp_change_path_rsp(struct avctp *conn,
 	struct avrcp *session = user_data;
 	struct avrcp_player *player = session->player;
 	struct media_player *mp = player->user_data;
-	uint8_t status;
-	uint32_t num_of_items;
+	int ret;
 
-	status = pdu->params[0];
-	if (status != AVRCP_STATUS_SUCCESS)
-		return FALSE;
+	if (pdu == NULL) {
+		ret = -ETIMEDOUT;
+		goto done;
+	}
 
-	num_of_items = bt_get_be32(&pdu->params[1]);
+	if (pdu->params[0] != AVRCP_STATUS_SUCCESS) {
+		ret = -EINVAL;
+		goto done;
+	}
 
-	g_free(player->path);
-	player->path = player->change_path;
-	player->change_path = NULL;
+	ret = bt_get_be32(&pdu->params[1]);
+
+done:
+	if (ret < 0) {
+		g_free(player->change_path);
+		player->change_path = NULL;
+	} else {
+		g_free(player->path);
+		player->path = player->change_path;
+		player->change_path = NULL;
+	}
 
-	media_player_set_folder(mp, player->path, num_of_items);
+	media_player_change_folder_complete(mp, player->path, ret);
 
 	return FALSE;
 }
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index d56640f..0ef0ac3 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -591,6 +591,30 @@ static void parse_folder_list(gpointer data, gpointer user_data)
 	dbus_message_iter_close_container(array, &entry);
 }
 
+void media_player_change_folder_complete(struct media_player *mp,
+						const char *path, int ret)
+{
+	struct media_folder *folder = mp->scope;
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
+	media_player_set_folder(mp, path, ret);
+
+	reply = g_dbus_create_reply(folder->msg, DBUS_TYPE_INVALID);
+
+done:
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+	dbus_message_unref(folder->msg);
+	folder->msg = NULL;
+}
+
 void media_player_list_complete(struct media_player *mp, GSList *items,
 								int err)
 {
@@ -867,7 +891,43 @@ static struct media_folder *media_player_find_folder(struct media_player *mp,
 static DBusMessage *media_folder_change_folder(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return btd_error_failed(msg, strerror(ENOTSUP));
+	struct media_player *mp = data;
+	struct media_folder *folder = mp->scope;
+	struct player_callback *cb = mp->cb;
+	const char *path;
+	int err;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	if (folder->msg != NULL)
+		return btd_error_failed(msg, strerror(EBUSY));
+
+	folder = media_player_find_folder(mp, path);
+	if (folder == NULL)
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	if (mp->scope == folder)
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+	if (folder == mp->playlist || folder == mp->folder) {
+		media_player_change_scope(mp, folder);
+		return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+	}
+
+	if (cb->cbs->change_folder == NULL)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	err = cb->cbs->change_folder(mp, folder->item->name, folder->item->uid,
+								cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	mp->scope->msg = dbus_message_ref(msg);
+
+	return NULL;
 }
 
 static gboolean folder_name_exists(const GDBusPropertyTable *property,
@@ -932,7 +992,7 @@ static const GDBusMethodTable media_folder_methods[] = {
 			GDBUS_ARGS({ "filter", "a{sv}" }),
 			GDBUS_ARGS({ "items", "a{oa{sv}}" }),
 			media_folder_list_items) },
-	{ GDBUS_EXPERIMENTAL_METHOD("ChangeFolder",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ChangeFolder",
 			GDBUS_ARGS({ "folder", "o" }), NULL,
 			media_folder_change_folder) },
 	{ }
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 4103742..151cabd 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -93,6 +93,8 @@ struct media_item *media_player_create_item(struct media_player *mp,
 void media_item_set_playable(struct media_item *item, bool value);
 void media_player_list_complete(struct media_player *mp, GSList *items,
 								int err);
+void media_player_change_folder_complete(struct media_player *player,
+						const char *path, int ret);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1.4

