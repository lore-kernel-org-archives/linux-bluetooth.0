Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/9] player: Add Playlist property
Date: Wed, 27 Feb 2013 15:15:55 +0200
Message-Id: <1361970961-14300-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
References: <1361970961-14300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Playlist property refer to the folder where the list of items being
played can be found.
---
 doc/media-api.txt       |  4 ++++
 profiles/audio/avrcp.c  |  4 +++-
 profiles/audio/player.c | 46 +++++++++++++++++++++++++++++++++++++++++++++-
 profiles/audio/player.h |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 2656a9e..5638fc9 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -259,6 +259,10 @@ Properties	string Equalizer [readwrite]
 			by using MediaLibrary interface but it might interfere
 			in the playback of other players.
 
+		object Playlist
+
+			Playlist object path.
+
 MediaFolder1 hierarchy
 ======================
 
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 9be977e..b14d10c 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2041,8 +2041,10 @@ static void avrcp_player_parse_features(struct avrcp_player *player,
 	if (features[7] & 0x10)
 		media_player_set_searchable(mp, true);
 
-	if (features[8] & 0x02)
+	if (features[8] & 0x02) {
 		media_player_create_folder(mp, "/NowPlaying");
+		media_player_set_playlist(mp, "/NowPlaying");
+	}
 }
 
 static void avrcp_parse_media_player_item(struct avrcp *session,
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 8401e19..f026a51 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -78,7 +78,8 @@ struct media_player {
 	char			*subtype;	/* Player subtype */
 	bool			browsable;	/* Player browsing feature */
 	bool			searchable;	/* Player searching feature */
-	struct media_folder	*folder;	/* Player currenct folder */
+	struct media_folder	*folder;	/* Player current folder */
+	struct media_item	*playlist;	/* Player current playlist */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
@@ -413,6 +414,29 @@ static gboolean get_searchable(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean playlist_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct media_player *mp = data;
+
+	return mp->playlist != NULL;
+}
+
+static gboolean get_playlist(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+	struct media_item *playlist = mp->playlist;
+
+	if (playlist == NULL)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
+							&playlist->path);
+
+	return TRUE;
+}
+
 static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -577,6 +601,8 @@ static const GDBusPropertyTable media_player_properties[] = {
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "Searchable", "b", get_searchable, NULL, searchable_exists,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Playlist", "o", get_playlist, NULL, playlist_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -1009,6 +1035,24 @@ void media_player_set_folder(struct media_player *mp, const char *name,
 	media_player_set_folder_item(mp, item, number_of_items);
 }
 
+void media_player_set_playlist(struct media_player *mp, const char *name)
+{
+	struct media_item *item;
+
+	DBG("%s", name);
+
+	item = media_player_find_folder(mp, name);
+	if (item == NULL) {
+		error("Unknown folder: %s", name);
+		return;
+	}
+
+	mp->playlist = item;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), mp->path,
+					MEDIA_PLAYER_INTERFACE, "Playlist");
+}
+
 static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index a59cc66..eae887b 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -54,6 +54,7 @@ void media_player_set_browsable(struct media_player *mp, bool enabled);
 void media_player_set_searchable(struct media_player *mp, bool enabled);
 void media_player_set_folder(struct media_player *mp, const char *path,
 								uint32_t items);
+void media_player_set_playlist(struct media_player *mp, const char *name);
 
 int media_player_create_folder(struct media_player *mp, const char *path);
 
-- 
1.8.1.2

