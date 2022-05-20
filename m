Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A36C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 04:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbiETERM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 00:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiETERK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 00:17:10 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4EF6BFE4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:09 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id oe17-20020a17090b395100b001df77d29587so10451272pjb.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 May 2022 21:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Gv7CsCeeGdZZYw/wLPt9ZJW1vb4D4muTrAmmQBTZmPE=;
        b=GM+V1Fl7VaAyCn0eJ7VUXdPR+L6xww+uJ3WNmleFrDkO8CjHOqkMTgn7EO5SucK/OR
         iyuo+cqqMB4yenvXL0t7ivHdD0+SexX+mIQrO1CHK8r7jsPV4y5LEOMy3bZntgMcGIsL
         cG2xyyqWKOdV+Th71x+uLEO+c/n7cgsa5/w0YdPl+8gjqmQEjY87b1CBxxRCpydJ6osf
         tblF2dxtTCgNQtleP6iBzc1QTQMrNLiLrYLBadA6+edbf8z4ZnP7Zedg/Ua3AJRUuC1b
         YSz1ETmGFSky7nAOKDj460rRY9HCH8uRKnXTjzhNPbRDLQVMh7Xio7+0zPjuWL6tMB+k
         ktJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gv7CsCeeGdZZYw/wLPt9ZJW1vb4D4muTrAmmQBTZmPE=;
        b=wdQNHqNw0SR+3XFt16Na1tJjsZzrhBu9HfUkq68J3glaiafJVrYfBiTgFKHlBeehGd
         DJALYJwPsW3gqXBPUbndL0C72KO7OjvL8KW2t7lIVDeZY5nQMOu2I90wQnPT6Mpg+paf
         i0+xsnQUQCyRGY0KXEgbDtY0L6qcDP2Jw1AdcxScUAJMl8NKtKTqWODsrG3Z/q708DgG
         hT7MrhmDiWpyVD9ST0qP90gChtP7OKiXTkjT/rvRckO6ecNxeExERFyxZ6QmBwrl2/WO
         4BBAjZXhPClzMlSd2CvR+njUujKYUMrttU5mc1/dMZleoZBfMIMsMzCPKij8ZfysJXCt
         taSw==
X-Gm-Message-State: AOAM532iNlP75/+HuJ2CQ6D+1ULtQuow8ySrOsyZGuSIhS1ZH8A2u9ej
        kEzcVqbstWGxSD++I+0FAVVR9D8zT40=
X-Google-Smtp-Source: ABdhPJy6etU65WXPUgKWB6afrvStjIAyqBH1uBm55pmxOtw/CyW9oTTued0uGVBYOxs94MXVwZGbHg==
X-Received: by 2002:a17:902:aa06:b0:158:f13b:4859 with SMTP id be6-20020a170902aa0600b00158f13b4859mr7874356plb.141.1653020228979;
        Thu, 19 May 2022 21:17:08 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u13-20020a17090a450d00b001df955c28f6sm381405pjg.37.2022.05.19.21.17.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 21:17:08 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] monitor/att: Add decoding support for CCC
Date:   Thu, 19 May 2022 21:17:01 -0700
Message-Id: <20220520041701.2572197-7-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520041701.2572197-1-luiz.dentz@gmail.com>
References: <20220520041701.2572197-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds decoding support for CCC so its value can be decoded:

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
> ACL Data RX: Handle 3585 flags 0x02 dlen 6
      ATT: Read Response (0x0b) len 1
        Value: 01
            Notification (0x01)
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
          Data: 0100
            Notification (0x01)
---
 monitor/att.c | 241 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 223 insertions(+), 18 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index 304c37319..f1af420ba 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -215,6 +215,82 @@ static void att_error_response(const struct l2cap_frame *frame)
 	print_field("Error: %s (0x%2.2x)", str, pdu->error);
 }
 
+static const struct bitfield_data ccc_value_table[] = {
+	{  0, "Notification (0x01)"		},
+	{  1, "Indication (0x02)"		},
+	{ }
+};
+
+static void print_ccc_value(uint8_t value)
+{
+	uint8_t mask = value;
+
+	mask = print_bitfield(4, value, ccc_value_table);
+	if (mask)
+		print_text(COLOR_WHITE_BG, "    Unknown fields (0x%2.2x)",
+								mask);
+}
+
+static void gatt_ccc_read(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_ccc_value(value);
+}
+
+static void gatt_ccc_write(const struct l2cap_frame *frame)
+{
+	uint8_t value;
+
+	if (!l2cap_frame_get_u8((void *)frame, &value)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_ccc_value(value);
+}
+
+#define GATT_HANDLER(_uuid, _read, _write, _notify) \
+{ \
+	.uuid = { \
+		.type = BT_UUID16, \
+		.value.u16 = _uuid, \
+	}, \
+	.read = _read, \
+	.write = _write, \
+	.notify = _notify \
+}
+
+struct gatt_handler {
+	bt_uuid_t uuid;
+	void (*read)(const struct l2cap_frame *frame);
+	void (*write)(const struct l2cap_frame *frame);
+	void (*notify)(const struct l2cap_frame *frame);
+} gatt_handlers[] = {
+	GATT_HANDLER(GATT_CLIENT_CHARAC_CFG_UUID, gatt_ccc_read,
+					gatt_ccc_write, NULL)
+};
+
+static struct gatt_handler *get_handler(struct gatt_db_attribute *attr)
+{
+	const bt_uuid_t *uuid = gatt_db_attribute_get_type(attr);
+	size_t i;
+
+	for (i = 0; i < ARRAY_SIZE(gatt_handlers); i++) {
+		struct gatt_handler *handler = &gatt_handlers[i];
+
+		if (!bt_uuid_cmp(&handler->uuid, uuid))
+			return handler;
+	}
+
+	return NULL;
+}
+
 static void att_exchange_mtu_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_exchange_mtu_req *pdu = frame->data;
@@ -326,9 +402,16 @@ static void att_read_type_rsp(const struct l2cap_frame *frame)
 					frame->data + 1, frame->size - 1);
 }
 
+struct att_read {
+	struct gatt_db_attribute *attr;
+	uint16_t cid;
+	void (*func)(const struct l2cap_frame *frame);
+};
+
 struct att_conn_data {
 	struct gatt_db *ldb;
 	struct gatt_db *rdb;
+	struct queue *reads;
 };
 
 static void att_conn_data_free(void *data)
@@ -337,6 +420,7 @@ static void att_conn_data_free(void *data)
 
 	gatt_db_unref(att_data->rdb);
 	gatt_db_unref(att_data->ldb);
+	queue_destroy(att_data->reads, free);
 	free(att_data);
 }
 
@@ -441,13 +525,67 @@ done:
 static void att_read_req(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_read_req *pdu = frame->data;
+	uint16_t handle;
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct att_read *read;
+	struct gatt_db_attribute *attr;
+	struct gatt_handler *handler;
 
-	print_handle(frame, le16_to_cpu(pdu->handle), false);
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
+
+	handle = le16_to_cpu(pdu->handle);
+	print_handle(frame, handle, false);
+
+	attr = get_attribute(frame, handle, false);
+	if (!attr)
+		return;
+
+	handler = get_handler(attr);
+	if (!handler)
+		return;
+
+	conn = packet_get_conn_data(frame->handle);
+	data = conn->data;
+
+	if (!data->reads)
+		data->reads = queue_new();
+
+	read = new0(struct att_read, 1);
+	read->attr = attr;
+	read->cid = frame->cid;
+	read->func = handler->read;
+
+	queue_push_tail(data->reads, read);
+}
+
+static bool match_read_frame(const void *data, const void *match_data)
+{
+	const struct att_read *read = data;
+	const struct l2cap_frame *frame = match_data;
+
+	return read->cid == frame->cid;
 }
 
 static void att_read_rsp(const struct l2cap_frame *frame)
 {
+	struct packet_conn_data *conn;
+	struct att_conn_data *data;
+	struct att_read *read;
+
 	print_hex_field("Value", frame->data, frame->size);
+
+	conn = packet_get_conn_data(frame->handle);
+	if (!conn)
+		return;
+
+	data = conn->data;
+
+	read = queue_find(data->reads, match_read_frame, frame);
+	if (!read)
+		return;
+
+	read->func(frame);
 }
 
 static void att_read_blob_req(const struct l2cap_frame *frame)
@@ -509,10 +647,41 @@ static void att_read_group_type_rsp(const struct l2cap_frame *frame)
 					frame->data + 1, frame->size - 1);
 }
 
+static void print_write(const struct l2cap_frame *frame, uint16_t handle,
+							size_t len)
+{
+	struct gatt_db_attribute *attr;
+	struct gatt_handler *handler;
+
+	print_handle(frame, handle, false);
+	print_hex_field("  Data", frame->data, frame->size);
+
+	if (len > frame->size) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	attr = get_attribute(frame, handle, false);
+	if (!attr)
+		return;
+
+	handler = get_handler(attr);
+	if (!handler)
+		return;
+
+	handler->write(frame);
+}
+
 static void att_write_req(const struct l2cap_frame *frame)
 {
-	print_handle(frame, get_le16(frame->data), false);
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+	uint16_t handle;
+
+	if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_write(frame, handle, frame->size);
 }
 
 static void att_write_rsp(const struct l2cap_frame *frame)
@@ -553,20 +722,49 @@ static void att_execute_write_req(const struct l2cap_frame *frame)
 	print_field("Flags: %s (0x%02x)", flags_str, flags);
 }
 
+static void print_notify(const struct l2cap_frame *frame, uint16_t handle,
+								size_t len)
+{
+	struct gatt_db_attribute *attr;
+	struct gatt_handler *handler;
+
+	print_handle(frame, handle, true);
+	print_hex_field("  Data", frame->data, len);
+
+	if (len > frame->size) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	attr = get_attribute(frame, handle, true);
+	if (!attr)
+		return;
+
+	handler = get_handler(attr);
+	if (!handler)
+		return;
+
+	handler->notify(frame);
+}
+
 static void att_handle_value_notify(const struct l2cap_frame *frame)
 {
+	uint16_t handle;
 	const struct bt_l2cap_att_handle_value_notify *pdu = frame->data;
 
-	print_handle(frame, le16_to_cpu(pdu->handle), true);
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
+
+	handle = le16_to_cpu(pdu->handle);
+	print_notify(frame, handle, frame->size);
 }
 
 static void att_handle_value_ind(const struct l2cap_frame *frame)
 {
 	const struct bt_l2cap_att_handle_value_ind *pdu = frame->data;
 
-	print_handle(frame, le16_to_cpu(pdu->handle), true);
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+	l2cap_frame_pull((void *)frame, frame, sizeof(*pdu));
+
+	print_notify(frame, le16_to_cpu(pdu->handle), frame->size);
 }
 
 static void att_handle_value_conf(const struct l2cap_frame *frame)
@@ -591,13 +789,7 @@ static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
 
 		print_field("Length: 0x%4.4x", len);
 
-		print_hex_field("  Data", f->data,
-				len < f->size ? len : f->size);
-
-		if (len > f->size) {
-			print_text(COLOR_ERROR, "invalid size");
-			return;
-		}
+		print_notify(frame, handle, len);
 
 		l2cap_frame_pull(f, f, len);
 	}
@@ -605,14 +797,27 @@ static void att_multiple_vl_rsp(const struct l2cap_frame *frame)
 
 static void att_write_command(const struct l2cap_frame *frame)
 {
-	print_handle(frame, get_le16(frame->data), false);
-	print_hex_field("  Data", frame->data + 2, frame->size - 2);
+	uint16_t handle;
+
+	if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_write(frame, handle, frame->size);
 }
 
 static void att_signed_write_command(const struct l2cap_frame *frame)
 {
-	print_handle(frame, get_le16(frame->data), false);
-	print_hex_field("  Data", frame->data + 2, frame->size - 2 - 12);
+	uint16_t handle;
+
+	if (!l2cap_frame_get_le16((void *)frame, &handle)) {
+		print_text(COLOR_ERROR, "invalid size");
+		return;
+	}
+
+	print_write(frame, handle, frame->size - 12);
+	print_hex_field("  Data", frame->data, frame->size - 12);
 	print_hex_field("  Signature", frame->data + frame->size - 12, 12);
 }
 
-- 
2.35.1

