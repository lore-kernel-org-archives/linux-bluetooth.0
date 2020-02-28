Return-Path: <SRS0=e/tT=4Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83692C3F2D2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB8E246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZl4iA/b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgB1XrN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:13 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41293 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XrN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:13 -0500
Received: by mail-pg1-f193.google.com with SMTP id b1so2291633pgm.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=F0EYRJheUMHXrROxyDRP4RYQ+UKzYUGuYTVdPdCLH+E=;
        b=XZl4iA/b7jylrHnuYNeX0LqAHO/fD+P4tLBeMhHPgUe04qJ0O2hI6nACzmiOmACb2v
         nMhKHMHAT3YZ1+5gzxLljUIyPX4kTYLCaijQ81Q0wVxB74Ep9wxotLI0KBBD+vYttWX1
         gheI6aDQOCV0rCd9tcAfyEhgST5lZFgCuZpbzGmxjceEriHp+SxjwHTKt4plvaQSDNmV
         dO2QVFju0Jg8+dUDq7zs6UgKRRpFHiP3RIubDbPqg+hAKkbIznmu2Bwr0vHRj3/ZjJjH
         WLCsLazVTseADV9YbbgX8UtzMxgrzPYBVeUwSGqyZ45C81X2CNpDb08wDDVRUAcWEyBK
         +KgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F0EYRJheUMHXrROxyDRP4RYQ+UKzYUGuYTVdPdCLH+E=;
        b=MS4YaETaFBHtp/NrRIDB6jPuilOHGkl+4b7ayFHTOVznrJk86hmcHDFYoCUIhr/rjU
         bArh4cJxNOz8oLlNAd/RfQ/2Jlt5Fvp5pyufL6uYP0GXlTJ+Eb+ciSAqYg1LFJw7mhgL
         m7/HuE9LJ8sRzMHLmqAYp8Pb/weobcNBn58NqSB7b5BM9lCyoGsCf9YqzWFdY2ddiHyW
         H4RV98zR35hAQ+lSXD2VekBNoQU528zSCQfDvEjAMVyuO4ffbTqossJOJHMgnfuwVu7g
         4AjMojVyIdjWVhNKmS8t7E/vEVOLwMQLPHHifCReSXLBP8ZvAfgITZaAwgJWFnnq9rdJ
         XESQ==
X-Gm-Message-State: APjAAAWMLXoATE5w6+2r69iSC6OHYqvtTn5+lWQsQOwFl4/2A7AvLq8P
        /NAFyKDJasD37IuEQ8vgrgKh71DNvHk=
X-Google-Smtp-Source: APXvYqxb3gumvOZHNpm1UqtRR0Q9BN0T2DlO3pmYUnAX3L/hS+V0LGQ/0KGpnVDYrwzPfDtQ43Tkog==
X-Received: by 2002:a63:e20a:: with SMTP id q10mr5725388pgh.331.1582933630570;
        Fri, 28 Feb 2020 15:47:10 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/12] shared/gatt-server: Add support for Read Multiple Variable Length
Date:   Fri, 28 Feb 2020 15:46:56 -0800
Message-Id: <20200228234701.14614-8-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200228234701.14614-1-luiz.dentz@gmail.com>
References: <20200228234701.14614-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The Read Multiple Variable Length Request is used to request that the
server read two or more values of a set of attributes that have a
variable or unknown value length and return their values in a
Read Multiple Variable Length Response.
---
 src/shared/att-types.h   |   2 +
 src/shared/gatt-server.c | 113 ++++++++++++++++++++++++++-------------
 2 files changed, 79 insertions(+), 36 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 7b88e7d92..cc9cc9fd6 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -75,6 +75,8 @@
 #define BT_ATT_OP_HANDLE_VAL_NOT		0x1B
 #define BT_ATT_OP_HANDLE_VAL_IND		0x1D
 #define BT_ATT_OP_HANDLE_VAL_CONF		0x1E
+#define BT_ATT_OP_READ_MULT_VL_REQ		0x20
+#define BT_ATT_OP_READ_MULT_VL_RSP		0x21
 
 /* Packed struct definitions for ATT protocol PDUs */
 /* TODO: Complete these definitions for all opcodes */
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ee0058486..8b18cb21f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -102,6 +102,7 @@ struct bt_gatt_server {
 	unsigned int read_id;
 	unsigned int read_blob_id;
 	unsigned int read_multiple_id;
+	unsigned int read_multiple_vl_id;
 	unsigned int prep_write_id;
 	unsigned int exec_write_id;
 
@@ -136,6 +137,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->read_id);
 	bt_att_unregister(server->att, server->read_blob_id);
 	bt_att_unregister(server->att, server->read_multiple_id);
+	bt_att_unregister(server->att, server->read_multiple_vl_id);
 	bt_att_unregister(server->att, server->prep_write_id);
 	bt_att_unregister(server->att, server->exec_write_id);
 
@@ -1013,9 +1015,10 @@ static void read_blob_cb(struct bt_att_chan *chan, uint8_t opcode,
 	handle_read_req(chan, server, opcode, handle, offset);
 }
 
-struct read_multiple_resp_data {
+struct read_mult_data {
 	struct bt_att_chan *chan;
 	struct bt_gatt_server *server;
+	uint8_t opcode;
 	uint16_t *handles;
 	size_t cur_handle;
 	size_t num_handles;
@@ -1024,7 +1027,7 @@ struct read_multiple_resp_data {
 	size_t mtu;
 };
 
-static void read_multiple_resp_data_free(struct read_multiple_resp_data *data)
+static void read_mult_data_free(struct read_mult_data *data)
 {
 	free(data->handles);
 	free(data->rsp_data);
@@ -1035,15 +1038,16 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 					const uint8_t *value, size_t len,
 					void *user_data)
 {
-	struct read_multiple_resp_data *data = user_data;
+	struct read_mult_data *data = user_data;
 	struct gatt_db_attribute *next_attr;
 	uint16_t handle = gatt_db_attribute_get_handle(attr);
 	uint8_t ecode;
+	uint16_t length;
 
 	if (err != 0) {
-		bt_att_chan_send_error_rsp(data->chan,
-					BT_ATT_OP_READ_MULT_REQ, handle, err);
-		read_multiple_resp_data_free(data);
+		bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
+									err);
+		read_mult_data_free(data);
 		return;
 	}
 
@@ -1051,29 +1055,45 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 						BT_ATT_PERM_READ_AUTHEN |
 						BT_ATT_PERM_READ_ENCRYPT);
 	if (ecode) {
-		bt_att_chan_send_error_rsp(data->chan,
-					BT_ATT_OP_READ_MULT_REQ, handle, ecode);
-		read_multiple_resp_data_free(data);
+		bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
+									ecode);
+		read_mult_data_free(data);
 		return;
 	}
 
-	len = MIN(len, data->mtu - data->length - 1);
+	length = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
+			MIN(len, data->mtu - data->length - 3) :
+			MIN(len, data->mtu - data->length - 1);
 
-	memcpy(data->rsp_data + data->length, value, len);
-	data->length += len;
+	if (data->opcode == BT_ATT_OP_READ_MULT_VL_REQ) {
+		/* The Length Value Tuple List may be truncated within the first
+		 * two octets of a tuple due to the size limits of the current
+		 * ATT_MTU.
+		 */
+		put_le16(len, data->rsp_data + data->length);
+		data->length += 2;
+	}
+
+	memcpy(data->rsp_data + data->length, value, length);
+	data->length += length;
 
 	data->cur_handle++;
 
-	if ((data->length >= data->mtu - 1) ||
-				(data->cur_handle == data->num_handles)) {
-		bt_att_chan_send_rsp(data->chan, BT_ATT_OP_READ_MULT_RSP,
+	len = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
+		data->mtu - data->length - 3 : data->mtu - data->length - 1;
+
+	if (!len || (data->cur_handle == data->num_handles)) {
+		bt_att_chan_send_rsp(data->chan, data->opcode + 1,
 						data->rsp_data, data->length);
-		read_multiple_resp_data_free(data);
+		read_mult_data_free(data);
 		return;
 	}
 
 	util_debug(data->server->debug_callback, data->server->debug_data,
-				"Read Multiple Req - #%zu of %zu: 0x%04x",
+				"%s Req - #%zu of %zu: 0x%04x",
+				data->opcode == BT_ATT_OP_READ_MULT_REQ ?
+				"Read Multiple" :
+				"Read Multiple Variable Length",
 				data->cur_handle + 1, data->num_handles,
 				data->handles[data->cur_handle]);
 
@@ -1085,7 +1105,7 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 					BT_ATT_OP_READ_MULT_REQ,
 					data->handles[data->cur_handle],
 					BT_ATT_ERROR_INVALID_HANDLE);
-		read_multiple_resp_data_free(data);
+		read_mult_data_free(data);
 		return;
 	}
 
@@ -1096,17 +1116,39 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 						BT_ATT_OP_READ_MULT_REQ,
 						data->handles[data->cur_handle],
 						BT_ATT_ERROR_UNLIKELY);
-		read_multiple_resp_data_free(data);
+		read_mult_data_free(data);
 	}
 }
 
+static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
+						struct bt_att_chan *chan,
+						uint8_t opcode,
+						uint16_t num_handles)
+{
+	struct read_mult_data *data;
+
+	data = new0(struct read_mult_data, 1);
+	data->chan = chan;
+	data->opcode = opcode;
+	data->handles = new0(uint16_t, num_handles);
+	data->rsp_data = NULL;
+	data->server = server;
+	data->num_handles = num_handles;
+	data->cur_handle = 0;
+	data->mtu = bt_att_get_mtu(server->att);
+	data->length = 0;
+	data->rsp_data = new0(uint8_t, data->mtu - 1);
+
+	return data;
+}
+
 static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 					const void *pdu, uint16_t length,
 					void *user_data)
 {
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
-	struct read_multiple_resp_data *data = NULL;
+	struct read_mult_data *data = NULL;
 	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
 	size_t i = 0;
 
@@ -1115,27 +1157,17 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 		goto error;
 	}
 
-	data = new0(struct read_multiple_resp_data, 1);
-	data->chan = chan;
-	data->handles = NULL;
-	data->rsp_data = NULL;
-	data->server = server;
-	data->num_handles = length / 2;
-	data->cur_handle = 0;
-	data->mtu = bt_att_get_mtu(server->att);
-	data->length = 0;
-	data->rsp_data = malloc(data->mtu - 1);
-
-	if (!data->rsp_data)
+	data = read_mult_data_new(server, chan, opcode, length / 2);
+	if (!data)
 		goto error;
 
-	data->handles = new0(uint16_t, data->num_handles);
-
 	for (i = 0; i < data->num_handles; i++)
 		data->handles[i] = get_le16(pdu + i * 2);
 
 	util_debug(server->debug_callback, server->debug_data,
-			"Read Multiple Req - %zu handles, 1st: 0x%04x",
+			"%s Req - %zu handles, 1st: 0x%04x",
+			data->opcode == BT_ATT_OP_READ_MULT_REQ ?
+			"Read Multiple" : "Read Multiple Variable Length",
 			data->num_handles, data->handles[0]);
 
 	attr = gatt_db_get_attribute(server->db, data->handles[0]);
@@ -1151,7 +1183,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 error:
 	if (data)
-		read_multiple_resp_data_free(data);
+		read_mult_data_free(data);
 
 	bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
 }
@@ -1588,6 +1620,15 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
 	if (!server->read_multiple_id)
 		return false;
 
+	/* Read Multiple Variable Length Request */
+	server->read_multiple_vl_id = bt_att_register(server->att,
+						BT_ATT_OP_READ_MULT_VL_REQ,
+						read_multiple_cb,
+						server, NULL);
+
+	if (!server->read_multiple_vl_id)
+		return false;
+
 	/* Prepare Write Request */
 	server->prep_write_id = bt_att_register(server->att,
 						BT_ATT_OP_PREP_WRITE_REQ,
-- 
2.21.1

