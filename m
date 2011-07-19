Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 14/19] avrcp: handle RegisterNotification pdu
Date: Tue, 19 Jul 2011 16:49:25 -0300
Message-Id: <1311104970-18600-15-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Handle mandatory events according to AVRCP 1.3 spec.
---
 audio/control.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 670660f..212e95c 100644
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
@@ -122,6 +124,22 @@
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
 #define AVRCP_GET_PLAY_STATUS		0x30
+#define AVRCP_REGISTER_NOTIFICATION	0x31
+
+/* Notification events */
+#define AVRCP_EVENT_PLAYBACK_STATUS_CHANGED		0x01
+#define AVRCP_EVENT_TRACK_CHANGED			0x02
+#define AVRCP_EVENT_TRACK_REACHED_END			0x03
+#define AVRCP_EVENT_TRACK_REACHED_START			0x04
+#define AVRCP_EVENT_PLAYBACK_POS_CHANGED		0x05
+#define AVRCP_EVENT_BATT_STATUS_CHANGED			0x06
+#define AVRCP_EVENT_SYSTEM_STATUS_CHANGED		0x07
+#define AVRCP_EVENT_PLAYER_APPLICATION_SETTING_CHANGED	0x08
+#define AVRCP_EVENT_NOW_PLAYING_CONTENT_CHANGED		0x09
+#define AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED		0x0a
+#define AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED		0x0b
+#define AVRCP_EVENT_UIDS_CHANGED			0x0c
+#define AVRCP_EVENT_VOLUME_CHANGED			0x0d
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -289,6 +307,7 @@ struct control {
 
 	uint8_t player_setting[PLAYER_SETTING_SCAN + 1];
 	struct media_info mi;
+	uint16_t registered_events;
 };
 
 static struct {
@@ -944,6 +963,38 @@ static int handle_vendordep_pdu(struct control *control,
 		}
 
 		break;
+	case AVRCP_REGISTER_NOTIFICATION:
+		if (len == 5 && avrcp->code == CTYPE_NOTIFY) {
+			int size;
+
+			switch (pdu->params[0]) {
+			case (AVRCP_EVENT_PLAYBACK_STATUS_CHANGED):
+				size = 2;
+				pdu->params[1] = control->mi.status;
+
+				break;
+			case (AVRCP_EVENT_TRACK_CHANGED):
+				size = 9;
+				memset(&pdu->params[1], 0, 8);
+
+				break;
+			default:
+				/* All other events are not supported yet */
+				pdu->params[0] = E_INVALID_PARAM;
+				goto err_metadata;
+			}
+
+			/* Register event */
+			control->registered_events |= (1 << pdu->params[0]);
+
+			avrcp->code = CTYPE_INTERIM;
+			pdu->params_len = htons(size);
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + size;
+		}
+
+		break;
 	}
 
 	/*
-- 
1.7.6

