Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 15/22] avrcp: handle RegisterNotification pdu
Date: Thu, 11 Aug 2011 12:53:26 -0300
Message-Id: <1313078013-19103-16-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle mandatory events according to AVRCP 1.3 spec.
---
 audio/control.c |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 187c3f1..603659d 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -74,10 +74,12 @@
 /* ctype entries */
 #define CTYPE_CONTROL		0x0
 #define CTYPE_STATUS		0x1
+#define CTYPE_NOTIFY		0x3
 #define CTYPE_NOT_IMPLEMENTED	0x8
 #define CTYPE_ACCEPTED		0x9
 #define CTYPE_REJECTED		0xA
 #define CTYPE_STABLE		0xC
+#define CTYPE_INTERIM		0xF
 
 /* opcodes */
 #define OP_VENDORDEP		0x00
@@ -122,6 +124,11 @@
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
 #define AVRCP_GET_PLAY_STATUS		0x30
+#define AVRCP_REGISTER_NOTIFICATION	0x31
+
+/* Notification events */
+#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED		0x01
+#define AVRCP_EVENT_TRACK_CHANGED			0x02
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -292,6 +299,8 @@ struct control {
 	gboolean target;
 
 	uint8_t key_quirks[256];
+
+	uint16_t registered_events;
 };
 
 static struct {
@@ -1047,6 +1056,58 @@ static int avrcp_handle_get_play_status(struct control *control,
 	return 9;
 }
 
+static int avrcp_handle_register_notification(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	uint8_t status;
+
+	/*
+	 * 1 byte for EventID, 4 bytes for Playback interval but the latest
+	 * one is applicable only for EVENT_PLAYBACK_POS_CHANGED. See AVRCP
+	 * 1.3 spec, section 5.4.2.
+	 */
+	if (len != 5)
+		goto err;
+
+	switch (pdu->params[0]) {
+	case AVRCP_EVENT_PLAYBACK_STATUS_CHANGED:
+		len = 2;
+		if (control->mp) {
+			mp_get_playback_status(control->mp, &status,
+								NULL, NULL);
+			pdu->params[1] = status;
+		} else {
+			pdu->params[1] = PLAY_STATUS_ERROR;
+		}
+
+		break;
+	case AVRCP_EVENT_TRACK_CHANGED:
+		len = 9;
+
+		if (!control->mp)
+			memset(&pdu->params[1], 0xFF, 8);
+		else
+			memset(&pdu->params[1], 0, 8);
+
+		break;
+	default:
+		/* All other events are not supported yet */
+		goto err;
+	}
+
+	/* Register event */
+	control->registered_events |= (1 << pdu->params[0]);
+
+	pdu->params_len = htons(len);
+
+	return len;
+
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+	return -EINVAL;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -1200,6 +1261,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_REGISTER_NOTIFICATION:
+		if (avrcp->code != CTYPE_NOTIFY) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_register_notification(control, pdu);
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_INTERIM;
+
+		break;
 	default:
 		/* Invalid pdu_id */
 		pdu->params[0] = E_INVALID_COMMAND;
-- 
1.7.6

