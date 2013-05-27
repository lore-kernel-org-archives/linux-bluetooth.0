Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/13] player: Add implementation of MediaItem.AddToNowPlaying
Date: Mon, 27 May 2013 14:34:03 +0300
Message-Id: <1369654443-11514-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369654443-11514-1-git-send-email-luiz.dentz@gmail.com>
References: <1369654443-11514-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 5939086..0b7b797 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -1402,7 +1402,23 @@ static DBusMessage *media_item_play(DBusConnection *conn, DBusMessage *msg,
 static DBusMessage *media_item_add_to_nowplaying(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return btd_error_failed(msg, strerror(ENOTSUP));
+	struct media_item *item = data;
+	struct media_player *mp = item->player;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (!item->playable)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	if (cb->cbs->play_item == NULL)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	err = cb->cbs->add_to_nowplaying(mp, item->path, item->uid,
+							cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static gboolean item_name_exists(const GDBusPropertyTable *property,
-- 
1.8.1.4

