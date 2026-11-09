Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239110;
	b=dUGEgtz6gyx3UvE8Vhmxa4C6anJ5oMZ5KOOrQw9HjJ70iuuNuXatlh5G0V9cNDbnwnzI
	 JKEiLi5Ymi7xryUHwzt/Jg98BSk/XoxWNpeS39mBYeZFHfwj2sr8NlTzxAg0Wym2CDRY0
	 719SxFf22ck92tqnLFGrM1OwaCA69ZwTjnxmCBcXKFLM+uvBEF52o3m264RTC57nJWYcH
	 y/wv7gbuDMkYaF4u3lW0BmbuNhAppf9r84PaW06mxYH2K4kg0hVVI2/BwVAkYl5N8/Ho8
	 lYAs6RpyIofjPkXvuaw9cB9wZo/H4WG0TUqfsoACBmK8sdZQhYHADfrovES011ktbZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=whyxnDGetRL9jJkg9sZ+wQL4bg3mRUEDo6yqRgXu81o=;
	b=sp5DaM0tN9Hzn8bGX09QJTn1XbDpKvbs0wvYUmpY0C+tLXO4MF39mry+MakIthac79if
	 PNAnyxtgUGWvkSwTucarbTen+zagOqaqImJDHY7h19U3IR8sazTTo1JePWBpDLf5af6xF
	 lj+dlwt+PTuUcO+u8GOb3ksgdwm59oOMRWyQmNlvRqkyAW0UmeNSc5FpCgd9ZKUkxIkaP
	 OLB/WIsFWG7pDs95r3ZRx76eJ4Lo5AX47llX+7mkiIFpE8xaojYgBcH6OT46fCNq5yWpa
	 JKmC+i6b9iuLUiFhX3dRB0KBhdkt8dShdc/K9mK9m90Z9ZnRXhA1zjLYzEtUZWmNA2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhJDrrRE;
	arc=none smtp.remote-ip=209.85.221.182
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECF606A334
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11ECF606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EhJDrrRE
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5eae1276409so383015e0c.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:45:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239109; x=1794843909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=whyxnDGetRL9jJkg9sZ+wQL4bg3mRUEDo6yqRgXu81o=;
        b=EhJDrrRE9gKfvOf5xHqXTJqIhdsxm28LI6Vroge3UudeMpIVy90zO0gGrJC1yGOpCx
         eHID3egVgLTmwlUwObIJz3Zqatdu0LtCimKzhtThNvN2xhUCrUWjlv4QjXP7J5IIQ0F9
         DzDhWmuWLsiWEI6WrxCcY6UBVu21PVkvykbpe52y024yZoJrJ9C1wTxeUnQsY4Yb7IQA
         8puUmfUNOa9q63IGMVp5/TcmZN9Td4K2oHXGyOytJkm4CMJqwdROQUIzZBjA3Yc6Ncsq
         GFBK6WSBvvaFmFJQJ917zEz3zTb1s7RH5k4sTAAU5jNTG52DZCJ5dGwKu0S0Du9wgy56
         3Alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239109; x=1794843909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=whyxnDGetRL9jJkg9sZ+wQL4bg3mRUEDo6yqRgXu81o=;
        b=L2kzfE8DXtBhPagyn4y1giBmV0lv/hiZ68uQpuaPSjKqyh3D7GYQ4AAxTPZI9u+CSj
         Z/MJTXC6i3MLym9dIBm+LzwoMtXtp3fvz11ORvVVAS3Izu5CIIvRSIP7L0GkudxszCmy
         7I64RplAXsVsw6Q1MSxGfK1kD70ogFTHZj85QgPToa3TaZ+rqJEp4eEo9+uLMlV9NyER
         s03CqCfB5cZRh/LGv0hs0bHyLkFb3Pmarg6JoD8HEsyOKvisANvnOKUEH5cOL6byTN0i
         aNcNKuZVNpEKmi15dWlT989Qa5BZYEY+2x1lC0gEYPTGRBW2y3qOddtp/QSWAkzMEL7z
         AOtQ==
X-Gm-Message-State: APuU4Z/6DcAGAMMT9DEBOMri5l81Cxm/shJKi2Xj0ZiWTslNJ12Af4TA
	TC6xnaRUHNf3FB/JbNUo5kiU/HmyGHjf+zMs8qR4x2vYKGEYRvA3VNtJZjZ7Ig==
X-Gm-Gg: AYBFou2KBYUsl32eYPXLaaM87OWPM++1aIhNN60hweyGbNGsoCPaJz98IS9SHtSosIn
	It5JL6oCHLeRBE8R59yoqUaxUn+J/nOodFqOxwWieKhYcP9LaAo5Z/UXLJSZy0BSnvAZNRaeUlW
	TiXHhJQZ7dpZTJTsdJABwnjXQsaQyVzYuBBB8uaFKyahllIqABtR4wJjQXF60MMVZJ7WH3bEYtv
	9XsYakvpd4OdIOYqlOqcQ7Uqz/R8/3SAm78IQj5j5J9ZmcOGVGeICZv3pS7f36huiOeW4s2FsCD
	U40HPi/o64Fg9rTMSGWj54wU0V8FI4bt3LUjiKtZCwnzloGpf92x24BQtZh0ITZ6jF7KEfjEUPz
	L/pwJHFFN10cAZlYJJc8UgXHqI+9VPR6EuyEFhJHWdxnfgnDDWppwoM72ZeKv2qgZxBg7J/NK8Q
	QWk1i2OS1pnjIdnUunjjviKMRFUICXX7Y8nf3s0tKfp9Pj8SIzyh8pmVz5/wLYSGlvbWW9jL/SW
	Kgl0zNId9IlUBlu12uiScE6swT+Ltsb3djTsZxHrnMdsmogtoyzJlPYntF+fePgtlDeOVJRbmPi
	GHR5YcTfZp8hHcig02X9jZ57GNIuHg2w2Zy6CQDbEk8YU8K3I3P71nWYGhISH0X0BgCdcdb0gWC
	cVe43rJV2hXxF8iDXptI3uwREoX9IqhlBZ0RuCv9anj7znUZ6XFkjYmODRdsn2QQP4j6NNmdEk/
	Dl7uo=
X-Received: by 2002:a05:6102:b0f:b0:7a7:198a:c2c6 with SMTP id ada2fe7eead31-7d2db2337cfmr1257621137.36.1794239107814;
        Mon, 09 Nov 2026 07:45:07 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c02a60a83sm4097474241.10.2026.11.09.07.45.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:45:07 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/10] shared/gatt-client: Use util_iov helpers to build and parse PDUs
Date: Mon,  9 Nov 2026 10:44:55 -0500
Message-ID: <20261109154501.1362649-5-luiz.dentz@gmail.com>
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

Use util_iov_pull_* to parse notifications, Service Changed and Read
Multiple Variable Length responses, and util_iov_push_* to build read,
write and prepare write requests. Prepare write responses are compared
with util_iov_memcmp.

Assisted-by: OpenCode:claude-sonnet-5.5
---
 src/shared/gatt-client.c | 203 ++++++++++++++++++---------------------
 1 file changed, 94 insertions(+), 109 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index a923699b74bb..7bebc50dcf9d 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2004,14 +2004,13 @@ static void service_changed_cb(uint16_t value_handle, const uint8_t *value,
 {
 	struct bt_gatt_client *client = user_data;
 	struct service_changed_op *op;
+	struct iovec iov = { (void *)value, length };
 	uint16_t start, end;
 
-	if (length != 4)
+	if (!util_iov_pull_le16(&iov, &start) ||
+			!util_iov_pull_le16(&iov, &end) || iov.iov_len)
 		return;
 
-	start = get_le16(value);
-	end = get_le16(value + 2);
-
 	if (start > end) {
 		DBG(client,
 			"Service Changed received with invalid handles");
@@ -2271,6 +2270,7 @@ static void notify_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 					void *user_data)
 {
 	struct bt_gatt_client *client = user_data;
+	struct iovec iov = { (void *)pdu, length };
 	struct value_data data;
 
 	bt_gatt_client_ref(client);
@@ -2281,36 +2281,27 @@ static void notify_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 	memset(&data, 0, sizeof(data));
 
 	if (opcode == BT_ATT_OP_HANDLE_NFY_MULT) {
-		while (length >= 4) {
-			data.handle = get_le16(pdu);
-			length -= 2;
-			pdu += 2;
-
-			data.len = get_le16(pdu);
-			length -= 2;
-			pdu += 2;
+		while (iov.iov_len >= 4) {
+			if (!util_iov_pull_le16(&iov, &data.handle) ||
+				!util_iov_pull_le16(&iov, &data.len))
+				break;
 
-			if (data.len > length)
-				data.len = length;
+			if (data.len > iov.iov_len)
+				data.len = iov.iov_len;
 
-			data.data = pdu;
+			data.data = util_iov_pull_mem(&iov, data.len);
+			if (!data.data)
+				break;
 
 			queue_foreach(client->notify_list, notify_handler,
 								&data);
-
-			length -= data.len;
-			pdu += data.len;
 		}
 	} else {
-		if (length < 2)
+		if (!util_iov_pull_le16(&iov, &data.handle))
 			goto done;
 
-		data.handle = get_le16(pdu);
-		length -= 2;
-		pdu += 2;
-
-		data.len = length;
-		data.data = pdu;
+		data.len = iov.iov_len;
+		data.data = iov.iov_base;
 
 		queue_foreach(client->notify_list, notify_handler, &data);
 	}
@@ -2901,6 +2892,7 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	struct read_op *op = req->data;
 	uint8_t att_ecode;
 	bool success;
+	struct iovec iov;
 
 	if ((opcode != BT_ATT_OP_READ_MULT_RSP &&
 			opcode != BT_ATT_OP_READ_MULT_VL_RSP) ||
@@ -2935,25 +2927,29 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	/* Keep the request alive in case a callback cancels it */
 	request_ref(req);
 
+	iov.iov_base = (void *)pdu;
+	iov.iov_len = length;
+
 	/* Parse response */
-	while (length >= 2 && !req->removed) {
+	while (iov.iov_len >= 2 && !req->removed) {
+		const uint8_t *value;
 		uint16_t len;
 
-		len = get_le16(pdu);
-		length -= 2;
-		pdu += 2;
+		if (!util_iov_pull_le16(&iov, &len))
+			break;
 
 		/* The Length Value Tuple List may be truncated within the
 		 * first two octets of a tuple due to the size limits of the
 		 * current ATT_MTU.
 		 */
-		if (len > length)
-			len = length;
+		if (len > iov.iov_len)
+			len = iov.iov_len;
 
-		op->callback(success, att_ecode, pdu, len, op->user_data);
+		value = util_iov_pull_mem(&iov, len);
+		if (!value)
+			break;
 
-		length -= len;
-		pdu += len;
+		op->callback(success, att_ecode, value, len, op->user_data);
 	}
 
 	request_unref(req);
@@ -2966,6 +2962,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy)
 {
 	uint8_t *pdu = newa(uint8_t, num_handles * 2);
+	struct iovec iov = { pdu, 0 };
 	struct request *req;
 	struct read_op *op;
 	uint8_t opcode;
@@ -2996,13 +2993,14 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 	req->destroy = destroy_read_op;
 
 	for (i = 0; i < num_handles; i++)
-		put_le16(handles[i], pdu + (2 * i));
+		util_iov_push_le16(&iov, handles[i]);
 
 	opcode = bt_gatt_client_get_features(client) &
 		BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
 		BT_ATT_OP_READ_MULT_REQ;
 
-	req->att_id = bt_att_send(client->att, opcode, pdu, num_handles * 2,
+	req->att_id = bt_att_send(client->att, opcode, iov.iov_base,
+							iov.iov_len,
 							read_multiple_cb, req,
 							request_unref);
 	if (!req->att_id) {
@@ -3039,21 +3037,13 @@ static void destroy_read_long_op(void *data)
 static bool append_chunk(struct read_long_op *op, const uint8_t *data,
 								uint16_t len)
 {
-	void *buf;
-
 	/* Truncate if the data would exceed maximum length */
 	if (op->offset + len > BT_ATT_MAX_VALUE_LEN)
 		len = BT_ATT_MAX_VALUE_LEN - op->offset;
 
-	buf = realloc(op->iov.iov_base, op->iov.iov_len + len);
-	if (!buf)
+	if (!util_iov_append(&op->iov, data, len))
 		return false;
 
-	op->iov.iov_base = buf;
-
-	memcpy(op->iov.iov_base + op->iov.iov_len, data, len);
-
-	op->iov.iov_len += len;
 	op->offset += len;
 
 	return true;
@@ -3093,14 +3083,16 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 
 	if (length >= bt_att_get_mtu(op->client->att) - 1) {
 		uint8_t pdu[4];
+		struct iovec iov = { pdu, 0 };
 		int err;
 
-		put_le16(op->value_handle, pdu);
-		put_le16(op->offset, pdu + 2);
+		util_iov_push_le16(&iov, op->value_handle);
+		util_iov_push_le16(&iov, op->offset);
 
 		err = bt_att_resend(op->client->att, req->att_id,
 							BT_ATT_OP_READ_BLOB_REQ,
-							pdu, sizeof(pdu),
+							iov.iov_base,
+							iov.iov_len,
 							read_long_cb,
 							request_ref(req),
 							request_unref);
@@ -3131,7 +3123,7 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 	struct read_long_op *op;
 	uint8_t att_op;
 	uint8_t pdu[4];
-	uint16_t pdu_len;
+	struct iovec iov = { pdu, 0 };
 
 	if (!client)
 		return 0;
@@ -3154,8 +3146,7 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 	req->data = op;
 	req->destroy = destroy_read_long_op;
 
-	put_le16(value_handle, pdu);
-	pdu_len = sizeof(value_handle);
+	util_iov_push_le16(&iov, value_handle);
 
 	/*
 	 * Core v4.2, part F, section 1.3.4.4.5:
@@ -3171,15 +3162,14 @@ unsigned int bt_gatt_client_read_long_value(struct bt_gatt_client *client,
 
 	if (op->offset) {
 		att_op = BT_ATT_OP_READ_BLOB_REQ;
-		pdu_len += sizeof(op->offset);
-
-		put_le16(op->offset, pdu + 2);
+		util_iov_push_le16(&iov, op->offset);
 	} else {
 		att_op = BT_ATT_OP_READ_REQ;
 	}
 
-	req->att_id = bt_att_send(client->att, att_op, pdu, pdu_len,
-					read_long_cb, req, request_unref);
+	req->att_id = bt_att_send(client->att, att_op, iov.iov_base,
+					iov.iov_len, read_long_cb, req,
+					request_unref);
 
 	if (!req->att_id) {
 		op->destroy = NULL;
@@ -3196,6 +3186,7 @@ unsigned int bt_gatt_client_write_without_response(
 					bool signed_write,
 					const uint8_t *value, uint16_t length) {
 	uint8_t *pdu = newa(uint8_t, 2 + length);
+	struct iovec iov = { pdu, 0 };
 	struct request *req;
 	int security;
 	uint8_t op;
@@ -3215,11 +3206,11 @@ unsigned int bt_gatt_client_write_without_response(
 	} else
 		op = BT_ATT_OP_WRITE_CMD;
 
-	put_le16(value_handle, pdu);
-	memcpy(pdu + 2, value, length);
+	util_iov_push_le16(&iov, value_handle);
+	util_iov_push_mem(&iov, length, value);
 
-	req->att_id = bt_att_send(client->att, op, pdu, 2 + length, NULL, req,
-								request_unref);
+	req->att_id = bt_att_send(client->att, op, iov.iov_base, iov.iov_len,
+						NULL, req, request_unref);
 	if (!req->att_id) {
 		request_unref(req);
 		return 0;
@@ -3277,6 +3268,7 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 	struct request *req;
 	struct write_op *op;
 	uint8_t *pdu = newa(uint8_t, 2 + length);
+	struct iovec iov = { pdu, 0 };
 
 	if (!client)
 		return 0;
@@ -3296,11 +3288,11 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 	req->data = op;
 	req->destroy = destroy_write_op;
 
-	put_le16(value_handle, pdu);
-	memcpy(pdu + 2, value, length);
+	util_iov_push_le16(&iov, value_handle);
+	util_iov_push_mem(&iov, length, value);
 
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
-							pdu, 2 + length,
+						iov.iov_base, iov.iov_len,
 							write_cb, req,
 							request_unref);
 	if (!req->att_id) {
@@ -3349,22 +3341,22 @@ static void handle_next_prep_write(struct request *req)
 {
 	struct long_write_op *op = req->data;
 	bool success = true;
-	uint8_t *pdu;
+	struct iovec iov = {};
 	int err;
 
-	pdu = malloc(op->cur_length + 4);
-	if (!pdu) {
+	iov.iov_base = malloc(op->cur_length + 4);
+	if (!iov.iov_base) {
 		success = false;
 		goto done;
 	}
 
-	put_le16(op->value_handle, pdu);
-	put_le16(op->offset + op->index, pdu + 2);
-	memcpy(pdu + 4, op->value + op->index, op->cur_length);
+	util_iov_push_le16(&iov, op->value_handle);
+	util_iov_push_le16(&iov, op->offset + op->index);
+	util_iov_push_mem(&iov, op->cur_length, op->value + op->index);
 
 	err = bt_att_resend(op->client->att, req->att_id,
 						BT_ATT_OP_PREP_WRITE_REQ,
-						pdu, op->cur_length + 4,
+						iov.iov_base, iov.iov_len,
 						prepare_write_cb,
 						request_ref(req),
 						request_unref);
@@ -3373,7 +3365,7 @@ static void handle_next_prep_write(struct request *req)
 		success = false;
 	}
 
-	free(pdu);
+	free(iov.iov_base);
 
 	/* If so far successful, then the operation should continue.
 	 * Otherwise, there was an error and the procedure should be
@@ -3493,20 +3485,15 @@ static void prepare_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	}
 
 	if (op->reliable) {
-		if (!pdu || length != (op->cur_length + 4)) {
-			success = false;
-			reliable_error = true;
-			goto done;
-		}
-
-		if (get_le16(pdu) != op->value_handle ||
-				get_le16(pdu + 2) != (op->offset + op->index)) {
-			success = false;
-			reliable_error = true;
-			goto done;
-		}
-
-		if (memcmp(pdu + 4, op->value + op->index, op->cur_length)) {
+		struct iovec iov = { (void *)pdu, length };
+		struct iovec value = { op->value + op->index, op->cur_length };
+		uint16_t handle, offset;
+
+		if (!pdu || !util_iov_pull_le16(&iov, &handle) ||
+				!util_iov_pull_le16(&iov, &offset) ||
+				handle != op->value_handle ||
+				offset != (op->offset + op->index) ||
+				util_iov_memcmp(&iov, &value)) {
 			success = false;
 			reliable_error = true;
 			goto done;
@@ -3544,7 +3531,7 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 {
 	struct request *req;
 	struct long_write_op *op;
-	uint8_t *pdu;
+	struct iovec iov = {};
 
 	if (!client)
 		return 0;
@@ -3593,22 +3580,23 @@ unsigned int bt_gatt_client_write_long_value(struct bt_gatt_client *client,
 		return req->id;
 	}
 
-	pdu = malloc(op->cur_length + 4);
-	if (!pdu) {
+	iov.iov_base = malloc(op->cur_length + 4);
+	if (!iov.iov_base) {
 		free(op->value);
 		free(op);
 		return 0;
 	}
 
-	put_le16(value_handle, pdu);
-	put_le16(offset, pdu + 2);
-	memcpy(pdu + 4, op->value, op->cur_length);
+	util_iov_push_le16(&iov, value_handle);
+	util_iov_push_le16(&iov, offset);
+	util_iov_push_mem(&iov, op->cur_length, op->value);
 
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
-							pdu, op->cur_length + 4,
+							iov.iov_base,
+							iov.iov_len,
 							prepare_write_cb, req,
 							request_unref);
-	free(pdu);
+	free(iov.iov_base);
 
 	if (!req->att_id) {
 		op->destroy = NULL;
@@ -3645,6 +3633,8 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 {
 	struct request *req = user_data;
 	struct prep_write_op *op = req->data;
+	struct iovec rsp = { (void *)pdu, length };
+	struct iovec exp = { op->pdu, op->pdu_len };
 	bool success;
 	uint8_t att_ecode;
 	bool reliable_error;
@@ -3663,8 +3653,7 @@ static void prep_write_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		goto done;
 	}
 
-	if (!pdu || length != op->pdu_len ||
-					memcmp(pdu, op->pdu, op->pdu_len)) {
+	if (!pdu || util_iov_memcmp(&rsp, &exp)) {
 		success = false;
 		reliable_error = true;
 		att_ecode = 0;
@@ -3716,6 +3705,7 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	struct request *req;
 	struct prep_write_op *op;
 	uint8_t *pdu = newa(uint8_t, 4 + length);
+	struct iovec iov = { pdu, 0 };
 
 	if (!client)
 		return 0;
@@ -3747,35 +3737,30 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	req->destroy = destroy_prep_write_op;
 	req->prep_write = true;
 
-	put_le16(value_handle, pdu);
-	put_le16(offset, pdu + 2);
-	memcpy(pdu + 4, value, length);
+	util_iov_push_le16(&iov, value_handle);
+	util_iov_push_le16(&iov, offset);
+	util_iov_push_mem(&iov, length, value);
 
 	/*
 	 * Before sending command we need to remember pdu as we need to validate
-	 * it in the response. Store handle, offset and value. Therefore
-	 * increase length by 4 (handle + offset) as we need it in couple places
-	 * below
+	 * it in the response. Store handle, offset and value.
 	 */
-	length += 4;
-
-	op->pdu = malloc(length);
+	op->pdu = util_memdup(iov.iov_base, iov.iov_len);
 	if (!op->pdu) {
 		op->destroy = NULL;
 		request_unref(req);
 		return 0;
 	}
 
-	memcpy(op->pdu, pdu, length);
-	op->pdu_len = length;
+	op->pdu_len = iov.iov_len;
 
 	/*
 	 * Now we are ready to send command
 	 * Note that request_unref will be done on write execute
 	 */
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ, pdu,
-					length, prep_write_cb, req,
-					NULL);
+	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ,
+					iov.iov_base, iov.iov_len,
+					prep_write_cb, req, NULL);
 	if (!req->att_id) {
 		op->destroy = NULL;
 		request_unref(req);
-- 
2.56.0

