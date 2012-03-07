Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <luiz.dentz@gmail.com>, <lucas.demarchi@profusion.mobi>,
	<johan.hedberg@gmail.com>,
	Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v3] avrcp: Add error code for rejected vendor command
Date: Wed, 7 Mar 2012 17:23:14 +0100
Message-ID: <1331137394-27292-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA@mail.gmail.com>
References: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix response for any vendor commands when there are no players
registered. According to the specification responses should be
REJECTED with error code.

"For error response PDU the response parameter is always the
error code independent of the response format defined for
ACCEPTED PDU response for the corresponding PDU command."
(source: section 4.7.9 of AVRCP 1.3 specification)
---
 audio/avctp.c |    4 +++-
 audio/avrcp.c |   15 +++++++++++++++
 audio/avrcp.h |    2 ++
 3 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5bd5db1..dfad9fd 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -53,6 +53,7 @@
 #include "manager.h"
 #include "device.h"
 #include "avctp.h"
+#include "avrcp.h"
 
 #define QUIRK_NO_RELEASE 1 << 0
 
@@ -464,7 +465,8 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	handler = find_handler(handlers, avc->opcode);
 	if (!handler) {
 		DBG("handler not found for 0x%02x", avc->opcode);
-		avc->code = AVC_CTYPE_REJECTED;
+		packet_size += avrcp_handle_vendor_reject(&code, operands);
+		avc->code = code;
 		goto done;
 	}
 
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 4573133..8eba046 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -1092,6 +1092,21 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands)
+{
+    struct avrcp_header *pdu = (void *) operands;
+    uint32_t company_id = get_company_id(pdu->company_id);
+
+    *code = AVC_CTYPE_REJECTED;
+    pdu->params_len = htons(1);
+    pdu->params[0] = E_INTERNAL;
+
+    DBG("rejecting AVRCP PDU 0x%02X, company 0x%06X len 0x%04X",
+            pdu->pdu_id, company_id, pdu->params_len);
+
+    return AVRCP_HEADER_LENGTH + 1;
+}
+
 static struct avrcp_server *find_server(GSList *list, const bdaddr_t *src)
 {
 	for (; list; list = list->next) {
diff --git a/audio/avrcp.h b/audio/avrcp.h
index fb64f3b..8a09546 100644
--- a/audio/avrcp.h
+++ b/audio/avrcp.h
@@ -98,3 +98,5 @@ struct avrcp_player *avrcp_register_player(const bdaddr_t *src,
 void avrcp_unregister_player(struct avrcp_player *player);
 
 int avrcp_player_event(struct avrcp_player *player, uint8_t id, void *data);
+
+size_t avrcp_handle_vendor_reject(uint8_t *code, uint8_t *operands);
-- 
on behalf of ST-Ericsson

