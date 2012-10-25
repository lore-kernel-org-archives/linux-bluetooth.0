Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/11] AVCTP: Reduce verbosity of PDU parsing
Date: Thu, 25 Oct 2012 16:59:08 +0300
Message-Id: <1351173554-28039-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
References: <1351173554-28039-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This information is not really useful as debug and there are better
tools for sniffing traffic such as hcidump and wireshark.
---
 audio/avctp.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 0db6031..5f6a677 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -471,8 +471,6 @@ static int avctp_send(struct avctp_channel *control, uint8_t transaction,
 	struct iovec iov[2];
 	int sk, err = 0;
 
-	DBG("transaction %u", transaction);
-
 	iov[0].iov_base = control->buffer;
 	iov[0].iov_len  = sizeof(*avctp) + sizeof(*avc);
 	iov[1].iov_base = operands;
@@ -637,10 +635,6 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 		goto failed;
 
 	avctp = (struct avctp_header *) buf;
-	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
-				"PID 0x%04X",
-				avctp->transaction, avctp->packet_type,
-				avctp->cr, avctp->ipid, ntohs(avctp->pid));
 
 	if (avctp->packet_type != AVCTP_PACKET_SINGLE)
 		goto failed;
@@ -698,8 +692,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	if (ret <= 0)
 		goto failed;
 
-	DBG("Got %d bytes of data for AVCTP session %p", ret, session);
-
 	if ((unsigned int) ret < sizeof(struct avctp_header)) {
 		error("Too small AVCTP packet");
 		goto failed;
@@ -707,11 +699,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 
 	avctp = (struct avctp_header *) buf;
 
-	DBG("AVCTP transaction %u, packet type %u, C/R %u, IPID %u, "
-			"PID 0x%04X",
-			avctp->transaction, avctp->packet_type,
-			avctp->cr, avctp->ipid, ntohs(avctp->pid));
-
 	ret -= sizeof(struct avctp_header);
 	if ((unsigned int) ret < sizeof(struct avc_header)) {
 		error("Too small AVCTP packet");
@@ -725,12 +712,6 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	operands = buf + sizeof(struct avctp_header) + sizeof(struct avc_header);
 	operand_count = ret;
 
-	DBG("AV/C %s 0x%01X, subunit_type 0x%02X, subunit_id 0x%01X, "
-			"opcode 0x%02X, %d operands",
-			avctp->cr ? "response" : "command",
-			avc->code, avc->subunit_type, avc->subunit_id,
-			avc->opcode, operand_count);
-
 	if (avctp->cr == AVCTP_RESPONSE) {
 		control_response(control, avctp, avc, operands, operand_count);
 		return TRUE;
@@ -1295,8 +1276,6 @@ static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
 					size_t operand_count, void *user_data)
 {
-	DBG("code %u", code);
-
 	if (code != AVC_CTYPE_ACCEPTED)
 		return FALSE;
 
@@ -1315,8 +1294,6 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op)
 {
 	uint8_t operands[2];
 
-	DBG("");
-
 	/* Button pressed */
 	operands[0] = op & 0x7f;
 	operands[1] = 0;
-- 
1.7.11.7

