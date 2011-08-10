Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 03/22] avrcp: implement SetProperty() method of MediaPlayer
Date: Wed, 10 Aug 2011 10:06:17 -0300
Message-Id: <1312981596-7291-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

SetProperty() is used by an application to set player specific
settings.
---
 audio/control.c |  153 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 153 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index cc6532e..d2365bf 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -104,6 +104,37 @@
 
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
@@ -186,6 +217,7 @@ struct avctp_server {
 };
 
 struct media_player {
+	uint8_t settings[PLAYER_SETTING_SCAN + 1];
 };
 
 struct control {
@@ -423,6 +455,82 @@ static void handle_panel_passthrough(struct control *control,
 						operands[0] & 0x7F, status);
 }
 
+static int attrval_to_val(uint8_t attr, const char *value)
+{
+	int ret;
+
+	switch (attr) {
+	case PLAYER_SETTING_EQUALIZER:
+		if (!strcmp(value, "off"))
+			ret = EQUALIZER_MODE_OFF;
+		else if (!strcmp(value, "on"))
+			ret = EQUALIZER_MODE_ON;
+		else
+			ret = -EINVAL;
+
+		return ret;
+	case PLAYER_SETTING_REPEAT:
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
+	case PLAYER_SETTING_SHUFFLE:
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
+	case PLAYER_SETTING_SCAN:
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
+static int attr_to_val(const char *str)
+{
+	if (!strcmp(str, "Equalizer"))
+		return PLAYER_SETTING_EQUALIZER;
+	else if (!strcmp(str, "Repeat"))
+		return PLAYER_SETTING_REPEAT;
+	else if (!strcmp(str, "Shuffle"))
+		return PLAYER_SETTING_SHUFFLE;
+	else if (!strcmp(str, "Scan"))
+		return PLAYER_SETTING_SCAN;
+
+	return -EINVAL;
+}
+
+static void mp_set_attribute(struct media_player *mp,
+						uint8_t attr, uint8_t val)
+{
+	DBG("Change attribute: %u %u", attr, val);
+
+	mp->settings[attr] = val;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -1129,7 +1237,52 @@ static GDBusSignalTable control_signals[] = {
 	{ NULL, NULL }
 };
 
+static DBusMessage *mp_set_property(DBusConnection *conn,
+					DBusMessage *msg, void *data)
+{
+	struct audio_device *device = data;
+	struct control *control = device->control;
+	DBusMessageIter iter;
+	DBusMessageIter var;
+	const char *attrstr, *valstr;
+	int attr, val;
+
+	if (!dbus_message_iter_init(msg, &iter))
+		return btd_error_invalid_args(msg);
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return btd_error_invalid_args(msg);
+
+	dbus_message_iter_get_basic(&iter, &attrstr);
+
+	attr = attr_to_val(attrstr);
+	if (attr < 0)
+		return btd_error_not_supported(msg);
+
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
+	dbus_message_iter_get_basic(&var, &valstr);
+
+	val = attrval_to_val(attr, valstr);
+	if (val < 0)
+		return btd_error_not_supported(msg);
+
+	mp_set_attribute(control->mp, attr, val);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static GDBusMethodTable mp_methods[] = {
+	{ "SetProperty",	"sv",		"",	mp_set_property },
 	{ }
 };
 
-- 
1.7.6

