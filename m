Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/11] player: Enable MediaPlayer1 interface as experimental
Date: Fri, 28 Dec 2012 14:51:08 +0200
Message-Id: <1356699069-5469-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
References: <1356699069-5469-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable MediaPlayer1 when GDBUS_EXPERIMENTAL=1
---
 profiles/audio/player.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 005d0d1..693a590 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -239,25 +239,31 @@ static void set_setting(const GDBusPropertyTable *property,
 }
 
 static const GDBusMethodTable media_player_methods[] = {
-	{ GDBUS_METHOD("GetTrack",
+	{ GDBUS_EXPERIMENTAL_METHOD("GetTrack",
 			NULL, GDBUS_ARGS({ "metadata", "a{sv}" }),
 			media_player_get_track) },
 	{ }
 };
 
 static const GDBusSignalTable media_player_signals[] = {
-	{ GDBUS_SIGNAL("TrackChanged",
+	{ GDBUS_EXPERIMENTAL_SIGNAL("TrackChanged",
 			GDBUS_ARGS({ "metadata", "a{sv}" })) },
 	{ }
 };
 
 static const GDBusPropertyTable media_player_properties[] = {
-	{ "Position", "u", get_position },
-	{ "Status", "s", get_status, NULL, status_exists },
-	{ "Equalizer", "s", get_setting, set_setting, setting_exists },
-	{ "Repeat", "s", get_setting, set_setting, setting_exists },
-	{ "Shuffle", "s", get_setting, set_setting, setting_exists },
-	{ "Scan", "s", get_setting, set_setting, setting_exists },
+	{ "Position", "u", get_position, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Status", "s", get_status, NULL, status_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Equalizer", "s", get_setting, set_setting, setting_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Repeat", "s", get_setting, set_setting, setting_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Shuffle", "s", get_setting, set_setting, setting_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "Scan", "s", get_setting, set_setting, setting_exists,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
@@ -298,7 +304,6 @@ struct media_player *media_player_controller_create(const char *path)
 							g_free, g_free);
 	mp->progress = g_timer_new();
 
-#if 0
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
 					media_player_methods,
@@ -308,7 +313,7 @@ struct media_player *media_player_controller_create(const char *path)
 		media_player_destroy(mp);
 		return NULL;
 	}
-#endif
+
 	DBG("%s", mp->path);
 
 	return mp;
@@ -410,7 +415,6 @@ void media_player_set_status(struct media_player *mp, const char *status)
 
 static gboolean process_metadata_changed(void *user_data)
 {
-#if 0
 	struct media_player *mp = user_data;
 	DBusMessage *signal;
 	DBusMessageIter iter, dict;
@@ -439,7 +443,7 @@ static gboolean process_metadata_changed(void *user_data)
 	dbus_message_iter_close_container(&iter, &dict);
 
 	g_dbus_send_message(btd_get_dbus_connection(), signal);
-#endif
+
 	return FALSE;
 }
 
-- 
1.8.0.1

