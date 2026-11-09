Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239109;
	b=bh8rVmqFUBOrwMGbXzZWoSCi7CYt464RJ7kHYXMT5doZC2ihGFnlf+JxmxpG4gosftAh
	 plZzqW2saezXuu/2P+vx3uZzwbAw52LR0apFnLLLOqw2ghUQcTXC9A4KkHA7+PJU0yX0f
	 VlpqyBuq7Tc9iQIzyH+poCuGPDiYCSeygo3dWgiaF14WpOnudQ82OGLynWQ2L8/IuznVP
	 +9Uw4pJ1vz6lAh+Y/YCzvfATKtz6bmV4in/am4GNXqSLFGt4en3kJrMxF+RLdQ734kPir
	 jvcKGY7fkq1+ynl1Jnb9H50SCLevbwDijCHFKAs+DrXLRDiQ6izlmvCTY1aCk0yjZYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239109;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MlW0/4rJ6QoEU1krH5P5es3N1YLDWObeO9TaOJ++Ad0=;
	b=T1rwcUwc/IqYHKPEGjD0b8POgVqD/t9nvR9AoQxQnZhpnNVOZ8igFdMYDfQ4Fs3XpWuW
	 fK4vZQjDmyfx0al9uDnphOtSZUsltxQ5LqZDZUL3cCajEmz6dAD84o6t2XaerEPTVdkjX
	 x5k4YyVFzkdbXrejJJG29lY34xx6d6GH5HOoSU5RoxeEIa31nvyLWKFg8E0Rt4J8LxRsM
	 CmaP0FYdPgS5/B27hVc10947c/8jFLckayeOSyQ6GUL4HBF5Po4K/S9Gbpm3A+MHQbK6T
	 DcMdYSB10xxbfUBa41+u71ID/fgJa9g9m3oz5ESU+bBu3pb43lNpgJD3I33+bh7lVTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCDPHWhS;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD414606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD414606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jCDPHWhS
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7cc603a168fso403455137.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239107; x=1794843907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MlW0/4rJ6QoEU1krH5P5es3N1YLDWObeO9TaOJ++Ad0=;
        b=jCDPHWhSQPL3KIcmEno1K8vVrivxxGmloecNfrGxHXIatzeeFbxJxAMdKgTCjJcX1S
         e7fWshBTAtJ8Fpa7R28wQqXgOWN3zF7aLbfI1SmWdQ2ZWW4BvbXS8BQwdCK3vnZN0cmA
         fwvc1d3WKjT480TS33TF5QLS1rpFAIMLAQhKNoBNdLIi95xJ6atspVn0Q5f5N6PHuilM
         tMqeGI/usYYOXhsWA8+40ckGjWasFiqxw/DMThJuVy/fv9nYCTFyP1G1BNUZ+jiciusM
         kkh2D79lWeNLzyvOjMI0ty7Q4E5rtJGP3JXQAFfPrwtrrJis6ElplPqkbQWOzD8VrMz0
         nJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239107; x=1794843907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MlW0/4rJ6QoEU1krH5P5es3N1YLDWObeO9TaOJ++Ad0=;
        b=J5zh3oIQv0sCbYt83jZxniH50D2z8xeeeZIRPs60XbHVLO1BNlnCNMct4xOSoIKbr1
         Gzsw/ZiwM3HwfoyYr+RVQ9ngO9yr8G9pgcU1eXVFwvtA0x6LoMjaWBFjx+diGC9GvlUJ
         1gT0PJcHLvLsw/bdhIB/b7W8eKoyfmE6VcP9zEIQvNZolIhy7FvvscfKV6KHQZo6FnFw
         lfL4YK1g6MPQAkgXb7KgOOrdb3/QnmxdTjhpIyb4D+xlIomN+Ibv0jthihhvva1oSv1G
         SpGyjtOHAlloPKgVwXCBOB5KU+U2FaOz7fheZCnJm3ISnY44YSlUmAnO0f2ieyWc1ugi
         CzZA==
X-Gm-Message-State: APuU4Z/GOcJq8yJ6xZ4lQuWwz40rIFzeeI0xjBn8F17swy1Efpf4eI6G
	7OeexasC67aos+Ctly/0l96BvvBEnxLBBRK6MjqsjUtw56Qep3wM6tD7u31KNw==
X-Gm-Gg: AYBFou11a7L7SEp1J5u7GQ6xcl4Bv4D568CXQMbYpb+HomovtwOGSUqZC0hDgDsbN5h
	wijTk3r8gDc6LkJk+8lrhhb1XWn5eMUaTzW9lVpfznj7zDzKIsv+B2CR2SLMQ1vHt63RXGdHISg
	2qEKgBS7OYvRaAtyenaGygtsxmZWWKx4WRMWgyGtHqn66LT1+KWx9apDs2hKUYuOyXdMqFaCmUY
	ahCwaKK/rgbx6fyZbt8Nf1FryZR3BHORp4qMq4fPeCXIYj1UYSSzh9MFHFbnUzmmBrx011DbdFd
	N6wkkx4d8ZL/daZalqgYMEJ5glqd+sdeuJh633ZB+pgDZ47nrGAaqkEFJZQS4vNmrpKPHHIWTKy
	PhoRglZwgiCd4Wlbi2rAwFIWvMC22VZaRR4fPps/8GKEt4cDelhPsWsUA/GXxopKTNAowbcJ9FK
	ua7YQdf9nXdkCekIOlt2O4uyv52JI3ODFiCaL5NRluUkBdCUGlSNtdQ5AIvBjKN/1dvET6tOvQ/
	V3fRdAp2MDVPZCekxNax/EDXYW1sVbktf+f/trkNB9M/MEj8DvCFkhaBscgrG8UxCDIgxKA8m1a
	CvJxz7nA5iWUUfE+k3GAyfk0rOfcKJB1GZafIFHGfaLkjHcPhYn2zxbCxEdBhU9yMf5M5WH8/rN
	8/4YdREgNPSCU/K4+duJBR4plLSPpmdcweIw4G5z92OPA33tlT78sSUecP6cTgiQUHXNMMs7fv8
	IyD4I=
X-Received: by 2002:a05:6102:dc6:b0:7c5:4da3:aefd with SMTP id ada2fe7eead31-7d2db05f2bamr1153495137.15.1794239106892;
        Mon, 09 Nov 2026 07:45:06 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:06 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 03/10] shared/gatt-helpers: Use util_iov helpers to build and parse PDUs
Date: Mon,  9 Nov 2026 10:44:54 -0500
Message-ID: <20261109154501.1362649-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Build requests with util_iov_push_* and parse responses with
util_iov_pull_*. The result iterators now check each element against the
stored PDU length and return false for a malformed one rather than
reading past it.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-helpers.c | 452 +++++++++++++++++++++++++-------------
 1 file changed, 296 insertions(+), 156 deletions(-)

diff --git a/src/shared/gatt-helpers.c b/src/shared/gatt-helpers.c
index e3281ec17758..ea77a41ef362 100644
--- a/src/shared/gatt-helpers.c
+++ b/src/shared/gatt-helpers.c
@@ -225,13 +225,37 @@ static struct bt_gatt_result *result_append(uint8_t opcode, const void *pdu,
 	return result;
 }
 
+/* Get the data element at the current position of the iterator */
+static bool iter_elem(struct bt_gatt_iter *iter, struct iovec *elem)
+{
+	struct bt_gatt_result *result = iter->result;
+	struct iovec iov = { result->pdu, result->pdu_len };
+
+	if (!util_iov_pull(&iov, iter->pos))
+		return false;
+
+	elem->iov_base = util_iov_pull_mem(&iov, result->data_len);
+	elem->iov_len = result->data_len;
+
+	return elem->iov_base != NULL;
+}
+
+static void iter_advance(struct bt_gatt_iter *iter)
+{
+	iter->pos += iter->result->data_len;
+	if (iter->pos >= iter->result->pdu_len) {
+		iter->result = iter->result->next;
+		iter->pos = 0;
+	}
+}
+
 bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 				uint16_t *handle, uint16_t *start_handle,
 				uint16_t *end_handle, uint8_t uuid[16])
 {
 	struct bt_gatt_result *read_result;
 	struct bt_gatt_request *op;
-	const void *pdu_ptr;
+	struct iovec elem;
 	int i = 0;
 
 	if (!iter || !iter->result || !handle || !start_handle || !end_handle
@@ -256,28 +280,24 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 	if (iter->result->data_len != 8 && iter->result->data_len != 6)
 		return false;
 
-	pdu_ptr = iter->result->pdu + iter->pos;
+	if (!iter_elem(iter, &elem))
+		return false;
+
+	if (!util_iov_pull_le16(&elem, handle) ||
+			!util_iov_pull_le16(&elem, start_handle) ||
+			!util_iov_pull_le16(&elem, end_handle))
+		return false;
 
 	/* This result contains 16 bit UUID */
 	if (iter->result->data_len == 8) {
-		*handle = get_le16(pdu_ptr);
-		*start_handle = get_le16(pdu_ptr + 2);
-		*end_handle = get_le16(pdu_ptr + 4);
-		convert_uuid_le(pdu_ptr + 6, 2, uuid);
+		if (!convert_uuid_le(elem.iov_base, elem.iov_len, uuid))
+			return false;
 
-		iter->pos += iter->result->data_len;
-
-		if (iter->pos == iter->result->pdu_len) {
-			iter->result = iter->result->next;
-			iter->pos = 0;
-		}
+		iter_advance(iter);
 
 		return true;
 	}
 
-	*handle = get_le16(pdu_ptr);
-	*start_handle = get_le16(pdu_ptr + 2);
-	*end_handle = get_le16(pdu_ptr + 4);
 	read_result = iter->result;
 
 	/*
@@ -295,9 +315,11 @@ bool bt_gatt_iter_next_included_service(struct bt_gatt_iter *iter,
 	if (!read_result)
 		return false;
 
-	convert_uuid_le(read_result->pdu, read_result->data_len, uuid);
+	if (!convert_uuid_le(read_result->pdu, read_result->data_len, uuid))
+		return false;
+
 	iter->pos += iter->result->data_len;
-	if (iter->pos == iter->result->pdu_len) {
+	if (iter->pos >= iter->result->pdu_len) {
 		iter->result = read_result->next;
 		iter->pos = 0;
 	}
@@ -310,25 +332,25 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 				uint8_t uuid[16])
 {
 	struct bt_gatt_request *op;
-	const void *pdu_ptr;
+	struct iovec elem;
 	bt_uuid_t tmp;
 
 	if (!iter || !iter->result || !start_handle || !end_handle || !uuid)
 		return false;
 
 	op = iter->result->op;
-	pdu_ptr = iter->result->pdu + iter->pos;
+
+	if (!iter_elem(iter, &elem) ||
+			!util_iov_pull_le16(&elem, start_handle) ||
+			!util_iov_pull_le16(&elem, end_handle))
+		return false;
 
 	switch (iter->result->opcode) {
 	case BT_ATT_OP_READ_BY_GRP_TYPE_RSP:
-		*start_handle = get_le16(pdu_ptr);
-		*end_handle = get_le16(pdu_ptr + 2);
-		convert_uuid_le(pdu_ptr + 4, iter->result->data_len - 4, uuid);
+		if (!convert_uuid_le(elem.iov_base, elem.iov_len, uuid))
+			return false;
 		break;
 	case BT_ATT_OP_FIND_BY_TYPE_RSP:
-		*start_handle = get_le16(pdu_ptr);
-		*end_handle = get_le16(pdu_ptr + 2);
-
 		bt_uuid_to_uuid128(&op->uuid, &tmp);
 		memcpy(uuid, tmp.value.u128.data, 16);
 		break;
@@ -336,12 +358,7 @@ bool bt_gatt_iter_next_service(struct bt_gatt_iter *iter,
 		return false;
 	}
 
-
-	iter->pos += iter->result->data_len;
-	if (iter->pos == iter->result->pdu_len) {
-		iter->result = iter->result->next;
-		iter->pos = 0;
-	}
+	iter_advance(iter);
 
 	return true;
 }
@@ -352,7 +369,8 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 				uint8_t uuid[16])
 {
 	struct bt_gatt_request *op;
-	const void *pdu_ptr;
+	struct iovec elem;
+	struct iovec next;
 
 	if (!iter || !iter->result || !start_handle || !end_handle ||
 					!value_handle || !properties || !uuid)
@@ -375,25 +393,24 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 	if (iter->result->data_len != 21 && iter->result->data_len != 7)
 		return false;
 
-	pdu_ptr = iter->result->pdu + iter->pos;
-
-	*start_handle = get_le16(pdu_ptr);
-	*properties = ((uint8_t *) pdu_ptr)[2];
-	*value_handle = get_le16(pdu_ptr + 3);
-	convert_uuid_le(pdu_ptr + 5, iter->result->data_len - 5, uuid);
+	if (!iter_elem(iter, &elem) ||
+			!util_iov_pull_le16(&elem, start_handle) ||
+			!util_iov_pull_u8(&elem, properties) ||
+			!util_iov_pull_le16(&elem, value_handle) ||
+			!convert_uuid_le(elem.iov_base, elem.iov_len, uuid))
+		return false;
 
-	iter->pos += iter->result->data_len;
-	if (iter->pos == iter->result->pdu_len) {
-		iter->result = iter->result->next;
-		iter->pos = 0;
-	}
+	iter_advance(iter);
 
 	if (!iter->result) {
 		*end_handle = op->end_handle;
 		return true;
 	}
 
-	*end_handle = get_le16(iter->result->pdu + iter->pos) - 1;
+	if (!iter_elem(iter, &next) || !util_iov_pull_le16(&next, end_handle))
+		return false;
+
+	(*end_handle)--;
 
 	return true;
 }
@@ -401,7 +418,7 @@ bool bt_gatt_iter_next_characteristic(struct bt_gatt_iter *iter,
 bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
 							uint8_t uuid[16])
 {
-	const void *pdu_ptr;
+	struct iovec elem;
 
 	if (!iter || !iter->result || !handle || !uuid)
 		return false;
@@ -409,16 +426,11 @@ bool bt_gatt_iter_next_descriptor(struct bt_gatt_iter *iter, uint16_t *handle,
 	if (iter->result->opcode != BT_ATT_OP_FIND_INFO_RSP)
 		return false;
 
-	pdu_ptr = iter->result->pdu + iter->pos;
-
-	*handle = get_le16(pdu_ptr);
-	convert_uuid_le(pdu_ptr + 2, iter->result->data_len - 2, uuid);
+	if (!iter_elem(iter, &elem) || !util_iov_pull_le16(&elem, handle) ||
+			!convert_uuid_le(elem.iov_base, elem.iov_len, uuid))
+		return false;
 
-	iter->pos += iter->result->data_len;
-	if (iter->pos == iter->result->pdu_len) {
-		iter->result = iter->result->next;
-		iter->pos = 0;
-	}
+	iter_advance(iter);
 
 	return true;
 }
@@ -428,7 +440,7 @@ bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
 				const uint8_t **value)
 {
 	struct bt_gatt_request *op;
-	const void *pdu_ptr;
+	struct iovec elem;
 
 	if (!iter || !iter->result || !handle || !length || !value)
 		return false;
@@ -444,17 +456,13 @@ bool bt_gatt_iter_next_read_by_type(struct bt_gatt_iter *iter,
 	if (op->uuid.type == BT_UUID_UNSPEC)
 		return false;
 
-	pdu_ptr = iter->result->pdu + iter->pos;
+	if (!iter_elem(iter, &elem) || !util_iov_pull_le16(&elem, handle))
+		return false;
 
-	*handle = get_le16(pdu_ptr);
-	*length = iter->result->data_len - 2;
-	*value = pdu_ptr + 2;
+	*length = elem.iov_len;
+	*value = elem.iov_base;
 
-	iter->pos += iter->result->data_len;
-	if (iter->pos == iter->result->pdu_len) {
-		iter->result = iter->result->next;
-		iter->pos = 0;
-	}
+	iter_advance(iter);
 
 	return true;
 }
@@ -495,6 +503,7 @@ static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	struct mtu_op *op = user_data;
 	bool success = true;
 	uint8_t att_ecode = 0;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t server_rx_mtu;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
@@ -503,12 +512,13 @@ static void mtu_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		goto done;
 	}
 
-	if (opcode != BT_ATT_OP_MTU_RSP || !pdu || length != 2) {
+	if (opcode != BT_ATT_OP_MTU_RSP || !pdu ||
+			!util_iov_pull_le16(&iov, &server_rx_mtu) ||
+			iov.iov_len) {
 		success = false;
 		goto done;
 	}
 
-	server_rx_mtu = get_le16(pdu);
 	bt_att_set_mtu(op->att, MIN(op->client_rx_mtu, server_rx_mtu));
 
 done:
@@ -523,6 +533,7 @@ unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 {
 	struct mtu_op *op;
 	uint8_t pdu[2];
+	struct iovec req = { pdu, 0 };
 	unsigned int id;
 
 	if (!att || !client_rx_mtu)
@@ -535,10 +546,10 @@ unsigned int bt_gatt_exchange_mtu(struct bt_att *att, uint16_t client_rx_mtu,
 	op->user_data = user_data;
 	op->destroy = destroy;
 
-	put_le16(client_rx_mtu, pdu);
+	util_iov_push_le16(&req, client_rx_mtu);
 
-	id = bt_att_send(att, BT_ATT_OP_MTU_REQ, pdu, sizeof(pdu), mtu_cb, op,
-								destroy_mtu_op);
+	id = bt_att_send(att, BT_ATT_OP_MTU_REQ, req.iov_base, req.iov_len,
+						mtu_cb, op, destroy_mtu_op);
 	if (!id)
 		free(op);
 
@@ -553,6 +564,59 @@ static inline int get_uuid_len(const bt_uuid_t *uuid)
 	return (uuid->type == BT_UUID16) ? 2 : 16;
 }
 
+static bool pull_data_length(struct iovec *iov, size_t *data_length)
+{
+	uint8_t len;
+
+	if (!util_iov_pull_u8(iov, &len))
+		return false;
+
+	*data_length = len;
+
+	return true;
+}
+
+static bool push_uuid_le(struct iovec *iov, const bt_uuid_t *uuid)
+{
+	void *data = util_iov_push(iov, get_uuid_len(uuid));
+
+	if (!data)
+		return false;
+
+	bt_uuid_to_le(uuid, data);
+
+	return true;
+}
+
+/*
+ * Pull a le16 located skip octets into the last data_length sized element of
+ * a list of data_length sized elements.
+ */
+static bool pull_last_le16(const void *list, size_t length, size_t data_length,
+					size_t skip, uint16_t *val)
+{
+	struct iovec iov = { (void *)list, length };
+
+	if (length < data_length)
+		return false;
+
+	return util_iov_pull(&iov, length - data_length + skip) &&
+			util_iov_pull_le16(&iov, val);
+}
+
+/* Push the le16 located at pos + 2 in the result into a Read Request */
+static bool push_included_handle(struct iovec *req,
+					const struct bt_gatt_result *result,
+					size_t pos)
+{
+	struct iovec iov = { result->pdu, result->pdu_len };
+	uint16_t handle;
+
+	return util_iov_pull(&iov, pos + 2) &&
+			util_iov_pull_le16(&iov, &handle) &&
+			util_iov_push_le16(req, handle);
+}
+
 struct bt_gatt_request *bt_gatt_request_ref(struct bt_gatt_request *req)
 {
 	if (!req)
@@ -621,12 +685,12 @@ static void discovery_op_complete(struct bt_gatt_request *op, bool success,
 static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
+	struct iovec iov = { (void *)pdu, length };
 	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
 	struct bt_gatt_result *cur_result;
 	size_t data_length;
-	size_t list_length;
 	uint16_t last_end;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
@@ -647,11 +711,13 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	data_length = ((uint8_t *) pdu)[0];
-	list_length = length - 1;
+	if (!pull_data_length(&iov, &data_length)) {
+		success = false;
+		goto done;
+	}
 
 	if ((data_length != 6 && data_length != 20) ||
-					(list_length % data_length)) {
+					(iov.iov_len % data_length)) {
 		success = false;
 		goto done;
 	}
@@ -659,14 +725,17 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	/* PDU is correctly formatted. Get the last end handle to process the
 	 * next request and store the PDU.
 	 */
-	cur_result = result_append(opcode, pdu + 1, list_length, data_length,
-									op);
+	cur_result = result_append(opcode, iov.iov_base, iov.iov_len,
+							data_length, op);
 	if (!cur_result) {
 		success = false;
 		goto done;
 	}
 
-	last_end = get_le16(pdu + length - data_length + 2);
+	if (!pull_last_le16(pdu, length, data_length, 2, &last_end)) {
+		success = false;
+		goto done;
+	}
 
 	/*
 	 * If last handle is lower from previous start handle then it is smth
@@ -681,13 +750,14 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		put_le16(op->service_type, pdu + 4);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
+		util_iov_push_le16(&req, op->service_type);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						read_by_grp_type_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -703,9 +773,17 @@ static void read_by_grp_type_cb(uint8_t opcode, const void *pdu,
 	 * Manually set the end group handle that we report in the result to the
 	 * end handle in the original request.
 	 */
-	if (last_end == 0xffff && last_end != op->end_handle)
-		put_le16(op->end_handle,
-				cur_result->pdu + length - data_length + 1);
+	if (last_end == 0xffff && last_end != op->end_handle) {
+		struct iovec end = { cur_result->pdu, cur_result->pdu_len };
+		void *p;
+
+		if (util_iov_pull(&end, cur_result->pdu_len -
+						data_length + 2)) {
+			p = util_iov_pull_mem(&end, 2);
+			if (p)
+				put_le16(op->end_handle, p);
+		}
+	}
 
 	success = true;
 
@@ -747,7 +825,10 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 	 * 2 octets with end handle
 	 * last_end is end handle of last data set
 	 */
-	last_end = get_le16(pdu + length - 2);
+	if (!pull_last_le16(pdu, length, 4, 2, &last_end)) {
+		success = false;
+		goto done;
+	}
 
 	/*
 	* If last handle is lower from previous start handle then it is smth
@@ -762,14 +843,15 @@ static void find_by_type_val_cb(uint8_t opcode, const void *pdu,
 
 	if (last_end < op->end_handle) {
 		uint8_t pdu[6 + get_uuid_len(&op->uuid)];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		put_le16(op->service_type, pdu + 4);
-		bt_uuid_to_le(&op->uuid, pdu + 6);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
+		util_iov_push_le16(&req, op->service_type);
+		push_uuid_le(&req, &op->uuid);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						find_by_type_val_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -828,18 +910,20 @@ static struct bt_gatt_request *discover_services(struct bt_att *att,
 	/* If UUID is NULL, then discover all primary services */
 	if (!uuid) {
 		uint8_t pdu[6];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(start, pdu);
-		put_le16(end, pdu + 2);
-		put_le16(op->service_type, pdu + 4);
+		util_iov_push_le16(&req, start);
+		util_iov_push_le16(&req, end);
+		util_iov_push_le16(&req, op->service_type);
 
 		op->id = bt_att_send(att, BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						read_by_grp_type_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
 	} else {
 		uint8_t pdu[6 + get_uuid_len(uuid)];
+		struct iovec req = { pdu, 0 };
 
 		if (uuid->type == BT_UUID_UNSPEC) {
 			free(op);
@@ -849,13 +933,13 @@ static struct bt_gatt_request *discover_services(struct bt_att *att,
 		/* Discover by UUID */
 		op->uuid = *uuid;
 
-		put_le16(start, pdu);
-		put_le16(end, pdu + 2);
-		put_le16(op->service_type, pdu + 4);
-		bt_uuid_to_le(&op->uuid, pdu + 6);
+		util_iov_push_le16(&req, start);
+		util_iov_push_le16(&req, end);
+		util_iov_push_le16(&req, op->service_type);
+		push_uuid_le(&req, &op->uuid);
 
 		op->id = bt_att_send(att, BT_ATT_OP_FIND_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						find_by_type_val_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -949,6 +1033,7 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 	struct bt_gatt_request *op = data->op;
 	uint8_t att_ecode = 0;
 	uint8_t read_pdu[2];
+	struct iovec read_req = { read_pdu, 0 };
 	bool success;
 
 	if (opcode == BT_ATT_OP_ERROR_RSP) {
@@ -979,20 +1064,26 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 	if (data->pos == data->result->pdu_len) {
 		uint16_t last_handle;
 		uint8_t pdu[6];
+		struct iovec req = { pdu, 0 };
+
+		if (!pull_last_le16(data->result->pdu, data->pos,
+					data->result->data_len, 0,
+					&last_handle)) {
+			success = false;
+			goto done;
+		}
 
-		last_handle = get_le16(data->result->pdu + data->pos -
-							data->result->data_len);
 		if (last_handle == op->end_handle) {
 			success = true;
 			goto done;
 		}
 
-		put_le16(last_handle + 1, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		put_le16(GATT_INCLUDE_UUID, pdu + 4);
+		util_iov_push_le16(&req, last_handle + 1);
+		util_iov_push_le16(&req, op->end_handle);
+		util_iov_push_le16(&req, GATT_INCLUDE_UUID);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						discover_included_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1003,11 +1094,15 @@ static void read_included_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	memcpy(read_pdu, data->result->pdu + data->pos + 2, sizeof(uint16_t));
+	if (!push_included_handle(&read_req, data->result, data->pos)) {
+		success = false;
+		goto done;
+	}
 
 	data->pos += data->result->data_len;
 
-	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, read_pdu, sizeof(read_pdu),
+	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, read_req.iov_base,
+				read_req.iov_len,
 				read_included_cb, read_included_ref(data),
 				read_included_unref))
 		return;
@@ -1023,17 +1118,20 @@ static void read_included(struct read_incl_data *data)
 {
 	struct bt_gatt_request *op = data->op;
 	uint8_t pdu[2];
+	struct iovec req = { pdu, 0 };
 
-	memcpy(pdu, data->result->pdu + 2, sizeof(uint16_t));
+	if (!push_included_handle(&req, data->result, 0))
+		goto failed;
 
 	data->pos += data->result->data_len;
 
-	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, pdu, sizeof(pdu),
+	if (bt_att_send(op->att, BT_ATT_OP_READ_REQ, req.iov_base, req.iov_len,
 							read_included_cb,
 							read_included_ref(data),
 							read_included_unref))
 		return;
 
+failed:
 	if (op->callback)
 		op->callback(false, 0, NULL, data->op->user_data);
 
@@ -1043,6 +1141,7 @@ static void read_included(struct read_incl_data *data)
 static void discover_included_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
+	struct iovec iov = { (void *)pdu, length };
 	struct bt_gatt_request *op = user_data;
 	struct bt_gatt_result *cur_result;
 	uint8_t att_ecode = 0;
@@ -1061,7 +1160,10 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		goto failed;
 	}
 
-	data_length = ((const uint8_t *) pdu)[0];
+	if (!pull_data_length(&iov, &data_length)) {
+		success = false;
+		goto failed;
+	}
 
 	/*
 	 * Check if PDU contains data sets with length declared in the beginning
@@ -1073,13 +1175,13 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 	 * optional 2 octets - Bluetooth UUID of included service
 	 */
 	if ((data_length != 8 && data_length != 6) ||
-						(length - 1) % data_length) {
+						iov.iov_len % data_length) {
 		success = false;
 		goto failed;
 	}
 
-	cur_result = result_append(opcode, pdu + 1, length - 1, data_length,
-									op);
+	cur_result = result_append(opcode, iov.iov_base, iov.iov_len,
+							data_length, op);
 	if (!cur_result) {
 		success = false;
 		goto failed;
@@ -1098,7 +1200,10 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 		return;
 	}
 
-	last_handle = get_le16(pdu + length - data_length);
+	if (!pull_last_le16(pdu, length, data_length, 0, &last_handle)) {
+		success = false;
+		goto failed;
+	}
 
 	/*
 	 * If last handle is lower from previous start handle then it is smth
@@ -1112,13 +1217,14 @@ static void discover_included_cb(uint8_t opcode, const void *pdu,
 	op->start_handle = last_handle + 1;
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[6];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		put_le16(GATT_INCLUDE_UUID, pdu + 4);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
+		util_iov_push_le16(&req, GATT_INCLUDE_UUID);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						discover_included_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1143,6 +1249,7 @@ struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 {
 	struct bt_gatt_request *op;
 	uint8_t pdu[6];
+	struct iovec req = { pdu, 0 };
 
 	if (!att)
 		return NULL;
@@ -1155,11 +1262,12 @@ struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 	op->start_handle = start;
 	op->end_handle = end;
 
-	put_le16(start, pdu);
-	put_le16(end, pdu + 2);
-	put_le16(GATT_INCLUDE_UUID, pdu + 4);
+	util_iov_push_le16(&req, start);
+	util_iov_push_le16(&req, end);
+	util_iov_push_le16(&req, GATT_INCLUDE_UUID);
 
-	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
+	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
+				req.iov_base, req.iov_len,
 				discover_included_cb, bt_gatt_request_ref(op),
 				async_req_unref);
 	if (!op->id) {
@@ -1173,6 +1281,7 @@ struct bt_gatt_request *bt_gatt_discover_included_services(struct bt_att *att,
 static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
+	struct iovec iov = { (void *)pdu, length };
 	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
@@ -1198,20 +1307,26 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	data_length = ((uint8_t *) pdu)[0];
+	if (!pull_data_length(&iov, &data_length)) {
+		success = false;
+		goto done;
+	}
 
 	if ((data_length != 7 && data_length != 21) ||
-					((length - 1) % data_length)) {
+					(iov.iov_len % data_length)) {
 		success = false;
 		goto done;
 	}
 
-	if (!result_append(opcode, pdu + 1, length - 1,
+	if (!result_append(opcode, iov.iov_base, iov.iov_len,
 							data_length, op)) {
 		success = false;
 		goto done;
 	}
-	last_handle = get_le16(pdu + length - data_length);
+	if (!pull_last_le16(pdu, length, data_length, 0, &last_handle)) {
+		success = false;
+		goto done;
+	}
 
 	/*
 	 * If last handle is lower from previous start handle then it is smth
@@ -1226,13 +1341,14 @@ static void discover_chrcs_cb(uint8_t opcode, const void *pdu,
 
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[6];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		put_le16(GATT_CHARAC_UUID, pdu + 4);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
+		util_iov_push_le16(&req, GATT_CHARAC_UUID);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						discover_chrcs_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1257,6 +1373,7 @@ struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 {
 	struct bt_gatt_request *op;
 	uint8_t pdu[6];
+	struct iovec req = { pdu, 0 };
 
 	if (!att)
 		return NULL;
@@ -1269,11 +1386,12 @@ struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 	op->start_handle = start;
 	op->end_handle = end;
 
-	put_le16(start, pdu);
-	put_le16(end, pdu + 2);
-	put_le16(GATT_CHARAC_UUID, pdu + 4);
+	util_iov_push_le16(&req, start);
+	util_iov_push_le16(&req, end);
+	util_iov_push_le16(&req, GATT_CHARAC_UUID);
 
-	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
+	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
+				req.iov_base, req.iov_len,
 				discover_chrcs_cb, bt_gatt_request_ref(op),
 				async_req_unref);
 	if (!op->id) {
@@ -1287,6 +1405,7 @@ struct bt_gatt_request *bt_gatt_discover_characteristics(struct bt_att *att,
 static void read_by_type_cb(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data)
 {
+	struct iovec iov = { (void *)pdu, length };
 	struct bt_gatt_request *op = user_data;
 	bool success;
 	uint8_t att_ecode = 0;
@@ -1305,21 +1424,28 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	data_length = ((const uint8_t *) pdu)[0];
-	if (data_length < 2 || data_length > length - 1U ||
-					(length - 1) % data_length) {
+	if (!pull_data_length(&iov, &data_length)) {
+		success = false;
+		goto done;
+	}
+	if (data_length < 2 || data_length > iov.iov_len ||
+					iov.iov_len % data_length) {
 		success = false;
 		att_ecode = 0;
 		goto done;
 	}
 
-	if (!result_append(opcode, pdu + 1, length - 1, data_length, op)) {
+	if (!result_append(opcode, iov.iov_base, iov.iov_len, data_length,
+									op)) {
 		success = false;
 		att_ecode = 0;
 		goto done;
 	}
 
-	last_handle = get_le16(pdu + length - data_length);
+	if (!pull_last_le16(pdu, length, data_length, 0, &last_handle)) {
+		success = false;
+		goto done;
+	}
 
 	/*
 	 * If last handle is lower from previous start handle then it is smth
@@ -1334,13 +1460,14 @@ static void read_by_type_cb(uint8_t opcode, const void *pdu,
 
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[4 + get_uuid_len(&op->uuid)];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
-		bt_uuid_to_le(&op->uuid, pdu + 4);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
+		push_uuid_le(&req, &op->uuid);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_READ_BY_TYPE_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						read_by_type_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1365,6 +1492,7 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 {
 	struct bt_gatt_request *op;
 	uint8_t pdu[4 + get_uuid_len(uuid)];
+	struct iovec req = { pdu, 0 };
 
 	if (!att || !uuid || uuid->type == BT_UUID_UNSPEC)
 		return false;
@@ -1378,11 +1506,12 @@ bool bt_gatt_read_by_type(struct bt_att *att, uint16_t start, uint16_t end,
 	op->end_handle = end;
 	op->uuid = *uuid;
 
-	put_le16(start, pdu);
-	put_le16(end, pdu + 2);
-	bt_uuid_to_le(uuid, pdu + 4);
+	util_iov_push_le16(&req, start);
+	util_iov_push_le16(&req, end);
+	push_uuid_le(&req, uuid);
 
-	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ, pdu, sizeof(pdu),
+	op->id = bt_att_send(att, BT_ATT_OP_READ_BY_TYPE_REQ,
+						req.iov_base, req.iov_len,
 						read_by_type_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1400,6 +1529,7 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 	bool success;
 	uint8_t att_ecode = 0;
 	uint8_t format;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t last_handle;
 	size_t data_length;
 
@@ -1420,7 +1550,10 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	format = ((uint8_t *) pdu)[0];
+	if (!util_iov_pull_u8(&iov, &format)) {
+		success = false;
+		goto done;
+	}
 
 	if (format == 0x01)
 		data_length = 4;
@@ -1431,17 +1564,21 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 		goto done;
 	}
 
-	if ((length - 1) % data_length) {
+	if (iov.iov_len % data_length) {
 		success = false;
 		goto done;
 	}
 
-	if (!result_append(opcode, pdu + 1, length - 1, data_length, op)) {
+	if (!result_append(opcode, iov.iov_base, iov.iov_len, data_length,
+									op)) {
 		success = false;
 		goto done;
 	}
 
-	last_handle = get_le16(pdu + length - data_length);
+	if (!pull_last_le16(pdu, length, data_length, 0, &last_handle)) {
+		success = false;
+		goto done;
+	}
 
 	/*
 	 * If last handle is lower from previous start handle then it is smth
@@ -1456,12 +1593,13 @@ static void discover_descs_cb(uint8_t opcode, const void *pdu,
 
 	if (last_handle != op->end_handle) {
 		uint8_t pdu[4];
+		struct iovec req = { pdu, 0 };
 
-		put_le16(op->start_handle, pdu);
-		put_le16(op->end_handle, pdu + 2);
+		util_iov_push_le16(&req, op->start_handle);
+		util_iov_push_le16(&req, op->end_handle);
 
 		op->id = bt_att_send(op->att, BT_ATT_OP_FIND_INFO_REQ,
-						pdu, sizeof(pdu),
+						req.iov_base, req.iov_len,
 						discover_descs_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
@@ -1486,6 +1624,7 @@ struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 {
 	struct bt_gatt_request *op;
 	uint8_t pdu[4];
+	struct iovec req = { pdu, 0 };
 
 	if (!att)
 		return NULL;
@@ -1498,10 +1637,11 @@ struct bt_gatt_request *bt_gatt_discover_descriptors(struct bt_att *att,
 	op->start_handle = start;
 	op->end_handle = end;
 
-	put_le16(start, pdu);
-	put_le16(end, pdu + 2);
+	util_iov_push_le16(&req, start);
+	util_iov_push_le16(&req, end);
 
-	op->id = bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ, pdu, sizeof(pdu),
+	op->id = bt_att_send(att, BT_ATT_OP_FIND_INFO_REQ,
+						req.iov_base, req.iov_len,
 						discover_descs_cb,
 						bt_gatt_request_ref(op),
 						async_req_unref);
-- 
2.56.0

