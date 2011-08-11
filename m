Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 13/22] avrcp: handle InformBatteryStatusOfCT pdu
Date: Thu, 11 Aug 2011 12:53:24 -0300
Message-Id: <1313078013-19103-14-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index f728e93..feb6930 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -120,6 +120,7 @@
 #define AVRCP_GET_PLAYER_ATTRIBUTE_TEXT	0x15
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
+#define AVRCP_CT_BATTERY_STATUS		0x18
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -166,6 +167,14 @@ enum play_status {
 	PLAY_STATUS_ERROR =		0xFF
 };
 
+enum battery_status {
+	BATTERY_STATUS_NORMAL =		0,
+	BATTERY_STATUS_WARNING =	1,
+	BATTERY_STATUS_CRITICAL =	2,
+	BATTERY_STATUS_EXTERNAL =	3,
+	BATTERY_STATUS_FULL_CHARGE =	4,
+};
+
 static DBusConnection *connection = NULL;
 
 static GSList *servers = NULL;
@@ -667,6 +676,24 @@ static int play_status_to_val(const char *status)
 	return -EINVAL;
 }
 
+static const char *battery_status_to_str(enum battery_status status)
+{
+	switch (status) {
+	case BATTERY_STATUS_NORMAL:
+		return "normal";
+	case BATTERY_STATUS_WARNING:
+		return "warning";
+	case BATTERY_STATUS_CRITICAL:
+		return "critical";
+	case BATTERY_STATUS_EXTERNAL:
+		return "external";
+	case BATTERY_STATUS_FULL_CHARGE:
+		return "fullcharge";
+	}
+
+	return NULL;
+}
+
 static void mp_set_playback_status(struct control *control, uint8_t status,
 							uint32_t elapsed)
 {
@@ -937,6 +964,31 @@ err:
 	return -EINVAL;
 }
 
+static int avrcp_handle_ct_battery_status(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	const char *valstr;
+
+	if (len != 1)
+		goto err;
+
+	valstr = battery_status_to_str(pdu->params[0]);
+	if (valstr == NULL)
+		goto err;
+
+	emit_property_changed(control->dev->conn, control->dev->path,
+					MEDIA_PLAYER_INTERFACE, "Battery",
+					DBUS_TYPE_STRING, &valstr);
+	pdu->params_len = 0;
+
+	return 0;
+
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+	return -EINVAL;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -1064,6 +1116,19 @@ static int handle_vendordep_pdu(struct control *control,
 		len = 0;
 
 		break;
+	case AVRCP_CT_BATTERY_STATUS:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_ct_battery_status(control, pdu);
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_STABLE;
+
+		break;
 	default:
 		/* Invalid pdu_id */
 		pdu->params[0] = E_INVALID_COMMAND;
-- 
1.7.6

