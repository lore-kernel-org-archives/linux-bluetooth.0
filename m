Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: David Stockwell <dstockwell@frequency-one.com>
Subject: [PATCH 3/5] avrcp: get/set three-byte company-id
Date: Thu,  8 Sep 2011 20:14:48 -0300
Message-Id: <1315523690-11195-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1315523690-11195-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: David Stockwell <dstockwell@frequency-one.com>

---
 audio/control.c |   36 +++++++++++++++++++++++++++---------
 1 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 2f240f0..0a333db 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -471,6 +471,28 @@ static sdp_record_t *avrcp_tg_record(void)
 	return record;
 }
 
+/**
+ *	get_company_id:
+ *
+ *	Get three-byte Company_ID from incoming AVRCP message
+ */
+static uint32_t get_company_id(const uint8_t cid[3])
+{
+	return cid[0] << 16 | cid[1] << 8 | cid[2];
+}
+
+/**
+ *	set_company_id:
+ *
+ *	Set three-byte Company_ID into outgoing AVRCP message
+ */
+static void set_company_id(uint8_t cid[3], const uint32_t cid_in)
+{
+	cid[0] = cid_in >> 16;
+	cid[1] = cid_in >> 8;
+	cid[2] = cid_in;
+}
+
 static int send_event(int fd, uint16_t type, uint16_t code, int32_t value)
 {
 	struct uinput_event event;
@@ -748,9 +770,7 @@ static int avctp_send_event(struct control *control, uint8_t id, void *data)
 	avrcp->subunit_type = SUBUNIT_PANEL;
 	avrcp->opcode = OP_VENDORDEP;
 
-	pdu->company_id[0] = IEEEID_BTSIG >> 16;
-	pdu->company_id[1] = (IEEEID_BTSIG >> 8) & 0xFF;
-	pdu->company_id[2] = IEEEID_BTSIG & 0xFF;
+	set_company_id(pdu->company_id, IEEEID_BTSIG);
 
 	pdu->pdu_id = AVRCP_REGISTER_NOTIFICATION;
 	pdu->params[0] = id;
@@ -995,9 +1015,8 @@ static int avrcp_handle_get_capabilities(struct control *control,
 	switch (pdu->params[0]) {
 	case CAP_COMPANY_ID:
 		for (i = 0; i < G_N_ELEMENTS(company_ids); i++) {
-			pdu->params[2 + i * 3] = company_ids[i] >> 16;
-			pdu->params[3 + i * 3] = (company_ids[i] >> 8) & 0xFF;
-			pdu->params[4 + i * 3] = company_ids[i] & 0xFF;
+			set_company_id(&pdu->params[2 + i * 3],
+							company_ids[i]);
 		}
 
 		pdu->params_len = htons(2 + (3 * G_N_ELEMENTS(company_ids)));
@@ -1378,9 +1397,8 @@ static int handle_vendordep_pdu(struct control *control,
 					int operand_count)
 {
 	struct avrcp_spec_avc_pdu *pdu = (void *) avrcp + AVRCP_HEADER_LENGTH;
-	uint32_t company_id = (pdu->company_id[0] << 16) |
-				(pdu->company_id[1] << 8) |
-				(pdu->company_id[2]);
+	uint32_t company_id = get_company_id(pdu->company_id);
+
 	int len;
 
 	if (company_id != IEEEID_BTSIG ||
-- 
1.7.6.1

