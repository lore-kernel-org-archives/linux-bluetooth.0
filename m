Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97257223702
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 18:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959336; cv=none; b=LoO61KDGHa7f/OU74yMBHrleyRhwjXthRz0p7L31Lmfue00wQ6eyTwf1IeYgd14RVHwcx3yH0d/oa1II7AYF13XQxoh/z6chNFG/76VoNAP2D2zxdYGNtu9KkruwsiG0UPZZIrdQi1Z0D9cPvnMEbRsa5I9sCH7e92b5XcVenb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959336; c=relaxed/simple;
	bh=tj7njfOipgRvkdJBf9CTkkC7fZIsUSh37xNGHYbmj5s=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=XCoQM+mDnqM7C/sWCZYCDPv0obhWK06651a1z94BAkvRgLvLwDy5ryjAU8B6iAadhZRq+DcNaOlAJTc/oGnw7mZahC7XgXngQFwl6IAaJrK4FLqjR15YUTKH9bwwBRs5a1JK69grWPSHV5vSYBoYgKGo45aaQdDHO1J3h+N7rpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7oXEmxf; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7oXEmxf"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5673891928cso2739042e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Feb 2026 10:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771959334; x=1772564134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MIVKvu4p+klqgBIsuicRBhfkVfC9gYjgeWgQxfuEhx0=;
        b=M7oXEmxfKvTnf9GJdosnVYKEqOYj8WdCqGpCjf03mvKT5QwmWeVTlV5Re8IEoCEuqE
         IvEIcKXsInsWMjIyJLwP2wg2VNzNS5pzx1du3nwjUMb+uHTNl82vj7FHWZukKHYpMCHz
         h7BEVMlTdXnqsf0gqPhnpp7y1fasc2REVZPry/tEmyr5psA6AW8Xyc94aMf/RGenjui2
         ocUhM7GBn1VtU6E+YenANwm9+hJ4s6t58XW/rRe4Yy6RdlcBmIAXsw/bwBt7aS3/QaFK
         fszBWQdUykAcCxDg6k1UAdxCbeqjv2VbOsHohkeqG9EO+kNfVpJHugna9Y0voOchow/e
         KARA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771959334; x=1772564134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MIVKvu4p+klqgBIsuicRBhfkVfC9gYjgeWgQxfuEhx0=;
        b=eErpWtrorW+6J3arwBwKRLlXRfnswTUlcXawHC9JC8akoG3nvnC4lXGjj4Ty0qULVp
         tPoUt8zuKnJo+OwV0wG7DbB0GeG1pRYXUUDmEnd6Y5ciVgS/SD8yzfFs2P8UBHJ4fOIJ
         bOLFL7UWL8Rmvq25eCAd6N3DpxwyKAR0uWdmYOKTG1yUhRGf5z/U5/PLmrz9En02H9mM
         mDYfj/Vi/AJdHE2DZLhBRAg3FalV3vxyygi6tqsWEnQX6WOhOPVBadpPKfArMzfYUq48
         bYwMINKI26cWwdl5MN8DuwSBXsffnDganGJxZMJRbrVhRoMoB3Mfx+zRbRn14/f/nBsI
         AEkw==
X-Gm-Message-State: AOJu0Yw+t87OIXoV1EcYpSW+kantVsupaFqcDrmYIei8wquMZu/KCeqL
	EpC7GJ/KfJN7QMOfiIFnSh2JggcOvQRLKOMz4MF/IdhGiH4cAXYmzXzRNpvDVlCQ
X-Gm-Gg: ATEYQzzjoS2qInXe2qK2paU6PXhgz3nCqHtO8n2wRrbyNYGYvbsGr6GJymZb9E2Q0kE
	gPO63v164EhVKP0Ty+Bz6xIRfQQcUKcXvSa3qBYLOFr12kn6Os72O2Z9zfwdkAkBkqMFC6zyKqk
	KTalmy/x3ixTZ/nkkkNd12ZH6Ntbj90NTuptB/m4YFa2YKb1/dPCN43DLlJL2AjysZ8Wb5aUBeD
	L9Ogbiev202BIrM6rRUWzS1WmznxDRvbWmT1oFch/NNV8ea+2ebRyDP9+pNxZawx2cfq6zu/HML
	//pEpCuC9U5xjfPZvKzJCbTdlKlTeIS5yyV81RmOsCxuDP6zcmjj7+mhpYIXV5CfiKTSwVAV2cM
	vq+5gy0SuuE6sEjuWek5MtIZ3mhJoI6wBtEuSk78Vw5Pn0jcNNk7sImo99kIaCUGtls0jSN5roC
	2TCeje1MBSRk6IXgD4Hq5FwHVv+3uLhS+yXjynCAC1WVxYrq+rLkHikQFD/qZ7T6B1GEu8NMY1z
	vqFWwBKijcB7KZx4ukZ9zO0dc67
X-Received: by 2002:a05:6122:1801:b0:55b:305b:4e3d with SMTP id 71dfb90a1353d-568e48f7535mr4581440e0c.19.1771959334362;
        Tue, 24 Feb 2026 10:55:34 -0800 (PST)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a7d70549asm989457e0c.4.2026.02.24.10.55.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 10:55:33 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/att: Simplify logic of DB out of sync recovery
Date: Tue, 24 Feb 2026 13:55:24 -0500
Message-ID: <20260224185524.4044679-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes struct pending_db_sync since it is not really necessary
to record all the field in bt_att_pdu_error_rsp, most of them can be
directly recovered from the original request and the ecode is meant
to be only BT_ATT_ERROR_DB_OUT_OF_SYNC.
---
 src/shared/att.c | 101 ++++++++++++++---------------------------------
 1 file changed, 30 insertions(+), 71 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index f6236248874c..3d3c8cfa262a 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -35,7 +35,6 @@
 #define BT_ATT_SIGNATURE_LEN		12
 
 struct att_send_op;
-struct pending_db_sync;
 
 struct bt_att_chan {
 	struct bt_att *att;
@@ -48,7 +47,7 @@ struct bt_att_chan {
 
 	struct att_send_op *pending_req;
 	struct att_send_op *pending_ind;
-	struct pending_db_sync *pending_db_sync;
+	struct att_send_op *pending_db_sync;
 	bool writer_active;
 
 	bool in_req;			/* There's a pending incoming request */
@@ -205,11 +204,6 @@ struct att_send_op {
 	void *user_data;
 };
 
-struct pending_db_sync {
-	struct att_send_op *op;
-	struct bt_att_pdu_error_rsp error;
-};
-
 static void destroy_att_send_op(void *data)
 {
 	struct att_send_op *op = data;
@@ -655,10 +649,8 @@ static void bt_att_chan_free(void *data)
 	if (chan->pending_ind)
 		destroy_att_send_op(chan->pending_ind);
 
-	if (chan->pending_db_sync) {
-		destroy_att_send_op(chan->pending_db_sync->op);
-		free(chan->pending_db_sync);
-	}
+	if (chan->pending_db_sync)
+		destroy_att_send_op(chan->pending_db_sync);
 
 	queue_destroy(chan->queue, destroy_att_send_op);
 
@@ -699,8 +691,7 @@ static bool disconnect_cb(struct io *io, void *user_data)
 	}
 
 	if (chan->pending_db_sync) {
-		disc_att_send_op(chan->pending_db_sync->op);
-		free(chan->pending_db_sync);
+		disc_att_send_op(chan->pending_db_sync);
 		chan->pending_db_sync = NULL;
 	}
 
@@ -828,15 +819,6 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 	/* Check if this is DB_OUT_OF_SYNC and we have a callback */
 	if (rsp->ecode == BT_ATT_ERROR_DB_OUT_OF_SYNC &&
 				att->db_sync_callback) {
-		struct pending_db_sync *pending;
-
-		pending = new0(struct pending_db_sync, 1);
-		if (!pending)
-			return false;
-
-		pending->op = op;
-		pending->error = *rsp;
-
 		/* Remove timeout since we're waiting for approval */
 		if (op->timeout_id) {
 			timeout_remove(op->timeout_id);
@@ -844,13 +826,13 @@ static bool handle_error_rsp(struct bt_att_chan *chan, uint8_t *pdu,
 		}
 
 		/* Move to pending_db_sync */
-		chan->pending_db_sync = pending;
+		chan->pending_db_sync = op;
 		chan->pending_req = NULL;
 
 		DBG(att, "(chan %p) DB out of sync for operation %p", chan, op);
 
 		/* Notify upper layer */
-		att->db_sync_callback(&pending->error, op->pdu + 1, op->len - 1,
+		att->db_sync_callback(rsp, op->pdu + 1, op->len - 1,
 				      op->id, att->db_sync_data);
 
 		return true;
@@ -1726,7 +1708,6 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
 {
 	const struct queue_entry *entry;
 	struct att_send_op *op;
-	bool from_db_sync = false;
 	bool result;
 
 	if (!att || !id)
@@ -1741,40 +1722,18 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
 			break;
 
 		/* Also check pending_db_sync */
-		if (chan->pending_db_sync &&
-				chan->pending_db_sync->op->id == id) {
-			from_db_sync = true;
-			break;
+		if (chan->pending_db_sync && chan->pending_db_sync->id == id) {
+			op = chan->pending_db_sync;
+			chan->pending_db_sync = NULL;
+			DBG(att, "(chan %p) Resending DB out of sync operation"
+				" %p", chan, op);
+			goto done;
 		}
 	}
 
 	if (!entry)
 		return -ENOENT;
 
-	/* If from pending_db_sync, extract operation details if not provided */
-	if (from_db_sync) {
-		struct bt_att_chan *chan = entry->data;
-		struct pending_db_sync *pending = chan->pending_db_sync;
-		struct att_send_op *stored_op = pending->op;
-
-		/* Auto-extract from stored operation if pdu is NULL */
-		if (!pdu) {
-			opcode = stored_op->opcode;
-			pdu = stored_op->pdu + 1;
-			length = stored_op->len - 1;
-			callback = stored_op->callback;
-			user_data = stored_op->user_data;
-			destroy = stored_op->destroy;
-		}
-
-		DBG(att, "(chan %p) Resending DB out of sync operation %p",
-			chan, stored_op);
-
-		/* Clear pending_db_sync state */
-		chan->pending_db_sync = NULL;
-		free(pending);
-	}
-
 	/* Only allow requests to be resend */
 	if (get_op_type(opcode) != ATT_OP_TYPE_REQ)
 		return -EOPNOTSUPP;
@@ -1786,6 +1745,7 @@ int bt_att_resend(struct bt_att *att, unsigned int id, uint8_t opcode,
 
 	op->id = id;
 
+done:
 	switch (opcode) {
 	/* Only prepend requests that could be a continuation */
 	case BT_ATT_OP_READ_BLOB_REQ:
@@ -1873,30 +1833,29 @@ bool bt_att_chan_cancel(struct bt_att_chan *chan, unsigned int id)
 
 static bool bt_att_db_sync_cancel(struct bt_att_chan *chan, unsigned int id)
 {
-	if (chan->pending_db_sync && chan->pending_db_sync->op->id == id) {
-		struct pending_db_sync *pending = chan->pending_db_sync;
-		struct att_send_op *op = pending->op;
-		uint8_t error_pdu[sizeof(struct bt_att_pdu_error_rsp)];
+	struct att_send_op *op = chan->pending_db_sync;
+	struct bt_att_pdu_error_rsp rsp;
 
-		/* Build error response PDU */
-		memcpy(error_pdu, &pending->error, sizeof(pending->error));
+	if (!op || op->id != id)
+		return false;
 
-		/* Clear pending state */
-		chan->pending_db_sync = NULL;
-		free(pending);
+	/* Build error response PDU */
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.opcode = op->opcode;
+	rsp.ecode = BT_ATT_ERROR_DB_OUT_OF_SYNC;
 
-		/* Notify callback with error */
-		if (op->callback)
-			op->callback(BT_ATT_OP_ERROR_RSP, error_pdu,
-				     sizeof(error_pdu), op->user_data);
+	/* Clear pending state */
+	chan->pending_db_sync = NULL;
 
-		destroy_att_send_op(op);
-		wakeup_chan_writer(chan, NULL);
+	/* Notify callback with error */
+	if (op->callback)
+		op->callback(BT_ATT_OP_ERROR_RSP, &rsp, sizeof(rsp),
+						op->user_data);
 
-		return true;
-	}
+	destroy_att_send_op(op);
+	wakeup_chan_writer(chan, NULL);
 
-	return false;
+	return true;
 }
 
 static bool bt_att_disc_cancel(struct bt_att *att, unsigned int id)
-- 
2.52.0

