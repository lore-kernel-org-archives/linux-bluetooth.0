Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 09/13] player: Add implementation of MediaFolder.ChangeFolder
Date: Mon, 27 May 2013 14:33:59 +0300
Message-Id: <1369654443-11514-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1369654443-11514-1-git-send-email-luiz.dentz@gmail.com>
References: <1369654443-11514-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 profiles/audio/player.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 103a19b..e918a0d 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -868,7 +868,42 @@ done:
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
+	folder = media_player_find_folder_by_path(mp, path);
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
+	err = cb->cbs->change_folder(mp, folder->item->path, folder->item->uid,
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

