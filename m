Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 8/8 v2] player: Add Device property
Date: Thu, 10 Jan 2013 15:24:37 +0200
Message-Id: <1357824283-19233-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
References: <1357824283-19233-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Device property indicates which device object the player belongs to.
---
 doc/media-api.txt       |  4 ++++
 profiles/audio/player.c | 14 ++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/doc/media-api.txt b/doc/media-api.txt
index 12a2d7a..e2cafd1 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -288,6 +288,10 @@ Properties	string Equalizer [readwrite]
 
 					Track duration in milliseconds
 
+		object Device [readonly]
+
+			Device object path.
+
 MediaEndpoint1 hierarchy
 ========================
 
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 81bb7fe..bac5649 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -56,6 +56,7 @@ struct pending_req {
 };
 
 struct media_player {
+	char			*device;	/* Device path */
 	char			*path;		/* Player object path */
 	GHashTable		*settings;	/* Player settings */
 	GHashTable		*track;		/* Player current track */
@@ -239,6 +240,16 @@ static gboolean get_track(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_player *mp = data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &mp->device);
+
+	return TRUE;
+}
+
 static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -417,6 +428,7 @@ static const GDBusPropertyTable media_player_properties[] = {
 	{ "Shuffle", "s", get_setting, set_setting, setting_exists },
 	{ "Scan", "s", get_setting, set_setting, setting_exists },
 	{ "Track", "a{sv}", get_track, NULL, NULL },
+	{ "Device", "s", get_device, NULL, NULL },
 	{ }
 };
 
@@ -442,6 +454,7 @@ void media_player_destroy(struct media_player *mp)
 	g_free(mp->cb);
 	g_free(mp->status);
 	g_free(mp->path);
+	g_free(mp->device);
 	g_free(mp);
 }
 
@@ -450,6 +463,7 @@ struct media_player *media_player_controller_create(const char *path)
 	struct media_player *mp;
 
 	mp = g_new0(struct media_player, 1);
+	mp->device = g_strdup(path);
 	mp->path = g_strdup_printf("%s/player1", path);
 	mp->settings = g_hash_table_new_full(g_str_hash, g_str_equal,
 							g_free, g_free);
-- 
1.8.0.1

