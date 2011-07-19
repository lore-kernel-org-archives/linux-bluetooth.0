Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 06/19] avrcp: handle SetPlayerApplicationSettingValue pdu
Date: Tue, 19 Jul 2011 16:49:17 -0300
Message-Id: <1311104970-18600-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 884e01c..2d6d9e6 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -116,6 +116,7 @@
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 #define AVRCP_LIST_PLAYER_VALUES	0x12
 #define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
+#define AVRCP_SET_PLAYER_VALUE		0x14
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -492,6 +493,133 @@ static unsigned int setting_get_max_val(uint8_t setting)
 	return 0;
 }
 
+static const char *setting_equalizer_to_string(enum equalizer_mode value)
+{
+	switch (value) {
+	case (EQUALIZER_MODE_ON):
+		return "on";
+	case (EQUALIZER_MODE_OFF):
+		return "off";
+	}
+
+	return NULL;
+}
+
+static const char *setting_repeat_to_string(enum repeat_mode value)
+{
+	switch (value) {
+	case (REPEAT_MODE_OFF):
+		return "off";
+	case (REPEAT_MODE_SINGLE):
+		return "singletrack";
+	case (REPEAT_MODE_ALL):
+		return "alltracks";
+	case (REPEAT_MODE_GROUP):
+		return "group";
+	}
+
+	return NULL;
+}
+
+static const char *setting_shuffle_to_string(enum shuffle_mode value)
+{
+	switch (value) {
+	case (SHUFFLE_MODE_OFF):
+		return "off";
+	case (SHUFFLE_MODE_ALL):
+		return "alltracks";
+	case (SHUFFLE_MODE_GROUP):
+		return "group";
+	}
+
+	return NULL;
+}
+
+static const char *setting_scan_to_string(enum scan_mode value)
+{
+	switch (value) {
+	case (SCAN_MODE_OFF):
+		return "off";
+	case (SCAN_MODE_ALL):
+		return "alltracks";
+	case (SCAN_MODE_GROUP):
+		return "group";
+	}
+
+	return NULL;
+}
+
+static const char *setting_value_to_string(enum player_setting setting,
+								uint8_t value)
+{
+	switch (setting) {
+	case (PLAYER_SETTING_EQUALIZER):
+		return setting_equalizer_to_string(value);
+	case(PLAYER_SETTING_REPEAT):
+		return setting_repeat_to_string(value);
+	case(PLAYER_SETTING_SHUFFLE):
+		return setting_shuffle_to_string(value);
+	case(PLAYER_SETTING_SCAN):
+		return setting_scan_to_string(value);
+	}
+
+	return NULL;
+}
+
+static const char *setting_to_string(enum player_setting setting)
+{
+	switch (setting) {
+	case (PLAYER_SETTING_EQUALIZER):
+		return "Equalizer";
+	case(PLAYER_SETTING_REPEAT):
+		return "Repeat";
+	case(PLAYER_SETTING_SHUFFLE):
+		return "Shuffle";
+	case(PLAYER_SETTING_SCAN):
+		return "Scan";
+	}
+
+	return NULL;
+}
+
+static void append_variant(DBusMessageIter *iter, int type, void *val)
+{
+	DBusMessageIter value;
+	char sig[2] = { type, '\0' };
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_VARIANT, sig, &value);
+
+	dbus_message_iter_append_basic(&value, type, val);
+
+	dbus_message_iter_close_container(iter, &value);
+}
+
+static dbus_bool_t emit_setting_changed(DBusConnection *conn,
+						const char *path,
+						const char *interface,
+						const char *name,
+						int type, void *value)
+{
+	DBusMessage *signal;
+	DBusMessageIter iter;
+
+	signal = dbus_message_new_signal(path, interface, "SettingChanged");
+
+	if (!signal) {
+		error("Unable to allocate new %s.SettingChanged signal",
+				interface);
+		return FALSE;
+	}
+
+	dbus_message_iter_init_append(signal, &iter);
+
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &name);
+
+	append_variant(&iter, type, value);
+
+	return g_dbus_send_message(conn, signal);
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -647,6 +775,55 @@ static int handle_vendordep_pdu(struct control *control,
 		}
 
 		break;
+	case AVRCP_SET_PLAYER_VALUE:
+		if (len > 2 && avrcp->code == CTYPE_CONTROL) {
+			len = 0;
+
+			/*
+			 * From sec. 5.7 of AVRCP 1.3 spec, we should igore
+			 * non-existent IDs and set the existent ones. Sec.
+			 * 5.2.4 is not clear however how to indicate that a
+			 * certain ID was not accepted. If at least one
+			 * attribute we respond with no parameters. Otherwise
+			 * an E_INVALID_PARAM is sent.
+			 */
+			for (i = 0; i < pdu->params[0]; i++) {
+				uint8_t setting = pdu->params[i * 2 + 1];
+				uint8_t val = pdu->params[i * 2 + 2];
+				const char *settingstr;
+				const char *valstr;
+
+				settingstr = setting_to_string(setting);
+				if (!setting)
+					continue;
+
+				valstr = setting_value_to_string(setting, val);
+				if (!valstr)
+					continue;
+
+				len++;
+				control->player_setting[setting] = val;
+
+				emit_setting_changed(control->dev->conn,
+						control->dev->path,
+						AUDIO_CONTROL_INTERFACE,
+						settingstr,
+						DBUS_TYPE_STRING, &valstr);
+			}
+
+			if (!len) {
+				pdu->params[0] = E_INVALID_PARAM;
+				goto err_metadata;
+			}
+
+			avrcp->code = CTYPE_STABLE;
+			pdu->params_len = 0;
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH;
+		}
+
+		break;
 	}
 
 	/*
-- 
1.7.6

