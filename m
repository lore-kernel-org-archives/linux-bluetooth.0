Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [RFC 01/19] avrcp: handle query for company ids
Date: Tue, 19 Jul 2011 16:49:12 -0300
Message-Id: <1311104970-18600-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1311104970-18600-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |   88 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 86 insertions(+), 2 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index c3ef737..983c8cd 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -102,6 +102,22 @@
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
+#define CAP_EVENTS_SUPPORTED	0x03
+
 #define QUIRK_NO_RELEASE	1 << 0
 
 static DBusConnection *connection = NULL;
@@ -217,6 +233,11 @@ static struct {
 	{ NULL }
 };
 
+/* Company IDs supported by this device */
+static uint32_t company_ids[] = {
+	IEEEID_BTSIG,
+};
+
 static GSList *avctp_callbacks = NULL;
 
 static void auth_cb(DBusError *derr, void *user_data);
@@ -424,8 +445,71 @@ static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
 					int operand_count)
 {
-	avrcp->code = CTYPE_NOT_IMPLEMENTED;
-	return AVRCP_HEADER_LENGTH;
+	struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
+	uint32_t company_id = (pdu->company_id[0] << 16) |
+				(pdu->company_id[1] << 8) |
+				(pdu->company_id[2]);
+	uint16_t len;
+	unsigned int i;
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
+	len = ntohs(pdu->params_len);
+
+	switch (pdu->pdu_id) {
+	case AVRCP_GET_CAPABILITIES:
+		if (len != 1 || avrcp->code != CTYPE_STATUS)
+			break;
+
+		DBG("GET_CAPABILITIES id=%u", pdu->params[0]);
+
+		switch (pdu->params[0]) { /* capability id */
+		case CAP_COMPANY_ID:
+			avrcp->code = CTYPE_STABLE;
+			pdu->params_len = htons(1 +
+						3 * G_N_ELEMENTS(company_ids));
+			pdu->params[1] = G_N_ELEMENTS(company_ids);
+
+			for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
+				pdu->params[2 + i * 3] = company_ids[i] >> 16;
+				pdu->params[3 + i * 3] = (company_ids[i] >> 8)
+									& 0xFF;
+				pdu->params[4 + i * 3] = company_ids[i] & 0xFF;
+			}
+
+			return AVRCP_HEADER_LENGTH +
+					AVRCP_SPECAVCPDU_HEADER_LENGTH + 1 +
+					3 * G_N_ELEMENTS(company_ids);
+		}
+
+		pdu->params[0] = E_INVALID_PARAM;
+		goto err_metadata;
+	}
+
+	/*
+	 * If either pdu_id was invalid or message was malformed, respond with
+	 * E_INVALID_COMMAND. For other errors, we already jumped into
+	 * err_metadata.
+	 */
+	pdu->params[0] = E_INVALID_COMMAND;
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

