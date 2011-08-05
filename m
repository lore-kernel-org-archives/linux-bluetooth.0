Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 07/23] avrcp: handle query for company ids
Date: Fri,  5 Aug 2011 15:15:16 -0300
Message-Id: <1312568132-21112-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1312568132-21112-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example of response for PTS test TC_TG_CFG_BV_02_C:

> ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(d): cid 0x0043 len 14 [psm 23]
      AVCTP: Command : pt 0x00 transaction 2 pid 0x110e
        AV/C: Status: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt 0x00 len 0x0001
            CapabilityID: 0x02 (CompanyID)
< ACL data: handle 11 flags 0x02 dlen 22
    L2CAP(d): cid 0x0043 len 18 [psm 23]
      AVCTP: Response : pt 0x00 transaction 2 pid 0x110e
        AV/C: Stable: address 0x48 opcode 0x00
          Subunit: Panel
          Opcode: Vendor Dependent
          Company ID: 0x001958
          AVRCP: GetCapabilities: pt 0x00 len 0x0005
            CapabilityID: 0x02 (CompanyID)
            CapabilityCount: 0x01
            CompanyID: 0x001958
---
 audio/control.c |   99 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index d721c64..51c2aca 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -102,6 +102,21 @@
 #define FORWARD_OP		0x4b
 #define BACKWARD_OP		0x4c
 
+/* Company IDs for vendor dependent commands */
+#define IEEEID_BTSIG		0x001958
+
+/* Error codes for metadata transfer */
+#define E_INVALID_COMMAND	0x00
+#define E_INVALID_PARAM		0x01
+#define E_PARAM_NOT_FOUND	0x02
+#define E_INTERNAL		0x03
+
+/* PDU types for metadata transfer */
+#define AVRCP_GET_CAPABILITIES		0x10
+
+/* Capabilities for AVRCP_GET_CAPABILITIES pdu */
+#define CAP_COMPANY_ID		0x02
+
 #define QUIRK_NO_RELEASE	1 << 0
 
 enum player_setting {
@@ -277,6 +292,11 @@ static struct {
 	{ NULL }
 };
 
+/* Company IDs supported by this device */
+static uint32_t company_ids[] = {
+	IEEEID_BTSIG,
+};
+
 static GSList *avctp_callbacks = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
@@ -623,13 +643,88 @@ static void mp_set_media_attributes(struct control *control,
 			   mi->ntracks, mi->track, mi->track_len);
 }
 
+static int avrcp_handle_get_capabilities(struct control *control,
+						struct avrcp_spec_avc_pdu *pdu)
+{
+	uint16_t len = ntohs(pdu->params_len);
+	unsigned int i;
+
+	if (len != 1)
+		goto err;
+
+	DBG("id=%u", pdu->params[0]);
+
+	switch (pdu->params[0]) {
+	case CAP_COMPANY_ID:
+		for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
+			pdu->params[2 + i * 3] = company_ids[i] >> 16;
+			pdu->params[3 + i * 3] = (company_ids[i] >> 8) & 0xFF;
+			pdu->params[4 + i * 3] = company_ids[i] & 0xFF;
+		}
+
+		pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
+		pdu->params[1] = G_N_ELEMENTS(company_ids);
+
+		return 2 + (3 * G_N_ELEMENTS(company_ids));
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
 					int operand_count)
 {
-	avrcp->code = CTYPE_NOT_IMPLEMENTED;
-	return AVRCP_HEADER_LENGTH;
+	struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
+	uint32_t company_id = (pdu->company_id[0] << 16) |
+				(pdu->company_id[1] << 8) |
+				(pdu->company_id[2]);
+	int len;
+
+	if (company_id != IEEEID_BTSIG ||
+				pdu->packet_type != AVCTP_PACKET_SINGLE) {
+		avrcp->code = CTYPE_NOT_IMPLEMENTED;
+		return AVRCP_HEADER_LENGTH;
+	}
+
+	pdu->packet_type = 0;
+	pdu->rsvd = 0;
+
+	if (operand_count + 3 < AVRCP_SPECAVCPDU_HEADER_LENGTH) {
+		pdu->params[0] = E_INVALID_COMMAND;
+		goto err_metadata;
+	}
+
+	switch (pdu->pdu_id) {
+	case AVRCP_GET_CAPABILITIES:
+		if (avrcp->code != CTYPE_STATUS) {
+			pdu->params[0] = E_INVALID_COMMAND;
+			goto err_metadata;
+		}
+
+		len = avrcp_handle_get_capabilities(control, pdu);
+		if (len < 0)
+			goto err_metadata;
+
+		avrcp->code = CTYPE_STABLE;
+
+		break;
+	default:
+		/* Invalid pdu_id */
+		pdu->params[0] = E_INVALID_COMMAND;
+		goto err_metadata;
+	}
+
+	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + len;
+
+err_metadata:
+	avrcp->code = CTYPE_REJECTED;
+	pdu->params_len = htons(1);
+
+	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
 }
 
 static void avctp_disconnected(struct audio_device *dev)
-- 
1.7.6

