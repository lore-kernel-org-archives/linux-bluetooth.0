Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] avrcp: Fix printing order for browsing avrcp header
Date: Fri, 31 Jan 2014 14:36:17 +0200
Message-Id: <1391171777-27512-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1391171777-27512-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1391171777-27512-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 profiles/audio/avrcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index bc5cab3..4ece4af 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1730,7 +1730,7 @@ static size_t handle_browsing_pdu(struct avctp *conn,
 	struct avrcp_browsing_header *pdu = (void *) operands;
 
 	DBG("AVRCP Browsing PDU 0x%02X, len 0x%04X", pdu->pdu_id,
-							pdu->param_len);
+							ntohs(pdu->param_len));
 
 	for (handler = browsing_handlers; handler->pdu_id; handler++) {
 		if (handler->pdu_id == pdu->pdu_id)
-- 
1.8.3.2

