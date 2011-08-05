Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 09/23] avrcp: handle ListPlayerApplicationSettingValues pdu
Date: Fri,  5 Aug 2011 15:15:18 -0300
Message-Id: <1312568132-21112-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example of response obtained with PTS test TC_TG_PAS_BV_06_C:

> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 23]
      AVCTP: Command : pt 0x00 transaction 3 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: ListPlayerApplicationSettingValues: pt 0x00 len 0x0001
            AttributeID: 0x01 (Equalizer ON/OFF Status)
< ACL data: handle 11 flags 0x02 dlen 20
    L2CAP(d): cid 0x0043 len 16 [psm 23]
      AVCTP: Response : pt 0x00 transaction 3 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: ListPlayerApplicationSettingValues: pt 0x00 len 0x0003
            ValueCount: 0x02
            ValueID: 0x01 (OFF)
            ValueID: 0x02 (ON)
---
 audio/control.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 45a669e..2e910cd 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -114,6 +114,7 @@
 /* PDU types for metadata transfer */
 #define AVRCP_GET_CAPABILITIES		0x10
 #define AVRCP_LIST_PLAYER_ATTRIBUTES	0X11
+#define AVRCP_LIST_PLAYER_VALUES	0x12
 
 /* Capabilities for AVRCP_GET_CAPABILITIES pdu */
 #define CAP_COMPANY_ID		0x02
@@ -500,6 +501,22 @@ static void handle_panel_passthrough(struct control *control,
 						operands[0] & 0x7F, status);
 }
 
+static unsigned int attr_get_max_val(uint8_t attr)
+{
+	switch (attr) {
+	case PLAYER_SETTING_EQUALIZER:
+		return EQUALIZER_MODE_ON;
+	case PLAYER_SETTING_REPEAT:
+		return REPEAT_MODE_GROUP;
+	case PLAYER_SETTING_SHUFFLE:
+		return SHUFFLE_MODE_GROUP;
+	case PLAYER_SETTING_SCAN:
+		return SCAN_MODE_GROUP;
+	}
+
+	return 0;
+}
+
 static int attrval_to_val(uint8_t attr, const char *value) {
 	int ret;
 
@@ -713,6 +730,35 @@ done:
 	return len + 1;
 }
 
+static int avrcp_handle_list_player_values(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	struct media_player *mp = control->mp;
+	unsigned int i;
+
+	if (len != 1 || !mp)
+		goto err;
+
+	len = attr_get_max_val(pdu->params[0]);
+	if (!len) {
+		error("Attribute is invalid: %u", pdu->params[0]);
+		goto err;
+	}
+
+	for (i = 1; i <= len; i++)
+		pdu->params[i] = i;
+
+	pdu->params[0] = len;
+	pdu->params_len = htons(len + 1);
+
+	return len + 1;
+
+err:
+	pdu->params[0] = E_INVALID_PARAM;
+	return -EINVAL;
+}
+
 /* handle vendordep pdu inside an avctp packet */
 static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
@@ -765,6 +811,19 @@ static int handle_vendordep_pdu(struct control *control,
 		avrcp->code = CTYPE_STABLE;
 
 		break;
+	case AVRCP_LIST_PLAYER_VALUES:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_list_player_values(control, pdu);
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

