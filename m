Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v3 09/22] avrcp: handle GetCurrentPlayerAplicationSettingValue pdu
Date: Wed, 10 Aug 2011 10:06:23 -0300
Message-Id: <1312981596-7291-10-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312981596-7291-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example response for PTS test TC_TG_PAS_BV_10_C:

> ACL data: handle 11 flags 0x02 dlen 19
    L2CAP(d): cid 0x0043 len 15 [psm 23]
      AVCTP: Command : pt 0x00 transaction 3 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCurrentPlayerApplicationSettingValue: pt 0x00 len 0x0002
            AttributeCount: 0x01
            AttributeID: 0x01 (Equalizer ON/OFF Status)
< ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0043 len 16 [psm 23]
      AVCTP: Response : pt 0x00 transaction 3 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCurrentPlayerApplicationSettingValue: pt 0x00 len 0x0003
            ValueCount: 0x01
            AttributeID: 0x01 (Equalizer ON/OFF Status)
            ValueID: 0x02 (ON)
---
 audio/control.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index d82409d..14c56ba 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -115,6 +115,7 @@
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 #define AVRCP_LIST_PLAYER_VALUES	0x12
+#define AVRCP_GET_CURRENT_PLAYER_VALUE	0x13
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -760,6 +761,68 @@ err:
 	return -EINVAL;
 }
 
+static int avrcp_handle_get_current_player_value(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	struct media_player *mp = control->mp;
+	uint8_t *settings;
+	unsigned int i;
+
+	if (mp == NULL || len <= 1 || pdu->params[0] != len - 1)
+		goto err;
+
+	/*
+	 * Save a copy of requested settings because we can override them
+	 * while responding
+	 */
+	settings = g_malloc(pdu->params[0]);
+	memcpy(settings, &pdu->params[1], pdu->params[0]);
+	len = 0;
+
+	/*
+	 * From sec. 5.7 of AVRCP 1.3 spec, we should igore non-existent IDs
+	 * and send a response with the existent ones. Only if all IDs are
+	 * non-existent we should send an error.
+	 */
+	for (i = 0; i < pdu->params[0]; i++) {
+		uint8_t val;
+
+		if (settings[i] < PLAYER_SETTING_EQUALIZER ||
+				settings[i] > PLAYER_SETTING_SCAN) {
+			DBG("Ignoring %u", settings[i]);
+			continue;
+		}
+
+		val = mp_get_attribute(mp, settings[i]);
+		if (!val) {
+			DBG("Ignoring %u: not supported by player",
+								settings[i]);
+			continue;
+		}
+
+		pdu->params[len] = settings[i];
+		pdu->params[len + 1] = val;
+		len += 2;
+	}
+
+	g_free(settings);
+
+	if (len) {
+		pdu->params[0] = len;
+		pdu->params_len = htons(2 * len + 1);
+
+		return 2 * len + 1;
+	}
+
+	error("No valid attributes in request");
+
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+
+	return -EINVAL;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -825,6 +888,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_GET_CURRENT_PLAYER_VALUE:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_get_current_player_value(control, pdu);
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

