Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2883F76035
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452509; cv=none; b=M1Qu08gxLrTYj8lFxHnpeHCJoSBtIZl05fTYz7G/N9cDGoaGhve13rY/QFAVETT7D0JmEAenHddCRw/bW5HU1fYXD6TMqLq6V3oLkyTbAzFQ685oaNJY2js0K0sVUbcB2h3KpvgG8I95nYc4UggAhKTz3G4KimwTwc1bv2/7bWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452509; c=relaxed/simple;
	bh=HME6AP+CPZICqU4AjLQU8euRm1JpFhh/s/5im71oDx0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=rFJg+aLEJx0qDanQ7+zbqHNUjhhs/D4O2Eg7m0kaQISyzOrEhfrWn5vsBRXxYCmRjSWZFYnWGqA2VMuACKCP4RPtFuv5BFI92dAert4IaMylY1K4ShYF/H5l/DuP6DgIe2/vqERKWjWGO7NLQxJ1JCT7flK3kh+6p85f/oxVO/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mfiQR80w; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mfiQR80w"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-8100df48323so1023852241.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 Jul 2024 08:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720452505; x=1721057305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IKDSymq46tkzYYGzhbA1pjSZ4iOAbEBbM/RM3zDnGVk=;
        b=mfiQR80w2OLuAdoKpyQA/xaoqFGlJTXeWnrN4ios+SGEkSVj6AGI7DvT1jZ8kFkZ3K
         5MD7cMIGsnIJxDsO9jiT3EwfVx9BdDFP5O/P/xXl4RG59nW94itgrxbqq2NmBmcbPzRZ
         2vxO5F0N17YON+Rw/iGkPsOF5UUypMUDq+u9hFSQ2VV2IxOCAOrC0PnFaLlJP/IJXO3B
         WFkjbOXPn/z39z+XCtzv9aEXz90eBNY+Bp/h4iBgvhqqXCYkcqioqPMHIKNhXJMO7p/n
         BRbSSNGcAxpivQE7sgnul7dcMGWnQre+JlzMnZR79fNCj2dr5B/h+uVxBUI818ouBjri
         V4vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720452505; x=1721057305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKDSymq46tkzYYGzhbA1pjSZ4iOAbEBbM/RM3zDnGVk=;
        b=N2nu4f/uFTcZHV41NjCG3hMMcLAte90xzXTF+K8494eUx+tkzj1CBh8shxJKWeyTrU
         cN6XEsPlbOjCobXQZsGwsq5B4gjCXaRBG9HtpHbzR3oI8U4Ux0BgZ8j/1Bt1kl0JzuSa
         gLcIcZXrj3/H2zCtCM7F1s66u2QsHhvMP2CTTMvhG1G+hB5ltdeCmKBPhOfL8XwoY8Im
         0JS2hTsX8ttEL/MQ/yYT1d1aSJw8kdQDmRlPoxfH4O3D5UUXGU4UUHlHJW2TL7PEoUh6
         GnNHQip/qFgiOmPlIcM8aZzVywfCbThemgufAHKaSMy7WDvBvAU9ohJ07FEOSui+W7xS
         mBAg==
X-Gm-Message-State: AOJu0YwPxyJmf5NhDutYLuTD+y6LHXdTajsaEIHtV6pw6/VZaAz7Oe9+
	uFYB/4TpUyyhsXsQUeRdxP0eeKzAywASzKFU5q7pum5VCX14Gj9k6deDdQ==
X-Google-Smtp-Source: AGHT+IGPU5qtCvxLBvYPDgmbG92J417Nd9H8q59+sJS6+10qN+31J2WeQNdgFsGEWt9q9yB9bIKHAg==
X-Received: by 2002:a05:6122:3c8d:b0:4f3:17d0:7092 with SMTP id 71dfb90a1353d-4f317d075cemr5409231e0c.16.1720452505141;
        Mon, 08 Jul 2024 08:28:25 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4f33da2e40csm23772e0c.20.2024.07.08.08.28.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:28:24 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] shared/gatt-server: Fix not using correct MTU for responses
Date: Mon,  8 Jul 2024 11:28:23 -0400
Message-ID: <20240708152823.2726052-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Responses shall use the bt_att_channel MTU not the bt_att MTU since the
response shall be send over the same channel as the request.
---
 attrib/gattrib.c         |  8 ++--
 src/shared/att.c         |  5 ++-
 src/shared/att.h         |  2 +-
 src/shared/gatt-client.c |  2 +-
 src/shared/gatt-server.c | 91 +++++++++++++++++++---------------------
 5 files changed, 53 insertions(+), 55 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index 997af3699c51..1795cd3a72ff 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -237,9 +237,9 @@ static void attrib_callback_result(uint8_t opcode, const void *pdu,
 	free(buf);
 }
 
-static void attrib_callback_notify(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void attrib_callback_notify(struct bt_att_chan *chan, uint16_t mtu,
+					uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
 {
 	uint8_t *buf;
 	struct attrib_callbacks *cb = user_data;
@@ -355,7 +355,7 @@ static void client_notify_cb(uint16_t value_handle, const uint8_t *value,
 	if (length)
 		memcpy(buf + 2, value, length);
 
-	attrib_callback_notify(NULL, ATT_OP_HANDLE_NOTIFY, buf, length + 2,
+	attrib_callback_notify(NULL, 0, ATT_OP_HANDLE_NOTIFY, buf, length + 2,
 							user_data);
 }
 
diff --git a/src/shared/att.c b/src/shared/att.c
index 485ef071bb24..a45e9c26801a 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1009,8 +1009,9 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
 		found = true;
 
 		if (notify->callback)
-			notify->callback(chan, opcode, pdu + 1, pdu_len - 1,
-							notify->user_data);
+			notify->callback(chan, chan->mtu, opcode,
+						pdu + 1, pdu_len - 1,
+						notify->user_data);
 
 		/* callback could remove all entries from notify list */
 		if (queue_isempty(att->notify_list))
diff --git a/src/shared/att.h b/src/shared/att.h
index 6fd78636e49b..53a3f7a2ae98 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -35,7 +35,7 @@ int bt_att_get_channels(struct bt_att *att);
 
 typedef void (*bt_att_response_func_t)(uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
-typedef void (*bt_att_notify_func_t)(struct bt_att_chan *chan,
+typedef void (*bt_att_notify_func_t)(struct bt_att_chan *chan, uint16_t mtu,
 					uint8_t opcode, const void *pdu,
 					uint16_t length, void *user_data);
 typedef void (*bt_att_destroy_func_t)(void *user_data);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8e4ae7e5e230..b48d739fc609 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2228,7 +2228,7 @@ static void notify_handler(void *data, void *user_data)
 				value_data->len, notify_data->user_data);
 }
 
-static void notify_cb(struct bt_att_chan *chan, uint8_t opcode,
+static void notify_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					void *user_data)
 {
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 3a53d5dfde6b..b30ec8c6acc9 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -50,6 +50,7 @@ struct async_read_op {
 	struct bt_gatt_server *server;
 	uint8_t opcode;
 	bool done;
+	uint16_t mtu;
 	uint8_t *pdu;
 	size_t pdu_len;
 	size_t value_len;
@@ -228,7 +229,7 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 * value is seen.
 		 */
 		if (iter == 0) {
-			data_val_len = MIN(MIN((unsigned)mtu - 6, 251),
+			data_val_len = MIN(MIN((unsigned int)mtu - 6, 251),
 								value.iov_len);
 			pdu[0] = data_val_len + 4;
 			iter++;
@@ -266,15 +267,14 @@ static void gatt_log(struct bt_gatt_server *server, const char *format, ...)
 	va_end(ap);
 }
 
-static void read_by_grp_type_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void read_by_grp_type_cb(struct bt_att_chan *chan, uint16_t mtu,
+					uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
 	bt_uuid_t type;
 	bt_uuid_t prim, snd;
-	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t rsp_pdu[mtu];
 	uint16_t rsp_len;
 	uint8_t ecode = 0;
@@ -359,11 +359,8 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 						size_t len, void *user_data)
 {
 	struct async_read_op *op = user_data;
-	struct bt_gatt_server *server = op->server;
-	uint16_t mtu;
 	uint16_t handle;
 
-	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
 
 	/* Terminate the operation if there was an error */
@@ -375,7 +372,7 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 	}
 
 	if (op->pdu_len == 0) {
-		op->value_len = MIN(MIN((unsigned) mtu - 4, 253), len);
+		op->value_len = MIN(MIN((unsigned int)op->mtu - 4, 253), len);
 		op->pdu[0] = op->value_len + 2;
 		op->pdu_len++;
 	} else if (len != op->value_len) {
@@ -384,7 +381,7 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 	}
 
 	/* Stop if this would surpass the MTU */
-	if (op->pdu_len + op->value_len + 2 > (unsigned) mtu - 1) {
+	if (op->pdu_len + op->value_len + 2 > (unsigned int) op->mtu - 1) {
 		op->done = true;
 		goto done;
 	}
@@ -395,7 +392,7 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 
 	op->pdu_len += op->value_len + 2;
 
-	if (op->pdu_len == (unsigned) mtu - 1)
+	if (op->pdu_len == (unsigned int) op->mtu - 1)
 		op->done = true;
 
 done:
@@ -491,9 +488,9 @@ error:
 	async_read_op_destroy(op);
 }
 
-static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void read_by_type_cb(struct bt_att_chan *chan, uint16_t mtu,
+				uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
@@ -536,7 +533,8 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 	}
 
 	op = new0(struct async_read_op, 1);
-	op->pdu = malloc(bt_att_get_mtu(server->att));
+	op->mtu = mtu;
+	op->pdu = malloc(mtu);
 	if (!op->pdu) {
 		free(op);
 		ecode = BT_ATT_ERROR_INSUFFICIENT_RESOURCES;
@@ -611,13 +609,12 @@ static bool encode_find_info_rsp(struct gatt_db *db, struct queue *q,
 	return true;
 }
 
-static void find_info_cb(struct bt_att_chan *chan, uint8_t opcode,
+static void find_info_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end;
-	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t rsp_pdu[mtu];
 	uint16_t rsp_len;
 	uint8_t ecode = 0;
@@ -709,14 +706,13 @@ static void find_by_type_val_att_cb(struct gatt_db_attribute *attrib,
 	data->len += 4;
 }
 
-static void find_by_type_val_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void find_by_type_val_cb(struct bt_att_chan *chan, uint16_t mtu,
+					uint8_t opcode, const void *pdu,
+					uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t start, end, uuid16;
 	struct find_by_type_val_data data;
-	uint16_t mtu = bt_att_get_mtu(server->att);
 	uint8_t rsp_pdu[mtu];
 	uint16_t ehandle = 0;
 	bt_uuid_t uuid;
@@ -821,8 +817,8 @@ static uint8_t check_length(uint16_t length, uint16_t offset)
 	return 0;
 }
 
-static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void write_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
+			const void *pdu, uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
@@ -908,12 +904,10 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct async_read_op *op = user_data;
 	struct bt_gatt_server *server = op->server;
 	uint8_t rsp_opcode;
-	uint16_t mtu;
 	uint16_t handle;
 
 	DBG(server, "Read Complete: err %d", err);
 
-	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
 
 	if (err) {
@@ -925,13 +919,14 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	rsp_opcode = get_read_rsp_opcode(op->opcode);
 
 	bt_att_chan_send_rsp(op->chan, rsp_opcode, len ? value : NULL,
-					MIN((unsigned int) mtu - 1, len));
+					MIN((unsigned int) op->mtu - 1, len));
 	async_read_op_destroy(op);
 }
 
 static void handle_read_req(struct bt_att_chan *chan,
-				struct bt_gatt_server *server, uint8_t opcode,
-				uint16_t handle, uint16_t offset)
+				struct bt_gatt_server *server, uint16_t mtu,
+				uint8_t opcode, uint16_t handle,
+				uint16_t offset)
 {
 	struct gatt_db_attribute *attr;
 	uint8_t ecode;
@@ -958,6 +953,7 @@ static void handle_read_req(struct bt_att_chan *chan,
 	op->chan = chan;
 	op->opcode = opcode;
 	op->server = bt_gatt_server_ref(server);
+	op->mtu = mtu;
 
 	if (gatt_db_attribute_read(attr, offset, opcode, server->att,
 							read_complete_cb, op))
@@ -972,8 +968,8 @@ error:
 	bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
 }
 
-static void read_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
-					uint16_t length, void *user_data)
+static void read_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
+			const void *pdu, uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle;
@@ -986,10 +982,10 @@ static void read_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 
 	handle = get_le16(pdu);
 
-	handle_read_req(chan, server, opcode, handle, 0);
+	handle_read_req(chan, server, mtu, opcode, handle, 0);
 }
 
-static void read_blob_cb(struct bt_att_chan *chan, uint8_t opcode,
+static void read_blob_cb(struct bt_att_chan *chan, uint16_t mtu, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					void *user_data)
 {
@@ -1005,7 +1001,7 @@ static void read_blob_cb(struct bt_att_chan *chan, uint8_t opcode,
 	handle = get_le16(pdu);
 	offset = get_le16(pdu + 2);
 
-	handle_read_req(chan, server, opcode, handle, offset);
+	handle_read_req(chan, server, mtu, opcode, handle, offset);
 }
 
 struct read_mult_data {
@@ -1105,6 +1101,7 @@ error:
 
 static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
 						struct bt_att_chan *chan,
+						uint16_t mtu,
 						uint8_t opcode,
 						uint16_t num_handles)
 {
@@ -1118,16 +1115,16 @@ static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
 	data->server = server;
 	data->num_handles = num_handles;
 	data->cur_handle = 0;
-	data->mtu = bt_att_get_mtu(server->att);
+	data->mtu = mtu;
 	data->length = 0;
 	data->rsp_data = new0(uint8_t, data->mtu - 1);
 
 	return data;
 }
 
-static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void read_multiple_cb(struct bt_att_chan *chan, uint16_t mtu,
+				uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
@@ -1141,7 +1138,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 		goto error;
 	}
 
-	data = read_mult_data_new(server, chan, opcode, length / 2);
+	data = read_mult_data_new(server, chan, mtu, opcode, length / 2);
 
 	for (i = 0; i < data->num_handles; i++)
 		data->handles[i] = get_le16(pdu + i * 2);
@@ -1304,9 +1301,9 @@ static void prep_write_complete_cb(struct gatt_db_attribute *attr, int err,
 	free(pwcd);
 }
 
-static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void prep_write_cb(struct bt_att_chan *chan, uint16_t mtu,
+				uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t handle = 0;
@@ -1436,9 +1433,9 @@ static bool find_no_reliable_characteristic(const void *data,
 	return !prep_data->reliable_supported;
 }
 
-static void exec_write_cb(struct bt_att_chan *chan, uint8_t opcode,
-					const void *pdu, uint16_t length,
-					void *user_data)
+static void exec_write_cb(struct bt_att_chan *chan, uint16_t mtu,
+				uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	struct exec_data *data;
@@ -1499,9 +1496,9 @@ error:
 	bt_att_chan_send_error_rsp(chan, opcode, ehandle, ecode);
 }
 
-static void exchange_mtu_cb(struct bt_att_chan *chan, uint8_t opcode,
-				const void *pdu, uint16_t length,
-				void *user_data)
+static void exchange_mtu_cb(struct bt_att_chan *chan, uint16_t mtu,
+				uint8_t opcode, const void *pdu,
+				uint16_t length, void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	uint16_t client_rx_mtu;
-- 
2.45.2

