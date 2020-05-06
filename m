Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B07EC28CBC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CFDC2073A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 11:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lTJxaE6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgEFLpC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 07:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEFLpB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 07:45:01 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D764C061A0F
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 04:45:01 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id j4so2222317ybj.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 May 2020 04:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y9mksum0NZV+v+BKnFQt8oIA2iEmEWE4Jz/TGaYCh0k=;
        b=lTJxaE6k8UN6ei/W9b2uKvdkN4ckVWYoZSI4JPMXX2c0RJ32bWqf0ZmZ+1IxA6XS7G
         mrJ+nr8SfJrQIgLXEEpolqKRV4c5LCFSTbAEMd9y2uSL4PdmvW5EyRz/GNMlVBSCfbnC
         4wRnWXLhev3ya0PG17JCCJbKi8Yy4k6ASx38+oUkmJrKqw3eJLsX4/GX9DaHCfNp0Sto
         OurFIEVN3ruZd34vmQSVkH34eTP6nVLlRPVX9QG78qMIt2MfX0Wt1QeO+yU4SqJB5/zl
         bIoomlCLVd6DvbnSOJuqSiROmiIEv0S4crKe2jznhIH6ewEGUiMsEw7uRDCTgYfm7rEe
         ePxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y9mksum0NZV+v+BKnFQt8oIA2iEmEWE4Jz/TGaYCh0k=;
        b=UKzVM8ceHeUe7KE493S3YkMW5KcUUJCkUkKuPHyBHx8SkIgzjjDmvtEo2FkCoamGvY
         LbG7peCu0ndLe1US+m+a8nYuvO9aKHDt9Ve4V666Dg/+I/KrOypITcz3Or4mLxzf0ZoH
         u78ax/aQxWyB1EsSmrN3b3tm9IrVpsdDyy08qHFaNarJhoGjdhgscuJ8PJMtqSKIFYWV
         xL0f74hc9vUJLwXqrS+IT+mLbWaMMv/MukAN64hxKaXxQib4bdhExAHA7lZSFGE2WaBA
         DVK+QtAIVLuomhNm/YFrKTmQNxwfhMmaaf6f2APG/2OnsT22B+xIymVxCwSXc6vTLCBn
         WqXQ==
X-Gm-Message-State: AGi0PuZ4YIvFqjmt27pytHMxBV4+mouugJbi3OoBltecl63Z3KUOuTBR
        8NNIlX0ODc9CqzpYUMjIVuzOPAQgVQVrd98zMVDyTqq/tZHbUeywblfR82FAA5gR1M7Uvzqxyld
        CxMLPZzd+xIZHsLB3tMKqj91qn4lhgQMK/rf7Ge71xMWR/d+YD6Ju8NJZY+YDCyyLaX8VMud8IQ
        p1
X-Google-Smtp-Source: APiQypIArKIYUC940bwh+UGTJ9S78ZwIdCiE6JTug+0U6q8gJwn7OP/XFJc2rNPKPRoYT3n0YlpOFI3pRt2z
X-Received: by 2002:a25:2d01:: with SMTP id t1mr13770206ybt.180.1588765500659;
 Wed, 06 May 2020 04:45:00 -0700 (PDT)
Date:   Wed,  6 May 2020 19:44:46 +0800
Message-Id: <20200506194332.Bluez.v1.1.I45da219fa28f72db2e11778c15cee5aad446b1c4@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [Bluez PATCH v1] shared/gatt-server: Fix read multiple charc values
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

 src/shared/gatt-server.c | 88 ++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 4e07398d2..e937d80a8 100644
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
+			MIN(len, MAX(0, data->mtu - data->length - 3)) :
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

