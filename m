Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v4 07/22] avrcp: handle ListPlayerApplicationSettingAttributes pdu
Date: Thu, 11 Aug 2011 12:53:18 -0300
Message-Id: <1313078013-19103-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1313078013-19103-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example of response obtained with PTS test TC_TG_PAS_BV_06_C:

> ACL data: handle 11 flags 0x02 dlen 17
    L2CAP(d): cid 0x0043 len 13 [psm 23]
      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: ListPlayerApplicationSettingAttributes: pt 0x00 len 0x0000
< ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0043 len 16 [psm 23]
      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: ListPlayerApplicationSettingAttributes: pt 0x00 len 0x0003
            AttributeCount: 0x02
            AttributeID: 0x01 (Equalizer ON/OFF Status)
            AttributeID: 0x04 (Scan ON/OFF Status)
---
 audio/control.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 87dcdbf..bd40e4d 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -113,6 +113,7 @@
 
 /* PDU types for metadata transfer */
 #define AVRCP_GET_CAPABILITIES		0x10
+#define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -609,6 +610,13 @@ static void mp_set_attribute(struct media_player *mp,
 	mp->settings[attr] = val;
 }
 
+static int mp_get_attribute(struct media_player *mp, uint8_t attr)
+{
+	DBG("Get attribute: %u", attr);
+
+	return mp->settings[attr];
+}
+
 static void mp_set_media_attributes(struct control *control,
 							struct media_info *mi)
 {
@@ -674,6 +682,38 @@ err:
 	return -EINVAL;
 }
 
+static int avrcp_handle_list_player_attributes(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	struct media_player *mp = control->mp;
+	unsigned int i;
+
+	if (len != 0) {
+		pdu->params[0] = E_INVALID_PARAM;
+		return -EINVAL;
+	}
+
+	if (!mp)
+		goto done;
+
+	for (i = 1; i <= PLAYER_SETTING_SCAN; i++) {
+		if (!mp_get_attribute(mp, i)) {
+			DBG("Ignoring setting %u: not supported by player", i);
+			continue;
+		}
+
+		len++;
+		pdu->params[len] = i;
+	}
+
+done:
+	pdu->params[0] = len;
+	pdu->params_len = htons(len + 1);
+
+	return len + 1;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -713,6 +753,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_LIST_PLAYER_ATTRIBUTES:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_list_player_attributes(control, pdu);
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

