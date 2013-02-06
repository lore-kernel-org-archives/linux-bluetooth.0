Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5 v2] AVRCP: Create folders for /Filesystem and /NowPlaying
Date: Wed,  6 Feb 2013 11:15:00 +0200
Message-Id: <1360142100-5141-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1360142100-5141-1-git-send-email-luiz.dentz@gmail.com>
References: <1360142100-5141-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If browsing is supported create objects representing /Filesystem and
/NowPlaying, these object implement MediaItem interface and can be
passed to ChangeFolder to change the scope.
---
 profiles/audio/avrcp.c  |   7 +-
 profiles/audio/player.c | 232 ++++++++++++++++++++++++++++++++++++++++++------
 profiles/audio/player.h |   2 +
 3 files changed, 215 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 55887bc..3b9aad6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1984,11 +1984,16 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 
 	player->features = g_memdup(features, 16);
 
-	if (features[7] & 0x08)
+	if (features[7] & 0x08) {
 		media_player_set_browsable(mp, true);
+		media_player_create_folder(mp, "/Filesystem");
+	}
 
 	if (features[7] & 0x10)
 		media_player_set_searchable(mp, true);
+
+	if (features[8] & 0x02)
+		media_player_create_folder(mp, "/NowPlaying");
 }
 
 static void avrcp_parse_media_player_item(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 558aee5..9ff21cf 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -45,6 +45,7 @@
 
 #define MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 #define MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
+#define MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 
 struct player_callback {
 	const struct media_player_callback *cbs;
@@ -57,9 +58,17 @@ struct pending_req {
 	const char *value;
 };
 
+struct media_item {
+	struct media_player	*player;
+	char			*path;		/* Item object path */
+	char			*name;		/* Item name */
+	bool			folder;		/* Item folder flag */
+	bool			playable;	/* Item playable flag */
+};
+
 struct media_folder {
-	char			*name;		/* Folder name */
-	uint32_t		items;		/* Number of items */
+	struct media_item	*item;		/* Folder item */
+	uint32_t		number_of_items;/* Number of items */
 };
 
 struct media_player {
@@ -79,6 +88,7 @@ struct media_player {
 	guint			process_id;
 	struct player_callback	*cb;
 	GSList			*pending;
+	GSList			*folders;
 };
 
 static void append_metadata(void *key, void *value, void *user_data)
@@ -588,25 +598,27 @@ static gboolean folder_name_exists(const GDBusPropertyTable *property,
 								void *data)
 {
 	struct media_player *mp = data;
+	struct media_folder *folder = mp->folder;
 
-	if (mp->folder == NULL)
+	if (folder == NULL || folder->item == NULL)
 		return FALSE;
 
-	return mp->folder->name != NULL;
+	return folder->item->name != NULL;
 }
 
 static gboolean get_folder_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_player *mp = data;
+	struct media_folder *folder = mp->folder;
 
-	if (mp->folder == NULL || mp->folder->name == NULL)
+	if (folder == NULL || folder->item == NULL)
 		return FALSE;
 
-	DBG("%s", mp->folder->name);
+	DBG("%s", folder->item->name);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
-							&mp->folder->name);
+							&folder->item->name);
 
 	return TRUE;
 }
@@ -622,14 +634,15 @@ static gboolean get_items(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_player *mp = data;
+	struct media_folder *folder = mp->folder;
 
-	if (mp->folder == NULL)
+	if (folder == NULL)
 		return FALSE;
 
-	DBG("%u", mp->folder->items);
+	DBG("%u", folder->number_of_items);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT32,
-							&mp->folder->items);
+						&folder->number_of_items);
 
 	return TRUE;
 }
@@ -657,9 +670,22 @@ static const GDBusPropertyTable media_folder_properties[] = {
 	{ }
 };
 
+static void media_item_destroy(void *data)
+{
+	struct media_item *item = data;
+
+	DBG("%s", item->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), item->path,
+						MEDIA_ITEM_INTERFACE);
+
+	g_free(item->path);
+	g_free(item->name);
+	g_free(item);
+}
+
 static void media_folder_destroy(struct media_folder *folder)
 {
-	g_free(folder->name);
 	g_free(folder);
 }
 
@@ -687,6 +713,7 @@ void media_player_destroy(struct media_player *mp)
 	}
 
 	g_slist_free_full(mp->pending, g_free);
+	g_slist_free_full(mp->folders, media_item_destroy);
 
 	g_timer_destroy(mp->progress);
 	g_free(mp->cb);
@@ -911,31 +938,186 @@ void media_player_set_searchable(struct media_player *mp, bool enabled)
 	mp->searchable = enabled;
 }
 
-void media_player_set_folder(struct media_player *mp, const char *path,
-								uint32_t items)
+static void media_player_set_folder_item(struct media_player *mp,
+						struct media_item *item,
+						uint32_t number_of_items)
 {
 	struct media_folder *folder;
 
-	DBG("%s items %u", path, items);
+	folder = mp->folder;
 
-	if (mp->folder != NULL)
-		media_folder_destroy(mp->folder);
-
-	folder = g_new0(struct media_folder, 1);
-	folder->name = g_strdup(path);
-	folder->items = items;
-	mp->folder = folder;
+	if (folder == NULL) {
+		folder = g_new0(struct media_folder, 1);
+		mp->folder = folder;
 
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+		if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					mp->path, MEDIA_FOLDER_INTERFACE,
 					media_folder_methods,
 					NULL,
 					media_folder_properties, mp, NULL)) {
-		error("D-Bus failed to register %s on %s path",
+			error("D-Bus failed to register %s on %s path",
 					MEDIA_FOLDER_INTERFACE, mp->path);
-		media_folder_destroy(mp->folder);
-		mp->folder = NULL;
+			media_folder_destroy(mp->folder);
+			mp->folder = NULL;
+		}
+	}
+
+	folder->item = item;
+	folder->number_of_items = number_of_items;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+				MEDIA_FOLDER_INTERFACE, "Name");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+				MEDIA_FOLDER_INTERFACE, "NumberOfItems");
+}
+
+static struct media_item *media_player_find_folder(struct media_player *mp,
+							const char *name)
+{
+	GSList *l;
+
+	for (l = mp->folders; l; l = l->next) {
+		struct media_item *item = l->data;
+
+		if (!item->folder)
+			continue;
+
+		if (g_str_equal(item->name, name))
+			return item;
+	}
+
+	return NULL;
+}
+
+void media_player_set_folder(struct media_player *mp, const char *name,
+						uint32_t number_of_items)
+{
+	struct media_item *item;
+
+	DBG("%s number of items %u", name, number_of_items);
+
+	item = media_player_find_folder(mp, name);
+	if (item == NULL) {
+		error("Unknown folder: %s", name);
+		return;
+	}
+
+	media_player_set_folder_item(mp, item, number_of_items);
+}
+
+static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return btd_error_failed(msg, strerror(ENOTSUP));
+}
+
+static DBusMessage *media_item_add_to_nowplaying(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	return btd_error_failed(msg, strerror(ENOTSUP));
+}
+
+static gboolean item_name_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_item *item = data;
+
+	return item->name != NULL;
+}
+
+static gboolean get_item_name(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_item *item = data;
+
+	if (item->name == NULL)
+		return FALSE;
+
+	DBG("%s", item->name);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &item->name);
+
+	return TRUE;
+}
+
+static gboolean get_folder_flag(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_item *item = data;
+	dbus_bool_t value;
+
+	DBG("%s", item->folder ? "true" : "false");
+
+	value = item->folder ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static gboolean get_playable(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_item *item = data;
+	dbus_bool_t value;
+
+	DBG("%s", item->playable ? "true" : "false");
+
+	value = item->playable ? TRUE : FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+
+	return TRUE;
+}
+
+static const GDBusMethodTable media_item_methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL,
+					media_item_play) },
+	{ GDBUS_EXPERIMENTAL_METHOD("AddtoNowPlaying", NULL, NULL,
+					media_item_add_to_nowplaying) },
+	{ }
+};
+
+static const GDBusPropertyTable media_item_properties[] = {
+	{ "Name", "s", get_item_name, NULL, item_name_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Folder", "b", get_folder_flag, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Playable", "b", get_playable, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
+};
+
+int media_player_create_folder(struct media_player *mp, const char *name)
+{
+	struct media_item *item;
+
+	DBG("%s", name);
+
+	item = g_new0(struct media_item, 1);
+	item->player = mp;
+	item->path = g_strdup_printf("%s%s", mp->path, name);
+	item->name = g_strdup(name);
+	item->folder = true;
+	item->playable = false;
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					item->path, MEDIA_ITEM_INTERFACE,
+					media_item_methods,
+					NULL,
+					media_item_properties, item, NULL)) {
+		error("D-Bus failed to register %s on %s path",
+					MEDIA_ITEM_INTERFACE, item->path);
+		media_item_destroy(item);
+		return -EINVAL;
 	}
+
+	if (mp->folder == NULL)
+		media_player_set_folder_item(mp, item, 0);
+
+	mp->folders = g_slist_prepend(mp->folders, item);
+
+	return 0;
 }
 
 void media_player_set_callbacks(struct media_player *mp,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 9109b1f..a59cc66 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -55,6 +55,8 @@ void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 
+int media_player_create_folder(struct media_player *mp, const char *path);
+
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
 				void *user_data);
-- 
1.8.1

