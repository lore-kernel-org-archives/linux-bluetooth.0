Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/13 v2] player: Add support for button controls
Date: Thu, 10 Jan 2013 15:37:08 +0200
Message-Id: <1357825038-21970-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
References: <1357825038-21970-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for buttons controls in MediaPlayer1
---
 profiles/audio/avrcp.c  |  75 +++++++++++++++++++++++++++-
 profiles/audio/player.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |   7 +++
 3 files changed, 210 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a139606..9ca5a3a 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1965,8 +1965,80 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
 	return true;
 }
 
+static int ct_press(struct avrcp_player *player, uint8_t op)
+{
+	int err;
+	struct avrcp *session;
+
+	session = player->sessions->data;
+	if (session == NULL)
+		return -ENOTCONN;
+
+	err = avctp_send_passthrough(session->conn, op);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
+static int ct_play(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_PLAY);
+}
+
+static int ct_pause(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_PAUSE);
+}
+
+static int ct_stop(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_STOP);
+}
+
+static int ct_next(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_FORWARD);
+}
+
+static int ct_previous(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_BACKWARD);
+}
+
+static int ct_fast_forward(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_FAST_FORWARD);
+}
+
+static int ct_rewind(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_REWIND);
+}
+
 static const struct media_player_callback ct_cbs = {
-	.set_setting = ct_set_setting,
+	.set_setting	= ct_set_setting,
+	.play		= ct_play,
+	.pause		= ct_pause,
+	.stop		= ct_stop,
+	.next		= ct_next,
+	.previous	= ct_previous,
+	.fast_forward	= ct_fast_forward,
+	.rewind		= ct_rewind,
 };
 
 static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
@@ -1988,6 +2060,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	count = pdu->params[1];
 
 	path = device_get_path(session->dev->btd_dev);
+
 	mp = media_player_controller_create(path);
 	if (mp == NULL)
 		return FALSE;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index 9add1b8..2e5c386 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -242,7 +242,136 @@ static gboolean get_track(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *media_player_play(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->play == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->play(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_pause(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->pause == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->pause(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_stop(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->stop == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->stop(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_next(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->next == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->next(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_previous(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->previous == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->previous(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_fast_forward(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->fast_forward == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->fast_forward(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_rewind(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->rewind == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->rewind(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static const GDBusMethodTable media_player_methods[] = {
+	{ GDBUS_EXPERIMENTAL_METHOD("Play", NULL, NULL, media_player_play) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Pause", NULL, NULL, media_player_pause) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Stop", NULL, NULL, media_player_stop) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Next", NULL, NULL, media_player_next) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Previous", NULL, NULL,
+						media_player_previous) },
+	{ GDBUS_EXPERIMENTAL_METHOD("FastForward", NULL, NULL,
+						media_player_fast_forward) },
+	{ GDBUS_EXPERIMENTAL_METHOD("Rewind", NULL, NULL,
+						media_player_rewind) },
 	{ }
 };
 
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 87dfb66..212a5a6 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -28,6 +28,13 @@ struct media_player;
 struct media_player_callback {
 	bool (*set_setting) (struct media_player *mp, const char *key,
 				const char *value, void *user_data);
+	int (*play) (struct media_player *mp, void *user_data);
+	int (*pause) (struct media_player *mp, void *user_data);
+	int (*stop) (struct media_player *mp, void *user_data);
+	int (*next) (struct media_player *mp, void *user_data);
+	int (*previous) (struct media_player *mp, void *user_data);
+	int (*fast_forward) (struct media_player *mp, void *user_data);
+	int (*rewind) (struct media_player *mp, void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path);
-- 
1.8.0.1

