Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7585B2FFFA5
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jan 2026 08:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768984694; cv=none; b=FhVd4mS4blly4quBpl8+bukdjvlhWMJ8s6P02Y8NQMT1GA6xKZp/Wjca6frRID4OjL1SjY9rUu6PwIjV41w6B7vk+6IjdlbDjU8u6/gusGOQNSHK1XeNCLSgCkofr32sGzvVnKB/KIkDCx0JviytsKOhbUrRAc5dISc/9X6wM3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768984694; c=relaxed/simple;
	bh=mcY9owxR21urVK56T9v8POw0dhZwoG9ZOnEqIDG0HRw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R83Vneh56PPs6FrrJqXN37xfJPUbkfOwj1cZouN9hlceBhDZskbNAUoWnlR4Elr23EIfS537nv/8+QGfn/DXpEsKWn2LW+ITEnO0GVAVF7r1LsaEpZXz60LyFqNRQ7fPZ7f7x+ZDNoMhcDR/QlVNX7c4NM3qwedI/0qLb/jeMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=h+6buOdj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="h+6buOdj"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L6XLLu2354294;
	Wed, 21 Jan 2026 08:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QhJGGe8n5PC
	IEASf0SbfEs4/nFSSerAQW7sPyMKwJaI=; b=h+6buOdjWRn+3X2kCWlVwnvXFwY
	Uxrxnh7B/xxSC1Tfa22vhPJXPLdjlXVJvTco6kyltpRmoLGvk8WEnrKalN8z+dUh
	5oPe0mzAisXcAaoK9bt00DNAZFAx0IhjG7sztQJgfPRz7kk6AFzBEd8SsXsGJ/rR
	PkfCyB5x88OAw2s22FXdcCtezOCYEw7ufeud595BXRtawXav5d9AgF11RVPMSx7T
	7+BYA5aKdO1yDcRoLa0lJpMGx81EK/XfDLPFNO/KVITXH6DIm+O7gj8y7Idi9UqB
	UgA6UByH2XF3UCHKU2Di3ePTw0g05NsgJaTV3VsWLbev4PKtz4ZIrdDPSpg==
Received: from aptaippmta01.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btsmprcsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:10 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 60L8c8vY029080;
	Wed, 21 Jan 2026 08:38:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 4br3gms2ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:08 +0000
Received: from APTAIPPMTA01.qualcomm.com (APTAIPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60L8c8U1029075;
	Wed, 21 Jan 2026 08:38:08 GMT
Received: from bt-iot-sh02-lnx.ap.qualcomm.com (smtphost-taiwan.qualcomm.com [10.249.136.33])
	by APTAIPPMTA01.qualcomm.com (PPS) with ESMTPS id 60L8c7Lv029072
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Jan 2026 08:38:08 +0000
Received: by bt-iot-sh02-lnx.ap.qualcomm.com (Postfix, from userid 4766378)
	id DCE1B23883; Wed, 21 Jan 2026 16:38:06 +0800 (CST)
From: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
To: luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, chezhou@qti.qualcomm.com,
        wei.deng@oss.qualcomm.com, yiboz@qti.qualcomm.com,
        Mengshi Wu <mengshi.wu@oss.qualcomm.com>
Subject: [PATCH v3 1/2] shared/att: Implement ATT error retry mechanism with callback support
Date: Wed, 21 Jan 2026 16:38:03 +0800
Message-Id: <20260121083804.4010106-2-mengshi.wu@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
References: <20260121083804.4010106-1-mengshi.wu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=EIcLElZC c=1 sm=1 tr=0 ts=69709072 cx=c_pps
 a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=ia_pDvnbsAvbDmiY8_EA:9
X-Proofpoint-ORIG-GUID: Hnc0vW-PRoM6DcMCScyGo_oezBKFl_Ko
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA3MSBTYWx0ZWRfX7Yt3Wj45kvuS
 +uOckQter4zD9bU60r1EMBTu6NZZDMe6YJFKrLm0jzG/SJpDdiKapF4zmGTiY1UFeyGVGFWt5rn
 H9npD8NRa+pUbBr4PR0fYJy7GHApR6vB0wwXmcWF4d4KAuLLeSir6DbgjqU1lYYto2UcIIQpxbm
 S/rDEEDY4XpLTgZVOZLBET+veKWfttY/RaoIixFBEiFGPQh3EIi/Dcm0+c76pk4hqoeqghiavOe
 eilZV4oi+rQHhZFhYlA56OWVnBBrbNylDqAWuW2GS5Y2VVeRpCH425JvQ3DgeLDUW4AichBcuxI
 ERoGt/9Xwere6E3MfXuqRzAqTy0jr0K4O5/bpbEXXgWUZauj2XRueLpkTwrqMsw7pQbm9I9+Tlf
 D+1c5hc3Fzv1tFa1hJxB+SQ3nK4LjsmZ18Up1cEx+sw8D00Pr4fQcyKgodUNyrZBs/7xuWXuFja
 E80aB8ZMWcDB1PBIEhg==
X-Proofpoint-GUID: Hnc0vW-PRoM6DcMCScyGo_oezBKFl_Ko
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210071

Add a retry mechanism for ATT operations that allows upper layers to
decide whether to retry failed requests. This includes:

- Add retry callback registration (bt_att_set_retry_cb) to allow
  applications to handle retry decisions
- Implement pending_retry state tracking in att_send_op to store
  operations awaiting retry approval
- Add bt_att_retry_request() and bt_att_cancel_retry() functions to
  approve or reject retry attempts
- Store error PDUs during retry_pending state for callback inspection
- Modify handle_error_rsp() to return retry decision codes instead of
  boolean values
- Add BT_ATT_RETRY_* constants for retry decision handling
- Update GATT helpers to support retry callbacks for operations like
  discovery and read/write requests

This enables more robust error handling by allowing the application
layer to implement custom retry logic based on ATT error codes.

Signed-off-by: Mengshi Wu <mengshi.wu@oss.qualcomm.com>
---
 src/shared/att.c | 182 +++++++++++++++++++++++++++++++++++++++++++++--
 src/shared/att.h |  16 +++++
 2 files changed, 191 insertions(+), 7 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 77ca4aa24..4ae97530a 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -47,6 +47,7 @@ struct bt_att_chan {
 
 	struct att_send_op *pending_req;
 	struct att_send_op *pending_ind;
+	struct att_send_op *pending_retry;
 	bool writer_active;
 
 	bool in_req;			/* There's a pending incoming request */
@@ -78,6 +79,10 @@ struct bt_att {
 	bt_att_destroy_func_t timeout_destroy;
 	void *timeout_data;
 
+	bt_att_retry_func_t retry_callback;
+	bt_att_destroy_func_t retry_destroy;
+	void *retry_data;
+
 	uint8_t debug_level;
 	bt_att_debug_func_t debug_callback;
 	bt_att_destroy_func_t debug_destroy;
@@ -194,6 +199,9 @@ struct att_send_op {
 	void *pdu;
 	uint16_t len;
 	bool retry;
+	bool retry_pending;  /* Waiting for approval to retry */
+	uint8_t *error_pdu;  /* Stored error PDU for retry_pending */
+	uint16_t error_pdu_len;
 	bt_att_response_func_t callback;
 	bt_att_destroy_func_t destroy;
 	void *user_data;
@@ -210,6 +218,7 @@ static void destroy_att_send_op(void *data)
 		op->destroy(op->user_data);
 
 	free(op->pdu);
+	free(op->error_pdu);
 	free(op);
 }
 
@@ -644,6 +653,9 @@ static void bt_att_chan_free(void *data)
 	if (chan->pending_ind)
 		destroy_att_send_op(chan->pending_ind);
 
+	if (chan->pending_retry)
+		destroy_att_send_op(chan->pending_retry);
+
 	queue_destroy(chan->queue, destroy_att_send_op);
 
 	io_destroy(chan->io);
@@ -682,6 +694,11 @@ static bool disconnect_cb(struct io *io, void *user_data)
 		chan->pending_ind = NULL;
 	}
 
+	if (chan->pending_retry) {
+		disc_att_send_op(chan->pending_retry);
+		chan->pending_retry = NULL;
+	}
+
 	bt_att_chan_free(chan);
 
 	/* Don't run disconnect callback if there are channels left */
@@ -777,16 +794,17 @@ static bool change_security(struct bt_att_chan *chan, uint8_t ecode)
 	return bt_att_chan_set_security(chan, security);
 }
 
-static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
+static int handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 					ssize_t pdu_len, uint8_t *opcode)
 {
 	struct bt_att *att = chan->att;
 	const struct bt_att_pdu_error_rsp *rsp;
 	struct att_send_op *op = chan->pending_req;
+	int should_retry = BT_ATT_RETRY_NO;
 
 	if (pdu_len != sizeof(*rsp)) {
 		*opcode = 0;
-		return false;
+		return should_retry;
 	}
 
 	rsp = (void *) pdu;
@@ -797,11 +815,43 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 	 * the security again.
 	 */
 	if (op->retry)
-		return false;
+		return should_retry;
 
 	/* Attempt to change security */
-	if (!change_security(chan, rsp->ecode))
-		return false;
+	if (change_security(chan, rsp->ecode)) {
+		should_retry = BT_ATT_RETRY_YES;
+	} else if (att->retry_callback) {
+		should_retry = att->retry_callback(op->opcode, rsp->ecode,
+						   op->pdu + 1, op->len - 1,
+						   op->id, att->retry_data);
+
+		/* Check if callback wants to defer the retry decision */
+		if (should_retry == BT_ATT_RETRY_PENDING) {
+			op->retry_pending = true;
+
+			/* Store error PDU for later use */
+			op->error_pdu = malloc(pdu_len);
+			if (op->error_pdu) {
+				memcpy(op->error_pdu, pdu, pdu_len);
+				op->error_pdu_len = pdu_len;
+			}
+
+			/* Remove timeout since we're waiting for approval */
+			if (op->timeout_id) {
+				timeout_remove(op->timeout_id);
+				op->timeout_id = 0;
+			}
+
+			/* Move from pending_req to pending_retry */
+			chan->pending_retry = op;
+
+			DBG(att, "(chan %p) Retry pending for operation %p",
+			    chan, op);
+		}
+	}
+
+	if (should_retry != BT_ATT_RETRY_YES)
+		return should_retry;
 
 	/* Remove timeout_id if outstanding */
 	if (op->timeout_id) {
@@ -815,7 +865,8 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 	op->retry = true;
 
 	/* Push operation back to channel queue */
-	return queue_push_head(chan->queue, op);
+	return queue_push_head(chan->queue, op) ?
+		BT_ATT_RETRY_YES : BT_ATT_RETRY_NO;
 }
 
 static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
@@ -845,9 +896,15 @@ static void handle_rsp(struct bt_att_chan *chan, uint8_t opcode, uint8_t *pdu,
 	 */
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
 		/* Return if error response cause a retry */
-		if (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
+		switch (handle_error_rsp(chan, pdu, pdu_len, &req_opcode)) {
+		case BT_ATT_RETRY_PENDING:
+			/* Operation moved to pending_retry, clear pending_req */
+			chan->pending_req = NULL;
+		case BT_ATT_RETRY_YES:
 			wakeup_chan_writer(chan, NULL);
 			return;
+		default:
+			break;
 		}
 	} else if (!(req_opcode = get_req_opcode(opcode)))
 		goto fail;
@@ -1142,6 +1199,9 @@ static void bt_att_free(struct bt_att *att)
 	if (att->timeout_destroy)
 		att->timeout_destroy(att->timeout_data);
 
+	if (att->retry_destroy)
+		att->retry_destroy(att->retry_data);
+
 	if (att->debug_destroy)
 		att->debug_destroy(att->debug_data);
 
@@ -1473,6 +1533,23 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 	return true;
 }
 
+bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy)
+{
+	if (!att)
+		return false;
+
+	if (att->retry_destroy)
+		att->retry_destroy(att->retry_data);
+
+	att->retry_callback = callback;
+	att->retry_destroy = destroy;
+	att->retry_data = user_data;
+
+	return true;
+}
+
 unsigned int bt_att_register_disconnect(struct bt_att *att,
 					bt_att_disconnect_func_t callback,
 					void *user_data,
@@ -2051,6 +2128,97 @@ bool bt_att_has_crypto(struct bt_att *att)
 	return att->crypto ? true : false;
 }
 
+bool bt_att_retry_request(struct bt_att *att, unsigned int id)
+{
+	const struct queue_entry *entry;
+	struct bt_att_chan *chan = NULL;
+	struct att_send_op *op;
+
+	if (!att || !id)
+		return false;
+
+	/* Find the channel with the pending retry operation */
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *c = entry->data;
+
+		if (c->pending_retry && c->pending_retry->id == id &&
+		    c->pending_retry->retry_pending) {
+			chan = c;
+			op = c->pending_retry;
+			break;
+		}
+	}
+
+	if (!chan || !op)
+		return false;
+
+	DBG(att, "(chan %p) Approving retry for operation %p", chan, op);
+
+	/* Clear pending retry state and mark for retry */
+	op->retry_pending = false;
+	op->retry = true;
+	chan->pending_retry = NULL;
+
+	/* Free stored error PDU as we're retrying */
+	free(op->error_pdu);
+	op->error_pdu = NULL;
+	op->error_pdu_len = 0;
+
+	/* Push operation back to channel queue for retry */
+	if (!queue_push_head(chan->queue, op))
+		return false;
+
+	/* Wake up writer to send the retry */
+	wakeup_chan_writer(chan, NULL);
+
+	return true;
+}
+
+bool bt_att_cancel_retry(struct bt_att *att, unsigned int id)
+{
+	const struct queue_entry *entry;
+	struct bt_att_chan *chan = NULL;
+	struct att_send_op *op;
+
+	if (!att || !id)
+		return false;
+
+	/* Find the channel with the pending retry operation */
+	for (entry = queue_get_entries(att->chans); entry;
+						entry = entry->next) {
+		struct bt_att_chan *c = entry->data;
+
+		if (c->pending_retry && c->pending_retry->id == id &&
+		    c->pending_retry->retry_pending) {
+			chan = c;
+			op = c->pending_retry;
+			break;
+		}
+	}
+
+	if (!chan || !op)
+		return false;
+
+	DBG(att, "(chan %p) Canceling retry for operation %p", chan, op);
+
+	/* Clear pending retry state */
+	op->retry_pending = false;
+	chan->pending_retry = NULL;
+
+	/* Call the callback with stored error PDU to notify upper layer */
+	if (op->callback)
+		op->callback(BT_ATT_OP_ERROR_RSP, op->error_pdu,
+			     op->error_pdu_len, op->user_data);
+
+	destroy_att_send_op(op);
+
+	/* Wake up writer in case there are other operations */
+	wakeup_chan_writer(chan, NULL);
+
+	return true;
+}
+
 bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
 {
 	struct att_send_op *op;
diff --git a/src/shared/att.h b/src/shared/att.h
index 53a3f7a2a..6dc9944bb 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -46,6 +46,15 @@ typedef void (*bt_att_disconnect_func_t)(int err, void *user_data);
 typedef void (*bt_att_exchange_func_t)(uint16_t mtu, void *user_data);
 typedef bool (*bt_att_counter_func_t)(uint32_t *sign_cnt, void *user_data);
 
+/* Return values for bt_att_retry_func_t */
+#define BT_ATT_RETRY_NO	0	/* Don't retry */
+#define BT_ATT_RETRY_YES	1	/* Retry immediately */
+#define BT_ATT_RETRY_PENDING	2	/* Defer retry decision */
+
+typedef int (*bt_att_retry_func_t)(uint8_t opcode, uint8_t error_code,
+					const void *pdu, uint16_t length,
+					unsigned int att_id, void *user_data);
+
 bool bt_att_set_debug(struct bt_att *att, uint8_t level,
 			bt_att_debug_func_t callback, void *user_data,
 			bt_att_destroy_func_t destroy);
@@ -58,6 +67,13 @@ bool bt_att_set_timeout_cb(struct bt_att *att, bt_att_timeout_func_t callback,
 						void *user_data,
 						bt_att_destroy_func_t destroy);
 
+bool bt_att_set_retry_cb(struct bt_att *att, bt_att_retry_func_t callback,
+						void *user_data,
+						bt_att_destroy_func_t destroy);
+
+bool bt_att_retry_request(struct bt_att *att, unsigned int id);
+bool bt_att_cancel_retry(struct bt_att *att, unsigned int id);
+
 unsigned int bt_att_send(struct bt_att *att, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					bt_att_response_func_t callback,
-- 
2.34.1

