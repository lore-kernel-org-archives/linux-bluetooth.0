Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 01/13] player: Split item creation
Date: Tue, 28 May 2013 15:51:19 +0300
Message-Id: <1369745491-23897-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This split item creation into two functions, media_player_create_folder
for folders and media_player_create_item for regular items.
---
 profiles/audio/avrcp.c  |   4 +-
 profiles/audio/player.c | 343 +++++++++++++++++++++++++++++++++---------------
 profiles/audio/player.h |  11 +-
 3 files changed, 250 insertions(+), 108 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 4558407..39882e4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2138,7 +2138,7 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 	if (features[7] & 0x08) {
 		media_player_set_browsable(mp, true);
 		media_player_create_folder(mp, "/Filesystem",
-						PLAYER_FOLDER_TYPE_MIXED);
+						PLAYER_FOLDER_TYPE_MIXED, 0);
 	}
 
 	if (features[7] & 0x10)
@@ -2146,7 +2146,7 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 
 	if (features[8] & 0x02) {
 		media_player_create_folder(mp, "/NowPlaying",
-						PLAYER_FOLDER_TYPE_MIXED);
+						PLAYER_FOLDER_TYPE_MIXED, 0);
 		media_player_set_playlist(mp, "/NowPlaying");
 	}
 }
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index e08e373..c774cfe 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -65,11 +65,15 @@ struct media_item {
 	player_item_type_t	type;		/* Item type */
 	player_folder_type_t	folder_type;	/* Folder type */
 	bool			playable;	/* Item playable flag */
+	uint64_t		uid;		/* Item uid */
 };
 
 struct media_folder {
+	struct media_folder	*parent;
 	struct media_item	*item;		/* Folder item */
 	uint32_t		number_of_items;/* Number of items */
+	GSList			*subfolders;
+	GSList			*items;
 };
 
 struct media_player {
@@ -79,8 +83,9 @@ struct media_player {
 	char			*subtype;	/* Player subtype */
 	bool			browsable;	/* Player browsing feature */
 	bool			searchable;	/* Player searching feature */
+	struct media_folder	*scope;		/* Player current scope */
 	struct media_folder	*folder;	/* Player current folder */
-	struct media_item	*playlist;	/* Player current playlist */
+	struct media_folder	*playlist;	/* Player current playlist */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
@@ -375,7 +380,7 @@ static gboolean browsable_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_player *mp = data;
 
-	return mp->folder != NULL;
+	return mp->scope != NULL;
 }
 
 static gboolean get_browsable(const GDBusPropertyTable *property,
@@ -384,7 +389,7 @@ static gboolean get_browsable(const GDBusPropertyTable *property,
 	struct media_player *mp = data;
 	dbus_bool_t value;
 
-	if (mp->folder == NULL)
+	if (mp->scope == NULL)
 		return FALSE;
 
 	DBG("%s", mp->browsable ? "true" : "false");
@@ -401,7 +406,7 @@ static gboolean searchable_exists(const GDBusPropertyTable *property,
 {
 	struct media_player *mp = data;
 
-	return mp->folder != NULL;
+	return mp->scope != NULL;
 }
 
 static gboolean get_searchable(const GDBusPropertyTable *property,
@@ -434,13 +439,13 @@ static gboolean get_playlist(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_player *mp = data;
-	struct media_item *playlist = mp->playlist;
+	struct media_folder *playlist = mp->playlist;
 
 	if (playlist == NULL)
 		return FALSE;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
-							&playlist->path);
+							&playlist->item->path);
 
 	return TRUE;
 }
@@ -626,6 +631,93 @@ static DBusMessage *media_folder_list_items(DBusConnection *conn,
 	return btd_error_failed(msg, strerror(ENOTSUP));
 }
 
+static void media_item_free(struct media_item *item)
+{
+	g_free(item->path);
+	g_free(item->name);
+	g_free(item);
+}
+
+static void media_item_destroy(void *data)
+{
+	struct media_item *item = data;
+
+	DBG("%s", item->path);
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), item->path,
+						MEDIA_ITEM_INTERFACE);
+
+	media_item_free(item);
+}
+
+static void media_folder_destroy(void *data)
+{
+	struct media_folder *folder = data;
+
+	g_slist_free_full(folder->subfolders, media_folder_destroy);
+	g_slist_free_full(folder->items, media_item_destroy);
+
+	media_item_destroy(folder->item);
+	g_free(folder);
+}
+
+static void media_player_change_scope(struct media_player *mp,
+						struct media_folder *folder)
+{
+	if (mp->scope == folder)
+		return;
+
+	DBG("%s", folder->item->name);
+
+	/* Skip setting current folder if folder is current playlist */
+	if (folder == mp->playlist)
+		goto cleanup;
+
+	mp->folder = folder;
+
+	/* Skip item cleanup if scope is the current playlist */
+	if (mp->scope == mp->playlist)
+		goto done;
+
+cleanup:
+	g_slist_free_full(mp->scope->items, media_item_destroy);
+	mp->scope->items = NULL;
+
+done:
+	mp->scope = folder;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+				MEDIA_FOLDER_INTERFACE, "Name");
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+				MEDIA_FOLDER_INTERFACE, "NumberOfItems");
+}
+
+static struct media_folder *find_folder(GSList *folders, const char *pattern)
+{
+	GSList *l;
+
+	for (l = folders; l; l = l->next) {
+		struct media_folder *folder = l->data;
+
+		if (g_str_equal(folder->item->name, pattern))
+			return folder;
+
+		if (g_str_equal(folder->item->path, pattern))
+			return folder;
+
+		folder = find_folder(folder->subfolders, pattern);
+		if (folder != NULL)
+			return folder;
+	}
+
+	return NULL;
+}
+
+static struct media_folder *media_player_find_folder(struct media_player *mp,
+							const char *pattern)
+{
+	return find_folder(mp->folders, pattern);
+}
 
 static DBusMessage *media_folder_change_folder(DBusConnection *conn,
 						DBusMessage *msg, void *data)
@@ -637,7 +729,7 @@ static gboolean folder_name_exists(const GDBusPropertyTable *property,
 								void *data)
 {
 	struct media_player *mp = data;
-	struct media_folder *folder = mp->folder;
+	struct media_folder *folder = mp->scope;
 
 	if (folder == NULL || folder->item == NULL)
 		return FALSE;
@@ -649,7 +741,7 @@ static gboolean get_folder_name(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_player *mp = data;
-	struct media_folder *folder = mp->folder;
+	struct media_folder *folder = mp->scope;
 
 	if (folder == NULL || folder->item == NULL)
 		return FALSE;
@@ -666,14 +758,14 @@ static gboolean items_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_player *mp = data;
 
-	return mp->folder != NULL;
+	return mp->scope != NULL;
 }
 
 static gboolean get_items(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_player *mp = data;
-	struct media_folder *folder = mp->folder;
+	struct media_folder *folder = mp->scope;
 
 	if (folder == NULL)
 		return FALSE;
@@ -709,23 +801,24 @@ static const GDBusPropertyTable media_folder_properties[] = {
 	{ }
 };
 
-static void media_item_destroy(void *data)
+static void media_player_set_scope(struct media_player *mp,
+						struct media_folder *folder)
 {
-	struct media_item *item = data;
-
-	DBG("%s", item->path);
-
-	g_dbus_unregister_interface(btd_get_dbus_connection(), item->path,
-						MEDIA_ITEM_INTERFACE);
-
-	g_free(item->path);
-	g_free(item->name);
-	g_free(item);
-}
+	if (mp->scope == NULL) {
+		if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					mp->path, MEDIA_FOLDER_INTERFACE,
+					media_folder_methods,
+					NULL,
+					media_folder_properties, mp, NULL)) {
+			error("D-Bus failed to register %s on %s path",
+					MEDIA_FOLDER_INTERFACE, mp->path);
+			return;
+		}
+		mp->scope = folder;
+		return;
+	}
 
-static void media_folder_destroy(struct media_folder *folder)
-{
-	g_free(folder);
+	return media_player_change_scope(mp, folder);
 }
 
 void media_player_destroy(struct media_player *mp)
@@ -744,15 +837,13 @@ void media_player_destroy(struct media_player *mp)
 	if (mp->process_id > 0)
 		g_source_remove(mp->process_id);
 
-	if (mp->folder) {
+	if (mp->scope)
 		g_dbus_unregister_interface(btd_get_dbus_connection(),
 						mp->path,
 						MEDIA_FOLDER_INTERFACE);
-		media_folder_destroy(mp->folder);
-	}
 
 	g_slist_free_full(mp->pending, g_free);
-	g_slist_free_full(mp->folders, media_item_destroy);
+	g_slist_free_full(mp->folders, media_folder_destroy);
 
 	g_timer_destroy(mp->progress);
 	g_free(mp->cb);
@@ -1006,90 +1097,58 @@ void media_player_set_searchable(struct media_player *mp, bool enabled)
 					"Searchable");
 }
 
-static void media_player_set_folder_item(struct media_player *mp,
-						struct media_item *item,
+void media_player_set_folder(struct media_player *mp, const char *name,
 						uint32_t number_of_items)
 {
 	struct media_folder *folder;
 
-	folder = mp->folder;
+	DBG("%s number of items %u", name, number_of_items);
 
+	folder = media_player_find_folder(mp, name);
 	if (folder == NULL) {
-		folder = g_new0(struct media_folder, 1);
-		mp->folder = folder;
-
-		if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					mp->path, MEDIA_FOLDER_INTERFACE,
-					media_folder_methods,
-					NULL,
-					media_folder_properties, mp, NULL)) {
-			error("D-Bus failed to register %s on %s path",
-					MEDIA_FOLDER_INTERFACE, mp->path);
-			media_folder_destroy(mp->folder);
-			mp->folder = NULL;
-			return;
-		}
+		error("Unknown folder: %s", name);
+		return;
 	}
 
-	folder->item = item;
 	folder->number_of_items = number_of_items;
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
-				MEDIA_FOLDER_INTERFACE, "Name");
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
-				MEDIA_FOLDER_INTERFACE, "NumberOfItems");
-}
-
-static struct media_item *media_player_find_folder(struct media_player *mp,
-							const char *name)
-{
-	GSList *l;
-
-	for (l = mp->folders; l; l = l->next) {
-		struct media_item *item = l->data;
-
-		if (item->type != PLAYER_ITEM_TYPE_FOLDER)
-			continue;
-
-		if (g_str_equal(item->name, name))
-			return item;
-	}
-
-	return NULL;
+	media_player_set_scope(mp, folder);
 }
 
-void media_player_set_folder(struct media_player *mp, const char *name,
-						uint32_t number_of_items)
+void media_player_set_playlist(struct media_player *mp, const char *name)
 {
-	struct media_item *item;
+	struct media_folder *folder;
 
-	DBG("%s number of items %u", name, number_of_items);
+	DBG("%s", name);
 
-	item = media_player_find_folder(mp, name);
-	if (item == NULL) {
+	folder = media_player_find_folder(mp, name);
+	if (folder == NULL) {
 		error("Unknown folder: %s", name);
 		return;
 	}
 
-	media_player_set_folder_item(mp, item, number_of_items);
+	mp->playlist = folder;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, "Playlist");
 }
 
-void media_player_set_playlist(struct media_player *mp, const char *name)
+static struct media_item *media_folder_find_item(struct media_folder *folder,
+								uint64_t uid)
 {
-	struct media_item *item;
+	GSList *l;
 
-	DBG("%s", name);
+	if (uid == 0)
+		return NULL;
 
-	item = media_player_find_folder(mp, name);
-	if (item == NULL) {
-		error("Unknown folder: %s", name);
-		return;
-	}
+	for (l = folder->items; l; l = l->next) {
+		struct media_item *item = l->data;
 
-	mp->playlist = item;
+		if (item->uid == uid)
+			return item;
+	}
 
-	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
-					MEDIA_PLAYER_INTERFACE, "Playlist");
+	return NULL;
 }
 
 static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
@@ -1238,22 +1297,35 @@ static const GDBusPropertyTable media_item_properties[] = {
 	{ }
 };
 
-static struct media_item *media_player_create_item(struct media_player *mp,
+struct media_item *media_player_create_item(struct media_player *mp,
 						const char *name,
-						player_item_type_t type)
+						player_item_type_t type,
+						uint64_t uid)
 {
+	struct media_folder *folder = mp->scope;
 	struct media_item *item;
 	const char *strtype;
 
+	item = media_folder_find_item(folder, uid);
+	if (item != NULL)
+		return item;
+
 	strtype = type_to_string(type);
 	if (strtype == NULL)
 		return NULL;
 
-	DBG("%s type %s", name, strtype);
+	DBG("%s type %s uid %" PRIu64 "", name, strtype, uid);
 
 	item = g_new0(struct media_item, 1);
 	item->player = mp;
-	item->path = g_strdup_printf("%s%s", mp->path, name);
+	item->uid = uid;
+
+	if (uid > 0)
+		item->path = g_strdup_printf("%s/item%" PRIu64 "",
+						folder->item->path, uid);
+	else
+		item->path = g_strdup_printf("%s%s", mp->path, name);
+
 	item->name = g_strdup(name);
 	item->type = type;
 	item->folder_type = PLAYER_FOLDER_TYPE_INVALID;
@@ -1265,35 +1337,98 @@ static struct media_item *media_player_create_item(struct media_player *mp,
 					media_item_properties, item, NULL)) {
 		error("D-Bus failed to register %s on %s path",
 					MEDIA_ITEM_INTERFACE, item->path);
-		media_item_destroy(item);
+		media_item_free(item);
 		return NULL;
 	}
 
+	if (type != PLAYER_ITEM_TYPE_FOLDER)
+		folder->items = g_slist_prepend(folder->items, item);
+
+	DBG("%s", item->path);
+
 	return item;
 }
 
-int media_player_create_folder(struct media_player *mp, const char *name,
-						player_folder_type_t type)
+static struct media_item *
+media_player_create_subfolder(struct media_player *mp, const char *name,
+								uint64_t uid)
 {
+	struct media_folder *folder = mp->scope;
 	struct media_item *item;
+	char *path;
 
-	item = media_player_find_folder(mp, name);
-	if (item != NULL)
-		return 0;
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
+static struct media_folder *
+media_player_find_folder_by_uid(struct media_player *mp, uint64_t uid)
+{
+	struct media_folder *folder = mp->scope;
+	GSList *l;
+
+	for (l = folder->subfolders; l; l = l->next) {
+		struct media_folder *folder = l->data;
+
+		if (folder->item->uid == uid)
+			return folder;
+	}
+
+	return NULL;
+}
+
+struct media_item *media_player_create_folder(struct media_player *mp,
+						const char *name,
+						player_folder_type_t type,
+						uint64_t uid)
+{
+	struct media_folder *folder;
+	struct media_item *item;
+
+	if (uid > 0)
+		folder = media_player_find_folder_by_uid(mp, uid);
+	else
+		folder = media_player_find_folder(mp, name);
+
+	if (folder != NULL)
+		return folder->item;
+
+	if (uid > 0)
+		item = media_player_create_subfolder(mp, name, uid);
+	else
+		item = media_player_create_item(mp, name,
+						PLAYER_ITEM_TYPE_FOLDER, uid);
 
-	item = media_player_create_item(mp, name,
-					PLAYER_ITEM_TYPE_FOLDER);
 	if (item == NULL)
-		return -EINVAL;
+		return NULL;
+
+	folder = g_new0(struct media_folder, 1);
+	folder->item = item;
 
 	item->folder_type = type;
 
-	if (mp->folder == NULL)
-		media_player_set_folder_item(mp, item, 0);
+	if (mp->folder != NULL)
+		goto done;
 
-	mp->folders = g_slist_prepend(mp->folders, item);
+	mp->folder = folder;
 
-	return 0;
+done:
+	if (uid > 0) {
+		folder->parent = mp->folder;
+		mp->folder->subfolders = g_slist_prepend(
+							mp->folder->subfolders,
+							folder);
+	} else
+		mp->folders = g_slist_prepend(mp->folders, folder);
+
+	return item;
 }
 
 void media_player_set_callbacks(struct media_player *mp,
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 852042e..6e44308 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -42,6 +42,7 @@ typedef enum {
 } player_folder_type_t;
 
 struct media_player;
+struct media_item;
 
 struct media_player_callback {
 	bool (*set_setting) (struct media_player *mp, const char *key,
@@ -75,8 +76,14 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 void media_player_set_playlist(struct media_player *mp, const char *name);
 
-int media_player_create_folder(struct media_player *mp, const char *name,
-						player_folder_type_t type);
+struct media_item *media_player_create_folder(struct media_player *mp,
+						const char *name,
+						player_folder_type_t type,
+						uint64_t uid);
+struct media_item *media_player_create_item(struct media_player *mp,
+						const char *name,
+						player_item_type_t type,
+						uint64_t uid);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1.4

