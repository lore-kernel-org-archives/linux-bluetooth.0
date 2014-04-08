Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] android/avctp: Make avctp_send_browsing_req to take struct iovec
Date: Tue,  8 Apr 2014 16:34:39 +0300
Message-Id: <1396964080-19642-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1396964080-19642-1-git-send-email-luiz.dentz@gmail.com>
References: <1396964080-19642-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to pass data without copying.
---
 android/avctp.c     | 65 +++++++++++++++++++++++++++++++++--------------------
 android/avctp.h     |  2 +-
 android/avrcp-lib.c | 31 ++++++++++---------------
 3 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index ed91810..f49b3c3 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -123,8 +123,8 @@ struct avctp_control_req {
 
 struct avctp_browsing_req {
 	struct avctp_pending_req *p;
-	uint8_t *operands;
-	uint16_t operand_count;
+	struct iovec *iov;
+	int iov_cnt;
 	avctp_browsing_rsp_cb func;
 	void *user_data;
 };
@@ -552,35 +552,39 @@ static int avctp_send(struct avctp_channel *control, uint8_t transaction,
 
 static int avctp_browsing_send(struct avctp_channel *browsing,
 				uint8_t transaction, uint8_t cr,
-				uint8_t *operands, size_t operand_count)
+				const struct iovec *iov, int iov_cnt)
 {
-	struct avctp_header *avctp;
+	struct avctp_header avctp;
 	struct msghdr msg;
-	struct iovec iov[2];
+	struct iovec pdu[iov_cnt + 1];
 	int sk, err = 0;
+	int i;
+	size_t len = sizeof(avctp);
 
-	iov[0].iov_base = browsing->buffer;
-	iov[0].iov_len  = sizeof(*avctp);
-	iov[1].iov_base = operands;
-	iov[1].iov_len  = operand_count;
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i + 1].iov_base = iov[i].iov_base;
+		pdu[i + 1].iov_len  = iov[i].iov_len;
+		len += iov[i].iov_len;
+	}
 
-	if (browsing->omtu < (iov[0].iov_len + iov[1].iov_len))
+	pdu[0].iov_base = (void *) &avctp;
+	pdu[0].iov_len  = sizeof(avctp);
+
+	if (browsing->omtu < len)
 		return -EOVERFLOW;
 
 	sk = g_io_channel_unix_get_fd(browsing->io);
 
-	memset(browsing->buffer, 0, iov[0].iov_len);
-
-	avctp = (void *) browsing->buffer;
+	memset(&avctp, 0, sizeof(avctp));
 
-	avctp->transaction = transaction;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = cr;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+	avctp.transaction = transaction;
+	avctp.packet_type = AVCTP_PACKET_SINGLE;
+	avctp.cr = cr;
+	avctp.pid = htons(AV_REMOTE_SVCLASS_ID);
 
 	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 2;
+	msg.msg_iov = pdu;
+	msg.msg_iovlen = iov_cnt + 1;
 
 	if (sendmsg(sk, &msg, 0) < 0)
 		err = -errno;
@@ -610,6 +614,7 @@ static void browsing_req_destroy(void *data)
 	struct avctp_browsing_req *req = data;
 	struct avctp_pending_req *p = req->p;
 	struct avctp *session = p->chan->session;
+	int i;
 
 	if (p->err == 0 || req->func == NULL)
 		goto done;
@@ -617,7 +622,10 @@ static void browsing_req_destroy(void *data)
 	req->func(session, NULL, 0, req->user_data);
 
 done:
-	g_free(req->operands);
+	for (i = 0; i < req->iov_cnt; i++)
+		g_free(req->iov[i].iov_base);
+
+	g_free(req->iov);
 	g_free(req);
 }
 
@@ -656,7 +664,7 @@ static int process_browsing(void *data)
 	struct avctp_pending_req *p = req->p;
 
 	return avctp_browsing_send(p->chan, p->transaction, AVCTP_COMMAND,
-					req->operands, req->operand_count);
+						req->iov, req->iov_cnt);
 }
 
 static gboolean process_queue(void *user_data)
@@ -1125,20 +1133,29 @@ static int avctp_send_req(struct avctp *session, uint8_t code,
 }
 
 int avctp_send_browsing_req(struct avctp *session,
-				uint8_t *operands, size_t operand_count,
+				const struct iovec *iov, int iov_cnt,
 				avctp_browsing_rsp_cb func, void *user_data)
 {
 	struct avctp_channel *browsing = session->browsing;
 	struct avctp_pending_req *p;
 	struct avctp_browsing_req *req;
+	struct iovec *pdu;
+	int i;
 
 	if (browsing == NULL)
 		return -ENOTCONN;
 
+	pdu = g_new0(struct iovec, iov_cnt);
+
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i].iov_len = iov[i].iov_len;
+		pdu[i].iov_base = g_memdup(iov[i].iov_base, iov[i].iov_len);
+	}
+
 	req = g_new0(struct avctp_browsing_req, 1);
 	req->func = func;
-	req->operands = g_memdup(operands, operand_count);
-	req->operand_count = operand_count;
+	req->iov = pdu;
+	req->iov_cnt = iov_cnt;
 	req->user_data = user_data;
 
 	p = pending_create(browsing, process_browsing, req,
diff --git a/android/avctp.h b/android/avctp.h
index 98c1142..6e6bfad 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -174,5 +174,5 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 					size_t operand_count,
 					avctp_rsp_cb func, void *user_data);
 int avctp_send_browsing_req(struct avctp *session,
-				uint8_t *operands, size_t operand_count,
+				const struct iovec *iov, int iov_cnt,
 				avctp_browsing_rsp_cb func, void *user_data);
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 488df76..3b9735f 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -807,32 +807,25 @@ static int avrcp_send_browsing_req(struct avrcp *session, uint8_t pdu_id,
 					avctp_browsing_rsp_cb func,
 					void *user_data)
 {
-	struct avrcp_browsing_header *pdu = (void *) session->tx_buf;
-	size_t len = sizeof(*pdu);
+	struct iovec pdu[iov_cnt + 1];
+	struct avrcp_browsing_header hdr;
 	int i;
 
-	memset(pdu, 0, len);
-
-	pdu->pdu_id = pdu_id;
-
-	if (iov_cnt <= 0)
-		goto done;
+	memset(&hdr, 0, sizeof(hdr));
 
 	for (i = 0; i < iov_cnt; i++) {
-		len += iov[i].iov_len;
-
-		if (len > session->tx_mtu)
-			return -ENOBUFS;
-
-		memcpy(&pdu->params[pdu->params_len], iov[i].iov_base,
-							iov[i].iov_len);
-		pdu->params_len += iov[i].iov_len;
+		pdu[i + 1].iov_base = iov[i].iov_base;
+		pdu[i + 1].iov_len = iov[i].iov_len;
+		hdr.params_len += iov[i].iov_len;
 	}
 
-	pdu->params_len = htons(pdu->params_len);
+	hdr.pdu_id = pdu_id;
+	hdr.params_len = htons(hdr.params_len);
 
-done:
-	return avctp_send_browsing_req(session->conn, session->tx_buf, len,
+	pdu[0].iov_base = (void *) &hdr;
+	pdu[0].iov_len = sizeof(hdr);
+
+	return avctp_send_browsing_req(session->conn, pdu, iov_cnt + 1,
 							func, user_data);
 }
 
-- 
1.9.0

