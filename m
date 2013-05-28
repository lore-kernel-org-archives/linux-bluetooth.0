Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 04/13] player: Add implementation of MediaFolder.ListItems
Date: Tue, 28 May 2013 15:51:22 +0300
Message-Id: <1369745491-23897-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/avrcp.c  |   2 +
 profiles/audio/player.c | 135 +++++++++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/player.h |   2 +
 3 files changed, 137 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9b54ae9..f86dc9a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2135,6 +2135,8 @@ static gboolean avrcp_list_items_rsp(struct avctp *conn, uint8_t *operands,
 	}
 
 done:
+	media_player_list_complete(player->user_data, p->items);
+
 	g_slist_free(p->items);
 	g_free(p);
 	player->p = NULL;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index c774cfe..9fccb2f 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -74,6 +74,7 @@ struct media_folder {
 	uint32_t		number_of_items;/* Number of items */
 	GSList			*subfolders;
 	GSList			*items;
+	DBusMessage		*msg;
 };
 
 struct media_player {
@@ -569,6 +570,57 @@ static DBusMessage *media_player_rewind(DBusConnection *conn, DBusMessage *msg,
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
+static void parse_folder_list(gpointer data, gpointer user_data)
+{
+	struct media_item *item = data;
+	DBusMessageIter *array = user_data;
+	DBusMessageIter entry;
+
+	dbus_message_iter_open_container(array, DBUS_TYPE_DICT_ENTRY, NULL,
+								&entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_OBJECT_PATH,
+								&item->path);
+
+	g_dbus_get_properties(btd_get_dbus_connection(), item->path,
+						MEDIA_ITEM_INTERFACE, &entry);
+
+	dbus_message_iter_close_container(array, &entry);
+}
+
+void media_player_list_complete(struct media_player *mp, GSList *items)
+{
+	struct media_folder *folder = mp->scope;
+	DBusMessage *reply;
+	DBusMessageIter iter, array;
+
+	if (folder == NULL || folder->msg == NULL)
+		return;
+
+	reply = dbus_message_new_method_return(folder->msg);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_OBJECT_PATH_AS_STRING
+					DBUS_TYPE_ARRAY_AS_STRING
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+
+	g_slist_foreach(items, parse_folder_list, &array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
+
+	dbus_message_unref(folder->msg);
+	folder->msg = NULL;
+}
+
 static const GDBusMethodTable media_player_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL, media_player_play) },
 	{ GDBUS_EXPERIMENTAL_METHOD("Pause", NULL, NULL, media_player_pause) },
@@ -625,10 +677,83 @@ static DBusMessage *media_folder_search(DBusConnection *conn, DBusMessage *msg,
 	return btd_error_failed(msg, strerror(ENOTSUP));
 }
 
+static int parse_filters(struct media_player *player, DBusMessageIter *iter,
+						uint32_t *start, uint32_t *end)
+{
+	struct media_folder *folder = player->scope;
+	DBusMessageIter dict;
+	int ctype;
+
+	*start = 0;
+	*end = folder->number_of_items ? folder->number_of_items : UINT32_MAX;
+
+	ctype = dbus_message_iter_get_arg_type(iter);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return FALSE;
+
+	dbus_message_iter_recurse(iter, &dict);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID) {
+		DBusMessageIter entry;
+		const char *key;
+
+		if (ctype != DBUS_TYPE_DICT_ENTRY)
+			return -EINVAL;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_UINT32)
+			return -EINVAL;
+
+		if (strcasecmp(key, "Start") == 0)
+			dbus_message_iter_get_basic(&entry, start);
+		else if (strcasecmp(key, "End") == 0)
+			dbus_message_iter_get_basic(&entry, end);
+
+		dbus_message_iter_next(&dict);
+	}
+
+	if (folder->number_of_items > 0 && *end > folder->number_of_items)
+		*end = folder->number_of_items;
+
+	return 0;
+}
+
 static DBusMessage *media_folder_list_items(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return btd_error_failed(msg, strerror(ENOTSUP));
+	struct media_player *mp = data;
+	struct media_folder *folder = mp->scope;
+	struct player_callback *cb = mp->cb;
+	DBusMessageIter iter;
+	uint32_t start, end;
+	int err;
+
+	dbus_message_iter_init(msg, &iter);
+
+	if (parse_filters(mp, &iter, &start, &end) < 0)
+		return btd_error_invalid_args(msg);
+
+	if (cb->cbs->list_items == NULL)
+		return btd_error_not_supported(msg);
+
+	if (folder->msg != NULL)
+		return btd_error_failed(msg, strerror(EBUSY));
+
+	err = cb->cbs->list_items(mp, folder->item->name, start, end,
+							cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	folder->msg = dbus_message_ref(msg);
+
+	return NULL;
 }
 
 static void media_item_free(struct media_item *item)
@@ -657,6 +782,9 @@ static void media_folder_destroy(void *data)
 	g_slist_free_full(folder->subfolders, media_folder_destroy);
 	g_slist_free_full(folder->items, media_item_destroy);
 
+	if (folder->msg != NULL)
+		dbus_message_unref(folder->msg);
+
 	media_item_destroy(folder->item);
 	g_free(folder);
 }
@@ -783,7 +911,7 @@ static const GDBusMethodTable media_folder_methods[] = {
 			GDBUS_ARGS({ "string", "s" }, { "filter", "a{sv}" }),
 			GDBUS_ARGS({ "folder", "o" }),
 			media_folder_search) },
-	{ GDBUS_EXPERIMENTAL_METHOD("ListItems",
+	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("ListItems",
 			GDBUS_ARGS({ "filter", "a{sv}" }),
 			GDBUS_ARGS({ "items", "a{oa{sv}}" }),
 			media_folder_list_items) },
@@ -818,6 +946,9 @@ static void media_player_set_scope(struct media_player *mp,
 		return;
 	}
 
+	if (mp->scope->msg != NULL)
+		return;
+
 	return media_player_change_scope(mp, folder);
 }
 
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index e7a885e..0f75f4f 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -87,6 +87,8 @@ struct media_item *media_player_create_item(struct media_player *mp,
 						player_item_type_t type,
 						uint64_t uid);
 
+void media_player_list_complete(struct media_player *mp, GSList *items);
+
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
 				void *user_data);
-- 
1.8.1.4

