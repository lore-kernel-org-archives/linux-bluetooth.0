Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58399C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Nov 2022 21:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiKDVgz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiKDVgx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Nov 2022 17:36:53 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC9649B77
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Nov 2022 14:36:52 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso9356317pjg.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 04 Nov 2022 14:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XMD5vQCV8GDZ7SOShRSqUlhWC9SWNwH1MWaerbCB1yU=;
        b=C/lKptZ6WtSqChBVVbrAOaw8jfJHOqFI8B2oT9qMVVdIa809aLmNet7GRFRtHk4UCQ
         cpXGOYSqW+VITueJv5/yDZpLKO0ZL1GzS0YxhCVGJhV/EMvavrc5gB6aoPLUjzpln1oD
         LROv4/BBPWAZak0/KWOgT1a6jNpE48vjlG3wl6O0WlAKB9j6qpXZkyHCcDaG++BbseRz
         71GcPlpgW/VwjCZb0PFtcA16XMmaJd7+4yCK7TNY6dHKLdgTaM9kdswkTnFPtLkXaqI1
         joxrvtPCVeQTCPOS/lYxf9jMxTWSBXeQHqX15l4wW0Jt7nOum/U9JzOs0S0VwAVNaO6C
         l8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMD5vQCV8GDZ7SOShRSqUlhWC9SWNwH1MWaerbCB1yU=;
        b=4FRXYUekzMZYydrDiQPbTBNEN2mzcPBgxVjVXaTqwtrMIQsD0+xeukWmO/OiiL1IAD
         t7Ep2qsQ5BEB6aBSUz89Yg3h2x1CIXIJMLFUy3KPMiRvg2K0zX1zcvbsKN6A2XO23dOK
         UN+l05Zv3Hzfp33t053DNPYFdbWN5HoO8IzUd2xHxCysD7u1PfjXwCMSCEb/BIfnVuog
         vudy2OYh9nzhl/+Hi9CukNclPLhrh3fm2IpYLS6LVvCdVNXCnCisfMbrFW3990Pglvsw
         RpMxSw/VEK6fgW41jRBTrrI10I3i2VcaQU82H6xTCm7V4pRxnJ5d54Aqxetdd/A4497T
         arQg==
X-Gm-Message-State: ACrzQf14Y4xauxp6OPKv7S1Vd6+QF4ZIMLU/NcdOKaOX3idbf0/pAO/y
        5dyHT5WxeLUdeBqyM7hEtRQMkddjAyw=
X-Google-Smtp-Source: AMsMyM5eLWGll7BymPn+rBma/IVXfPozc4gI/08FIUYIgmIa65MtTwLFGTzpkqvhGps0WNk+mEtPog==
X-Received: by 2002:a17:90a:8808:b0:213:c7d0:2217 with SMTP id s8-20020a17090a880800b00213c7d02217mr33648842pjn.231.1667597811347;
        Fri, 04 Nov 2022 14:36:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 15-20020a17090a08cf00b001efa9e83927sm2041027pjn.51.2022.11.04.14.36.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 14:36:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] monitor/att: Add handler support for Read by Type
Date:   Fri,  4 Nov 2022 14:36:48 -0700
Message-Id: <20221104213649.36925-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds handler support for Read by Type so it can further decode
the values when the procedure is used.
---
 monitor/att.c   | 206 ++++++++++++++++++++++++++++++++++--------------
 monitor/l2cap.h |  13 ++-
 2 files changed, 155 insertions(+), 64 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index fbd75db03b83..289f4fc04d9a 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -43,6 +43,21 @@
 #include "l2cap.h"
 #include "att.h"
 
+struct att_read {
+	struct gatt_db_attribute *attr;
+	bool in;
+	uint16_t chan;
+	void (*func)(const struct l2cap_frame *frame);
+};
+
+struct att_conn_data {
+	struct gatt_db *ldb;
+	struct timespec ldb_mtim;
+	struct gatt_db *rdb;
+	struct timespec rdb_mtim;
+	struct queue *reads;
+};
+
 static void print_uuid(const char *label, const void *data, uint16_t size)
 {
 	const char *str;
@@ -77,27 +92,66 @@ static void print_handle_range(const char *label, const void *data)
 				get_le16(data), get_le16(data + 2));
 }
 
-static void print_data_list(const char *label, uint8_t length,
-					const void *data, uint16_t size)
+static bool match_read_frame(const void *data, const void *match_data)
 {
+	const struct att_read *read = data;
+	const struct l2cap_frame *frame = match_data;
+
+	/* Read frame and response frame shall be in the opposite direction to
+	 * match.
+	 */
+	if (read->in == frame->in)
+		return false;
+
+	return read->chan == frame->chan;
+}
+
+static void print_data_list(const char *label, uint8_t length,
+					const struct l2cap_frame *frame)
+{
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct att_read *read;
 	uint8_t count;
 
 	if (length == 0)
 		return;
 
-	count = size / length;
+	conn = packet_get_conn_data(frame->handle);
+	if (conn) {
+		data = conn->data;
+		if (data)
+			read = queue_remove_if(data->reads, match_read_frame,
+						(void *)frame);
+		else
+			read = NULL;
+	} else
+		read = NULL;
+
+	count = frame->size / length;
 
 	print_field("%s: %u entr%s", label, count, count == 1 ? "y" : "ies");
 
-	while (size >= length) {
-		print_field("Handle: 0x%4.4x", get_le16(data));
-		print_hex_field("Value", data + 2, length - 2);
+	while (frame->size >= length) {
+		if (!l2cap_frame_print_le16((void *)frame, "Handle"))
+			break;
 
-		data += length;
-		size -= length;
+		print_hex_field("Value", frame->data, length - 2);
+
+		if (read) {
+			struct l2cap_frame f;
+
+			l2cap_frame_clone_size(&f, frame, length - 2);
+
+			read->func(&f);
+		}
+
+		if (!l2cap_frame_pull((void *)frame, frame, length - 2))
+			break;
 	}
 
-	packet_hexdump(data, size);
+	packet_hexdump(frame->data, frame->size);
+	free(read);
 }
 
 static void print_attribute_info(uint16_t type, const void *data, uint16_t len)
@@ -2292,9 +2346,8 @@ struct gatt_handler {
 	GATT_HANDLER(0x2bba, content_control_id_read, NULL, NULL),
 };
 
-static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
+static struct gatt_handler *get_handler_uuid(const bt_uuid_t *uuid)
 {
-	const bt_uuid_t *uuid = gatt_db_attribute_get_type(attr);
 	size_t i;
 
 	for (i = 0; i < ARRAY_SIZE(gatt_handlers); i++) {
@@ -2307,6 +2360,11 @@ static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
 	return NULL;
 }
 
+static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
+{
+	return get_handler_uuid(gatt_db_attribute_get_type(attr));
+}
+
 static void att_exchange_mtu_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_exchange_mtu_req *pdu = frame->data;
@@ -2403,36 +2461,23 @@ static void att_find_by_type_val_rsp(const struct l2cap_frame *frame)
 	packet_hexdump(ptr, len);
 }
 
-static void att_read_type_req(const struct l2cap_frame *frame)
+static int bt_uuid_from_data(bt_uuid_t *uuid, const void *data, uint16_t size)
 {
-	print_handle_range("Handle range", frame->data);
-	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
+	uint128_t u128;
+
+	switch (size) {
+	case 2:
+		return bt_uuid16_create(uuid, get_le16(data));
+	case 4:
+		return bt_uuid32_create(uuid, get_le32(data));
+	case 16:
+		memcpy(u128.data, data, sizeof(u128.data));
+		return bt_uuid128_create(uuid, u128);
+	}
+
+	return -EINVAL;
 }
 
-static void att_read_type_rsp(const struct l2cap_frame *frame)
-{
-	const struct bt_l2cap_att_read_group_type_rsp *pdu = frame->data;
-
-	print_field("Attribute data length: %d", pdu->length);
-	print_data_list("Attribute data list", pdu->length,
-					frame->data + 1, frame->size - 1);
-}
-
-struct att_read {
-	struct gatt_db_attribute *attr;
-	bool in;
-	uint16_t chan;
-	void (*func)(const struct l2cap_frame *frame);
-};
-
-struct att_conn_data {
-	struct gatt_db *ldb;
-	struct timespec ldb_mtim;
-	struct gatt_db *rdb;
-	struct timespec rdb_mtim;
-	struct queue *reads;
-};
-
 static void att_conn_data_free(void *data)
 {
 	struct att_conn_data *att_data = data;
@@ -2443,6 +2488,67 @@ static void att_conn_data_free(void *data)
 	free(att_data);
 }
 
+static struct att_conn_data *att_get_conn_data(struct packet_conn_data *conn)
+{
+	struct att_conn_data *data = conn->data;
+
+	if (data)
+		return data;
+
+	data = new0(struct att_conn_data, 1);
+	data->rdb = gatt_db_new();
+	data->ldb = gatt_db_new();
+	conn->data = data;
+	conn->destroy = att_conn_data_free;
+
+	return data;
+}
+
+static void att_read_type_req(const struct l2cap_frame *frame)
+{
+	bt_uuid_t uuid;
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct att_read *read;
+	struct gatt_handler *handler;
+
+	print_handle_range("Handle range", frame->data);
+	print_uuid("Attribute type", frame->data + 4, frame->size - 4);
+
+	if (bt_uuid_from_data(&uuid, frame->data + 4, frame->size - 4))
+		return;
+
+	handler = get_handler_uuid(&uuid);
+	if (!handler || !handler->read)
+		return;
+
+	conn = packet_get_conn_data(frame->handle);
+	data = att_get_conn_data(conn);
+
+	if (!data->reads)
+		data->reads = queue_new();
+
+	read = new0(struct att_read, 1);
+	read->in = frame->in;
+	read->chan = frame->chan;
+	read->func = handler->read;
+
+	queue_push_tail(data->reads, read);
+}
+
+static void att_read_type_rsp(const struct l2cap_frame *frame)
+{
+	uint8_t len;
+
+	if (!l2cap_frame_get_u8((void *)frame, &len)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_field("Attribute data length: %d", len);
+	print_data_list("Attribute data list", len, frame);
+}
+
 static void gatt_load_db(struct gatt_db *db, const char *filename,
 						struct timespec *mtim)
 {
@@ -2467,19 +2573,11 @@ static void gatt_load_db(struct gatt_db *db, const char *filename,
 
 static void load_gatt_db(struct packet_conn_data *conn)
 {
-	struct att_conn_data *data = conn->data;
+	struct att_conn_data *data = att_get_conn_data(conn);
 	char filename[PATH_MAX];
 	char local[18];
 	char peer[18];
 
-	if (!data) {
-		data = new0(struct att_conn_data, 1);
-		data->rdb = gatt_db_new();
-		data->ldb = gatt_db_new();
-		conn->data = data;
-		conn->destroy = att_conn_data_free;
-	}
-
 	ba2str((bdaddr_t *)conn->src, local);
 	ba2str((bdaddr_t *)conn->dst, peer);
 
@@ -2605,20 +2703,6 @@ static void att_read_req(const struct l2cap_frame *frame)
 	queue_push_tail(data->reads, read);
 }
 
-static bool match_read_frame(const void *data, const void *match_data)
-{
-	const struct att_read *read = data;
-	const struct l2cap_frame *frame = match_data;
-
-	/* Read frame and response frame shall be in the opposite direction to
-	 * match.
-	 */
-	if (read->in == frame->in)
-		return false;
-
-	return read->chan == frame->chan;
-}
-
 static void att_read_rsp(const struct l2cap_frame *frame)
 {
 	struct packet_conn_data *conn;
diff --git a/monitor/l2cap.h b/monitor/l2cap.h
index e63377857cf7..935066e6e7dc 100644
--- a/monitor/l2cap.h
+++ b/monitor/l2cap.h
@@ -31,8 +31,9 @@ void l2cap_frame_init(struct l2cap_frame *frame, uint16_t index, bool in,
 				uint16_t cid, uint16_t psm,
 				const void *data, uint16_t size);
 
-static inline void l2cap_frame_clone(struct l2cap_frame *frame,
-				const struct l2cap_frame *source)
+static inline void l2cap_frame_clone_size(struct l2cap_frame *frame,
+				const struct l2cap_frame *source,
+				uint16_t size)
 {
 	if (frame != source) {
 		frame->index   = source->index;
@@ -44,10 +45,16 @@ static inline void l2cap_frame_clone(struct l2cap_frame *frame,
 		frame->chan    = source->chan;
 		frame->mode    = source->mode;
 		frame->data    = source->data;
-		frame->size    = source->size;
+		frame->size    = size;
 	}
 }
 
+static inline void l2cap_frame_clone(struct l2cap_frame *frame,
+				const struct l2cap_frame *source)
+{
+	l2cap_frame_clone_size(frame, source, source->size);
+}
+
 static inline void *l2cap_frame_pull(struct l2cap_frame *frame,
 				const struct l2cap_frame *source, uint16_t len)
 {
-- 
2.37.3

