Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/16] AVCTP: Make use of allocate buffer to send data
Date: Mon, 15 Oct 2012 16:05:27 +0200
Message-Id: <1350309936-31588-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
References: <1350309936-31588-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no need to use the stack as the channel now have proper buffer
which can be used to store data to be send.

In addition to that make avctp_send_passthrough to use avctp_send.
---
 audio/avctp.c | 83 ++++++++++++++++++++++++-----------------------------------
 1 file changed, 34 insertions(+), 49 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index 228d5b7..9a62bc0 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -1066,51 +1066,11 @@ void avctp_unregister(const bdaddr_t *src)
 	g_free(server);
 }
 
-int avctp_send_passthrough(struct avctp *session, uint8_t op)
-{
-	unsigned char buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + 2];
-	struct avctp_header *avctp = (void *) buf;
-	struct avc_header *avc = (void *) &buf[AVCTP_HEADER_LENGTH];
-	uint8_t *operands = &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
-	int sk;
-
-	if (session->state != AVCTP_STATE_CONNECTED)
-		return -ENOTCONN;
-
-	memset(buf, 0, sizeof(buf));
-
-	avctp->transaction = id++;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = AVCTP_COMMAND;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
-
-	avc->code = AVC_CTYPE_CONTROL;
-	avc->subunit_type = AVC_SUBUNIT_PANEL;
-	avc->opcode = AVC_OP_PASSTHROUGH;
-
-	operands[0] = op & 0x7f;
-	operands[1] = 0;
-
-	sk = g_io_channel_unix_get_fd(session->control->io);
-
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
-
-	/* Button release */
-	avctp->transaction = id++;
-	operands[0] |= 0x80;
-
-	if (write(sk, buf, sizeof(buf)) < 0)
-		return -errno;
-
-	return 0;
-}
-
 static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 				uint8_t code, uint8_t subunit, uint8_t opcode,
 				uint8_t *operands, size_t operand_count)
 {
-	uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
+	struct avctp_channel *control = session->control;
 	struct avctp_header *avctp;
 	struct avc_header *avc;
 	struct msghdr msg;
@@ -1120,12 +1080,20 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
+	iov[0].iov_base = control->buffer;
+	iov[0].iov_len  = sizeof(*avctp) + sizeof(*avc);
+	iov[1].iov_base = operands;
+	iov[1].iov_len  = operand_count;
+
+	if (control->omtu < (iov[0].iov_len + iov[1].iov_len))
+		return -EOVERFLOW;
+
 	sk = g_io_channel_unix_get_fd(session->control->io);
 
-	memset(buf, 0, sizeof(buf));
+	memset(control->buffer, 0, iov[0].iov_len);
 
-	avctp = (void *) buf;
-	avc = (void *) &buf[AVCTP_HEADER_LENGTH];
+	avctp = (void *) control->buffer;
+	avc = (void *) avctp + sizeof(*avctp);
 
 	avctp->transaction = transaction;
 	avctp->packet_type = AVCTP_PACKET_SINGLE;
@@ -1136,11 +1104,6 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	avc->subunit_type = subunit;
 	avc->opcode = opcode;
 
-	iov[0].iov_base = buf;
-	iov[0].iov_len  = sizeof(buf);
-	iov[1].iov_base = operands;
-	iov[1].iov_len  = operand_count;
-
 	memset(&msg, 0, sizeof(msg));
 	msg.msg_iov = iov;
 	msg.msg_iovlen = 2;
@@ -1151,6 +1114,28 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	return err;
 }
 
+int avctp_send_passthrough(struct avctp *session, uint8_t op)
+{
+	uint8_t operands[2];
+	int ret;
+
+	operands[0] = op & 0x7f;
+	operands[1] = 0;
+
+	ret = avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
+					AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+					operands, sizeof(operands));
+	if (ret < 0)
+		return ret;
+
+	/* Button release */
+	operands[0] |= 0x80;
+
+	return avctp_send(session, id, AVCTP_COMMAND, AVC_CTYPE_CONTROL,
+					AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
+					operands, sizeof(operands));
+}
+
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count)
-- 
1.7.11.4

