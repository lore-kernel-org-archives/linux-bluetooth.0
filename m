Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 1/5] avrcp: fix missing error code
Date: Thu, 15 Sep 2011 01:21:33 -0300
Message-Id: <1316060497-4068-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1316060497-4068-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/avrcp.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index c9eae6e..9b1d797 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1228,8 +1228,10 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
 
-	if (operand_count + 3 < AVRCP_HEADER_LENGTH)
+	if (operand_count + 3 < AVRCP_HEADER_LENGTH) {
+		pdu->params[0] = E_INVALID_COMMAND;
 		goto err_metadata;
+	}
 
 	for (handler = handlers; handler; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
-- 
1.7.6.1

