Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/9 v2] media: Rework MediaItem Type property
Date: Thu, 28 Feb 2013 14:22:01 +0200
Message-Id: <1362054128-20569-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
References: <1362054128-20569-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Type now can assume the value "folder" so it is no longer necessary to
have Folder property, FolderType in introduced to provide the folder type
that before was on the Type itself.

In addition to this add proper documentation what properties are optional
and under what condition they are available.
---
 doc/media-api.txt       | 47 ++++++++++++++++++++++-----------
 profiles/audio/avrcp.c  |  4 +--
 profiles/audio/player.c | 69 +++++++++++++++++++++++++++++++++++++++----------
 profiles/audio/player.h |  3 ++-
 4 files changed, 91 insertions(+), 32 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 2656a9e..699affa 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -352,51 +352,68 @@ Properties	string Name [readonly]
 
 			Item displayable name
 
-		boolean Folder [readonly]
-
-			Indicates whether the item is a folder
-
 		string Type [readonly]
 
 			Item type
 
-			Possible values:
+			Possible values: "video", "audio", "folder"
+
+		string FolderType [readonly, optional]
 
-				Folder: "Mixed", "Titles", "Albums", "Artists"
-				Other Items: "Video", "Audio"
+			Folder type.
 
-		boolean Playable [readonly]
+			Possible values: "mixed", "titles", "albums", "artists"
+
+			Available if property Type is "Folder"
+
+		boolean Playable [readonly, optional]
 
 			Indicates if the item can be played
 
-		string Title:
+			Available if property Type is "folder"
+
+		string Title [readonly, optional]
 
 			Item title name
 
-		string Artist:
+			Available if property Type is "audio" or "video"
+
+		string Artist [readonly, optional]
 
 			Item artist name
 
-		string Album:
+			Available if property Type is "audio" or "video"
+
+		string Album [readonly, optional]
 
 			Item album name
 
-		string Genre:
+			Available if property Type is "audio" or "video"
+
+		string Genre [readonly, optional]
 
 			Item genre name
 
-		uint32 NumberOfTracks:
+			Available if property Type is "audio" or "video"
+
+		uint32 NumberOfTracks [readonly, optional]
 
 			Item album number of tracks in total
 
-		uint32 Number:
+			Available if property Type is "audio" or "video"
+
+		uint32 Number [readonly, optional]
 
 			Item album number
 
-		uint32 Duration:
+			Available if property Type is "audio" or "video"
+
+		uint32 Duration [readonly, optional]
 
 			Item duration in milliseconds
 
+			Available if property Type is "audio" or "video"
+
 MediaEndpoint1 hierarchy
 ========================
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9be977e..5f0f0a4 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2035,14 +2035,14 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 
 	if (features[7] & 0x08) {
 		media_player_set_browsable(mp, true);
-		media_player_create_folder(mp, "/Filesystem");
+		media_player_create_folder(mp, "/Filesystem", "mixed");
 	}
 
 	if (features[7] & 0x10)
 		media_player_set_searchable(mp, true);
 
 	if (features[8] & 0x02)
-		media_player_create_folder(mp, "/NowPlaying");
+		media_player_create_folder(mp, "/NowPlaying", "mixed");
 }
 
 static void avrcp_parse_media_player_item(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index b222643..2593cd5 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -62,7 +62,8 @@ struct media_item {
 	struct media_player	*player;
 	char			*path;		/* Item object path */
 	char			*name;		/* Item name */
-	bool			folder;		/* Item folder flag */
+	char			*type;		/* Item type */
+	char			*folder_type;	/* Folder type */
 	bool			playable;	/* Item playable flag */
 };
 
@@ -686,6 +687,8 @@ static void media_item_destroy(void *data)
 
 	g_free(item->path);
 	g_free(item->name);
+	g_free(item->type);
+	g_free(item->folder_type);
 	g_free(item);
 }
 
@@ -983,7 +986,7 @@ static struct media_item *media_player_find_folder(struct media_player *mp,
 	for (l = mp->folders; l; l = l->next) {
 		struct media_item *item = l->data;
 
-		if (!item->folder)
+		if (g_strcmp0(item->type, "Folder") != 0)
 			continue;
 
 		if (g_str_equal(item->name, name))
@@ -1044,17 +1047,14 @@ static gboolean get_item_name(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean get_folder_flag(const GDBusPropertyTable *property,
+static gboolean get_item_type(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_item *item = data;
-	dbus_bool_t value;
-
-	DBG("%s", item->folder ? "true" : "false");
 
-	value = item->folder;
+	DBG("%s", item->type);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &item->type);
 
 	return TRUE;
 }
@@ -1074,6 +1074,30 @@ static gboolean get_playable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean folder_type_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_item *item = data;
+
+	return item->folder_type != NULL;
+}
+
+static gboolean get_folder_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_item *item = data;
+
+	if (item->folder_type == NULL)
+		return FALSE;
+
+	DBG("%s", item->folder_type);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
+							&item->folder_type);
+
+	return TRUE;
+}
+
 static const GDBusMethodTable media_item_methods[] = {
 	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL,
 					media_item_play) },
@@ -1085,25 +1109,28 @@ static const GDBusMethodTable media_item_methods[] = {
 static const GDBusPropertyTable media_item_properties[] = {
 	{ "Name", "s", get_item_name, NULL, item_name_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Folder", "b", get_folder_flag, NULL, NULL,
+	{ "Type", "s", get_item_type, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "FolderType", "s", get_folder_type, NULL, folder_type_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Playable", "b", get_playable, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-int media_player_create_folder(struct media_player *mp, const char *name)
+static struct media_item *media_player_create_item(struct media_player *mp,
+							const char *name,
+							const char *type)
 {
 	struct media_item *item;
 
-	DBG("%s", name);
+	DBG("%s type %s", name, type);
 
 	item = g_new0(struct media_item, 1);
 	item->player = mp;
 	item->path = g_strdup_printf("%s%s", mp->path, name);
 	item->name = g_strdup(name);
-	item->folder = true;
-	item->playable = false;
+	item->type = g_strdup(type);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					item->path, MEDIA_ITEM_INTERFACE,
@@ -1113,9 +1140,23 @@ int media_player_create_folder(struct media_player *mp, const char *name)
 		error("D-Bus failed to register %s on %s path",
 					MEDIA_ITEM_INTERFACE, item->path);
 		media_item_destroy(item);
-		return -EINVAL;
+		return NULL;
 	}
 
+	return item;
+}
+
+int media_player_create_folder(struct media_player *mp, const char *name,
+							const char *type)
+{
+	struct media_item *item;
+
+	item = media_player_create_item(mp, name, "folder");
+	if (item == NULL)
+		return -EINVAL;
+
+	item->folder_type = g_strdup(type);
+
 	if (mp->folder == NULL)
 		media_player_set_folder_item(mp, item, 0);
 
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index a59cc66..28689c5 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -55,7 +55,8 @@ void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 
-int media_player_create_folder(struct media_player *mp, const char *path);
+int media_player_create_folder(struct media_player *mp, const char *name,
+							const char *type);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1.2

