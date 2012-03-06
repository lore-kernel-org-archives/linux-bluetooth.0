Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>, <luiz.dentz@gmail.com>,
	<lucas.demarchi@profusion.mobi>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 2/2] avrcp: Add error code for rejected vendor command
Date: Tue, 6 Mar 2012 15:56:05 +0100
Message-ID: <1331045765-24790-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA%40mail.gmail.com>
References: <CAMOw1v6pNC7eebGEAMLEWKNJ8NaR2aUweigMCEzbG5_0wgkUTA%40mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make correct response for any vendor commands when there are not any
registered player. According to the specification responses should be
REJECTED with error code.

"For error response PDU the response parameter is always the
error code independent of the response format defined for
ACCEPTED PDU response for the corresponding PDU command."                                                                                            (source: AVRCP 1.3 specification, pages 34,56 or AVRCP 1.4
specification, pages 33,93)
---
 audio/avctp.c |    3 +++
 audio/avctp.h |    5 +++++
 audio/avrcp.c |   19 +++++++++++++++++++
 3 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 5bd5db1..38a2d20 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -465,6 +465,9 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	if (!handler) {
 		DBG("handler not found for 0x%02x", avc->opcode);
 		avc->code = AVC_CTYPE_REJECTED;
+
+		packet_size += handle_vendor_reject(session, avctp->transaction, &code,
+					&subunit, operands, operand_count, NULL);
 		goto done;
 	}
 
diff --git a/audio/avctp.h b/audio/avctp.h
index 9727485..a1109a9 100644
--- a/audio/avctp.h
+++ b/audio/avctp.h
@@ -97,3 +97,8 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count);
+
+size_t handle_vendor_reject(struct avctp *session, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data);
\ No newline at end of file
diff --git a/audio/avrcp.c b/audio/avrcp.c
index 4573133..2d29d56 100644
--- a/audio/avrcp.c
+++ b/audio/avrcp.c
@@ -862,6 +862,7 @@ static uint8_t avrcp_handle_get_play_status(struct avrcp_player *player,
 	position = player->cb->get_position(player->user_data);
 	pduration = player->cb->get_metadata(AVRCP_MEDIA_ATTRIBUTE_DURATION,
 							player->user_data);
+
 	if (pduration != NULL)
 		duration = htonl(GPOINTER_TO_UINT(pduration));
 	else
@@ -1092,6 +1093,24 @@ err_metadata:
 	return AVRCP_HEADER_LENGTH + 1;
 }
 
+size_t handle_vendor_reject(struct avctp *session, uint8_t transaction,
+					uint8_t *code, uint8_t *subunit,
+					uint8_t *operands, size_t operand_count,
+					void *user_data)
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
-- 
on behalf of ST-Ericsson

