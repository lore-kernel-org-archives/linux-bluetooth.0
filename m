Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 10/22] avrcp: handle SetPlayerApplicationSettingValue pdu
Date: Wed, 10 Aug 2011 10:06:24 -0300
Message-Id: <1312981596-7291-11-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |  125 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 125 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 14c56ba..cb40490 100644
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
+		case EQUALIZER_MODE_ON:
+			return "on";
+		case EQUALIZER_MODE_OFF:
+			return "off";
+		}
+
+		break;
+	case PLAYER_SETTING_REPEAT:
+		switch (value) {
+		case REPEAT_MODE_OFF:
+			return "off";
+		case REPEAT_MODE_SINGLE:
+			return "singletrack";
+		case REPEAT_MODE_ALL:
+			return "alltracks";
+		case REPEAT_MODE_GROUP:
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
 static int attrval_to_val(uint8_t attr, const char *value)
 {
 	int ret;
@@ -572,6 +616,22 @@ static int attrval_to_val(uint8_t attr, const char *value)
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
@@ -823,6 +883,57 @@ err:
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
+		emit_property_changed(control->dev->conn, control->dev->path,
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
@@ -901,6 +1012,19 @@ static int handle_vendordep_pdu(struct control *control,
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
@@ -1807,6 +1931,7 @@ static GDBusMethodTable mp_methods[] = {
 };
 
 static GDBusSignalTable mp_signals[] = {
+	{ "PropertyChanged",		"sv"	},
 	{ }
 };
 
-- 
1.7.6

