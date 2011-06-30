Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 2/3] avrcp: Factor out function to handle vendordep pdu
Date: Thu, 30 Jun 2011 15:50:34 -0300
Message-Id: <1309459835-11434-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to support vendordep pdu as required by AVRCP 1.3 this part
will get very large. So, separate it to a new function like is done for
panel_passthrough.
---
 audio/control.c |   39 ++++++++++++++++++++++++---------------
 1 files changed, 24 insertions(+), 15 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 57a4edc..9202966 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -419,6 +419,26 @@ static void handle_panel_passthrough(struct control *control,
 						operands[0] & 0x7F, status);
 }
 
+/* handle vendordep pdu inside an avctp packet */
+static int handle_vendordep_pdu(struct control *control,
+					struct avrcp_header *avrcp,
+					int operand_count)
+{
+	struct avrcp_spec_avc_pdu *pdu = (void *)(avrcp) +
+						AVRCP_SPECAVCPDU_HEADER_LENGTH;
+
+	/* Reply with REJECT msg with error code 0x0
+	 * (Invalid Command) as defined in AVRCP spec (6.15.1) */
+	avrcp->code = CTYPE_REJECTED;
+
+	pdu->packet_type = 0;
+	pdu->rsvd = 0;
+	pdu->params[0] = 0; /* invalid command */
+	pdu->params_len = htons(1);
+
+	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
+}
+
 static void avctp_disconnected(struct audio_device *dev)
 {
 	struct control *control = dev->control;
@@ -592,22 +612,11 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
 	} else if (avctp->cr == AVCTP_COMMAND &&
 			avrcp->opcode == OP_VENDORDEP) {
-		/* Reply with REJECT msg with error code 0x0
-		 * (Invalid Command) as defined in AVRCP spec (6.15.1) */
-		struct avrcp_spec_avc_pdu *pdu = (void *) operands;
-
+		int r_size;
+		operand_count -= 3;
 		avctp->cr = AVCTP_RESPONSE;
-		avrcp->code = CTYPE_REJECTED;
-
-		pdu->packet_type = 0;
-		pdu->rsvd = 0;
-		pdu->params[0] = 0; /* invalid command */
-		pdu->params_len = htons(1);
-
-		packet_size =  sizeof(struct avctp_header)
-					+ sizeof(struct avrcp_header)
-					+ sizeof(struct avrcp_spec_avc_pdu)
-					+ 1;
+		r_size = handle_vendordep_pdu(control, avrcp, operand_count);
+		packet_size = AVCTP_HEADER_LENGTH + r_size;
 	} else {
 		avctp->cr = AVCTP_RESPONSE;
 		avrcp->code = CTYPE_REJECTED;
-- 
1.7.6

