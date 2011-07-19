Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 02/19] avrcp: implement ChangeSetting() method for TG role
Date: Tue, 19 Jul 2011 16:49:13 -0300
Message-Id: <1311104970-18600-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

ChangeSetting() is used by an application to communicate with the
bluetooth device in TG role in order to notify the change in a certain
setting.
---
 audio/control.c     |  152 +++++++++++++++++++++++++++++++++++++++++++++++++++
 doc/control-api.txt |   12 ++--
 2 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 983c8cd..905f57a 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -120,6 +120,37 @@
 
 #define QUIRK_NO_RELEASE	1 << 0
 
+enum player_setting {
+	PLAYER_SETTING_EQUALIZER =	1,
+	PLAYER_SETTING_REPEAT =		2,
+	PLAYER_SETTING_SHUFFLE =	3,
+	PLAYER_SETTING_SCAN =		4,
+};
+
+enum equalizer_mode {
+	EQUALIZER_MODE_OFF =	1,
+	EQUALIZER_MODE_ON =	2,
+};
+
+enum repeat_mode {
+	REPEAT_MODE_OFF =	1,
+	REPEAT_MODE_SINGLE =	2,
+	REPEAT_MODE_ALL =	3,
+	REPEAT_MODE_GROUP =	4,
+};
+
+enum shuffle_mode {
+	SHUFFLE_MODE_OFF =	1,
+	SHUFFLE_MODE_ALL =	2,
+	SHUFFLE_MODE_GROUP =	3,
+};
+
+enum scan_mode {
+	SCAN_MODE_OFF =		1,
+	SCAN_MODE_ALL =		2,
+	SCAN_MODE_GROUP =	3,
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
@@ -216,6 +247,8 @@ struct control {
 	gboolean target;
 
 	uint8_t key_quirks[256];
+
+	uint8_t player_setting[PLAYER_SETTING_SCAN + 1];
 };
 
 static struct {
@@ -1193,12 +1226,131 @@ static DBusMessage *control_get_properties(DBusConnection *conn,
 	return reply;
 }
 
+static int setting_string_to_val(uint8_t setting, const char *value) {
+	int ret;
+
+	switch (setting) {
+	case (PLAYER_SETTING_EQUALIZER):
+		if (!strcmp(value, "off"))
+			ret = EQUALIZER_MODE_OFF;
+		else if (!strcmp(value, "on"))
+			ret = EQUALIZER_MODE_ON;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case(PLAYER_SETTING_REPEAT):
+		if (!strcmp(value, "off"))
+			ret = REPEAT_MODE_OFF;
+		else if (!strcmp(value, "singletrack"))
+			ret = REPEAT_MODE_SINGLE;
+		else if (!strcmp(value, "alltracks"))
+			ret = REPEAT_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = REPEAT_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case(PLAYER_SETTING_SHUFFLE):
+		if (!strcmp(value, "off"))
+			ret = SHUFFLE_MODE_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = SHUFFLE_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = SHUFFLE_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case(PLAYER_SETTING_SCAN):
+		if (!strcmp(value, "off"))
+			ret = SCAN_MODE_OFF;
+		else if (!strcmp(value, "alltracks"))
+			ret = SCAN_MODE_ALL;
+		else if (!strcmp(value, "group"))
+			ret = SCAN_MODE_GROUP;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	}
+
+	return -EINVAL;
+}
+
+static DBusMessage *setting_set(DBusMessage *msg, struct control *control,
+				const char *settingstr, const char *valstr)
+{
+	int val;
+	uint8_t setting;
+
+	if (!strcmp(settingstr, "Equalizer"))
+		setting = PLAYER_SETTING_EQUALIZER;
+	else if (!strcmp(settingstr, "Repeat"))
+		setting = PLAYER_SETTING_REPEAT;
+	else if (!strcmp(settingstr, "Shuffle"))
+		setting = PLAYER_SETTING_SHUFFLE;
+	else if (!strcmp(settingstr, "Scan"))
+		setting = PLAYER_SETTING_SCAN;
+	else
+		return btd_error_not_supported(msg);
+
+	val = setting_string_to_val(setting, valstr);
+	if (val == -1)
+		return btd_error_invalid_args(msg);
+
+	control->player_setting[setting] = val;
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *control_change_setting(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *setting;
+	const char *value;
+
+	if (control->state != AVCTP_STATE_CONNECTED)
+		return btd_error_not_connected(msg);
+
+	if (control->target) /* Only supported if this device is in TG role */
+		return btd_error_not_supported(msg);
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (!dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &setting);
+	dbus_message_iter_next(&iter);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_recurse(&iter, &var);
+
+	/* Only string arguments are supported for now */
+	if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&var, &value);
+
+	return setting_set(msg, control, setting, value);
+}
+
 static GDBusMethodTable control_methods[] = {
 	{ "IsConnected",	"",	"b",	control_is_connected,
 						G_DBUS_METHOD_FLAG_DEPRECATED },
 	{ "GetProperties",	"",	"a{sv}",control_get_properties },
 	{ "VolumeUp",		"",	"",	volume_up },
 	{ "VolumeDown",		"",	"",	volume_down },
+	{ "ChangeSetting",	"sv",	"",	control_change_setting },
 	{ NULL, NULL, NULL, NULL }
 };
 
diff --git a/doc/control-api.txt b/doc/control-api.txt
index 1a42846..931fa10 100644
--- a/doc/control-api.txt
+++ b/doc/control-api.txt
@@ -70,18 +70,20 @@ Methods		void Connect()
 		void ChangeSetting(string setting, variant value)
 
 			Called to transmit Application Settings, CT Status
-			and the like.
+			and the like. It's ONLY implemented for TG role. In
+			case they're never set, they will not be transmitted to
+			CT as a supported setting.
 
-			Currenet defined settings are represented with the
+			Current defined settings are represented with the
 			following keys:
 
 				Equalizer	off, on
 				Repeat		off, singletrack, alltracks, group
 				Shuffle		off, alltracks, group
 				Scan		off, alltracks, group
-				Battery		normal, warning, critical, external, fullcharge
-				System		powered, unpowered, unplugged
-				Volume		uint8
+				Battery		normal, warning, critical, external, fullcharge [ Not implemented]
+				System		powered, unpowered, unplugged [ Not implemented ]
+				Volume		uint8 [ Not implemented ]
 
 Signals		Connected()
 
-- 
1.7.6

