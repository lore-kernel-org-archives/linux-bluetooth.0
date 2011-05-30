Return-Path: <cyrus@holtmann.org>
From: Ilia Kolomisnky <ilia.kolominsky@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, Ilia Kolomisnky <iliak@ti.com>
Subject: [PATCH v3] AVRCP TG now return REJECTED response
Date: Mon, 30 May 2011 11:03:18 +0300
Message-Id: <1306742598-3291-1-git-send-email-iliak@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AVRCP TG now return REJECTED response with error code==Invalid
command for command with VENDOR-DEPENDED oper. code
( fix for PTS certification )
---
 audio/control.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 6238007..e2f94ae 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -80,6 +80,7 @@
 #define CTYPE_STABLE		0xC
 
 /* opcodes */
+#define OP_VENDORDEP	0x0
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
@@ -493,6 +514,7 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 	unsigned char buf[1024], *operands;
 	struct avctp_header *avctp;
 	struct avrcp_header *avrcp;
+
 	int ret, packet_size, operand_count, sock;
 
 	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
@@ -569,6 +591,19 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 			operands[1] = SUBUNIT_PANEL << 3;
 		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
+	} else if ( avrcp->opcode == OP_VENDORDEP ) {
+		/* reply with REJECT msg with err. code == 0x0
+		 * ( Invalid Command ) as defined in AVRCP spec ( 6.15.1 ) */
+		struct avrcp_spec_avc_pdu *pdu_spec;
+		pdu_spec = (void *) ( buf + sizeof(struct avctp_header)
+					+ sizeof(struct avrcp_header) );
+		pdu_spec->packet_type = 0;
+		pdu_spec->rsvd = 0;
+		pdu_spec->params[0] = 0; /* invalid command */
+		pdu_spec->params_len = htons(1);
+
+		avctp->cr = AVCTP_RESPONSE;
+		avrcp->code = CTYPE_REJECTED;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
 		avrcp->code = CTYPE_REJECTED;
-- 
1.7.1

