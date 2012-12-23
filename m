Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] player: Enable MediaPlayer1 interface as experimental
Date: Sun, 23 Dec 2012 17:24:57 +0200
Message-Id: <1356276298-13795-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
References: <1356276298-13795-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enable MediaPlayer1 when GDBUS_EXPERIMENTAL=1
---
 profiles/audio/player.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 005d0d1..60c7a8a 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -298,9 +298,9 @@ struct media_player *media_player_controller_create(const char *path)
 							g_free, g_free);
 	mp->progress = g_timer_new();
 
-#if 0
-	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+	if (!g_dbus_register_interface_with_flags(btd_get_dbus_connection(),
 					mp->path, MEDIA_PLAYER_INTERFACE,
+					G_DBUS_INTERFACE_FLAG_EXPERIMENTAL,
 					media_player_methods,
 					media_player_signals,
 					media_player_properties, mp, NULL)) {
@@ -308,7 +308,7 @@ struct media_player *media_player_controller_create(const char *path)
 		media_player_destroy(mp);
 		return NULL;
 	}
-#endif
+
 	DBG("%s", mp->path);
 
 	return mp;
@@ -410,7 +410,6 @@ void media_player_set_status(struct media_player *mp, const char *status)
 
 static gboolean process_metadata_changed(void *user_data)
 {
-#if 0
 	struct media_player *mp = user_data;
 	DBusMessage *signal;
 	DBusMessageIter iter, dict;
@@ -439,7 +438,7 @@ static gboolean process_metadata_changed(void *user_data)
 	dbus_message_iter_close_container(&iter, &dict);
 
 	g_dbus_send_message(btd_get_dbus_connection(), signal);
-#endif
+
 	return FALSE;
 }
 
-- 
1.7.11.7

