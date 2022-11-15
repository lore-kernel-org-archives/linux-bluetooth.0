Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B21C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiKOAan (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiKOAam (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:42 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99176D11D
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:41 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id o13so11752091pgu.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YrZksNtxMwN8zKibp2Oab3a3oHg6YCF87gJfDncnNok=;
        b=BzDIGm7+HtGWrFW4lhVXwmuOUURhPY0eUc2jwnoctQimeQdj4NmmNcT+lR/dYI4/ei
         7prx9L3hlRBxvfswPpg3I2HGPy+pnSgBu6XdQFfZu5j5LMj+CO0SeJfdeH+zHDaQNoZw
         Ttn6qnUM4au1CXZX4y1ZziAdqci0DW1hNT0RFs+EQEwhaGnEN4ejh+ZlGW+gTyZpuUYI
         Tm8+QSOUgtkraWUPFdmaWVIzlcdZI6Qj/W71usHqGURc+EjLN9MEAjVdJG/FtS7IyZDE
         Zee0zFUheelz1f9JG5lo/qhxkPHxV8N5UOAdCBi4l4ix5bqBwnoIONE0fcvPEKSQelhV
         ojJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YrZksNtxMwN8zKibp2Oab3a3oHg6YCF87gJfDncnNok=;
        b=xbL9yXOZsBNcmRc483aeF9QaNOaVbtomkpe6d6BkHsKMT5o4Ccu/ekRlmMepNofp+3
         YjTDV6rV1wv5lrsxpDPmD5kDXTMCKQhcxsjxEm8nSHr+12JPmG0DHNrBCNbZnju2cE07
         prhmEKu93fwcJnAfzWMn64KMFyVO5sj8b6axIZjVkoqdl73JRk+0iad8mKmHcmok7KGt
         zG62mIOXCiaZgzySu+Pcoi2CQHwsFUb+Or+YAnGgfBrymPGA/9fkjgCXFIp995GexHZK
         S8sLNrAXQ6ze9wXx7T7taN7OJgCp2011mq1wv0NbPARODX2flebSeUcRg9EiwHLokkOz
         N1uQ==
X-Gm-Message-State: ANoB5pkAnByUVW3vebDkf1qigIXiaageOxXQmhnhXYFF9VMnJnCNbO4W
        f7/X3G+DK5KovIbDBsCg47fdm/CS97I=
X-Google-Smtp-Source: AA0mqf4aYXAwGQk3h64ez2YuGJGkgCSc1aOdsNNvQ9vz6uOPNh3o4Fgl8Fzo7DPTomgXi/iUgikasA==
X-Received: by 2002:a63:6686:0:b0:44c:bfe:9b1c with SMTP id a128-20020a636686000000b0044c0bfe9b1cmr13722585pgc.103.1668472240450;
        Mon, 14 Nov 2022 16:30:40 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:39 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] monitor/att: Fix not dequeing att_read on error response
Date:   Mon, 14 Nov 2022 16:30:33 -0800
Message-Id: <20221115003038.2134340-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a read/read by type fails it needs to be dequeued otherwise it can
cause the next operation of the same type to return the wrong request
and possible decoding as if it was a different attribute type.
---
 monitor/att.c | 109 +++++++++++++++++++++++++++-----------------------
 1 file changed, 58 insertions(+), 51 deletions(-)

diff --git a/monitor/att.c b/monitor/att.c
index efd840d51961..d14cbd165697 100644
--- a/monitor/att.c
+++ b/monitor/att.c
@@ -106,27 +106,66 @@ static bool match_read_frame(const void *data, const void *match_data)
 	return read->chan == frame->chan;
 }
 
-static void print_data_list(const char *label, uint8_t length,
-					const struct l2cap_frame *frame)
+static struct att_read *att_get_read(const struct l2cap_frame *frame)
 {
 	struct packet_conn_data *conn;
 	struct att_conn_data *data;
+
+	conn = packet_get_conn_data(frame->handle);
+	if (!conn)
+		return NULL;
+
+	data = conn->data;
+	if (!data)
+		return NULL;
+
+	return queue_remove_if(data->reads, match_read_frame, (void *)frame);
+}
+
+static void print_attribute(struct gatt_db_attribute *attr)
+{
+	uint16_t handle;
+	const bt_uuid_t *uuid;
+	char label[21];
+
+	handle = gatt_db_attribute_get_handle(attr);
+	if (!handle)
+		goto done;
+
+	uuid = gatt_db_attribute_get_type(attr);
+	if (!uuid)
+		goto done;
+
+	switch (uuid->type) {
+	case BT_UUID16:
+		sprintf(label, "Handle: 0x%4.4x Type", handle);
+		print_field("%s: %s (0x%4.4x)", label,
+				bt_uuid16_to_str(uuid->value.u16),
+				uuid->value.u16);
+		return;
+	case BT_UUID128:
+		sprintf(label, "Handle: 0x%4.4x Type", handle);
+		print_uuid(label, &uuid->value.u128, 16);
+		return;
+	case BT_UUID_UNSPEC:
+	case BT_UUID32:
+		break;
+	}
+
+done:
+	print_field("Handle: 0x%4.4x", handle);
+}
+
+static void print_data_list(const char *label, uint8_t length,
+					const struct l2cap_frame *frame)
+{
 	struct att_read *read;
 	uint8_t count;
 
 	if (length == 0)
 		return;
 
-	conn = packet_get_conn_data(frame->handle);
-	if (conn) {
-		data = conn->data;
-		if (data)
-			read = queue_remove_if(data->reads, match_read_frame,
-						(void *)frame);
-		else
-			read = NULL;
-	} else
-		read = NULL;
+	read = att_get_read(frame);
 
 	count = frame->size / length;
 
@@ -271,6 +310,12 @@ static void att_error_response(const struct l2cap_frame *frame)
 							pdu->request);
 	print_field("Handle: 0x%4.4x", le16_to_cpu(pdu->handle));
 	print_field("Error: %s (0x%2.2x)", str, pdu->error);
+
+	/* Read/Read By Type may create a read object which needs to be dequeued
+	 * and freed in case the operation fails.
+	 */
+	if (pdu->request == 0x08 || pdu->request == 0x0a)
+		free(att_get_read(frame));
 }
 
 static const struct bitfield_data chrc_prop_table[] = {
@@ -2662,36 +2707,6 @@ static struct gatt_db_attribute *get_attribute(const struct l2cap_frame *frame,
 	return gatt_db_get_attribute(db, handle);
 }
 
-static void print_attribute(struct gatt_db_attribute *attr)
-{
-	uint16_t handle = gatt_db_attribute_get_handle(attr);
-	const bt_uuid_t *uuid;
-	char label[21];
-
-	uuid = gatt_db_attribute_get_type(attr);
-	if (!uuid)
-		goto done;
-
-	switch (uuid->type) {
-	case BT_UUID16:
-		sprintf(label, "Handle: 0x%4.4x Type", handle);
-		print_field("%s: %s (0x%4.4x)", label,
-				bt_uuid16_to_str(uuid->value.u16),
-				uuid->value.u16);
-		return;
-	case BT_UUID128:
-		sprintf(label, "Handle: 0x%4.4x Type", handle);
-		print_uuid(label, &uuid->value.u128, 16);
-		return;
-	case BT_UUID_UNSPEC:
-	case BT_UUID32:
-		break;
-	}
-
-done:
-	print_field("Handle: 0x%4.4x", handle);
-}
-
 static void print_handle(const struct l2cap_frame *frame, uint16_t handle,
 								bool rsp)
 {
@@ -2746,19 +2761,11 @@ static void att_read_req(const struct l2cap_frame *frame)
 
 static void att_read_rsp(const struct l2cap_frame *frame)
 {
-	struct packet_conn_data *conn;
-	struct att_conn_data *data;
 	struct att_read *read;
 
 	print_hex_field("Value", frame->data, frame->size);
 
-	conn = packet_get_conn_data(frame->handle);
-	if (!conn)
-		return;
-
-	data = conn->data;
-
-	read = queue_remove_if(data->reads, match_read_frame, (void *)frame);
+	read = att_get_read(frame);
 	if (!read)
 		return;
 
-- 
2.37.3

