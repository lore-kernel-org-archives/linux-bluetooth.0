Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/10 v4] player: Add enums for item types and folder types
Date: Mon,  4 Mar 2013 10:06:03 +0200
Message-Id: <1362384369-20709-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
References: <1362384369-20709-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid having to allocate memory just to store string representation
of these types.
---
 profiles/audio/avrcp.c  |  6 ++--
 profiles/audio/player.c | 83 ++++++++++++++++++++++++++++++++++++++-----------
 profiles/audio/player.h | 20 +++++++++++-
 3 files changed, 87 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5f0f0a4..110910d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2035,14 +2035,16 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 
 	if (features[7] & 0x08) {
 		media_player_set_browsable(mp, true);
-		media_player_create_folder(mp, "/Filesystem", "mixed");
+		media_player_create_folder(mp, "/Filesystem",
+						PLAYER_FOLDER_TYPE_MIXED);
 	}
 
 	if (features[7] & 0x10)
 		media_player_set_searchable(mp, true);
 
 	if (features[8] & 0x02)
-		media_player_create_folder(mp, "/NowPlaying", "mixed");
+		media_player_create_folder(mp, "/NowPlaying",
+						PLAYER_FOLDER_TYPE_MIXED);
 }
 
 static void avrcp_parse_media_player_item(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index c4dd588..4021f3a 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -62,8 +62,8 @@ struct media_item {
 	struct media_player	*player;
 	char			*path;		/* Item object path */
 	char			*name;		/* Item name */
-	char			*type;		/* Item type */
-	char			*folder_type;	/* Folder type */
+	uint8_t			type;		/* Item type */
+	uint8_t			folder_type;	/* Folder type */
 	bool			playable;	/* Item playable flag */
 };
 
@@ -687,8 +687,6 @@ static void media_item_destroy(void *data)
 
 	g_free(item->path);
 	g_free(item->name);
-	g_free(item->type);
-	g_free(item->folder_type);
 	g_free(item);
 }
 
@@ -986,7 +984,7 @@ static struct media_item *media_player_find_folder(struct media_player *mp,
 	for (l = mp->folders; l; l = l->next) {
 		struct media_item *item = l->data;
 
-		if (g_strcmp0(item->type, "folder") != 0)
+		if (item->type != PLAYER_ITEM_TYPE_FOLDER)
 			continue;
 
 		if (g_str_equal(item->name, name))
@@ -1047,14 +1045,31 @@ static gboolean get_item_name(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static const char *type_to_string(uint8_t type)
+{
+	switch (type) {
+	case PLAYER_ITEM_TYPE_AUDIO:
+		return "audio";
+	case PLAYER_ITEM_TYPE_VIDEO:
+		return "video";
+	case PLAYER_ITEM_TYPE_FOLDER:
+		return "folder";
+	}
+
+	return NULL;
+}
+
 static gboolean get_item_type(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_item *item = data;
+	const char *string;
 
-	DBG("%s", item->type);
+	string = type_to_string(item->type);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &item->type);
+	DBG("%s", string);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
 
 	return TRUE;
 }
@@ -1074,26 +1089,49 @@ static gboolean get_playable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static const char *folder_type_to_string(uint8_t type)
+{
+	switch (type) {
+	case PLAYER_FOLDER_TYPE_MIXED:
+		return "mixed";
+	case PLAYER_FOLDER_TYPE_TITLES:
+		return "titles";
+	case PLAYER_FOLDER_TYPE_ALBUMS:
+		return "albums";
+	case PLAYER_FOLDER_TYPE_ARTISTS:
+		return "artists";
+	case PLAYER_FOLDER_TYPE_GENRES:
+		return "genres";
+	case PLAYER_FOLDER_TYPE_PLAYLISTS:
+		return "playlists";
+	case PLAYER_FOLDER_TYPE_YEARS:
+		return "years";
+	}
+
+	return NULL;
+}
+
 static gboolean folder_type_exists(const GDBusPropertyTable *property,
 								void *data)
 {
 	struct media_item *item = data;
 
-	return item->folder_type != NULL;
+	return folder_type_to_string(item->folder_type) != NULL;
 }
 
 static gboolean get_folder_type(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_item *item = data;
+	const char *string;
 
-	if (item->folder_type == NULL)
+	string = folder_type_to_string(item->folder_type);
+	if (string == NULL)
 		return FALSE;
 
-	DBG("%s", item->folder_type);
+	DBG("%s", string);
 
-	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
-							&item->folder_type);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &string);
 
 	return TRUE;
 }
@@ -1119,18 +1157,24 @@ static const GDBusPropertyTable media_item_properties[] = {
 };
 
 static struct media_item *media_player_create_item(struct media_player *mp,
-							const char *name,
-							const char *type)
+						const char *name,
+						player_item_type_t type)
 {
 	struct media_item *item;
+	const char *strtype;
+
+	strtype = type_to_string(type);
+	if (strtype == NULL)
+		return NULL;
 
-	DBG("%s type %s", name, type);
+	DBG("%s type %s", name, strtype);
 
 	item = g_new0(struct media_item, 1);
 	item->player = mp;
 	item->path = g_strdup_printf("%s%s", mp->path, name);
 	item->name = g_strdup(name);
-	item->type = g_strdup(type);
+	item->type = type;
+	item->folder_type = PLAYER_FOLDER_TYPE_INVALID;
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					item->path, MEDIA_ITEM_INTERFACE,
@@ -1147,15 +1191,16 @@ static struct media_item *media_player_create_item(struct media_player *mp,
 }
 
 int media_player_create_folder(struct media_player *mp, const char *name,
-							const char *type)
+						player_folder_type_t type)
 {
 	struct media_item *item;
 
-	item = media_player_create_item(mp, name, "folder");
+	item = media_player_create_item(mp, name,
+					PLAYER_ITEM_TYPE_FOLDER);
 	if (item == NULL)
 		return -EINVAL;
 
-	item->folder_type = g_strdup(type);
+	item->folder_type = type;
 
 	if (mp->folder == NULL)
 		media_player_set_folder_item(mp, item, 0);
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 28689c5..bdf0501 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -23,6 +23,24 @@
  *
  */
 
+typedef enum {
+	PLAYER_ITEM_TYPE_AUDIO,
+	PLAYER_ITEM_TYPE_VIDEO,
+	PLAYER_ITEM_TYPE_FOLDER,
+	PLAYER_ITEM_TYPE_INVALID,
+} player_item_type_t;
+
+typedef enum {
+	PLAYER_FOLDER_TYPE_MIXED,
+	PLAYER_FOLDER_TYPE_TITLES,
+	PLAYER_FOLDER_TYPE_ALBUMS,
+	PLAYER_FOLDER_TYPE_ARTISTS,
+	PLAYER_FOLDER_TYPE_GENRES,
+	PLAYER_FOLDER_TYPE_PLAYLISTS,
+	PLAYER_FOLDER_TYPE_YEARS,
+	PLAYER_FOLDER_TYPE_INVALID,
+} player_folder_type_t;
+
 struct media_player;
 
 struct media_player_callback {
@@ -56,7 +74,7 @@ void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 
 int media_player_create_folder(struct media_player *mp, const char *name,
-							const char *type);
+						player_folder_type_t type);
 
 void media_player_set_callbacks(struct media_player *mp,
 				const struct media_player_callback *cbs,
-- 
1.8.1.2

