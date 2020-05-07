Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF53C38A24
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 06:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40AB52064A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 06:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daq9zZDI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbgEGGi7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 02:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgEGGi6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 02:38:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D5C061A10
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 23:38:57 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id i62so5792878ybc.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 23:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=boJzctwuYhR5WXLJYd0w/q3u5mJSnIg7ugKVxztDUfo=;
        b=daq9zZDI7uxvs7XR4djiADV8+GMrtuceLTJNO9teEgoH3Ub4MOS3wjB0hxq2+HIfDn
         gJUqegwQyL4lPvP51tIi2LC5ayP7j5UJ82v7G/njxC2QJvsc3iwTnlRphPtcz5LGvvFG
         c6dq+81DGQXppHa3Aqg3T/tiy0U3E24LzFe8YZvIpdpH8pQatX8j0FYHoHMFWbObwpKV
         X7jDJGgaWe33qpHc2gIRDJl9MFWcyAZhsKKSrZmnbYc26Vs4pSrvbAICGqzSjW1GbbHP
         YteoGjsePORDa6sp84HHiS2JAyxhaF+JCMUWEe0ENZBRGGEUcnn+xFry/yyV/7beEJ4E
         jqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=boJzctwuYhR5WXLJYd0w/q3u5mJSnIg7ugKVxztDUfo=;
        b=Hgm4fpyccBzstKVABIh9HqyieUFb0aiBKUUUPjUKK6wMlPYSiu11yvBklnx7lUQnAB
         kZhXrJTp5722MDVmGXCxYTm55r7Gzd1OUMWYeZPKQcIUb4Prj4USPIJvzqzENbF39Xwq
         AuKvDaBsPKy45JtGdQzkt2qCuE8dF1f9i5ivvCBqwOHCqR6cFoRcHbe8hVXpKV8OXtQD
         gQTl2hXq1+G7pysUsPBSRtNt/I5+XxySrNz+q/F9aWk5n0BzpPzPwnNFqJXVFWtaAe4K
         c7vIRfB1L+HwUlq3iwkePCncqqTOn+mJRdYKdFGuNlfyeCsMt8nxGEZWszz4h+GIrtCN
         qcrg==
X-Gm-Message-State: AGi0PubGucXmXk+MrgP6q7Z7wmmDD/sEKwjbvWXpWjjbjeoQPxTWv1SD
        37kwTOnUxTtZCb73QijRSbpzHT8FSitRP1bM3sWnw8NTb29X7Mv5+ucdJ3LZIVq5h+x8hJBsgND
        CUzApj8cdn+XPS8p/4mQkE+lE264YNxNQGiELsIgljOVxIqYNJDzQoE3vpZFKdVKBt0vbd6QXK0
        Fn
X-Google-Smtp-Source: APiQypJViHditvPUJO2OEeBMPO4ttluIMaTtccPE7wJ/sAVHKuRtfbFswvIpysExAu2xiO0BXF39ahpz+bWE
X-Received: by 2002:a25:afd0:: with SMTP id d16mr19936433ybj.441.1588833536328;
 Wed, 06 May 2020 23:38:56 -0700 (PDT)
Date:   Thu,  7 May 2020 14:38:46 +0800
Message-Id: <20200507143805.Bluez.v2.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [Bluez PATCH v2] shared/gatt-server: Fix read multiple charc values
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

According to bluetooth spec Ver 5.2, Vol 3, Part G, 4.8.4, An
ATT_ERROR_RSP PDU shall be sent by the server in response to the
ATT_READ_MULTIPLE_RSP PDU if insufficient authentication,
insufficient authorization, insufficient encryption key size, or
insufficient encryption is used by the client, or if a read operation
is not permitted on any of the Characteristic Values.

Currently if the size of the response grows larger than the MTU size,
BlueZ does an early return and not check the permission for the rest
of the characteristics. This patch forces BlueZ to check for possible
errors even though we already reach MTU size.

This patch also moves the read permission check for read multiple
characteristics so it is done before actually retrieving the
characteristics.
---

Changes in v2:
- Fix error underflowing unsigned int

 src/shared/gatt-server.c | 88 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4e07398d2..28ac2d68d 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1057,33 +1057,23 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint16_t length;
 
 	if (err != 0) {
-		bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
-									err);
-		read_mult_data_free(data);
-		return;
-	}
-
-	ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
-						BT_ATT_PERM_READ_AUTHEN |
-						BT_ATT_PERM_READ_ENCRYPT);
-	if (ecode) {
-		bt_att_chan_send_error_rsp(data->chan, data->opcode, handle,
-									ecode);
-		read_mult_data_free(data);
-		return;
+		ecode = err;
+		goto error;
 	}
 
 	length = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
-			MIN(len, data->mtu - data->length - 3) :
+			MIN(len, MAX(data->mtu - data->length, 3) - 3) :
 			MIN(len, data->mtu - data->length - 1);
 
 	if (data->opcode == BT_ATT_OP_READ_MULT_VL_REQ) {
 		/* The Length Value Tuple List may be truncated within the first
 		 * two octets of a tuple due to the size limits of the current
-		 * ATT_MTU.
+		 * ATT_MTU, but the first two octets cannot be separated.
 		 */
-		put_le16(len, data->rsp_data + data->length);
-		data->length += 2;
+		if (data->mtu - data->length >= 3) {
+			put_le16(len, data->rsp_data + data->length);
+			data->length += 2;
+		}
 	}
 
 	memcpy(data->rsp_data + data->length, value, length);
@@ -1091,45 +1081,46 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 
 	data->cur_handle++;
 
-	len = data->opcode == BT_ATT_OP_READ_MULT_VL_REQ ?
-		data->mtu - data->length - 3 : data->mtu - data->length - 1;
-
-	if (!len || (data->cur_handle == data->num_handles)) {
+	if (data->cur_handle == data->num_handles) {
 		bt_att_chan_send_rsp(data->chan, data->opcode + 1,
 						data->rsp_data, data->length);
 		read_mult_data_free(data);
 		return;
 	}
 
+	handle = data->handles[data->cur_handle];
+
 	util_debug(data->server->debug_callback, data->server->debug_data,
 				"%s Req - #%zu of %zu: 0x%04x",
 				data->opcode == BT_ATT_OP_READ_MULT_REQ ?
 				"Read Multiple" :
 				"Read Multiple Variable Length",
 				data->cur_handle + 1, data->num_handles,
-				data->handles[data->cur_handle]);
+				handle);
 
-	next_attr = gatt_db_get_attribute(data->server->db,
-					data->handles[data->cur_handle]);
+	next_attr = gatt_db_get_attribute(data->server->db, handle);
 
 	if (!next_attr) {
-		bt_att_chan_send_error_rsp(data->chan,
-					BT_ATT_OP_READ_MULT_REQ,
-					data->handles[data->cur_handle],
-					BT_ATT_ERROR_INVALID_HANDLE);
-		read_mult_data_free(data);
-		return;
+		ecode = BT_ATT_ERROR_INVALID_HANDLE;
+		goto error;
 	}
 
-	if (!gatt_db_attribute_read(next_attr, 0, BT_ATT_OP_READ_MULT_REQ,
+	ecode = check_permissions(data->server, next_attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_AUTHEN |
+						BT_ATT_PERM_READ_ENCRYPT);
+	if (ecode)
+		goto error;
+
+	if (gatt_db_attribute_read(next_attr, 0, data->opcode,
 					data->server->att,
-					read_multiple_complete_cb, data)) {
-		bt_att_chan_send_error_rsp(data->chan,
-						BT_ATT_OP_READ_MULT_REQ,
-						data->handles[data->cur_handle],
-						BT_ATT_ERROR_UNLIKELY);
-		read_mult_data_free(data);
-	}
+					read_multiple_complete_cb, data))
+		return;
+
+	ecode = BT_ATT_ERROR_UNLIKELY;
+
+error:
+	bt_att_chan_send_error_rsp(data->chan, data->opcode, handle, ecode);
+	read_mult_data_free(data);
 }
 
 static struct read_mult_data *read_mult_data_new(struct bt_gatt_server *server,
@@ -1161,8 +1152,9 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 	struct bt_gatt_server *server = user_data;
 	struct gatt_db_attribute *attr;
 	struct read_mult_data *data = NULL;
-	uint8_t ecode = BT_ATT_ERROR_UNLIKELY;
+	uint8_t ecode;
 	size_t i = 0;
+	uint16_t handle = 0;
 
 	if (length < 4) {
 		ecode = BT_ATT_ERROR_INVALID_PDU;
@@ -1176,28 +1168,38 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 	for (i = 0; i < data->num_handles; i++)
 		data->handles[i] = get_le16(pdu + i * 2);
 
+	handle = data->handles[0];
+
 	util_debug(server->debug_callback, server->debug_data,
 			"%s Req - %zu handles, 1st: 0x%04x",
 			data->opcode == BT_ATT_OP_READ_MULT_REQ ?
 			"Read Multiple" : "Read Multiple Variable Length",
-			data->num_handles, data->handles[0]);
+			data->num_handles, handle);
 
-	attr = gatt_db_get_attribute(server->db, data->handles[0]);
+	attr = gatt_db_get_attribute(server->db, handle);
 
 	if (!attr) {
 		ecode = BT_ATT_ERROR_INVALID_HANDLE;
 		goto error;
 	}
 
+	ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
+						BT_ATT_PERM_READ_AUTHEN |
+						BT_ATT_PERM_READ_ENCRYPT);
+	if (ecode)
+		goto error;
+
 	if (gatt_db_attribute_read(attr, 0, opcode, server->att,
 					read_multiple_complete_cb, data))
 		return;
 
+	ecode = BT_ATT_ERROR_UNLIKELY;
+
 error:
 	if (data)
 		read_mult_data_free(data);
 
-	bt_att_chan_send_error_rsp(chan, opcode, 0, ecode);
+	bt_att_chan_send_error_rsp(chan, opcode, handle, ecode);
 }
 
 static bool append_prep_data(struct prep_write_data *prep_data, uint16_t handle,
-- 
2.26.2.526.g744177e7f7-goog

