Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 15/23] avrcp: handle GetPlayStatus pdu
Date: Fri,  5 Aug 2011 15:15:24 -0300
Message-Id: <1312568132-21112-15-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example response for PTS test TC_TG_MDI_BV_02_C:

> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0043 len 13 [psm 23]
      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetPlayStatus: pt 0x00 len 0x0000
< ACL data: handle 11 flags 0x02 dlen 26
    L2CAP(d): cid 0x0043 len 22 [psm 23]
      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetPlayStatus: pt 0x00 len 0x0009
            SongLength: 0x0000a7f8 (43000 miliseconds)
            SongPosition: 0x00012fad (77741 miliconds)
            PlayStatus: 0x01 (PLAYING)
---
 audio/control.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 71 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 73dd2ff..3ea5123 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -121,6 +121,7 @@
 #define AVRCP_GET_PLAYER_VALUE_TEXT	0x16
 #define AVRCP_DISPLAYABLE_CHARSET	0x17
 #define AVRCP_CT_BATTERY_STATUS		0x18
+#define AVRCP_GET_PLAY_STATUS		0x30
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -693,6 +694,30 @@ static const char *battery_status_to_str(enum battery_status status)
 	return NULL;
 }
 
+static void mp_get_playback_status(struct media_player *mp, uint8_t *status,
+					uint32_t *elapsed, uint32_t *track_len)
+{
+	if (status)
+		*status = mp->status;
+	if (track_len)
+		*track_len = mp->mi.track_len;
+
+	if (!elapsed)
+		return;
+
+	*elapsed = mp->mi.elapsed;
+
+	if (mp->status == PLAY_STATUS_PLAYING) {
+		double timedelta = g_timer_elapsed(mp->timer, NULL);
+		uint32_t sec, msec;
+
+		sec = (uint32_t) timedelta;
+		msec = (uint32_t)((timedelta - sec) * 1000);
+
+		*elapsed += sec * 1000 + msec;
+	}
+}
+
 static void mp_set_playback_status(struct control *control, uint8_t status,
 							uint32_t elapsed)
 {
@@ -1027,6 +1052,39 @@ err:
 	return -EINVAL;
 }
 
+static int avrcp_handle_get_play_status(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	uint32_t elapsed;
+	uint32_t track_len;
+	uint8_t status;
+
+	if (len != 0) {
+		pdu->params[0] = E_INVALID_PARAM;
+		return -EINVAL;
+	}
+
+	if (control->mp) {
+		mp_get_playback_status(control->mp, &status,
+							&elapsed, &track_len);
+		track_len = htonl(track_len);
+		elapsed = htonl(elapsed);
+	} else {
+		track_len = 0xFFFFFFFF;
+		elapsed = 0xFFFFFFFF;
+		status = PLAY_STATUS_ERROR;
+	}
+
+	memcpy(&pdu->params[0], &track_len, 4);
+	memcpy(&pdu->params[4], &elapsed, 4);
+	pdu->params[8] = status;
+
+	pdu->params_len = htons(9);
+
+	return 9;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -1167,6 +1225,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_GET_PLAY_STATUS:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_get_play_status(control, pdu);
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

