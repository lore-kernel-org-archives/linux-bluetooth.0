Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mob>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 05/14] AVRCP: Convert spaces to tabs
Date: Wed, 27 Jun 2012 15:27:39 +0200
Message-ID: <1340803668-31686-5-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
References: <1340803668-31686-1-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix coding style issue.
---
 audio/avrcp.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/audio/avrcp.c b/audio/avrcp.c
index adcf30d..64f6086 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1134,17 +1134,17 @@ err_metadata:
 
 size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
 {
-    struct avrcp_header *pdu = (void *) operands;
-    uint32_t company_id = get_company_id(pdu->company_id);
+	struct avrcp_header *pdu = (void *) operands;
+	uint32_t company_id = get_company_id(pdu->company_id);
 
-    *code = AVC_CTYPE_REJECTED;
-    pdu->params_len = htons(1);
-    pdu->params[0] = STATUS_INTERNAL_ERROR;
+	*code = AVC_CTYPE_REJECTED;
+	pdu->params_len = htons(1);
+	pdu->params[0] = STATUS_INTERNAL_ERROR;
 
-    DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
-            pdu->pdu_id, company_id, pdu->params_len);
+	DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
+		pdu->pdu_id, company_id, pdu->params_len);
 
-    return AVRCP_HEADER_LENGTH + 1;
+	return AVRCP_HEADER_LENGTH + 1;
 }
 
 static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
-- 
on behalf of ST-Ericsson

