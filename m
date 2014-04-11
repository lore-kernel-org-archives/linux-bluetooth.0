Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 5/6] android/avctp: Make avctp_send_vendor_req to take struct iovec
Date: Fri, 11 Apr 2014 16:58:36 +0300
Message-Id: <1397224717-28446-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
References: <1397224717-28446-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it possible to pass data without copying.
---
 android/avctp.c     | 152 +++++++++++++++++++++++++++++++---------------------
 android/avctp.h     |   7 ++-
 android/avrcp-lib.c |  45 +++++++---------
 unit/test-avctp.c   |   2 +-
 4 files changed, 114 insertions(+), 92 deletions(-)

diff --git a/android/avctp.c b/android/avctp.c
index 56d4f4a..62c41fd 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -115,8 +115,8 @@ struct avctp_control_req {
 	uint8_t code;
 	uint8_t subunit;
 	uint8_t op;
-	uint8_t *operands;
-	uint16_t operand_count;
+	struct iovec *iov;
+	int iov_cnt;
 	avctp_rsp_cb func;
 	void *user_data;
 };
@@ -508,41 +508,50 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 static int avctp_send(struct avctp_channel *control, uint8_t transaction,
 				uint8_t cr, uint8_t code,
 				uint8_t subunit, uint8_t opcode,
-				uint8_t *operands, size_t operand_count)
+				const struct iovec *iov, int iov_cnt)
 {
-	struct avctp_header *avctp;
-	struct avc_header *avc;
+	struct avctp_header avctp;
+	struct avc_header avc;
 	struct msghdr msg;
-	struct iovec iov[2];
 	int sk, err = 0;
+	struct iovec pdu[iov_cnt + 2];
+	int i;
+	size_t len = sizeof(avctp) + sizeof(avc);
+
+	DBG("");
+
+	pdu[0].iov_base = &avctp;
+	pdu[0].iov_len  = sizeof(avctp);
+	pdu[1].iov_base = &avc;
+	pdu[1].iov_len  = sizeof(avc);
 
-	iov[0].iov_base = control->buffer;
-	iov[0].iov_len  = sizeof(*avctp) + sizeof(*avc);
-	iov[1].iov_base = operands;
-	iov[1].iov_len  = operand_count;
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i + 2].iov_base = iov[i].iov_base;
+		pdu[i + 2].iov_len  = iov[i].iov_len;
+		len += iov[i].iov_len;
+	}
 
-	if (control->omtu < (iov[0].iov_len + iov[1].iov_len))
+	if (control->omtu < len)
 		return -EOVERFLOW;
 
 	sk = g_io_channel_unix_get_fd(control->io);
 
-	memset(control->buffer, 0, iov[0].iov_len);
+	memset(&avctp, 0, sizeof(avctp));
 
-	avctp = (void *) control->buffer;
-	avc = (void *) avctp + sizeof(*avctp);
+	avctp.transaction = transaction;
+	avctp.packet_type = AVCTP_PACKET_SINGLE;
+	avctp.cr = cr;
+	avctp.pid = htons(AV_REMOTE_SVCLASS_ID);
 
-	avctp->transaction = transaction;
-	avctp->packet_type = AVCTP_PACKET_SINGLE;
-	avctp->cr = cr;
-	avctp->pid = htons(AV_REMOTE_SVCLASS_ID);
+	memset(&avc, 0, sizeof(avc));
 
-	avc->code = code;
-	avc->subunit_type = subunit;
-	avc->opcode = opcode;
+	avc.code = code;
+	avc.subunit_type = subunit;
+	avc.opcode = opcode;
 
 	memset(&msg, 0, sizeof(msg));
-	msg.msg_iov = iov;
-	msg.msg_iovlen = 2;
+	msg.msg_iov = pdu;
+	msg.msg_iovlen = iov_cnt + 2;
 
 	if (sendmsg(sk, &msg, 0) < 0)
 		err = -errno;
@@ -597,6 +606,7 @@ static void control_req_destroy(void *data)
 	struct avctp_control_req *req = data;
 	struct avctp_pending_req *p = req->p;
 	struct avctp *session = p->chan->session;
+	int i;
 
 	if (p->err == 0 || req->func == NULL)
 		goto done;
@@ -605,7 +615,10 @@ static void control_req_destroy(void *data)
 							req->user_data);
 
 done:
-	g_free(req->operands);
+	for (i = 0; i < req->iov_cnt; i++)
+		g_free(req->iov[i].iov_base);
+
+	g_free(req->iov);
 	g_free(req);
 }
 
@@ -654,8 +667,7 @@ static int process_control(void *data)
 	struct avctp_pending_req *p = req->p;
 
 	return avctp_send(p->chan, p->transaction, AVCTP_COMMAND, req->code,
-					req->subunit, req->op,
-					req->operands, req->operand_count);
+				req->subunit, req->op, req->iov, req->iov_cnt);
 }
 
 static int process_browsing(void *data)
@@ -1099,25 +1111,33 @@ done:
 	return p;
 }
 
-static int avctp_send_req(struct avctp *session, uint8_t code,
-				uint8_t subunit, uint8_t opcode,
-				uint8_t *operands, size_t operand_count,
-				avctp_rsp_cb func, void *user_data)
+static int avctp_send_req(struct avctp *session, uint8_t code, uint8_t subunit,
+			uint8_t opcode, const struct iovec *iov, int iov_cnt,
+			avctp_rsp_cb func, void *user_data)
 {
 	struct avctp_channel *control = session->control;
 	struct avctp_pending_req *p;
 	struct avctp_control_req *req;
+	struct iovec *pdu;
+	int i;
 
 	if (control == NULL)
 		return -ENOTCONN;
 
+	pdu = g_new0(struct iovec, iov_cnt);
+
+	for (i = 0; i < iov_cnt; i++) {
+		pdu[i].iov_len = iov[i].iov_len;
+		pdu[i].iov_base = g_memdup(iov[i].iov_base, iov[i].iov_len);
+	}
+
 	req = g_new0(struct avctp_control_req, 1);
 	req->code = code;
 	req->subunit = subunit;
 	req->op = opcode;
 	req->func = func;
-	req->operands = g_memdup(operands, operand_count);
-	req->operand_count = operand_count;
+	req->iov = pdu;
+	req->iov_cnt = iov_cnt;
 	req->user_data = user_data;
 
 	p = pending_create(control, process_control, req, control_req_destroy);
@@ -1190,53 +1210,61 @@ static const char *op2str(uint8_t op)
 static int avctp_passthrough_press(struct avctp *session, uint8_t op,
 					uint8_t *params, size_t params_len)
 {
-	uint8_t operands[7];
-	size_t len;
+	struct iovec iov[2];
+	int iov_cnt;
+	uint8_t operands[2];
+
+	DBG("%s", op2str(op));
 
-	DBG("op 0x%02x %s params_len %zd", op, op2str(op), params_len);
+	iov[0].iov_base = operands;
+	iov[0].iov_len = sizeof(operands);
 
 	/* Button pressed */
 	operands[0] = op & 0x7f;
 
-	if (op == AVC_VENDOR_UNIQUE && params &&
-				params_len == 5) {
-		memcpy(&operands[2], params, params_len);
-		len = params_len + 2;
+	if (params_len > 0) {
+		iov[1].iov_base = params;
+		iov[1].iov_len = params_len;
+		iov_cnt = 2;
 		operands[1] = params_len;
 	} else {
-		len = 2;
+		iov_cnt = 1;
 		operands[1] = 0;
 	}
 
 	return avctp_send_req(session, AVC_CTYPE_CONTROL,
 				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, len,
-				avctp_passthrough_rsp, NULL);
+				iov, iov_cnt, avctp_passthrough_rsp, NULL);
 }
 
 static int avctp_passthrough_release(struct avctp *session, uint8_t op,
 					uint8_t *params, size_t params_len)
 {
-	uint8_t operands[7];
-	size_t len;
+	struct iovec iov[2];
+	int iov_cnt;
+	uint8_t operands[2];
 
 	DBG("%s", op2str(op));
 
+	iov[0].iov_base = operands;
+	iov[0].iov_len = sizeof(operands);
+
 	/* Button released */
 	operands[0] = op | 0x80;
-	operands[1] = 0;
 
-	if (op == AVC_VENDOR_UNIQUE && params &&
-				params_len > sizeof(operands) - 2) {
-		memcpy(&operands[2], params, params_len);
-		len = params_len;
-	} else
-		len = 2;
+	if (params_len > 0) {
+		iov[1].iov_base = params;
+		iov[1].iov_len = params_len;
+		iov_cnt = 2;
+		operands[1] = params_len;
+	} else {
+		iov_cnt = 1;
+		operands[1] = 0;
+	}
 
 	return avctp_send_req(session, AVC_CTYPE_CONTROL,
 				AVC_SUBUNIT_PANEL, AVC_OP_PASSTHROUGH,
-				operands, len,
-				NULL, NULL);
+				iov, iov_cnt, NULL, NULL);
 }
 
 static gboolean repeat_timeout(gpointer user_data)
@@ -1322,27 +1350,29 @@ int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
 	return avctp_passthrough_press(session, op, params, params_len);
 }
 
-int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
+int avctp_send_vendor(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count)
 {
 	struct avctp_channel *control = session->control;
+	struct iovec iov;
 
 	if (control == NULL)
 		return -ENOTCONN;
 
+	iov.iov_base = operands;
+	iov.iov_len = operand_count;
+
 	return avctp_send(control, transaction, AVCTP_RESPONSE, code, subunit,
-					AVC_OP_VENDORDEP, operands, operand_count);
+						AVC_OP_VENDORDEP, &iov, 1);
 }
 
-int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
-					uint8_t subunit, uint8_t *operands,
-					size_t operand_count,
+int avctp_send_vendor_req(struct avctp *session, uint8_t code, uint8_t subunit,
+					const struct iovec *iov, int iov_cnt,
 					avctp_rsp_cb func, void *user_data)
 {
-	return avctp_send_req(session, code, subunit, AVC_OP_VENDORDEP,
-						operands, operand_count,
-						func, user_data);
+	return avctp_send_req(session, code, subunit, AVC_OP_VENDORDEP, iov,
+						iov_cnt, func, user_data);
 }
 
 unsigned int avctp_register_passthrough_handler(struct avctp *session,
diff --git a/android/avctp.h b/android/avctp.h
index 6e6bfad..1b15398 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -166,12 +166,11 @@ bool avctp_unregister_browsing_pdu_handler(struct avctp *session,
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op, uint8_t *params,
 							size_t params_len);
-int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
+int avctp_send_vendor(struct avctp *session, uint8_t transaction,
 				uint8_t code, uint8_t subunit,
 				uint8_t *operands, size_t operand_count);
-int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
-					uint8_t subunit, uint8_t *operands,
-					size_t operand_count,
+int avctp_send_vendor_req(struct avctp *session, uint8_t code, uint8_t subunit,
+					const struct iovec *iov, int iov_cnt,
 					avctp_rsp_cb func, void *user_data);
 int avctp_send_browsing_req(struct avctp *session,
 				const struct iovec *iov, int iov_cnt,
diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 22a68f7..e2bba11 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -724,7 +724,7 @@ int avrcp_send(struct avrcp *session, uint8_t transaction, uint8_t code,
 		pdu->params_len = htons(params_len);
 	}
 
-	return avctp_send_vendordep(session->conn, transaction, code, subunit,
+	return avctp_send_vendor(session->conn, transaction, code, subunit,
 							session->tx_buf, len);
 }
 
@@ -771,35 +771,28 @@ static int avrcp_send_req(struct avrcp *session, uint8_t code, uint8_t subunit,
 					int iov_cnt, avctp_rsp_cb func,
 					void *user_data)
 {
-	struct avrcp_header *pdu = (void *) session->tx_buf;
-	size_t len = sizeof(*pdu);
+	struct iovec pdu[iov_cnt + 1];
+	struct avrcp_header hdr;
 	int i;
 
-	memset(pdu, 0, len);
-
-	hton24(pdu->company_id, IEEEID_BTSIG);
-	pdu->pdu_id = pdu_id;
-	pdu->packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	memset(&hdr, 0, sizeof(hdr));
 
-	if (iov_cnt <= 0)
-		goto done;
+	pdu[0].iov_base = &hdr;
+	pdu[0].iov_len = sizeof(hdr);
 
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
+	hton24(hdr.company_id, IEEEID_BTSIG);
+	hdr.pdu_id = pdu_id;
+	hdr.packet_type = AVRCP_PACKET_TYPE_SINGLE;
+	hdr.params_len = htons(hdr.params_len);
 
-done:
-	return avctp_send_vendordep_req(session->conn, code, subunit,
-					session->tx_buf, len, func, user_data);
+	return avctp_send_vendor_req(session->conn, code, subunit, pdu,
+						iov_cnt + 1, func, user_data);
 }
 
 static int avrcp_send_browsing_req(struct avrcp *session, uint8_t pdu_id,
@@ -1409,8 +1402,8 @@ int avrcp_set_player_value(struct avrcp *session, uint8_t number,
 	iov.iov_len = 1 + number * 2;
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-				AVRCP_SET_PLAYER_VALUE, &iov, 1,
-				set_value_rsp, session);
+					AVRCP_SET_PLAYER_VALUE, &iov, 1,
+					set_value_rsp, session);
 }
 
 static gboolean get_play_status_rsp(struct avctp *conn,
@@ -1686,8 +1679,8 @@ int avrcp_set_addressed_player(struct avrcp *session, uint16_t player_id)
 	iov.iov_len = sizeof(pdu);
 
 	return avrcp_send_req(session, AVC_CTYPE_CONTROL, AVC_SUBUNIT_PANEL,
-				AVRCP_SET_ADDRESSED_PLAYER, &iov, 1,
-				set_addressed_rsp, session);
+					AVRCP_SET_ADDRESSED_PLAYER, &iov, 1,
+					set_addressed_rsp, session);
 }
 
 static gboolean set_browsed_rsp(struct avctp *conn, uint8_t *operands,
diff --git a/unit/test-avctp.c b/unit/test-avctp.c
index 0759731..8f7d5ad 100644
--- a/unit/test-avctp.c
+++ b/unit/test-avctp.c
@@ -264,7 +264,7 @@ static void test_client(gconstpointer data)
 {
 	struct context *context = create_context(0x0100, data);
 
-	avctp_send_vendordep_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
+	avctp_send_vendor_req(context->session, AVC_CTYPE_CONTROL, 0, NULL,
 						0, handler_response, context);
 
 	execute_context(context);
-- 
1.9.0

