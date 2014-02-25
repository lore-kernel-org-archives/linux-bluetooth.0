Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Fix passing wrong len
Date: Tue, 25 Feb 2014 15:47:38 +0200
Message-Id: <1393336058-431-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When handling vendor dependent pdus len was passed in wrong order to
callback.
---
 android/avrcp-lib.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index c78881f..c280cf8 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -128,14 +128,14 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	const struct avrcp_control_handler *handler;
 	struct avrcp_header *pdu = (void *) operands;
 	uint32_t company_id = ntoh24(pdu->company_id);
+	uint16_t params_len = ntohs(pdu->params_len);
 
 	if (company_id != IEEEID_BTSIG) {
 		*code = AVC_CTYPE_NOT_IMPLEMENTED;
 		return 0;
 	}
 
-	DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id,
-						ntohs(pdu->params_len));
+	DBG("AVRCP PDU 0x%02X, len 0x%04X", pdu->pdu_id, params_len);
 
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
@@ -163,10 +163,10 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 		goto reject;
 	}
 
-	*code = handler->func(session, transaction, &pdu->params_len,
+	*code = handler->func(session, transaction, &params_len,
 					pdu->params, session->control_data);
 
-	return AVRCP_HEADER_LENGTH + ntohs(pdu->params_len);
+	return AVRCP_HEADER_LENGTH + params_len;
 
 reject:
 	pdu->params_len = htons(1);
-- 
1.8.3.2

