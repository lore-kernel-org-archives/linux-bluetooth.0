Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] AVCTP: Make use of sendmsg to avoid copying data
Date: Thu, 19 Jul 2012 13:49:35 +0300
Message-Id: <1342694975-9184-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This use sendmsg to send headers and operands in separated buffers
avoiding memcpy.
---
 audio/avctp.c |   21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/audio/avctp.c b/audio/avctp.c
index e3e5275..9ef6161 100644
--- a/audio/avctp.c
+++ b/audio/avctp.c
@@ -929,23 +929,20 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 				uint8_t code, uint8_t subunit, uint8_t opcode,
 				uint8_t *operands, size_t operand_count)
 {
-	uint8_t *buf;
+	uint8_t buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
 	struct avctp_header *avctp;
 	struct avc_header *avc;
-	uint8_t *pdu;
+	struct msghdr msg;
+	struct iovec iov[2];
 	int sk, err = 0;
-	uint16_t size;
 
 	if (session->state != AVCTP_STATE_CONNECTED)
 		return -ENOTCONN;
 
 	sk = g_io_channel_unix_get_fd(session->io);
-	size = AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH + operand_count;
-	buf = g_malloc0(size);
 
 	avctp = (void *) buf;
 	avc = (void *) &buf[AVCTP_HEADER_LENGTH];
-	pdu = (void *) &buf[AVCTP_HEADER_LENGTH + AVC_HEADER_LENGTH];
 
 	avctp->transaction = transaction;
 	avctp->packet_type = AVCTP_PACKET_SINGLE;
@@ -956,12 +953,18 @@ static int avctp_send(struct avctp *session, uint8_t transaction, uint8_t cr,
 	avc->subunit_type = subunit;
 	avc->opcode = opcode;
 
-	memcpy(pdu, operands, operand_count);
+	iov[0].iov_base = buf;
+	iov[0].iov_len  = sizeof(buf);
+	iov[1].iov_base = operands;
+	iov[1].iov_len  = operand_count;
 
-	if (write(sk, buf, size) < 0)
+	memset(&msg, 0, sizeof(msg));
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 2;
+
+	if (sendmsg(sk, &msg, 0) < 0)
 		err = -errno;
 
-	g_free(buf);
 	return err;
 }
 
-- 
1.7.10.4

