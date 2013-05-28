Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 09/13] player: Add implementation of MediaFolder.ChangeFolder
Date: Tue, 28 May 2013 15:51:27 +0300
Message-Id: <1369745491-23897-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
References: <1369745491-23897-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index deae112..371487c 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -856,7 +856,42 @@ static struct media_folder *media_player_find_folder(struct media_player *mp,
 static DBusMessage *media_folder_change_folder(DBusConnection *conn,
 						DBusMessage *msg, void *data)
 {
-	return btd_error_failed(msg, strerror(ENOTSUP));
+	struct media_player *mp = data;
+	struct media_folder *folder = mp->scope;
+	struct player_callback *cb = mp->cb;
+	const char *path;
+	int err;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID))
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	if (folder->msg != NULL)
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	folder = media_player_find_folder(mp, path);
+	if (folder == NULL)
+		return btd_error_failed(msg, strerror(EINVAL));
+
+	if (mp->scope == folder)
+		goto done;
+
+	if (folder == mp->playlist || folder == mp->folder) {
+		media_player_change_scope(mp, folder);
+		goto done;
+	}
+
+	if (cb->cbs->change_folder == NULL)
+		return btd_error_failed(msg, strerror(ENOTSUP));
+
+	err = cb->cbs->change_folder(mp, folder->item->name, folder->item->uid,
+								cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+done:
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 }
 
 static gboolean folder_name_exists(const GDBusPropertyTable *property,
-- 
1.8.1.4

