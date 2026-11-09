Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239113;
	b=i99FwFSKstLfJ5cA7JjAWQliX1Hu9Ihtpf3wyMQbv+uEhBJjPBt3Rv2Ube1GUhxLD/EO
	 n8V/rkjIuttbG6I51+rIug0Lc++OfWGTaiYde5ZTl64/7nU0vpvCEgF8uH3ozhR6ZVLFn
	 VVmOCEKFk957WunAF8ZCviZaRIzwfScw0CpfRWIJqZvi9KaUFPmBSQzDoX2VGGmzuuIiN
	 iEMJQ/jXbPKVC7XRnI5v3f67SXk1Pm7ltxfodrPwAmHix+3kTC1o9QWD3Y202jJRmMEgE
	 k+faIVd0eNrjwN+7A3ye2nuFERbHWBKt3rSQbUp4IvL22fq7N8S0Zcxg8OhfSvfpNIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239113;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QEpRny9abkUdRcf2IS3P9r8xTlSM+9EzN1No3ArnrL4=;
	b=cSrJxUZDdxRxgU+vVdvPGgdxvjfZTXF7ahUpKg5FRJRlCktFRzyt3hDWTClhXMODzZKN
	 8/GaTPkb+levVX/fxcASHQCdhHVSb3gRRIHn9K8OnD3c62j11IoB1lLqz90MvjO0xXuRW
	 E9TwBx9ntIvB3LmYAZtL2dIK6sLgve3l27rzGBjJWJEAfQjWJ3VdUvP2oZJoxsexFsCHw
	 /6t94zzN8bjcUnOwLbbZ1d8x/y/9UsgxC16Zgozy/qOagSk9L+wUuUDHv2FgN4lEtflTz
	 PCt5nTZwq9AY71qkCrku3yI7lZWjlE/QJZKzh9HkG9Bh5ximMRuMWchPCD0Bs8k0s4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcUoTRnA;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA796082BC2
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EA796082BC2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PcUoTRnA
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2b25786d9so478569137.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239106; x=1794843906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=QEpRny9abkUdRcf2IS3P9r8xTlSM+9EzN1No3ArnrL4=;
        b=PcUoTRnAydVsPvY23LR+KhA+uo4d3CSslwhnPE6vmeJCEHdJ8NfpsOelxTNTpWKn1c
         HbSFrn6UI1syrfV7suzb19FC59HtGQFV9YyCL57h2EbPoXBOqSscNCZfRA2K7xgO4WpI
         7FvkUmiXJcJSklz8nSN4GqmEG2qX/2phwyqWlFzod90P/OHV7tJboXKA3SfxgNwhd2Hd
         iwHrHE8iofGwoVv9vKy0vJbWyceFejTtO/WrAvyybj8/HM9AZWb4VH1PVDu2UaFd4tcG
         21mcoeMQ+PQ1nX6Zvy1cR3QtY0y5N8yuy2r8iu1/4DeVo02eio/Za3qLVb7+7v+c10MD
         sMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239106; x=1794843906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=QEpRny9abkUdRcf2IS3P9r8xTlSM+9EzN1No3ArnrL4=;
        b=lTiFKEtDEB2uc1HqFj+sMfsHs06T3JlKOzrFX75M5B3H8yRluFnOnMLKce60xKOSUE
         3ueFQh5I76nihNbyJ8Hv78F117SAf+wBhdVAfLxN+58vN04HEecMPrmFOv91yKHWUfeM
         CNayeAENms+3vRK/l3StliR2Goiwk4sNF+9r7Mw7GgBl8w9UqI8ELm6E+VEkmyqDcviI
         Urjy/UDkc7iY78J5EqoiVV7AcU2YJHQeeX7QJNnYS68pIqQNyWuWsJyTer8Kb+qHJgxz
         dSwcFx9drYRvf+pDUroV7/JrZmkFjSW3HPgxGKkaefoEwzaRMpHqNKVTg+aMzezVsRr5
         gprQ==
X-Gm-Message-State: APuU4Z+2uhLpbaS7RSDdFy/WAQe5FlZMAz9e9/Bp/51dmSOqCCZoBwnj
	ozdvPgnFoukYxihDlm6yU6AvQj0E+OtAY2Oi+/NkjBY7uCJTMSMdCo9vJRzsmA==
X-Gm-Gg: AYBFou1qwA4+kWOMiL4Q4eTOub0AwI7hiXO8D7H24ICnPs1W9vF0SF1QQn4tCptk5FD
	3ZZQmWBsCW9xC9/WrI3yuAvQPj1Vu4Rb2RKjEw4odBxJ1PszRzjxKYKVcrYCjN0cnsga0ZsJ5nc
	h1Hy/GkvwN6iULrcD91pQoBHV0lGfctputLDHO370MtjQT+U7dndtsajzb2ND4qcExMT6kbjIFl
	YRC9hsuDGxAjvQXHnhff/QJNGeqM0RTDG0M1m/JbonHOivk4UiuKkTw0QpXeS52M+R+zupKJuiH
	s27XL7buZXT1IBMBDoYK1xermm9+HO7pSeaJvSbnSt+zCw8ZqdXU/jCsqfxSTNA3R/m6GpsiQf9
	cDIKtPv6TyQrD81nlJUmXyQ73nrhEBoXOkXtG91dL7drLjY0dYEb1BfMI1aEG4+p/ffh8hv0llV
	frWKxbx2Imk6c9JwXNmLCEQPkt+FGFcx3Vwd1IiogeYpCM3uncXnD1QzowUJp6aWIJNRblt8jwr
	EtTtkZoj1g4imht6K2NqrD9A6PsShpC9e9zLzr0oN/ds4gzjFWeO/elzW/ppDDIyew19szI/mGY
	vwOxQtpL3L9Ys7zYTGBPoJZUSBizNEqI84axuuFm5xIb3E6BZ0PIy4CB3nJ0sa4/uVp7jWxt5+M
	3BR+u3fndT5hiUJtIPUxYTX/DCWh3cDXpwwzmfh9f9VQz7stCDvztMj4CIYyB5baTs/OCGWvCc3
	YgAgA=
X-Received: by 2002:a05:6102:441d:b0:7cc:226a:f977 with SMTP id ada2fe7eead31-7d2db217582mr1434685137.36.1794239105887;
        Mon, 09 Nov 2026 07:45:05 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 02/10] shared/gatt-server: Use util_iov helpers to build and parse PDUs
Date: Mon,  9 Nov 2026 10:44:53 -0500
Message-ID: <20261109154501.1362649-3-luiz.dentz@gmail.com>
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

Parse requests with util_iov_pull_* and build responses with
util_iov_push_* instead of get_le16/put_le16/memcpy on pdu offsets, so
a short request is rejected with Invalid PDU by the pull itself.

Notification buffering and indication encoding now also fail instead of
using an unchecked allocation.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-server.c | 373 +++++++++++++++++++--------------------
 1 file changed, 185 insertions(+), 188 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 15944bd1478f..6796817bf324 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -43,8 +43,7 @@ struct async_read_op {
 	uint8_t opcode;
 	bool done;
 	uint16_t mtu;
-	uint8_t *pdu;
-	size_t pdu_len;
+	struct iovec rsp;
 	size_t value_len;
 	struct queue *db_data;
 };
@@ -75,8 +74,7 @@ static void prep_write_data_destroy(void *user_data)
 
 struct mnotify_data {
 	unsigned int id;
-	uint8_t *pdu;
-	uint16_t offset;
+	struct iovec pdu;
 	uint16_t len;
 };
 
@@ -126,7 +124,7 @@ static void mnotify_free(struct bt_gatt_server *server)
 	if (server->mnotify->id)
 		timeout_remove(server->mnotify->id);
 
-	free(server->mnotify->pdu);
+	free(server->mnotify->pdu.iov_base);
 	free(server->mnotify);
 	server->mnotify = NULL;
 }
@@ -160,23 +158,37 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	free(server);
 }
 
-static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
+/* Pull a 16 or 128 bits UUID taking all the remaining data in iov */
+static bool pull_uuid_le(struct iovec *iov, bt_uuid_t *out_uuid)
 {
 	uint128_t u128;
+	uint16_t u16;
+	void *data;
 
-	switch (len) {
+	switch (iov->iov_len) {
 	case 2:
-		bt_uuid16_create(out_uuid, get_le16(uuid));
+		if (!util_iov_pull_le16(iov, &u16))
+			return false;
+
+		bt_uuid16_create(out_uuid, u16);
 		return true;
 	case 16:
-		bswap_128(uuid, &u128.data);
+		data = util_iov_pull_mem(iov, 16);
+		if (!data)
+			return false;
+
+		bswap_128(data, &u128.data);
 		bt_uuid128_create(out_uuid, u128);
 		return true;
 	default:
 		return false;
 	}
+}
 
-	return false;
+/* Remaining space in a response, where cap excludes the opcode */
+static size_t rsp_room(const struct iovec *rsp, size_t cap)
+{
+	return rsp->iov_len < cap ? cap - rsp->iov_len : 0;
 }
 
 static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
@@ -191,15 +203,12 @@ static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
 
 static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 						struct bt_att *att,
-						uint16_t mtu, uint8_t *pdu,
-						uint16_t *len)
+						uint16_t mtu,
+						struct iovec *rsp)
 {
-	int iter = 0;
 	uint16_t start_handle, end_handle;
 	struct iovec value;
-	uint8_t data_val_len;
-
-	*len = 0;
+	uint8_t data_val_len = 0;
 
 	while (queue_peek_head(q)) {
 		struct gatt_db_attribute *attrib = queue_pop_head(q);
@@ -222,30 +231,25 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 * attribute data unit. Stop the list when a different attribute
 		 * value is seen.
 		 */
-		if (iter == 0) {
+		if (!rsp->iov_len) {
 			data_val_len = MIN(MIN((unsigned int)mtu - 6, 251),
 								value.iov_len);
-			pdu[0] = data_val_len + 4;
-			iter++;
+			util_iov_push_u8(rsp, data_val_len + 4);
 		} else if (value.iov_len != data_val_len)
 			break;
 
 		/* Stop if this unit would surpass the MTU */
-		if (iter + data_val_len + 4 > mtu - 1)
+		if (rsp_room(rsp, mtu - 1) < (size_t)data_val_len + 4)
 			break;
 
 		gatt_db_attribute_get_service_handles(attrib, &start_handle,
 								&end_handle);
 
-		put_le16(start_handle, pdu + iter);
-		put_le16(end_handle, pdu + iter + 2);
-		memcpy(pdu + iter + 4, value.iov_base, data_val_len);
-
-		iter += data_val_len + 4;
+		util_iov_push_le16(rsp, start_handle);
+		util_iov_push_le16(rsp, end_handle);
+		util_iov_push_mem(rsp, data_val_len, value.iov_base);
 	}
 
-	*len = iter;
-
 	return true;
 }
 
@@ -269,23 +273,21 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 	uint16_t start, end;
 	bt_uuid_t type;
 	bt_uuid_t prim, snd;
-	uint8_t *rsp_pdu = NULL;
-	uint16_t rsp_len;
+	struct iovec iov = { (void *)pdu, length };
+	struct iovec rsp = {};
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
 	struct queue *q = NULL;
 
-	if (length != 6 && length != 20) {
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end) ||
+			!pull_uuid_le(&iov, &type)) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
 	q = queue_new();
 
-	start = get_le16(pdu);
-	end = get_le16(pdu + 2);
-	get_uuid_le(pdu + 4, length - 4, &type);
-
 	DBG(server, "Read By Grp Type - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
@@ -320,14 +322,14 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}
 
-	rsp_pdu = malloc(mtu);
-	if (!rsp_pdu) {
+	rsp.iov_base = malloc(mtu);
+	if (!rsp.iov_base) {
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
 	if (!encode_read_by_grp_type_rsp(server->db, q, server->att, mtu,
-							rsp_pdu, &rsp_len)) {
+								&rsp)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
 	}
@@ -335,23 +337,23 @@ static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 	queue_destroy(q, NULL);
 
 	bt_att_chan_send_rsp(chan, BT_ATT_OP_READ_BY_GRP_TYPE_RSP,
-						rsp_pdu, rsp_len);
+					rsp.iov_base, rsp.iov_len);
 
-	free(rsp_pdu);
+	free(rsp.iov_base);
 
 	return;
 
 error:
 	queue_destroy(q, NULL);
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
-	free(rsp_pdu);
+	free(rsp.iov_base);
 }
 
 static void async_read_op_destroy(struct async_read_op *op)
 {
 	bt_gatt_server_unref(op->server);
 	queue_destroy(op->db_data, NULL);
-	free(op->pdu);
+	free(op->rsp.iov_base);
 	free(op);
 }
 
@@ -374,28 +376,25 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 		return;
 	}
 
-	if (op->pdu_len == 0) {
+	if (!op->rsp.iov_len) {
 		op->value_len = MIN(MIN((unsigned int)op->mtu - 4, 253), len);
-		op->pdu[0] = op->value_len + 2;
-		op->pdu_len++;
+		util_iov_push_u8(&op->rsp, op->value_len + 2);
 	} else if (len != op->value_len) {
 		op->done = true;
 		goto done;
 	}
 
 	/* Stop if this would surpass the MTU */
-	if (op->pdu_len + op->value_len + 2 > (unsigned int) op->mtu - 1) {
+	if (rsp_room(&op->rsp, op->mtu - 1) < op->value_len + 2) {
 		op->done = true;
 		goto done;
 	}
 
 	/* Encode the current value */
-	put_le16(handle, op->pdu + op->pdu_len);
-	memcpy(op->pdu + op->pdu_len + 2, value, op->value_len);
-
-	op->pdu_len += op->value_len + 2;
+	util_iov_push_le16(&op->rsp, handle);
+	util_iov_push_mem(&op->rsp, op->value_len, value);
 
-	if (op->pdu_len == (unsigned int) op->mtu - 1)
+	if (op->rsp.iov_len == (unsigned int) op->mtu - 1)
 		op->done = true;
 
 done:
@@ -473,7 +472,7 @@ static void process_read_by_type(struct async_read_op *op)
 
 	if (op->done || !attr) {
 		bt_att_chan_send_rsp(op->chan, BT_ATT_OP_READ_BY_TYPE_RSP,
-						op->pdu, op->pdu_len);
+					op->rsp.iov_base, op->rsp.iov_len);
 		async_read_op_destroy(op);
 		return;
 	}
@@ -501,22 +500,21 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
 	bt_uuid_t type;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t ehandle = 0;
 	uint8_t ecode;
 	struct queue *q = NULL;
 	struct async_read_op *op;
 
-	if (length != 6 && length != 20) {
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end) ||
+			!pull_uuid_le(&iov, &type)) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
 	q = queue_new();
 
-	start = get_le16(pdu);
-	end = get_le16(pdu + 2);
-	get_uuid_le(pdu + 4, length - 4, &type);
-
 	DBG(server, "Read By Type - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
@@ -540,8 +538,8 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint16_t mtu,
 
 	op = new0(struct async_read_op, 1);
 	op->mtu = mtu;
-	op->pdu = malloc(mtu);
-	if (!op->pdu) {
+	op->rsp.iov_base = malloc(mtu);
+	if (!op->rsp.iov_base) {
 		free(op);
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
@@ -563,15 +561,13 @@ error:
 
 static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
 						uint16_t mtu,
-						uint8_t *pdu, uint16_t *len)
+						struct iovec *rsp)
 {
 	uint16_t handle;
 	struct gatt_db_attribute *attr;
 	const bt_uuid_t *type;
-	int uuid_len, cur_uuid_len;
-	int iter = 0;
-
-	*len = 0;
+	void *uuid;
+	int uuid_len = 0, cur_uuid_len;
 
 	while (queue_peek_head(q)) {
 		attr = queue_pop_head(q);
@@ -582,35 +578,34 @@ static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
 
 		cur_uuid_len = bt_uuid_len(type);
 
-		if (iter == 0) {
+		if (!rsp->iov_len) {
 			switch (cur_uuid_len) {
 			case 2:
 				uuid_len = 2;
-				pdu[0] = 0x01;
+				util_iov_push_u8(rsp, 0x01);
 				break;
 			case 4:
 			case 16:
 				uuid_len = 16;
-				pdu[0] = 0x02;
+				util_iov_push_u8(rsp, 0x02);
 				break;
 			default:
 				return false;
 			}
-
-			iter++;
 		} else if (cur_uuid_len != uuid_len)
 			break;
 
-		if (iter + uuid_len + 2 > mtu - 1)
+		if (rsp_room(rsp, mtu - 1) < (size_t)uuid_len + 2)
 			break;
 
-		put_le16(handle, pdu + iter);
-		bt_uuid_to_le(type, pdu + iter + 2);
+		util_iov_push_le16(rsp, handle);
 
-		iter += uuid_len + 2;
-	}
+		uuid = util_iov_push(rsp, uuid_len);
+		if (!uuid)
+			return false;
 
-	*len = iter;
+		bt_uuid_to_le(type, uuid);
+	}
 
 	return true;
 }
@@ -621,22 +616,20 @@ static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
-	uint8_t *rsp_pdu = NULL;
-	uint16_t rsp_len;
+	struct iovec iov = { (void *)pdu, length };
+	struct iovec rsp = {};
 	uint8_t ecode = 0;
 	uint16_t ehandle = 0;
 	struct queue *q = NULL;
 
-	if (length != 4) {
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end) || iov.iov_len) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
 	q = queue_new();
 
-	start = get_le16(pdu);
-	end = get_le16(pdu + 2);
-
 	DBG(server, "Find Info - start: 0x%04x end: 0x%04x", start, end);
 
 	if (!start || !end) {
@@ -658,35 +651,35 @@ static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 		goto error;
 	}
 
-	rsp_pdu = malloc(mtu);
-	if (!rsp_pdu) {
+	rsp.iov_base = malloc(mtu);
+	if (!rsp.iov_base) {
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
-	if (!encode_find_info_rsp(server->db, q, mtu, rsp_pdu, &rsp_len)) {
+	if (!encode_find_info_rsp(server->db, q, mtu, &rsp)) {
 		ecode = BT_ATT_ERROR_UNLIKELY;
 		goto error;
 	}
 
-	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_INFO_RSP, rsp_pdu, rsp_len);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_INFO_RSP, rsp.iov_base,
+								rsp.iov_len);
 
 	queue_destroy(q, NULL);
 
-	free(rsp_pdu);
+	free(rsp.iov_base);
 
 	return;
 
 error:
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 	queue_destroy(q, NULL);
-	free(rsp_pdu);
+	free(rsp.iov_base);
 
 }
 
 struct find_by_type_val_data {
-	uint8_t *pdu;
-	uint16_t len;
+	struct iovec rsp;
 	uint16_t mtu;
 	uint8_t ecode;
 };
@@ -700,7 +693,7 @@ static void find_by_type_val_att_cb(struct gatt_db_attribute *attrib,
 	if (data->ecode)
 		return;
 
-	if (data->len + 4 > data->mtu - 1)
+	if (rsp_room(&data->rsp, data->mtu - 1) < 4)
 		return;
 
 	/*
@@ -715,10 +708,8 @@ static void find_by_type_val_att_cb(struct gatt_db_attribute *attrib,
 		return;
 	}
 
-	put_le16(handle, data->pdu + data->len);
-	put_le16(end_handle, data->pdu + data->len + 2);
-
-	data->len += 4;
+	util_iov_push_le16(&data->rsp, handle);
+	util_iov_push_le16(&data->rsp, end_handle);
 }
 
 static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
@@ -727,30 +718,25 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end, uuid16;
-	struct find_by_type_val_data data;
-	uint8_t *rsp_pdu = NULL;
+	struct find_by_type_val_data data = {};
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t ehandle = 0;
 	bt_uuid_t uuid;
 
-	if (length < 6) {
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end) ||
+			!util_iov_pull_le16(&iov, &uuid16)) {
 		data.ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
-	rsp_pdu = malloc(mtu);
-	if (!rsp_pdu) {
+	data.rsp.iov_base = malloc(mtu);
+	if (!data.rsp.iov_base) {
 		data.ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
 		goto error;
 	}
 
-	data.pdu = rsp_pdu;
-	data.len = 0;
 	data.mtu = mtu;
-	data.ecode = 0;
-
-	start = get_le16(pdu);
-	end = get_le16(pdu + 2);
-	uuid16 = get_le16(pdu + 4);
 
 	DBG(server,
 	    "Find By Type Value - start: 0x%04x end: 0x%04x uuid: 0x%04x",
@@ -763,27 +749,28 @@ static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
 	}
 
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_db_find_by_type_value(server->db, start, end, &uuid, pdu + 6,
-							length - 6,
+	gatt_db_find_by_type_value(server->db, start, end, &uuid,
+							iov.iov_base,
+							iov.iov_len,
 							find_by_type_val_att_cb,
 							&data);
 
-	if (!data.len)
+	if (!data.rsp.iov_len)
 		data.ecode = BT_ATT_ERROR_ATTRIBUTE_NOT_FOUND;
 
 	if (data.ecode)
 		goto error;
 
 	bt_att_chan_send_rsp(chan, BT_ATT_OP_FIND_BY_TYPE_RSP,
-					data.pdu, data.len);
+				data.rsp.iov_base, data.rsp.iov_len);
 
-	free(rsp_pdu);
+	free(data.rsp.iov_base);
 
 	return;
 
 error:
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, data.ecode);
-	free(rsp_pdu);
+	free(data.rsp.iov_base);
 }
 
 static void async_write_op_destroy(struct async_write_op *op)
@@ -846,11 +833,12 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t handle = 0;
 	struct async_write_op *op = NULL;
 	uint8_t ecode;
 
-	if (length < 2) {
+	if (iov.iov_len < sizeof(handle)) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
@@ -859,7 +847,8 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	if (ecode)
 		goto error;
 
-	handle = get_le16(pdu);
+	util_iov_pull_le16(&iov, &handle);
+
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
@@ -869,7 +858,7 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	DBG(server, "Write %s - handle: 0x%04x",
 		(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd", handle);
 
-	ecode = check_length(length - 2, 0);
+	ecode = check_length(iov.iov_len, 0);
 	if (ecode)
 		goto error;
 
@@ -882,7 +871,8 @@ static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	op->server = bt_gatt_server_ref(server);
 	op->opcode = opcode;
 
-	if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
+	if (gatt_db_attribute_write(attr, 0, iov.iov_base,
+							iov.iov_len, opcode,
 							server->att,
 							write_complete_cb, op))
 		return;
@@ -996,16 +986,15 @@ static void read_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 			const void *pdu, uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t handle;
 
-	if (length != 2) {
+	if (!util_iov_pull_le16(&iov, &handle) || iov.iov_len) {
 		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
-	handle = get_le16(pdu);
-
 	handle_read_req(chan, server, mtu, opcode, handle, 0);
 }
 
@@ -1014,17 +1003,16 @@ static void read_blob_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
+	struct iovec iov = { (void *)pdu, length };
 	uint16_t handle, offset;
 
-	if (length != 4) {
+	if (!util_iov_pull_le16(&iov, &handle) ||
+			!util_iov_pull_le16(&iov, &offset) || iov.iov_len) {
 		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
-	handle = get_le16(pdu);
-	offset = get_le16(pdu + 2);
-
 	handle_read_req(chan, server, mtu, opcode, handle, offset);
 }
 
@@ -1035,15 +1023,14 @@ struct read_mult_data {
 	uint16_t *handles;
 	size_t cur_handle;
 	size_t num_handles;
-	uint8_t *rsp_data;
-	size_t length;
+	struct iovec rsp;
 	size_t mtu;
 };
 
 static void read_mult_data_free(struct read_mult_data *data)
 {
 	free(data->handles);
-	free(data->rsp_data);
+	free(data->rsp.iov_base);
 	free(data);
 }
 
@@ -1055,36 +1042,36 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct gatt_db_attribute *next_attr;
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
 	uint8_t ecode;
-	uint16_t length;
+	size_t room;
 
 	if (err != 0) {
 		ecode = err;
 		goto error;
 	}
 
-	length = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
-			MIN(len, MAX(data->mtu - data->length, 3) - 3) :
-			MIN(len, data->mtu - data->length - 1);
+	room = rsp_room(&data->rsp, data->mtu - 1);
 
 	if (data->opcode == BT_ATT_OP_READ_MULT_VL_REQ) {
 		/* The Length Value Tuple List may be truncated within the first
 		 * two octets of a tuple due to the size limits of the current
 		 * ATT_MTU, but the first two octets cannot be separated.
 		 */
-		if (data->mtu - data->length >= 3) {
-			put_le16(len, data->rsp_data + data->length);
-			data->length += 2;
-		}
+		if (room >= 2) {
+			util_iov_push_le16(&data->rsp, len);
+			room -= 2;
+		} else
+			room = 0;
 	}
 
-	memcpy(data->rsp_data + data->length, value, length);
-	data->length += length;
+	if (len && room)
+		util_iov_push_mem(&data->rsp, MIN(len, room), value);
 
 	data->cur_handle++;
 
 	if (data->cur_handle == data->num_handles) {
 		bt_att_chan_send_rsp(data->chan, data->opcode + 1,
-						data->rsp_data, data->length);
+						data->rsp.iov_base,
+						data->rsp.iov_len);
 		read_mult_data_free(data);
 		return;
 	}
@@ -1135,13 +1122,11 @@ static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
 	data->chan = chan;
 	data->opcode = opcode;
 	data->handles = new0(uint16_t, num_handles);
-	data->rsp_data = NULL;
 	data->server = server;
 	data->num_handles = num_handles;
 	data->cur_handle = 0;
 	data->mtu = mtu;
-	data->length = 0;
-	data->rsp_data = new0(uint8_t, data->mtu - 1);
+	data->rsp.iov_base = new0(uint8_t, data->mtu - 1);
 
 	return data;
 }
@@ -1153,6 +1138,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint16_t mtu,
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
 	struct read_mult_data *data = NULL;
+	struct iovec iov = { (void *)pdu, length };
 	uint8_t ecode;
 	size_t i = 0;
 	uint16_t handle = 0;
@@ -1164,8 +1150,12 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint16_t mtu,
 
 	data = read_mult_data_new(server, chan, mtu, opcode, length / 2);
 
-	for (i = 0; i < data->num_handles; i++)
-		data->handles[i] = get_le16(pdu + i * 2);
+	for (i = 0; i < data->num_handles; i++) {
+		if (!util_iov_pull_le16(&iov, &data->handles[i])) {
+			ecode = BT_ATT_ERROR_INVALID_PDU;
+			goto error;
+		}
+	}
 
 	handle = data->handles[0];
 
@@ -1298,10 +1288,19 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 								void *user_data)
 {
 	struct prep_write_complete_data *pwcd = user_data;
+	struct iovec iov = { pwcd->pdu, pwcd->length };
 	uint16_t handle = 0;
 	uint16_t offset;
 
-	handle = get_le16(pwcd->pdu);
+	if (!util_iov_pull_le16(&iov, &handle) ||
+			!util_iov_pull_le16(&iov, &offset)) {
+		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_REQ,
+					handle, BT_ATT_ERROR_INVALID_PDU);
+		free(pwcd->pdu);
+		free(pwcd);
+
+		return;
+	}
 
 	if (err) {
 		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_REQ,
@@ -1312,10 +1311,8 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 		return;
 	}
 
-	offset = get_le16(pwcd->pdu + 2);
-
-	if (!store_prep_data(pwcd->server, handle, offset, pwcd->length - 4,
-						&((uint8_t *) pwcd->pdu)[4]))
+	if (!store_prep_data(pwcd->server, handle, offset, iov.iov_len,
+							iov.iov_base))
 		bt_att_chan_send_error_rsp(pwcd->chan, BT_ATT_OP_PREP_WRITE_RSP,
 					handle,
 					BT_ATT_ERROR_INSUFFICIENT_RESOURCES);
@@ -1336,9 +1333,10 @@ static void prep_write_cb(struct bt_att_chan *chan, uint16_t mtu,
 	uint16_t offset;
 	struct gatt_db_attribute *attr;
 	struct prep_write_complete_data *pwcd;
+	struct iovec iov = { (void *)pdu, length };
 	uint8_t ecode, status;
 
-	if (length < 4) {
+	if (iov.iov_len < sizeof(handle) + sizeof(offset)) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
@@ -1348,8 +1346,8 @@ static void prep_write_cb(struct bt_att_chan *chan, uint16_t mtu,
 		goto error;
 	}
 
-	handle = get_le16(pdu);
-	offset = get_le16(pdu + 2);
+	util_iov_pull_le16(&iov, &handle);
+	util_iov_pull_le16(&iov, &offset);
 
 	attr = gatt_db_get_attribute(server->db, handle);
 	if (!attr) {
@@ -1359,7 +1357,7 @@ static void prep_write_cb(struct bt_att_chan *chan, uint16_t mtu,
 
 	DBG(server, "Prep Write Req - handle: 0x%04x", handle);
 
-	ecode = check_length(length - 4, offset);
+	ecode = check_length(iov.iov_len, offset);
 	if (ecode)
 		goto error;
 
@@ -1369,8 +1367,7 @@ static void prep_write_cb(struct bt_att_chan *chan, uint16_t mtu,
 
 	pwcd = new0(struct prep_write_complete_data, 1);
 	pwcd->chan = chan;
-	pwcd->pdu = malloc(length);
-	memcpy(pwcd->pdu, pdu, length);
+	pwcd->pdu = util_memdup(pdu, length);
 	pwcd->length = length;
 	pwcd->server = server;
 
@@ -1465,18 +1462,17 @@ static void exec_write_cb(struct bt_att_chan *chan, uint16_t mtu,
 {
 	struct bt_gatt_server *server = user_data;
 	struct exec_data *data;
+	struct iovec iov = { (void *)pdu, length };
 	uint8_t flags;
 	uint8_t ecode;
 	bool write;
 	uint16_t ehandle = 0;
 
-	if (length != 1) {
+	if (!util_iov_pull_u8(&iov, &flags) || iov.iov_len) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
 		goto error;
 	}
 
-	flags = ((uint8_t *) pdu)[0];
-
 	DBG(server, "Exec Write Req - flags: 0x%02x", flags);
 
 	if (flags == 0x00)
@@ -1527,22 +1523,24 @@ static void exchange_mtu_cb(struct bt_att_chan *chan, uint16_t mtu,
 				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
+	struct iovec iov = { (void *)pdu, length };
+	uint8_t rsp_pdu[2];
+	struct iovec rsp = { rsp_pdu, 0 };
 	uint16_t client_rx_mtu;
 	uint16_t final_mtu;
-	uint8_t rsp_pdu[2];
 
-	if (length != 2) {
+	if (!util_iov_pull_le16(&iov, &client_rx_mtu) || iov.iov_len) {
 		bt_att_chan_send_error_rsp(chan, opcode, 0,
 						BT_ATT_ERROR_INVALID_PDU);
 		return;
 	}
 
-	client_rx_mtu = get_le16(pdu);
 	final_mtu = MAX(MIN(client_rx_mtu, server->mtu), BT_ATT_DEFAULT_LE_MTU);
 
 	/* Respond with the server MTU */
-	put_le16(server->mtu, rsp_pdu);
-	bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp_pdu, 2);
+	util_iov_push_le16(&rsp, server->mtu);
+	bt_att_chan_send_rsp(chan, BT_ATT_OP_MTU_RSP, rsp.iov_base,
+							rsp.iov_len);
 
 	/* Set MTU to be the minimum */
 	server->mtu = final_mtu;
@@ -1771,8 +1769,8 @@ static bool mnotify_send(void *user_data)
 	server->mnotify->id = 0;
 
 	bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY_MULT,
-			server->mnotify->pdu, server->mnotify->offset, NULL,
-			NULL, NULL);
+			server->mnotify->pdu.iov_base,
+			server->mnotify->pdu.iov_len, NULL, NULL, NULL);
 
 	mnotify_free(server);
 
@@ -1798,13 +1796,10 @@ bool bt_gatt_server_set_mnotify_timeout(struct bt_gatt_server *server,
 
 static bool notify_append_le16(struct mnotify_data *data, uint16_t value)
 {
-	if (data->offset + sizeof(value) > data->len)
+	if (rsp_room(&data->pdu, data->len) < sizeof(value))
 		return false;
 
-	put_le16(value, data->pdu + data->offset);
-	data->offset += sizeof(value);
-
-	return true;
+	return util_iov_push_le16(&data->pdu, value) != NULL;
 }
 
 bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
@@ -1825,8 +1820,8 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 		data = server->mnotify;
 
 		/* flush buffered data if this request hits buffer size limit */
-		if (data && data->offset > 0 &&
-				data->len - data->offset < 4 + length) {
+		if (data && data->pdu.iov_len > 0 &&
+			rsp_room(&data->pdu, data->len) < (size_t)4 + length) {
 			mnotify_timeout_remove(server);
 			mnotify_send(server);
 			/* data has been freed by mnotify_send */
@@ -1837,24 +1832,24 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	if (!data) {
 		data = new0(struct mnotify_data, 1);
 		data->len = bt_att_get_mtu(server->att) - 1;
-		data->pdu = malloc(data->len);
+		data->pdu.iov_base = malloc(data->len);
+		if (!data->pdu.iov_base)
+			goto error;
 	}
 
 	if (!notify_append_le16(data, handle))
 		goto error;
 
 	if (multiple) {
-		length = MIN(data->len - data->offset - 2, length);
+		length = MIN(rsp_room(&data->pdu, data->len) - 2, length);
 		if (!notify_append_le16(data, length))
 			goto error;
 	} else {
-		length = MIN(data->len - data->offset, length);
+		length = MIN(rsp_room(&data->pdu, data->len), length);
 	}
 
-	if (value)
-		memcpy(data->pdu + data->offset, value, length);
-
-	data->offset += length;
+	if (length && !util_iov_push_mem(&data->pdu, length, value))
+		goto error;
 
 	if (multiple) {
 		if (!server->mnotify)
@@ -1869,15 +1864,16 @@ bool bt_gatt_server_send_notification(struct bt_gatt_server *server,
 	}
 
 	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_NFY,
-				data->pdu, data->offset, NULL, NULL, NULL);
-	free(data->pdu);
+				data->pdu.iov_base, data->pdu.iov_len, NULL,
+				NULL, NULL);
+	free(data->pdu.iov_base);
 	free(data);
 
 	return result;
 
 error:
 	if (data) {
-		free(data->pdu);
+		free(data->pdu.iov_base);
 		free(data);
 	}
 
@@ -1917,7 +1913,7 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 					bt_gatt_server_destroy_func_t destroy)
 {
 	uint16_t pdu_len;
-	uint8_t *pdu;
+	struct iovec pdu = {};
 	struct ind_data *data;
 	bool result;
 
@@ -1925,8 +1921,8 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 		return false;
 
 	pdu_len = MIN(bt_att_get_mtu(server->att) - 1, length + 2);
-	pdu = malloc(pdu_len);
-	if (!pdu)
+	pdu.iov_base = malloc(pdu_len);
+	if (!pdu.iov_base)
 		return false;
 
 	data = new0(struct ind_data, 1);
@@ -1935,16 +1931,17 @@ bool bt_gatt_server_send_indication(struct bt_gatt_server *server,
 	data->destroy = destroy;
 	data->user_data = user_data;
 
-	put_le16(handle, pdu);
-	memcpy(pdu + 2, value, pdu_len - 2);
+	util_iov_push_le16(&pdu, handle);
+	if (pdu_len > 2)
+		util_iov_push_mem(&pdu, pdu_len - 2, value);
 
-	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_IND, pdu,
-							pdu_len, conf_cb,
-							data, destroy_ind_data);
+	result = !!bt_att_send(server->att, BT_ATT_OP_HANDLE_IND, pdu.iov_base,
+						pdu.iov_len, conf_cb,
+						data, destroy_ind_data);
 	if (!result)
 		destroy_ind_data(data);
 
-	free(pdu);
+	free(pdu.iov_base);
 
 	return result;
 }
-- 
2.56.0

