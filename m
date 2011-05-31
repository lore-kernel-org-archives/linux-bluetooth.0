Return-Path: <cyrus@holtmann.org>
From: Ilia Kolomisnky <ilia.kolominsky@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH v4] Fix response for vendor dependent AVRCP commands
Date: Tue, 31 May 2011 05:32:49 +0300
Message-Id: <1306809169-5050-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP TG now returns a REJECTED response with the "Invalid command"
error code for VENDOR DEPENDENT commands. This fixes test case
AVRCP/TG/INV/TC_TG_INV_BI_01_C with recent PTS version.
---
 audio/control.c |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 6238007..264699b 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -80,6 +80,7 @@
 #define CTYPE_STABLE		0xC
 
 /* opcodes */
+#define OP_VENDORDEP		0x00
 #define OP_UNITINFO		0x30
 #define OP_SUBUNITINFO		0x31
 #define OP_PASSTHROUGH		0x7c
@@ -127,6 +128,16 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
+struct avrcp_spec_avc_pdu {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t packet_type:2;
+	uint8_t rsvd:6;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
 struct avctp_header {
@@ -147,6 +158,16 @@ struct avrcp_header {
 } __attribute__ ((packed));
 #define AVRCP_HEADER_LENGTH 3
 
+struct avrcp_spec_avc_pdu {
+	uint8_t company_id[3];
+	uint8_t pdu_id;
+	uint8_t rsvd:6;
+	uint8_t packet_type:2;
+	uint16_t params_len;
+	uint8_t params[0];
+} __attribute__ ((packed));
+#define AVRCP_SPECAVCPDU_HEADER_LENGTH 7
+
 #else
 #error "Unknown byte order"
 #endif
@@ -569,6 +590,22 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 			operands[1] = SUBUNIT_PANEL << 3;
 		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
+	} else if (avrcp->opcode == OP_VENDORDEP) {
+		/* reply with REJECT msg with err. code == 0x0
+		 * ( Invalid Command ) as defined in AVRCP spec ( 6.15.1 ) */
+		struct avrcp_spec_avc_pdu *pdu = (void *) operands;
+		pdu->packet_type = 0;
+		pdu->rsvd = 0;
+		pdu->params[0] = 0; /* invalid command */
+		pdu->params_len = htons(1);
+
+		avctp->cr = AVCTP_RESPONSE;
+		avrcp->code = CTYPE_REJECTED;
+
+		packet_size =  sizeof(struct avctp_header)
+			+ sizeof(struct avrcp_header)
+			+ sizeof(struct avrcp_spec_avc_pdu)
+			+ 1;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
 		avrcp->code = CTYPE_REJECTED;
-- 
1.7.1

