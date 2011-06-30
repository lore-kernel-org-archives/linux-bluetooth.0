Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] avrcp: return NOT_IMPLEMENTED on request for vendor dep command
Date: Thu, 30 Jun 2011 15:50:35 -0300
Message-Id: <1309459835-11434-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a vendor dependent command is requested but target does not
implement it, the correct return value is CTYPE_NOT_IMPLEMENTED instead
of CTYPE_REJECTED.

AVRCP 1.3 spec clearly says so on section 4.5.1:
	[ It is assumed that devices that do not support this metadata
	transfer related features shall return a response of NOT
	IMPLEMENTED as per AV/C protocol specification ]

And AV/C General Specification, section 8.3.2 talks about legacy
behavior and mandates that NOT_IMPLEMENTED is returned.

Finally, in section 11.6.1 we see that VENDOR-DEPENDENT command frame
depends on the company_ID. Therefore we can't assume it has the same
format as the one specified for metadata transfer (in case the company
ID is 0x001958)
---
 audio/control.c |   15 ++-------------
 1 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 9202966..defbbc8 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -424,19 +424,8 @@ static int handle_vendordep_pdu(struct control *control,
 					struct avrcp_header *avrcp,
 					int operand_count)
 {
-	struct avrcp_spec_avc_pdu *pdu = (void *)(avrcp) +
-						AVRCP_SPECAVCPDU_HEADER_LENGTH;
-
-	/* Reply with REJECT msg with error code 0x0
-	 * (Invalid Command) as defined in AVRCP spec (6.15.1) */
-	avrcp->code = CTYPE_REJECTED;
-
-	pdu->packet_type = 0;
-	pdu->rsvd = 0;
-	pdu->params[0] = 0; /* invalid command */
-	pdu->params_len = htons(1);
-
-	return AVRCP_HEADER_LENGTH + AVRCP_SPECAVCPDU_HEADER_LENGTH + 1;
+	avrcp->code = CTYPE_NOT_IMPLEMENTED;
+	return AVRCP_HEADER_LENGTH;
 }
 
 static void avctp_disconnected(struct audio_device *dev)
-- 
1.7.6

