Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 05/23] avrcp: implement ChangePlayback() method
Date: Fri,  5 Aug 2011 15:15:14 -0300
Message-Id: <1312568132-21112-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ChangePlayback() is used by applications to inform bluetoothd of the
current status of playback.
---
 audio/control.c |   77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index ceff561..e05a66f 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -135,6 +135,15 @@ enum scan_mode {
 	SCAN_MODE_GROUP =	3,
 };
 
+enum play_status {
+	PLAY_STATUS_STOPPED =		0x00,
+	PLAY_STATUS_PLAYING =		0x01,
+	PLAY_STATUS_PAUSED =		0x02,
+	PLAY_STATUS_FWD_SEEK =		0x03,
+	PLAY_STATUS_REV_SEEK =		0x04,
+	PLAY_STATUS_ERROR =		0xFF
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
@@ -216,8 +225,16 @@ struct avctp_server {
 	uint32_t ct_record_id;
 };
 
+struct media_info {
+	uint32_t elapsed;
+};
+
 struct media_player {
 	uint8_t settings[PLAYER_SETTING_SCAN + 1];
+	enum play_status status;
+
+	struct media_info mi;
+	GTimer *timer;
 };
 
 struct control {
@@ -522,6 +539,40 @@ static int attr_to_val(const char *str)
 	return -EINVAL;
 }
 
+static int play_status_to_val(const char *status)
+{
+	if (!strcmp(status, "stopped"))
+		return PLAY_STATUS_STOPPED;
+	else if (!strcmp(status, "playing"))
+		return PLAY_STATUS_PLAYING;
+	else if (!strcmp(status, "paused"))
+		return PLAY_STATUS_PAUSED;
+	else if (!strcmp(status, "forward-seek"))
+		return PLAY_STATUS_FWD_SEEK;
+	else if (!strcmp(status, "reverse-seek"))
+		return PLAY_STATUS_REV_SEEK;
+	else if (!strcmp(status, "error"))
+		return PLAY_STATUS_ERROR;
+
+	return -EINVAL;
+}
+
+static void mp_set_playback_status(struct control *control, uint8_t status,
+							uint32_t elapsed)
+{
+	struct media_player *mp = control->mp;
+
+	DBG("Change playback: %u %u", status, elapsed);
+
+	mp->mi.elapsed = elapsed;
+	g_timer_start(mp->timer);
+
+	if (status == mp->status)
+		return;
+
+	mp->status = status;
+}
+
 static void mp_set_attribute(struct media_player *mp,
 						uint8_t attr, uint8_t val)
 {
@@ -1280,8 +1331,32 @@ static DBusMessage *mp_change_setting(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *mp_change_playback(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	const char *statusstr;
+	int status;
+	uint32_t elapsed;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &statusstr,
+						DBUS_TYPE_UINT32, &elapsed,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	status = play_status_to_val(statusstr);
+	if (status < 0)
+		return btd_error_invalid_args(msg);
+
+	mp_set_playback_status(control, status, elapsed);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable mp_methods[] = {
 	{ "ChangeSetting",	"sv",	"",	mp_change_setting },
+	{ "ChangePlayback",	"su",	"",	mp_change_playback },
 	{ }
 };
 
@@ -1313,6 +1388,7 @@ static void mp_path_unregister(void *data)
 	DBG("Unregistered interface %s on path %s",
 		MEDIA_PLAYER_INTERFACE, dev->path);
 
+	g_timer_destroy(mp->timer);
 	g_free(mp);
 	control->mp = NULL;
 }
@@ -1373,6 +1449,7 @@ struct control *control_init(struct audio_device *dev, uint16_t uuid16,
 		DBG("Registered interface %s on path %s",
 					MEDIA_PLAYER_INTERFACE, dev->path);
 
+		mp->timer = g_timer_new();
 		control->mp = mp;
 	}
 
-- 
1.7.6

