Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3677042061
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711639963; cv=none; b=G47ORFCsxFs0r+K4VTzN5tSdig0v0J0qYSeIXj06QNrDQW2ErUraA6O4Qf/XHmXrlhp0SCND3u1OE9u4FscU+RjPor2yInBjFNlOzVgemf+5rWkgoSUdYhpMDTcxTY0M5cGnOU1OUXl6u9c2lyHVUGeDHG/AL8vb6Rop+DrLCuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711639963; c=relaxed/simple;
	bh=s6AjkKM7l67Jm+PfQ3eIayWlh2msnynhMYKZ5DTJh7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AJymemKvasyUFC1Srfuw7LdZG+opCDbjL22EFDT3nup+MEJrDIgow8VvgItgWoDVqpAAywmB3pDYKK5PDFtW2idhVopvl7iCp4wI+tgCMcNH8TtDyw7ivmdoxNNVl7OyceGlr13pwXgcF5/vOMs8o+qXCaRaQ1yoUgQg+2enzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4lo84wf; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4lo84wf"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-609f359b7b1so12838317b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 08:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711639959; x=1712244759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqAAinjxXlYVUnmS5EdjylhAd2XALLPVKnOHpdRZeF8=;
        b=D4lo84wf+NwMFjjpQCWAWRVUypA2oybcNKrUmdcWs0MD8z2NGe3ZZoYSAMO/SWTqjY
         Iub9oN1LIexqrTtalLDCiPo/X1MXbitv5tNoMG92F/dK3gvaeRm0KYWYcmlUtXhGA030
         HymDWEUsdY6tbyDgGpITz2NAiTeAXq+v8yJdh5pjkb197nY4S4L02sNO9ef+ag2TFBQZ
         VQO0lsQNT7AMQ8h/5+SqDc8/WDkU5vUNcZPuzIuxTo59VnKoj4CutF2w5HprDy+Nlp+Y
         mMFlwF/5dTdIqaRT4tUfyWl9QLGGdMUuo0pgERItI7uL+mt17yKaPpzVrFYC4Sdl3VKU
         gr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711639959; x=1712244759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqAAinjxXlYVUnmS5EdjylhAd2XALLPVKnOHpdRZeF8=;
        b=n21hyXauQ87Aq6MxTg+84Us5Unc60Sx9b6Ai+jhud+nNRlBTQdh7xRTm/gRMdPCwi9
         UZYd3i/6oYhalpu9ExDKOWHnHcsKrvUbfjqAlLpYATSmAqmAu9PLRQKkte2Bmi12qUmF
         c5Uc9/6t5q/Q9vxNRm+VQPW5Wde2659GYDN1KbllaLQWnQfVpMtbmPl7e4YkJeQXnxSC
         vhNhAyIqu1BXrAi4onw0PoIRsk0kLchrPx0B7kfbhNWC8Dwqj1frLXbfuJsI91VXv/H+
         zb5x//pDzpW1Q8XDAVrcf14Epr3j+8atzuwpxQ12PBQ85Wh6RJUVj47Xihb3unI2Qcr9
         Yf0g==
X-Gm-Message-State: AOJu0YzXgS/zGmposJUDtSYZ2gkFDXCP3pN1LUbY4JxNYDJUFQh+FdOz
	Uslhd1lsxG3DDp4XXHKp2C6KxpJNGzF1+CY4nOW5deRWxx7Xp/n6b7M0cOjZ
X-Google-Smtp-Source: AGHT+IFhQfDIsSo2JFjoHrQLGUn0pMTXPgSSLUTwA8Rvd0W09za1ogIxWDYDGU0UHYiCiurl6meeZw==
X-Received: by 2002:a81:a142:0:b0:611:1be6:bee6 with SMTP id y63-20020a81a142000000b006111be6bee6mr3146519ywg.19.1711639959003;
        Thu, 28 Mar 2024 08:32:39 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id k36-20020a81ac24000000b0060a17127a36sm353665ywh.37.2024.03.28.08.32.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:32:38 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor/att: Add support for decoding GATT Long Reads
Date: Thu, 28 Mar 2024 11:32:35 -0400
Message-ID: <20240328153237.1752328-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for decoding GATT Long Reads:

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x0028 Type: Report Map (0x2a4b)
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Response (0x0b) len 22
        Value[22]: 05010902a10185020901a10095107501150025010509
        Long Value[22]: 05010902a10185020901a10095107501150025010509
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0016
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 19012910810205011601f826ff07750c950209300931
        Long Value[44]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c950209300931
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x002c
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 81061581257f75089501093881069501050c0a380281
        Long Value[66]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c9502093009318106
                        1581257f75089501
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0042
> ACL Data RX: Handle 3585 flags 0x02 dlen 27
      ATT: Read Blob Response (0x0d) len 22
        Value[22]: 06c0c00643ff0a0202a101851175089513150026ff00
        Long Value[88]: 05010902a10185020901a1009510750115002501050919
                        012910810205011601f826ff07750c9502093009318106
                        1581257f75089501093881069501050c0a38028106c0c0
                        0643ff0a0202a101851175089513150026ff00
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Read Blob Request (0x0c) len 4
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Offset: 0x0058
> ACL Data RX: Handle 3585 flags 0x02 dlen 14
      ATT: Read Blob Response (0x0d) len 9
        Value[9]: 0902810009029100c0
        Handle: 0x0028 Type: Report Map (0x2a4b)
        Value[97]: 05010902a10185020901a1009510750115002501050919
                   012910810205011601f826ff07750c9502093009318106
                   1581257f75089501093881069501050c0a38028106c0c0
                   0643ff0a0202a101851175089513150026ff0009028100
                   09029100c0
---
 monitor/att.c     | 125 +++++++++++++++++++++++++++++++++++++++-------
 monitor/display.h |   2 +-
 2 files changed, 108 insertions(+), 19 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 4628db44b139..3e5d7f12d182 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -46,10 +46,12 @@
 #include "keys.h"
 
 struct att_read {
+	struct att_conn_data *conn;
 	struct gatt_db_attribute *attr;
 	bool in;
 	uint16_t chan;
 	void (*func)(const struct l2cap_frame *frame);
+	struct iovec *iov;
 };
 
 struct att_conn_data {
@@ -58,6 +60,7 @@ struct att_conn_data {
 	struct gatt_db *rdb;
 	struct timespec rdb_mtim;
 	struct queue *reads;
+	uint16_t mtu;
 };
 
 static void print_uuid(const char *label, const void *data, uint16_t size)
@@ -210,6 +213,15 @@ done:
 	print_field("Handle: 0x%4.4x", handle);
 }
 
+static void att_read_free(struct att_read *read)
+{
+	if (!read)
+		return;
+
+	util_iov_free(read->iov, 1);
+	free(read);
+}
+
 static void print_data_list(const char *label, uint8_t length,
 					const struct l2cap_frame *frame)
 {
@@ -231,7 +243,7 @@ static void print_data_list(const char *label, uint8_t length,
 
 		print_hex_field("Value", frame->data, length - 2);
 
-		if (read) {
+		if (read && read->func) {
 			struct l2cap_frame f;
 
 			l2cap_frame_clone_size(&f, frame, length - 2);
@@ -244,7 +256,7 @@ static void print_data_list(const char *label, uint8_t length,
 	}
 
 	packet_hexdump(frame->data, frame->size);
-	free(read);
+	att_read_free(read);
 }
 
 static void print_attribute_info(uint16_t type, const void *data, uint16_t len)
@@ -370,7 +382,7 @@ static void att_error_response(const struct l2cap_frame *frame)
 	 */
 	if (pdu->request == 0x08 || pdu->request == 0x0a ||
 					pdu->request == 0x10)
-		free(att_get_read(frame));
+		att_read_free(att_get_read(frame));
 }
 
 static const struct bitfield_data chrc_prop_table[] = {
@@ -4095,9 +4107,23 @@ static void att_exchange_mtu_req(const struct l2cap_frame *frame)
 
 static void att_exchange_mtu_rsp(const struct l2cap_frame *frame)
 {
-	const struct bt_l2cap_att_exchange_mtu_rsp *pdu = frame->data;
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	uint16_t mtu;
 
-	print_field("Server RX MTU: %d", le16_to_cpu(pdu->mtu));
+	if (!l2cap_frame_get_le16((void *)frame, &mtu)) {
+		print_text(COLOR_ERROR, "  invalid size");
+		return;
+	}
+
+	print_field("Server RX MTU: %d", mtu);
+
+	conn = packet_get_conn_data(frame->handle);
+	data = att_get_conn_data(conn);
+	if (!data)
+		return;
+
+	data->mtu = mtu;
 }
 
 static void att_find_info_req(const struct l2cap_frame *frame)
@@ -4261,8 +4287,6 @@ static void queue_read(const struct l2cap_frame *frame, bt_uuid_t *uuid,
 	}
 
 	handler = attr ? get_handler(attr) : get_handler_uuid(uuid);
-	if (!handler || !handler->read)
-		return;
 
 	conn = packet_get_conn_data(frame->handle);
 	data = att_get_conn_data(conn);
@@ -4273,10 +4297,11 @@ static void queue_read(const struct l2cap_frame *frame, bt_uuid_t *uuid,
 		data->reads = queue_new();
 
 	read = new0(struct att_read, 1);
+	read->conn = data;
 	read->attr = attr;
 	read->in = frame->in;
 	read->chan = frame->chan;
-	read->func = handler->read;
+	read->func = handler ? handler->read : NULL;
 
 	queue_push_tail(data->reads, read);
 }
@@ -4334,31 +4359,95 @@ static void att_read_req(const struct l2cap_frame *frame)
 	queue_read(frame, NULL, handle);
 }
 
+static void att_read_append(struct att_read *read,
+				const struct l2cap_frame *frame)
+{
+	if (!read->iov)
+		read->iov = new0(struct iovec, 1);
+	util_iov_append(read->iov, frame->data, frame->size);
+}
+
+static void att_read_func(struct att_read *read,
+				const struct l2cap_frame *frame)
+{
+	att_read_append(read, frame);
+
+	print_attribute(read->attr);
+	print_hex_field("Value", read->iov->iov_base, read->iov->iov_len);
+
+	if (read->func) {
+		struct l2cap_frame f = *frame;
+
+		f.data = read->iov->iov_base;
+		f.size = read->iov->iov_len;
+
+		read->func(&f);
+	}
+
+	att_read_free(read);
+}
+
 static void att_read_rsp(const struct l2cap_frame *frame)
 {
 	struct att_read *read;
 
+	print_hex_field("Value", frame->data, frame->size);
+
 	read = att_get_read(frame);
 	if (!read)
 		return;
 
-	print_attribute(read->attr);
-	print_hex_field("Value", frame->data, frame->size);
+	/* Check if the data size is equal to the MTU then read long procedure
+	 * maybe used.
+	 */
+	if (frame->size == read->conn->mtu - 1) {
+		att_read_append(read, frame);
+		print_hex_field("Long Value", read->iov->iov_base,
+					read->iov->iov_len);
+		queue_push_head(read->conn->reads, read);
+		return;
+	}
 
-	read->func(frame);
-
-	free(read);
+	att_read_func(read, frame);
 }
 
 static void att_read_blob_req(const struct l2cap_frame *frame)
 {
-	print_handle(frame, get_le16(frame->data), false);
-	print_field("Offset: 0x%4.4x", get_le16(frame->data + 2));
+	uint16_t handle, offset;
+	struct att_read *read;
+
+	if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	if (!l2cap_frame_get_le16((void *)frame, &offset)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_handle(frame, handle, false);
+	print_field("Offset: 0x%4.4x", offset);
+
+	read = att_get_read(frame);
+	if (!read)
+		return;
+
+	/* Check if attribute handle and offset match so the read object shall
+	 * be keeped.
+	 */
+	if (gatt_db_attribute_get_handle(read->attr) == handle &&
+				offset == read->iov->iov_len) {
+		queue_push_head(read->conn->reads, read);
+		return;
+	}
+
+	att_read_func(read, frame);
 }
 
 static void att_read_blob_rsp(const struct l2cap_frame *frame)
 {
-	packet_hexdump(frame->data, frame->size);
+	att_read_rsp(frame);
 }
 
 static void att_read_multiple_req(const struct l2cap_frame *frame)
@@ -4403,7 +4492,7 @@ static void print_group_list(const char *label, uint8_t length,
 		print_handle_range("Handle range", frame->data);
 		print_uuid("UUID", frame->data + 4, length - 4);
 
-		if (read) {
+		if (read && read->func) {
 			struct l2cap_frame f;
 
 			l2cap_frame_clone_size(&f, frame, length);
@@ -4416,7 +4505,7 @@ static void print_group_list(const char *label, uint8_t length,
 	}
 
 	packet_hexdump(frame->data, frame->size);
-	free(read);
+	att_read_free(read);
 }
 
 static void att_read_group_type_rsp(const struct l2cap_frame *frame)
diff --git a/monitor/display.h b/monitor/display.h
index 5a82f8e6fd93..ee076448cc31 100644
--- a/monitor/display.h
+++ b/monitor/display.h
@@ -87,7 +87,7 @@ static inline void print_hex_field(const char *label, const uint8_t *data,
 	for (i = 0; i < len; i++)
 		sprintf(str + (i * 2), "%2.2x", data[i]);
 
-	print_field("%s: %s", label, str);
+	print_field("%s[%u]: %s", label, len, str);
 }
 
 void set_default_pager_num_columns(int num_columns);
-- 
2.44.0

