Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/16] AVCTP: Wait confirmation to send button release
Date: Mon, 15 Oct 2012 16:05:28 +0200
Message-Id: <1350309936-31588-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 audio/avctp.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 9a62bc0..c72d2d5 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -1114,26 +1114,60 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	return err;
 }
 
-int avctp_send_passthrough(struct avctp *session, uint8_t op)
+static int avctp_send_req(struct avctp *session, uint8_t code,
+				uint8_t subunit, uint8_t opcode,
+				uint8_t *operands, size_t operand_count,
+				avctp_rsp_cb func, void *user_data)
 {
-	uint8_t operands[2];
-	int ret;
+	struct avctp_rsp_handler *handler;
+	int err;
 
-	operands[0] = op & 0x7f;
-	operands[1] = 0;
+	err = avctp_send(session, id, AVCTP_COMMAND, code, subunit,
+				opcode, operands, operand_count);
+	if (err < 0)
+		return err;
 
-	ret = avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
-					AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-					operands, sizeof(operands));
-	if (ret < 0)
-		return ret;
+	handler = g_new0(struct avctp_rsp_handler, 1);
+	handler->id = id;
+	handler->func = func;
+	handler->user_data = user_data;
+
+	session->handlers = g_slist_prepend(session->handlers, handler);
+
+	id++;
+
+	return 0;
+}
+
+static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
+					uint8_t subunit, uint8_t *operands,
+					size_t operand_count, void *user_data)
+{
+	if (code != AVC_CTYPE_ACCEPTED)
+		return FALSE;
 
 	/* Button release */
 	operands[0] |= 0x80;
 
-	return avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
+	avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
 					AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-					operands, sizeof(operands));
+					operands, sizeof(operand_count));
+
+	return FALSE;
+}
+
+int avctp_send_passthrough(struct avctp *session, uint8_t op)
+{
+	uint8_t operands[2];
+
+	/* Button pressed */
+	operands[0] = op & 0x7f;
+	operands[1] = 0;
+
+	return avctp_send_req(session, AVC_CTYPE_CONTROL,
+				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+				operands, sizeof(operands),
+				avctp_passthrough_rsp, NULL);
 }
 
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
-- 
1.7.11.4

