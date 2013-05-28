Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 05/13] player: Add support for setting current Item object
Date: Tue, 28 May 2013 15:51:23 +0300
Message-Id: <1369745491-23897-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces media_player_set_playlist_item which is used when the
current item UID is known, with this the application can tell what
is the current item in the playlist.
---
 profiles/audio/avrcp.c  |  3 +++
 profiles/audio/player.c | 42 ++++++++++++++++++++++++++++++++++++------
 profiles/audio/player.h |  1 +
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index f86dc9a..6ae0a68 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1896,6 +1896,9 @@ static void avrcp_parse_attribute_list(struct avrcp_player *player,
 	struct media_player *mp = player->user_data;
 	int i;
 
+	if (player->uid > 0)
+		media_player_set_playlist_item(mp, player->uid);
+
 	for (i = 0; count > 0; count--) {
 		uint32_t id;
 		uint16_t charset, len;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 9fccb2f..77009c7 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -102,16 +102,18 @@ struct media_player {
 static void append_metadata(void *key, void *value, void *user_data)
 {
 	DBusMessageIter *dict = user_data;
+	const char *strkey = key;
 
-	if (strcasecmp((char *) key, "Duration") == 0 ||
-			strcasecmp((char *) key, "TrackNumber") == 0 ||
-			strcasecmp((char *) key, "NumberOfTracks") == 0)  {
+	if (strcasecmp(strkey, "Duration") == 0 ||
+			strcasecmp(strkey, "TrackNumber") == 0 ||
+			strcasecmp(strkey, "NumberOfTracks") == 0)  {
 		uint32_t num = atoi(value);
 		dict_append_entry(dict, key, DBUS_TYPE_UINT32, &num);
-		return;
+	} else if (strcasecmp(strkey, "Item") == 0) {
+		dict_append_entry(dict, key, DBUS_TYPE_OBJECT_PATH, &value);
+	} else {
+		dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
 	}
-
-	dict_append_entry(dict, key, DBUS_TYPE_STRING, &value);
 }
 
 static struct pending_req *find_pending(struct media_player *mp,
@@ -1282,6 +1284,34 @@ static struct media_item *media_folder_find_item(struct media_folder *folder,
 	return NULL;
 }
 
+void media_player_set_playlist_item(struct media_player *mp, uint64_t uid)
+{
+	struct media_folder *folder = mp->playlist;
+	struct media_item *item;
+
+	DBG("%" PRIu64 "", uid);
+
+	if (folder == NULL)
+		return;
+
+	item = media_folder_find_item(folder, uid);
+	if (item == NULL) {
+		warn("Item not found");
+		return;
+	}
+
+	if (item == g_hash_table_lookup(mp->track, "Item"))
+		return;
+
+	if (mp->process_id == 0) {
+		g_hash_table_remove_all(mp->track);
+		mp->process_id = g_idle_add(process_metadata_changed, mp);
+	}
+
+	g_hash_table_replace(mp->track, g_strdup("Item"),
+						g_strdup(item->path));
+}
+
 static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 0f75f4f..843c71b 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -77,6 +77,7 @@ void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
 void media_player_set_playlist(struct media_player *mp, const char *name);
+void media_player_set_playlist_item(struct media_player *mp, uint64_t uid);
 
 struct media_item *media_player_create_folder(struct media_player *mp,
 						const char *name,
-- 
1.8.1.4

