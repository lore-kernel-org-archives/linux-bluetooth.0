Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 10/19] avrcp: implement ChangePlayback() method
Date: Tue, 19 Jul 2011 16:49:21 -0300
Message-Id: <1311104970-18600-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ChangePlayback() is used by applications to inform BlueZ of the current
status of playback. It's expected to work only when the device is in TG
role.
---
 audio/control.c     |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/control-api.txt |    3 +-
 2 files changed, 68 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 866a558..77e0e6d 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -167,6 +167,15 @@ enum battery_status {
 	BATTERY_STATUS_FULL_CHARGE =	4,
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
@@ -248,6 +257,11 @@ struct avctp_server {
 	uint32_t ct_record_id;
 };
 
+struct media_info {
+	enum play_status status;
+	uint32_t current_position;
+};
+
 struct control {
 	struct audio_device *dev;
 
@@ -265,6 +279,7 @@ struct control {
 	uint8_t key_quirks[256];
 
 	uint8_t player_setting[PLAYER_SETTING_SCAN + 1];
+	struct media_info mi;
 };
 
 static struct {
@@ -1653,6 +1668,24 @@ static int setting_string_to_val(uint8_t setting, const char *value) {
 	return -EINVAL;
 }
 
+static int play_status_string_to_val(const char *status)
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
 static DBusMessage *setting_set(DBusMessage *msg, struct control *control,
 				const char *settingstr, const char *valstr)
 {
@@ -1718,6 +1751,38 @@ static DBusMessage *control_change_setting(DBusConnection *conn,
 	return setting_set(msg, control, setting, value);
 }
 
+static DBusMessage *control_change_playback(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	const char *statusstr;
+	int status;
+	uint32_t elapsed;
+
+	if (control->state != AVCTP_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	if (control->target) /* Only supported if this device is in TG role */
+		return btd_error_not_supported(msg);
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &statusstr,
+						DBUS_TYPE_UINT32, &elapsed,
+						DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	status = play_status_string_to_val(statusstr);
+	if (status < 0)
+		return btd_error_invalid_args(msg);
+
+	control->mi.status = status;
+	control->mi.current_position = elapsed;
+
+	DBG("Change playback: %s %u", statusstr, elapsed);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable control_methods[] = {
 	{ "IsConnected",	"",	"b",	control_is_connected,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
@@ -1725,6 +1790,7 @@ static GDBusMethodTable control_methods[] = {
 	{ "VolumeUp",		"",	"",	volume_up },
 	{ "VolumeDown",		"",	"",	volume_down },
 	{ "ChangeSetting",	"sv",	"",	control_change_setting },
+	{ "ChangePlayback",	"su",	"",	control_change_playback },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/doc/control-api.txt b/doc/control-api.txt
index 931fa10..ca97544 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -49,7 +49,8 @@ Methods		void Connect()
 
 			The status can be "playing", "stopped", "paused",
 			"forward-seek", "reverse-seek" or "error". Elapsed is
-			the position within the track in milliseconds.
+			the position within the track in milliseconds. ONLY
+			valid if BlueZ device is in TG role.
 
 		void ChangeTrack(dict metadata)
 
-- 
1.7.6

