Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 16/16] audio/player: Create item on media_player_set_playlist_item
Date: Fri, 14 Jun 2013 15:41:50 +0300
Message-Id: <1371213710-16607-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
References: <1371213710-16607-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes sure that even if /NowPlaying folder has not been listed the
current item is available and its metadata is updated.
---
 profiles/audio/avrcp.c  |   6 +--
 profiles/audio/player.c | 111 +++++++++++++++++++++++++++++++++---------------
 profiles/audio/player.h |   8 ++--
 3 files changed, 85 insertions(+), 40 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 135dcc7..92d4527 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1965,10 +1965,10 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 					uint8_t *operands, uint8_t count)
 {
 	struct media_player *mp = player->user_data;
+	struct media_item *item;
 	int i;
 
-	if (player->uid > 0)
-		media_player_set_playlist_item(mp, player->uid);
+	item = media_player_set_playlist_item(mp, player->uid);
 
 	for (i = 0; count > 0; count--) {
 		uint32_t id;
@@ -1987,7 +1987,7 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 			const char *key = metadata_to_str(id);
 
 			if (key != NULL)
-				media_player_set_metadata(mp,
+				media_player_set_metadata(mp, item,
 							metadata_to_str(id),
 							&operands[i], len);
 		}
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index a502a2d..d29b10a 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -101,7 +101,7 @@ struct media_player {
 	GSList			*folders;
 };
 
-static void append_metadata(void *key, void *value, void *user_data)
+static void append_track(void *key, void *value, void *user_data)
 {
 	DBusMessageIter *dict = user_data;
 	const char *strkey = key;
@@ -297,7 +297,7 @@ static gboolean get_track(const GDBusPropertyTable *property,
 					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
 					&dict);
 
-	g_hash_table_foreach(mp->track, append_metadata, &dict);
+	g_hash_table_foreach(mp->track, append_track, &dict);
 
 	dbus_message_iter_close_container(iter, &dict);
 
@@ -1289,6 +1289,7 @@ void media_player_set_status(struct media_player *mp, const char *status)
 static gboolean process_metadata_changed(void *user_data)
 {
 	struct media_player *mp = user_data;
+	const char *item;
 
 	mp->process_id = 0;
 
@@ -1296,11 +1297,20 @@ static gboolean process_metadata_changed(void *user_data)
 					mp->path, MEDIA_PLAYER_INTERFACE,
 					"Track");
 
+	item = g_hash_table_lookup(mp->track, "Item");
+	if (item == NULL)
+		return FALSE;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					item, MEDIA_ITEM_INTERFACE,
+					"Metadata");
+
 	return FALSE;
 }
 
-void media_player_set_metadata(struct media_player *mp, const char *key,
-						void *data, size_t len)
+void media_player_set_metadata(struct media_player *mp,
+				struct media_item *item, const char *key,
+				void *data, size_t len)
 {
 	char *value, *curval;
 
@@ -1446,34 +1456,6 @@ static struct media_item *media_folder_find_item(struct media_folder *folder,
 	return NULL;
 }
 
-void media_player_set_playlist_item(struct media_player *mp, uint64_t uid)
-{
-	struct media_folder *folder = mp->playlist;
-	struct media_item *item;
-
-	DBG("%" PRIu64 "", uid);
-
-	if (folder == NULL)
-		return;
-
-	item = media_folder_find_item(folder, uid);
-	if (item == NULL) {
-		warn("Item not found");
-		return;
-	}
-
-	if (item == g_hash_table_lookup(mp->track, "Item"))
-		return;
-
-	if (mp->process_id == 0) {
-		g_hash_table_remove_all(mp->track);
-		mp->process_id = g_idle_add(process_metadata_changed, mp);
-	}
-
-	g_hash_table_replace(mp->track, g_strdup("Item"),
-						g_strdup(item->path));
-}
-
 static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -1638,6 +1620,24 @@ static gboolean metadata_exists(const GDBusPropertyTable *property, void *data)
 	return item->metadata != NULL;
 }
 
+static void append_metadata(void *key, void *value, void *user_data)
+{
+	DBusMessageIter *dict = user_data;
+	const char *strkey = key;
+
+	if (strcasecmp(strkey, "Item") == 0)
+		return;
+
+	if (strcasecmp(strkey, "Duration") == 0 ||
+			strcasecmp(strkey, "TrackNumber") == 0 ||
+			strcasecmp(strkey, "NumberOfTracks") == 0)  {
+		uint32_t num = atoi(value);
+		dict_append_entry(dict, key, DBUS_TYPE_UINT32, &num);
+	} else {
+		dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
+	}
+}
+
 static gboolean get_metadata(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -1695,12 +1695,12 @@ void media_item_set_playable(struct media_item *item, bool value)
 					MEDIA_ITEM_INTERFACE, "Playable");
 }
 
-struct media_item *media_player_create_item(struct media_player *mp,
+static struct media_item *media_folder_create_item(struct media_player *mp,
+						struct media_folder *folder,
 						const char *name,
 						player_item_type_t type,
 						uint64_t uid)
 {
-	struct media_folder *folder = mp->scope;
 	struct media_item *item;
 	const char *strtype;
 
@@ -1750,6 +1750,14 @@ struct media_item *media_player_create_item(struct media_player *mp,
 	return item;
 }
 
+struct media_item *media_player_create_item(struct media_player *mp,
+						const char *name,
+						player_item_type_t type,
+						uint64_t uid)
+{
+	return media_folder_create_item(mp, mp->scope, name, type, uid);
+}
+
 static struct media_folder *
 media_player_find_folder_by_uid(struct media_player *mp, uint64_t uid)
 {
@@ -1828,3 +1836,38 @@ void media_player_set_callbacks(struct media_player *mp,
 
 	mp->cb = cb;
 }
+
+struct media_item *media_player_set_playlist_item(struct media_player *mp,
+								uint64_t uid)
+{
+	struct media_folder *folder = mp->playlist;
+	struct media_item *item;
+
+	DBG("%" PRIu64 "", uid);
+
+	if (folder == NULL)
+		return NULL;
+
+	item = media_folder_create_item(mp, folder, NULL,
+						PLAYER_ITEM_TYPE_AUDIO, uid);
+	if (item == NULL)
+		return NULL;
+
+	if (mp->track != item->metadata) {
+		g_hash_table_unref(mp->track);
+		mp->track = g_hash_table_ref(item->metadata);
+	}
+
+	if (item == g_hash_table_lookup(mp->track, "Item"))
+		return item;
+
+	if (mp->process_id == 0) {
+		g_hash_table_remove_all(mp->track);
+		mp->process_id = g_idle_add(process_metadata_changed, mp);
+	}
+
+	g_hash_table_replace(mp->track, g_strdup("Item"),
+						g_strdup(item->path));
+
+	return item;
+}
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 9edc51b..ac2a3da 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -75,8 +75,9 @@ void media_player_set_setting(struct media_player *mp, const char *key,
 							const char *value);
 const char *media_player_get_status(struct media_player *mp);
 void media_player_set_status(struct media_player *mp, const char *status);
-void media_player_set_metadata(struct media_player *mp, const char *key,
-						void *data, size_t len);
+void media_player_set_metadata(struct media_player *mp,
+				struct media_item *item, const char *key,
+				void *data, size_t len);
 void media_player_set_type(struct media_player *mp, const char *type);
 void media_player_set_subtype(struct media_player *mp, const char *subtype);
 void media_player_set_name(struct media_player *mp, const char *name);
@@ -85,7 +86,8 @@ void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 void media_player_set_playlist(struct media_player *mp, const char *name);
-void media_player_set_playlist_item(struct media_player *mp, uint64_t uid);
+struct media_item *media_player_set_playlist_item(struct media_player *mp,
+								uint64_t uid);
 
 struct media_item *media_player_create_folder(struct media_player *mp,
 						const char *name,
-- 
1.8.1.4

