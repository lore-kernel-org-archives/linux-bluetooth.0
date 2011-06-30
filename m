Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/3] avrcp: Check that AVCTP packet is of type COMMAND
Date: Thu, 30 Jun 2011 15:50:33 -0300
Message-Id: <1309459835-11434-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1309459835-11434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/control.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/audio/control.c b/audio/control.c
index 3db7d8e..57a4edc 100644
--- a/audio/control.c
+++ b/audio/control.c
@@ -590,7 +590,8 @@ static gboolean control_cb(GIOChannel *chan, GIOCondition cond,
 			operands[1] = SUBUNIT_PANEL << 3;
 		DBG("reply to %s", avrcp->opcode == OP_UNITINFO ?
 				"OP_UNITINFO" : "OP_SUBUNITINFO");
-	} else if (avrcp->opcode == OP_VENDORDEP) {
+	} else if (avctp->cr == AVCTP_COMMAND &&
+			avrcp->opcode == OP_VENDORDEP) {
 		/* Reply with REJECT msg with error code 0x0
 		 * (Invalid Command) as defined in AVRCP spec (6.15.1) */
 		struct avrcp_spec_avc_pdu *pdu = (void *) operands;
-- 
1.7.6

