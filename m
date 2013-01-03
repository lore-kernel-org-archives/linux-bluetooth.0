Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/8] player: Add support for button controls
Date: Thu,  3 Jan 2013 21:46:06 +0200
Message-Id: <1357242371-6752-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
References: <1357242371-6752-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for buttons controls in MediaPlayer1
---
 profiles/audio/avrcp.c  |  91 ++++++++++++++++++++++++++-
 profiles/audio/player.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/player.h |   9 +++
 3 files changed, 261 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ce070cd..7b7c2ef 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1965,8 +1965,96 @@ static bool ct_set_setting(struct media_player *mp, const char *key,
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
+static int ct_volume_up(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_VOLUME_UP);
+}
+
+static int ct_volume_down(struct media_player *mp, void *user_data)
+{
+	struct avrcp_player *player = user_data;
+
+	return ct_press(player, AVC_VOLUME_DOWN);
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
+	.volume_up	= ct_volume_up,
+	.volume_down	= ct_volume_down,
 };
 
 static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
@@ -1988,6 +2076,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn,
 	count = pdu->params[1];
 
 	path = device_get_path(session->dev->btd_dev);
+
 	mp = media_player_controller_create(path);
 	if (mp == NULL)
 		return FALSE;
diff --git a/profiles/audio/player.c b/profiles/audio/player.c
index ae6b19b..01086d0 100644
--- a/profiles/audio/player.c
+++ b/profiles/audio/player.c
@@ -239,7 +239,169 @@ static gboolean get_track(const GDBusPropertyTable *property,
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
+static DBusMessage *media_player_volume_up(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->volume_up == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->volume_up(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *media_player_volume_down(DBusConnection *conn,
+						DBusMessage *msg, void *data)
+{
+	struct media_player *mp = data;
+	struct player_callback *cb = mp->cb;
+	int err;
+
+	if (cb->cbs->volume_down == NULL)
+		return btd_error_not_supported(msg);
+
+	err = cb->cbs->volume_down(mp, cb->user_data);
+	if (err < 0)
+		return btd_error_failed(msg, strerror(-err));
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
 static const GDBusMethodTable media_player_methods[] = {
+	{ GDBUS_METHOD("Play", NULL, NULL, media_player_play) },
+	{ GDBUS_METHOD("Pause", NULL, NULL, media_player_pause) },
+	{ GDBUS_METHOD("Stop", NULL, NULL, media_player_stop) },
+	{ GDBUS_METHOD("Next", NULL, NULL, media_player_next) },
+	{ GDBUS_METHOD("Previous", NULL, NULL, media_player_previous) },
+	{ GDBUS_METHOD("FastForward", NULL, NULL, media_player_fast_forward) },
+	{ GDBUS_METHOD("Rewind", NULL, NULL, media_player_rewind) },
+	{ GDBUS_METHOD("VolumeUp", NULL, NULL, media_player_volume_up) },
+	{ GDBUS_METHOD("VolumeDown", NULL, NULL, media_player_volume_down) },
 	{ }
 };
 
diff --git a/profiles/audio/player.h b/profiles/audio/player.h
index 87dfb66..4b92b30 100644
--- a/profiles/audio/player.h
+++ b/profiles/audio/player.h
@@ -28,6 +28,15 @@ struct media_player;
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
+	int (*volume_up) (struct media_player *mp, void *user_data);
+	int (*volume_down) (struct media_player *mp, void *user_data);
 };
 
 struct media_player *media_player_controller_create(const char *path);
-- 
1.8.0.1

