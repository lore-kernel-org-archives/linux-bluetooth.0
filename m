Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] avrcp: Fix printing incorrect order for avrcp control header
Date: Fri, 31 Jan 2014 14:36:16 +0200
Message-Id: <1391171777-27512-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avrcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5030ce1..bc5cab3 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1658,7 +1658,7 @@ static size_t handle_vendordep_pdu(struct avctp *conn, uint8_t transaction,
 	}
 
 	DBG("AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
-			pdu->pdu_id, company_id, pdu->params_len);
+			pdu->pdu_id, company_id, ntohs(pdu->params_len));
 
 	pdu->packet_type = 0;
 	pdu->rsvd = 0;
@@ -1755,7 +1755,7 @@ size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 	pdu->params[0] = AVRCP_STATUS_INTERNAL_ERROR;
 
 	DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
-				pdu->pdu_id, company_id, pdu->params_len);
+			pdu->pdu_id, company_id, ntohs(pdu->params_len));
 
 	return AVRCP_HEADER_LENGTH + 1;
 }
-- 
1.8.3.2

