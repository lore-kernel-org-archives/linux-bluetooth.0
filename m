Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] Fix check for PDU size
Date: Wed, 26 Oct 2011 11:02:25 -0200
Message-Id: <1319634146-1643-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Company ID became part of the avrcp header so its size is already
accounted in the AVRCP_HEADER_LENGTH define.
---
 audio/avrcp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index f06afbf..879e959 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1053,7 +1053,7 @@ static size_t handle_vendordep_pdu(struct avctp *session, uint8_t transaction,
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
 
-	if (operand_count + 3 < AVRCP_HEADER_LENGTH) {
+	if (operand_count < AVRCP_HEADER_LENGTH) {
 		pdu->params[0] = E_INVALID_COMMAND;
 		goto err_metadata;
 	}
-- 
1.7.7.1

