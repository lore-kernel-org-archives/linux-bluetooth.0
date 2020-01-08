Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6489AC33C9B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39EB8206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY0edA1z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgAHAeC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:34:02 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:32853 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgAHAeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:34:02 -0500
Received: by mail-pj1-f68.google.com with SMTP id u63so5717769pjb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bu4oBw+goKYogLpgfJAv6oogbSfgCLkZb1y27cehctU=;
        b=kY0edA1zRoDIP/qjlgpOaP0Ujwc3hGCL4kuoDzN4/iTUATxi9zR4IZ5xKzW78VQP0C
         JNasxzACBfOou+Ad4YYUT2iffzP1wFgCFXbFAeSKqMh9zpC6EOd+9slyz/UsmlxlQ0Wc
         l+nr6rW2WuyyCpsOUp+tr2ssUMUGQuT26+UwsW5r6pC/CEeNO90gIY3KaYN8w3N1CdC+
         6qtnRCLnvSTgjqZb+H3AYMmiak2s/LWAt0zyHxGvUGSJq4GIcAc5NczMgmPecSUWcoRI
         Ycssem1VWmy5SW93Kj339azquzL/ojTCBo95vg/S1M1avc/vQOdmzGS/Y3BOs/gmZVuQ
         LqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bu4oBw+goKYogLpgfJAv6oogbSfgCLkZb1y27cehctU=;
        b=G3Rh8yIq1xbc5JCj+bhSWXXLXM/MUdqy+snu3PGZhiUz45HUoS09BBqpVJOIUnbJsG
         nLUIXa6ZAr8VgRZqBgFix0gOu6QNZ1zkY0ED+CClAPff92ouwAJ/4SEdHTwtvUufS6Uw
         2DzXLuLUaPUq0kYqiQeraeduqC4xgrZPR9nwztl8MqIVcVywMIgXvC/4pfBnlAP3EgNU
         4inzTDPogp/9pW69xNzzUgQZJed5ak2Dm4Ofk6ZK6ZXAA3IK1nbotWqVGXsj97j6F8qJ
         GzWUmtds3ClH3zd6GUxSmDFIxeqwj5IIgixKGxcjbm91XpkVMZ4ilPcqxEothFqtz79s
         g8VA==
X-Gm-Message-State: APjAAAUhKt5khDPBD665YRHoHZLwEYbDFfAxXBECeHzG3GpFGr1aIpf5
        bk45QuU0Pa+6X5FlxSHlRVbdpLY9+PA=
X-Google-Smtp-Source: APXvYqwwrlZZLYn5y56CVvzABoSyeaLiykda1sRThCwR23RmkHp+qEo14u7o0om9k783qdGyzdVQ6g==
X-Received: by 2002:a17:902:b785:: with SMTP id e5mr2522712pls.327.1578443641279;
        Tue, 07 Jan 2020 16:34:01 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.34.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:34:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 17/22] shared/gatt-server: Add support for Read Multiple Variable Length
Date:   Tue,  7 Jan 2020 16:33:37 -0800
Message-Id: <20200108003342.15458-18-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
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
 src/shared/gatt-server.c | 112 +++++++++++++++++++++++++++------------
 2 files changed, 80 insertions(+), 34 deletions(-)

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
index ee0058486..55535abdf 100644
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
 
@@ -1096,17 +1116,40 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
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
+	data->handles = NULL;
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
 
@@ -1115,18 +1158,8 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
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
 
 	data->handles = new0(uint16_t, data->num_handles);
@@ -1135,7 +1168,9 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 		data->handles[i] = get_le16(pdu + i * 2);
 
 	util_debug(server->debug_callback, server->debug_data,
-			"Read Multiple Req - %zu handles, 1st: 0x%04x",
+			"%s Req - %zu handles, 1st: 0x%04x",
+			data->opcode == BT_ATT_OP_READ_MULT_REQ ?
+			"Read Multiple" : "Read Multiple Variable Length",
 			data->num_handles, data->handles[0]);
 
 	attr = gatt_db_get_attribute(server->db, data->handles[0]);
@@ -1151,7 +1186,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 error:
 	if (data)
-		read_multiple_resp_data_free(data);
+		read_mult_data_free(data);
 
 	bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
 }
@@ -1588,6 +1623,15 @@ static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
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
2.21.0

