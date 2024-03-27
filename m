Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911A12EBED
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 15:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552054; cv=none; b=HUrsKi+s2IKk/UZtAIWgS46qUOB3fDfBPDaIVa1C5Fyh6SxEy0pbOy8g17cWTFai2ZdaRLk26kqmgAkd6PJhhgrx54IuFtXbrQ7fX47ACgSmrNtO7+6d43zJyf2A2kmD/8bEE8iTSgMrQb/Q+roxs6qlYj2x9Mp90oJCcs9au40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552054; c=relaxed/simple;
	bh=s6AjkKM7l67Jm+PfQ3eIayWlh2msnynhMYKZ5DTJh7Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AJSB9GIUkPUq9Cs7QGWO9eU6NRS9+JPbgJGgOy/qVOhNR/kc/EQsnkIaD9Ikol55uRLIjEG3OoalyWvReY/5yGte561Y9n8yHHjR3GfsUkEZHVgUHnQ5pwEiHVlXnUOctWo5HBbPWTcbAUwyScvLHpH5eMsBbhwfF1Q/XbAc76w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nTeUm6nx; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTeUm6nx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-609ed7ca444so68114877b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Mar 2024 08:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711552050; x=1712156850; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=VqAAinjxXlYVUnmS5EdjylhAd2XALLPVKnOHpdRZeF8=;
        b=nTeUm6nxMRPSwNirpMsB0MN0AswUa7RVYrpNK7dIgt17C+44uDDlYvj0k+w/eoM/OI
         9QjwMWjbr0BLQcWb9oWwqY70PcQzypVl6S1K3eDVdKCvMkIRG+ivT6Yh6ow9+VUKCK56
         w/lYDGIjbIkmqLknVtRKP9EQEb2KGY/8RIly1prS7GirVDK80O2LjYv0wDa7EQFIakwr
         nLucDHyVaN6fCBIiHRCMT1qVQlXP3y8zyInKMBzGcEu0nuPXl946ftFb4F75b8yw4Ze+
         BfgI4gPO9flzhM1VffHZWgErA772FTZU1eZBw/730CC4/LDpqBhlTeCeJACfzDCjrz4J
         2OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711552050; x=1712156850;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VqAAinjxXlYVUnmS5EdjylhAd2XALLPVKnOHpdRZeF8=;
        b=SPVIwnynGE32tD3ebrIn5INBn7EX9GE8CL6jLFAraFnMW17MS3D4ouVuaUqvHAMmPp
         rvTOmvo4STNa3E/OqmbccubQAcdKbBfO/RbaqP/kp4ERnIOE+wHGV4xdXtFsMBETdh1q
         5cy54LG3EnOsrG1XR7+VleAI5q4jLh2b/APTg01xkZYS16ZGmeP4Xdmu3saOLBh0YqiA
         XhOq+MGxSsCJ7pWKG3uGxNCyitHlJFp3W7j/e82Oy6GnweL+dQKPvwjeGoMDt7GZQOBa
         ISKo4nmgvI8eEwtceFFbNvTf4LeqA9qSzrB23qYOt/jybivX5L0/8XvaQcFuJ/PENAWO
         Yf4g==
X-Gm-Message-State: AOJu0YzBuAyIgfluk7y3rlr+eRb6DIq3nm0jJNH0B2U4F5k8QbAnglgr
	BxIC3MaM8RF9Jbrb/8z5452dPkZfPVc5cNOh9kUUB3gMI2/iqST+UUGOsTqy
X-Google-Smtp-Source: AGHT+IFr2pdEocDB06D118uJhxhASM0nDq93x2VdVwohPdprXXmpAOb1E+wvq1cD622NvYTl9Akflg==
X-Received: by 2002:a81:914b:0:b0:610:d2fe:3ef1 with SMTP id i72-20020a81914b000000b00610d2fe3ef1mr4498770ywg.9.1711552050092;
        Wed, 27 Mar 2024 08:07:30 -0700 (PDT)
Received: from lvondent-mobl4.. (107-146-107-067.biz.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id dc1-20020a05690c0f0100b0061129ac87fcsm1960073ywb.113.2024.03.27.08.07.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 08:07:29 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] monitor/att: Add support for decoding GATT Long Reads
Date: Wed, 27 Mar 2024 11:07:27 -0400
Message-ID: <20240327150727.1584607-1-luiz.dentz@gmail.com>
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

