Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 11/19] avrcp: handle GetPlayStatus pdu
Date: Tue, 19 Jul 2011 16:49:22 -0300
Message-Id: <1311104970-18600-12-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 77e0e6d..03f1cb4 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -121,6 +121,7 @@
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_PLAY_STATUS		0x30
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -260,6 +261,7 @@ struct avctp_server {
 struct media_info {
 	enum play_status status;
 	uint32_t current_position;
+	uint32_t track_length;
 };
 
 struct control {
@@ -918,6 +920,23 @@ static int handle_vendordep_pdu(struct control *control,
 		}
 
 		break;
+	case AVRCP_GET_PLAY_STATUS:
+		if (len == 0 && avrcp->code == CTYPE_STATUS) {
+			uint32_t track_length = htonl(control->mi.track_length);
+			uint32_t pos = htonl(control->mi.current_position);
+
+			memcpy(&pdu->params[0], &track_length, 4);
+			memcpy(&pdu->params[4], &pos, 4);
+			pdu->params[8] = control->mi.status;
+
+			avrcp->code = CTYPE_STABLE;
+			pdu->params_len = htons(9);
+
+			return AVRCP_HEADER_LENGTH +
+				AVRCP_SPECAVCPDU_HEADER_LENGTH + 9;
+		}
+
+		break;
 	}
 
 	/*
@@ -1207,6 +1226,20 @@ static void init_uinput(struct control *control)
 		DBG("AVRCP: uinput initialized for %s", address);
 }
 
+static void media_info_init(struct media_info *mi)
+{
+	memset(mi, 0, sizeof(*mi));
+	mi->status = PLAY_STATUS_ERROR;
+
+	/*
+	 * As per section 5.4.1 of AVRCP 1.3 spec, return 0xFFFFFFFF if TG
+	 * does not support these attributes (i.e. they were never set via
+	 * D-Bus)
+	 */
+	mi->track_length = 0xFFFFFFFF;
+	mi->current_position = 0xFFFFFFFF;
+}
+
 static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 {
 	struct control *control = data;
@@ -1237,6 +1270,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 		control->io = g_io_channel_ref(chan);
 
 	init_uinput(control);
+	media_info_init(&control->mi);
 
 	avctp_set_state(control, AVCTP_STATE_CONNECTED);
 	control->mtu = imtu;
-- 
1.7.6

