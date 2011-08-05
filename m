Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 11/23] avrcp: handle SetPlayerApplicationSettingValue pdu
Date: Fri,  5 Aug 2011 15:15:20 -0300
Message-Id: <1312568132-21112-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |  163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 163 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 22fb35a..5e2c899 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -116,6 +116,7 @@
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 #define AVRCP_LIST_PLAYER_VALUES	0x12
 #define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
+#define AVRCP_SET_PLAYER_VALUE		0x14
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -518,6 +519,49 @@ static unsigned int attr_get_max_val(uint8_t attr)
 	return 0;
 }
 
+static const char *attrval_to_str(uint8_t attr, uint8_t value)
+{
+	switch (attr) {
+	case PLAYER_SETTING_EQUALIZER:
+		switch (value) {
+		case (EQUALIZER_MODE_ON):
+			return "on";
+		case (EQUALIZER_MODE_OFF):
+			return "off";
+		}
+
+		break;
+	case PLAYER_SETTING_REPEAT:
+		switch (value) {
+		case (REPEAT_MODE_OFF):
+			return "off";
+		case (REPEAT_MODE_SINGLE):
+			return "singletrack";
+		case (REPEAT_MODE_ALL):
+			return "alltracks";
+		case (REPEAT_MODE_GROUP):
+			return "group";
+		}
+
+		break;
+	/* Shuffle and scan have the same values */
+	case PLAYER_SETTING_SHUFFLE:
+	case PLAYER_SETTING_SCAN:
+		switch (value) {
+		case SCAN_MODE_OFF:
+			return "off";
+		case SCAN_MODE_ALL:
+			return "alltracks";
+		case SCAN_MODE_GROUP:
+			return "group";
+		}
+
+		break;
+	}
+
+	return NULL;
+}
+
 static int attrval_to_val(uint8_t attr, const char *value) {
 	int ret;
 
@@ -571,6 +615,22 @@ static int attrval_to_val(uint8_t attr, const char *value) {
 	return -EINVAL;
 }
 
+static const char *attr_to_str(uint8_t attr)
+{
+	switch (attr) {
+	case PLAYER_SETTING_EQUALIZER:
+		return "Equalizer";
+	case PLAYER_SETTING_REPEAT:
+		return "Repeat";
+	case PLAYER_SETTING_SHUFFLE:
+		return "Shuffle";
+	case PLAYER_SETTING_SCAN:
+		return "Scan";
+	}
+
+	return NULL;
+}
+
 static int attr_to_val(const char *str)
 {
 	if (!strcmp(str, "Equalizer"))
@@ -669,6 +729,44 @@ static void mp_set_media_attributes(struct control *control,
 			   mi->ntracks, mi->track, mi->track_len);
 }
 
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
 static int avrcp_handle_get_capabilities(struct control *control,
 						struct avrcp_spec_avc_pdu *pdu)
 {
@@ -823,6 +921,57 @@ done:
 	return -EINVAL;
 }
 
+static int avrcp_handle_set_player_value(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	unsigned int i;
+
+	if (len < 3 || !control->mp)
+		goto err;
+
+	len = 0;
+
+	/*
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * and set the existent ones. Sec. 5.2.4 is not clear however how to
+	 * indicate that a certain ID was not accepted. If at least one
+	 * attribute is valid, we respond with no parameters. Otherwise an
+	 * E_INVALID_PARAM is sent.
+	 */
+	for (i = 1; i < pdu->params[0]; i += 2) {
+		uint8_t attr = pdu->params[i];
+		uint8_t val = pdu->params[i + 1];
+		const char *attrstr;
+		const char *valstr;
+
+		attrstr = attr_to_str(attr);
+		if (!attrstr)
+			continue;
+
+		valstr = attrval_to_str(attr, val);
+		if (!valstr)
+			continue;
+
+		len++;
+
+		mp_set_attribute(control->mp, attr, val);
+		emit_setting_changed(control->dev->conn, control->dev->path,
+					MEDIA_PLAYER_INTERFACE, attrstr,
+					DBUS_TYPE_STRING, &valstr);
+	}
+
+	if (len) {
+		pdu->params_len = 0;
+
+		return 0;
+	}
+
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+	return -EINVAL;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -901,6 +1050,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_SET_PLAYER_VALUE:
+		if (avrcp->code != CTYPE_CONTROL) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_set_player_value(control, pdu);
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_STABLE;
+
+		break;
 	default:
 		/* Invalid pdu_id */
 		pdu->params[0] = E_INVALID_COMMAND;
@@ -1807,6 +1969,7 @@ static GDBusMethodTable mp_methods[] = {
 };
 
 static GDBusSignalTable mp_signals[] = {
+	{ "SettingChanged",		"sv"	},
 	{ }
 };
 
-- 
1.7.6

