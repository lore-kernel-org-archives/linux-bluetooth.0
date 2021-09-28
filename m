Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F41CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 863646138F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 23:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243174AbhI1XCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbhI1XCD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 19:02:03 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB54C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:00:22 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id m21so578510pgu.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=allthenticate.net; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QmVRwo97hcdrl5wADlhDu1RqHEFI31lA7lyQk2sSIi4=;
        b=IIKDNqKsd7JxNNE50AH4VMe840jppSLamUjy9C+A+lnkwVccVueRy5B4OsntB1waJ5
         /hNlFnlDQJJPrQMOxyiSnUJ8lT/eGuv6y3IV/3l6BR3abb4/vkad9vIvK117MO9J0pBG
         kDi1lfJaXKLF+HmKiOePx2QmZerybD5n7HR2glxJu+nCZtE9RuZ0UJC6KQi6WIRgDx3d
         SIX0HS9yBLsdPrebTVyKqSf+I9Ug39nSfKXEHuPaEwga38KKGhNU15yBU+a9pKPgkGvH
         rA20iYBrCylgs10TjVKbI6mRZwO0OJltlJWt9QEMH4kGoPJVzPb+A2xUaps6LnmtjqgA
         wFZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QmVRwo97hcdrl5wADlhDu1RqHEFI31lA7lyQk2sSIi4=;
        b=E718JMYQj8MEc7Cx9EtXxihmUv6x4Dby5LsnD5udMEkF3wPmMtVZhNepBr5L1jcvdo
         sEykqqJJtIZ0WttZIlNxgx60wjOXce8A+pHJjDI2eb4tSxE5DWFWtjyywUu+ovaTySdZ
         JPfZwClagcJA6jdd+dw4HtjCMnqxHsTrH2cmCSGGIMLt4v1cKJvDENQPT41PTnZSx4iP
         CpsVr4FEPzGM7wxVI18lfA2bQf5imPjxCLAVUNJI0kCUBX2bjD1aWmg2w16bwXUmaNwZ
         Z8fBegn93Q6GS8mi09VPs/XrkjT7c+hZdph68A/wopWMN5CneNglV6ywz3MlpXn3hgQE
         /Z5Q==
X-Gm-Message-State: AOAM5336YPFNxEKUTbSz5uH6JGf0/DUFGbRZqsGjMFxUJUKZSBgSj55O
        huvfG3lZ0hJwrEt37B2zv6PbciBA8bVomAP0
X-Google-Smtp-Source: ABdhPJzBhhNTyLw0vQYJMFoMU0P4HcEl+UnwXiCVEUTwKZ1fUDLiCdzypwk22dYCQJDjlH0L68gFBQ==
X-Received: by 2002:a63:4622:: with SMTP id t34mr6808129pga.293.1632870021172;
        Tue, 28 Sep 2021 16:00:21 -0700 (PDT)
Received: from BernieDesktop.lan (wsip-72-222-70-2.sb.sd.cox.net. [72.222.70.2])
        by smtp.gmail.com with ESMTPSA id p9sm207664pgn.36.2021.09.28.16.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 16:00:20 -0700 (PDT)
From:   Bernie Conrad <bernie@allthenticate.net>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bernie Conrad <bernie@allthenticate.net>
Subject: [RFC PATCH BlueZ v2] Cleaning up gatt operations on a disconnect to fix possible use after free
Date:   Tue, 28 Sep 2021 16:00:15 -0700
Message-Id: <20210928230015.26295-1-bernie@allthenticate.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

There is a current use after free possible on a gatt server if a client
disconnects while a WriteValue call is being processed with dbus.

This patch includes the addition of a pending disconnect callback to handle
cleanup better if a disconnect occurs during a write, an acquire write
or read operation using bt_att_register_disconnect with the cb.

v2: Fixed a bad call to pending_read_new

---
 src/gatt-database.c | 115 +++++++++++++++++++++++++-------------------
 1 file changed, 65 insertions(+), 50 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 1f7ce5f02..a03c579cf 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -933,6 +933,24 @@ static struct btd_device *att_get_device(struct bt_att *att)
 	return btd_adapter_find_device(adapter, &dst, dst_type);
 }
 
+
+static void pending_op_free(void *data)
+{
+	struct pending_op *op = data;
+
+	if (op->owner_queue)
+		queue_remove(op->owner_queue, op);
+
+	free(op);
+}
+
+static void pending_disconnect_cb(int err, void *user_data)
+{
+	struct pending_op *op = user_data;
+
+	op->owner_queue = NULL;
+}
+
 static struct pending_op *pending_ccc_new(struct bt_att *att,
 					struct gatt_db_attribute *attrib,
 					uint16_t value,
@@ -956,17 +974,12 @@ static struct pending_op *pending_ccc_new(struct bt_att *att,
 	op->attrib = attrib;
 	op->link_type = link_type;
 
-	return op;
-}
+	bt_att_register_disconnect(att,
+				   pending_disconnect_cb,
+				   op,
+				   NULL);
 
-static void pending_op_free(void *data)
-{
-	struct pending_op *op = data;
-
-	if (op->owner_queue)
-		queue_remove(op->owner_queue, op);
-
-	free(op);
+	return op;
 }
 
 static void gatt_ccc_write_cb(struct gatt_db_attribute *attrib,
@@ -2169,24 +2182,26 @@ done:
 	gatt_db_attribute_read_result(op->attrib, op->id, ecode, value, len);
 }
 
-static struct pending_op *pending_read_new(struct btd_device *device,
+
+static struct pending_op *pending_read_new(struct bt_att *att,
 					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
-					unsigned int id, uint16_t offset,
-					uint8_t link_type)
+					unsigned int id, uint16_t offset)
 {
 	struct pending_op *op;
 
 	op = new0(struct pending_op, 1);
 
 	op->owner_queue = owner_queue;
-	op->device = device;
+	op->device = att_get_device(att);
 	op->attrib = attrib;
 	op->id = id;
 	op->offset = offset;
-	op->link_type = link_type;
+	op->link_type = bt_att_get_link_type(att);
 	queue_push_tail(owner_queue, op);
 
+	bt_att_register_disconnect(att, pending_disconnect_cb, op, NULL);
+
 	return op;
 }
 
@@ -2243,18 +2258,16 @@ static void read_setup_cb(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static struct pending_op *send_read(struct btd_device *device,
+static struct pending_op *send_read(struct bt_att *att,
 					struct gatt_db_attribute *attrib,
 					GDBusProxy *proxy,
 					struct queue *owner_queue,
 					unsigned int id,
-					uint16_t offset,
-					uint8_t link_type)
+					uint16_t offset)
 {
 	struct pending_op *op;
 
-	op = pending_read_new(device, owner_queue, attrib, id, offset,
-							link_type);
+	op = pending_read_new(att, owner_queue, attrib, id, offset);
 
 	if (g_dbus_proxy_method_call(proxy, "ReadValue", read_setup_cb,
 				read_reply_cb, op, pending_op_free) == TRUE)
@@ -2337,15 +2350,17 @@ static void write_reply_cb(DBusMessage *message, void *user_data)
 	}
 
 done:
-	gatt_db_attribute_write_result(op->attrib, op->id, ecode);
+	// Make sure that only reply if the device is connected
+	if (btd_device_is_connected(op->device))
+		gatt_db_attribute_write_result(op->attrib, op->id, ecode);
 }
 
-static struct pending_op *pending_write_new(struct btd_device *device,
+static struct pending_op *pending_write_new(struct bt_att *att,
 					struct queue *owner_queue,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
 					const uint8_t *value, size_t len,
-					uint16_t offset, uint8_t link_type,
+					uint16_t offset,
 					bool is_characteristic,
 					bool prep_authorize)
 {
@@ -2356,33 +2371,37 @@ static struct pending_op *pending_write_new(struct btd_device *device,
 	op->data.iov_base = (uint8_t *) value;
 	op->data.iov_len = len;
 
-	op->device = device;
+	op->device = att_get_device(att);
 	op->owner_queue = owner_queue;
 	op->attrib = attrib;
 	op->id = id;
 	op->offset = offset;
-	op->link_type = link_type;
+	op->link_type = bt_att_get_link_type(att);
 	op->is_characteristic = is_characteristic;
 	op->prep_authorize = prep_authorize;
 	queue_push_tail(owner_queue, op);
 
+	bt_att_register_disconnect(att,
+			    pending_disconnect_cb,
+			    op, NULL);
+
 	return op;
 }
 
-static struct pending_op *send_write(struct btd_device *device,
+static struct pending_op *send_write(struct bt_att *att,
 					struct gatt_db_attribute *attrib,
 					GDBusProxy *proxy,
 					struct queue *owner_queue,
 					unsigned int id,
 					const uint8_t *value, size_t len,
-					uint16_t offset, uint8_t link_type,
+					uint16_t offset,
 					bool is_characteristic,
 					bool prep_authorize)
 {
 	struct pending_op *op;
 
-	op = pending_write_new(device, owner_queue, attrib, id, value, len,
-					offset, link_type, is_characteristic,
+	op = pending_write_new(att, owner_queue, attrib, id, value, len,
+					offset, is_characteristic,
 					prep_authorize);
 
 	if (g_dbus_proxy_method_call(proxy, "WriteValue", write_setup_cb,
@@ -2558,17 +2577,16 @@ static void acquire_write_setup(DBusMessageIter *iter, void *user_data)
 }
 
 static struct pending_op *acquire_write(struct external_chrc *chrc,
-					struct btd_device *device,
+					struct bt_att *att,
 					struct gatt_db_attribute *attrib,
 					unsigned int id,
-					const uint8_t *value, size_t len,
-					uint8_t link_type)
+					const uint8_t *value, size_t len)
 {
 	struct pending_op *op;
 	bool acquiring = !queue_isempty(chrc->pending_writes);
 
-	op = pending_write_new(device, chrc->pending_writes, attrib, id, value,
-				len, 0, link_type, false, false);
+	op = pending_write_new(att, chrc->pending_writes, attrib, id, value,
+				len, 0, false, false);
 
 	if (acquiring)
 		return op;
@@ -2851,8 +2869,8 @@ static void desc_read_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
-	if (send_read(device, attrib, desc->proxy, desc->pending_reads, id,
-					offset, bt_att_get_link_type(att)))
+	if (send_read(att, attrib, desc->proxy, desc->pending_reads, id,
+					offset))
 		return;
 
 fail:
@@ -2883,10 +2901,9 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
 		if (!device_is_trusted(device) && !desc->prep_authorized &&
 						desc->req_prep_authorization)
-			send_write(device, attrib, desc->proxy,
+			send_write(att, attrib, desc->proxy,
 					desc->pending_writes, id, value, len,
-					offset, bt_att_get_link_type(att),
-					false, true);
+					offset, false, true);
 		else
 			gatt_db_attribute_write_result(attrib, id, 0);
 
@@ -2896,9 +2913,8 @@ static void desc_write_cb(struct gatt_db_attribute *attrib,
 	if (opcode == BT_ATT_OP_EXEC_WRITE_REQ)
 		desc->prep_authorized = false;
 
-	if (send_write(device, attrib, desc->proxy, desc->pending_writes, id,
-			value, len, offset, bt_att_get_link_type(att), false,
-			false))
+	if (send_write(att, attrib, desc->proxy, desc->pending_writes, id,
+			value, len, offset, false, false))
 		return;
 
 fail:
@@ -2977,8 +2993,8 @@ static void chrc_read_cb(struct gatt_db_attribute *attrib,
 		goto fail;
 	}
 
-	if (send_read(device, attrib, chrc->proxy, chrc->pending_reads, id,
-					offset, bt_att_get_link_type(att)))
+	if (send_read(att, attrib, chrc->proxy, chrc->pending_reads, id,
+	       offset))
 		return;
 
 fail:
@@ -3016,9 +3032,9 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	if (opcode == BT_ATT_OP_PREP_WRITE_REQ) {
 		if (!device_is_trusted(device) && !chrc->prep_authorized &&
 						chrc->req_prep_authorization)
-			send_write(device, attrib, chrc->proxy, queue,
+			send_write(att, attrib, chrc->proxy, queue,
 					id, value, len, offset,
-					bt_att_get_link_type(att), true, true);
+					true, true);
 		else
 			gatt_db_attribute_write_result(attrib, id, 0);
 
@@ -3039,13 +3055,12 @@ static void chrc_write_cb(struct gatt_db_attribute *attrib,
 	}
 
 	if (g_dbus_proxy_get_property(chrc->proxy, "WriteAcquired", &iter)) {
-		if (acquire_write(chrc, device, attrib, id, value, len,
-						bt_att_get_link_type(att)))
+		if (acquire_write(chrc, att, attrib, id, value, len))
 			return;
 	}
 
-	if (send_write(device, attrib, chrc->proxy, queue, id, value, len,
-			offset, bt_att_get_link_type(att), false, false))
+	if (send_write(att, attrib, chrc->proxy, queue, id, value, len,
+			offset, false, false))
 		return;
 
 fail:
-- 
2.17.1

