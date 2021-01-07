Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24AD7C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B4F2223E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbhAGBsy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbhAGBsx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 20:48:53 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEE8C0612EF
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 17:48:13 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 30so3640275pgr.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 17:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB5yMvnq+/xGPcV8kDD79nmzgHXjKAgfGxxUl0esbdc=;
        b=sWulCI+Spm6rC+MY1tc9xFurZzlQfIEVqheQBp3q/leOGaJ4UoKaWr68nkRAC/1LoU
         Bf/kiJy3jW4Aqs5LFdd4mGnPJ455M3ojKWLTjCoph3H2hNeRU3P6bfQUX9daCedbkCah
         QaZE0WooqR7ocdouRnYF6IAvwlKZymYVDtzCImm31JNR6W0Xbp9r22kKpgO467TTkMj9
         pPtVziqpJSyg7wz2ODHvQdxAXe4WqZ1PhSO7koY85PFzuxu3i9rlLZfUuzKk1kIict0g
         /1ziABQS2hPHWyY+kfRME3z7iO7YVynpG9LHkEVXAGh8POkImgIBVSsR9BhTH2IQ+dK4
         mzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EB5yMvnq+/xGPcV8kDD79nmzgHXjKAgfGxxUl0esbdc=;
        b=UiBaFR1BSOCN+K2Vw73wpGCIph98SuWHoDX1lHiM00w91GazWLj+F/qhG53i2AAFV6
         YMVyGeLDSD6KVBMr7Wn/pT9q221jGMsGw2wg/A1wcOCZzqtJXGdLitKFpfVErOASnOm2
         G+52sB7iJlRfezxmhM8+OJDsJ06uS7Y3uk5vmElK7FR3+qNMoD2h9kb+oimQreE4Wd4I
         ssVnevFwEwFdwO+XnHAy4795up5Lx9VSHZFPV9++90Wl6/fh4WfeC1awKguJYNtBI0I0
         NcEDQgps8lp0TbLER1J8DBpVFegNVr5G3QK0bf31K7DATBVy4D1NOLTl79EDwzOq/aNM
         Shxg==
X-Gm-Message-State: AOAM5309AtKISyWLtUMSyoVYctHvgEtn1c3DQnma64mb2U5PswlL5Rbn
        DZJyX+v7eoDP2RTQPoRop6G3BYmgVog=
X-Google-Smtp-Source: ABdhPJyTGGRr5AmKrX/FQm7Tx5JvLupFLPWErUQxacGebv4GEtqwUA/7QjmRpNQKibb6W3yHUDmPGA==
X-Received: by 2002:aa7:85d8:0:b029:19e:610e:1974 with SMTP id z24-20020aa785d80000b029019e610e1974mr6668573pfn.21.1609984092648;
        Wed, 06 Jan 2021 17:48:12 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k11sm3749684pgt.83.2021.01.06.17.48.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:48:12 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] shared/gatt-server: Fix not accepting multiple requests
Date:   Wed,  6 Jan 2021 17:48:11 -0800
Message-Id: <20210107014811.3812318-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With introduction of EATT it is possible to send multiple requests using
different channels therefore bt_gatt_server shall not attempt to check
if there is already an outstanding request.

gh issue: https://github.com/bluez/bluez/issues/75
---
 src/shared/gatt-server.c | 53 +++++-----------------------------------
 1 file changed, 6 insertions(+), 47 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0ce994be3..b5f7de7dc 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -108,9 +108,6 @@ struct bt_gatt_server {
 	struct queue *prep_queue;
 	unsigned int max_prep_queue_len;
 
-	struct async_read_op *pending_read_op;
-	struct async_write_op *pending_write_op;
-
 	bt_gatt_server_debug_func_t debug_callback;
 	bt_gatt_server_destroy_func_t debug_destroy;
 	void *debug_data;
@@ -140,12 +137,6 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 	bt_att_unregister(server->att, server->prep_write_id);
 	bt_att_unregister(server->att, server->exec_write_id);
 
-	if (server->pending_read_op)
-		server->pending_read_op->server = NULL;
-
-	if (server->pending_write_op)
-		server->pending_write_op->server = NULL;
-
 	queue_destroy(server->prep_queue, prep_write_data_destroy);
 
 	gatt_db_unref(server->db);
@@ -324,9 +315,7 @@ error:
 
 static void async_read_op_destroy(struct async_read_op *op)
 {
-	if (op->server)
-		op->server->pending_read_op = NULL;
-
+	bt_gatt_server_unref(op->server);
 	queue_destroy(op->db_data, NULL);
 	free(op->pdu);
 	free(op);
@@ -343,11 +332,6 @@ static void read_by_type_read_complete_cb(struct gatt_db_attribute *attr,
 	uint16_t mtu;
 	uint16_t handle;
 
-	if (!server) {
-		async_read_op_destroy(op);
-		return;
-	}
-
 	mtu = bt_att_get_mtu(server->att);
 	handle = gatt_db_attribute_get_handle(attr);
 
@@ -524,11 +508,6 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 		goto error;
 	}
 
-	if (server->pending_read_op) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
-
 	op = new0(struct async_read_op, 1);
 	op->pdu = malloc(bt_att_get_mtu(server->att));
 	if (!op->pdu) {
@@ -539,9 +518,8 @@ static void read_by_type_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 	op->chan = chan;
 	op->opcode = opcode;
-	op->server = server;
+	op->server = bt_gatt_server_ref(server);
 	op->db_data = q;
-	server->pending_read_op = op;
 
 	process_read_by_type(op);
 
@@ -764,9 +742,7 @@ error:
 
 static void async_write_op_destroy(struct async_write_op *op)
 {
-	if (op->server)
-		op->server->pending_write_op = NULL;
-
+	bt_gatt_server_unref(op->server);
 	free(op);
 }
 
@@ -777,7 +753,7 @@ static void write_complete_cb(struct gatt_db_attribute *attr, int err,
 	struct bt_gatt_server *server = op->server;
 	uint16_t handle;
 
-	if (!server || op->opcode == BT_ATT_OP_WRITE_CMD) {
+	if (op->opcode == BT_ATT_OP_WRITE_CMD) {
 		async_write_op_destroy(op);
 		return;
 	}
@@ -841,16 +817,10 @@ static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 	if (ecode)
 		goto error;
 
-	if (server->pending_write_op) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
-
 	op = new0(struct async_write_op, 1);
 	op->chan = chan;
-	op->server = server;
+	op->server = bt_gatt_server_ref(server);
 	op->opcode = opcode;
-	server->pending_write_op = op;
 
 	if (gatt_db_attribute_write(attr, 0, pdu + 2, length - 2, opcode,
 							server->att,
@@ -901,11 +871,6 @@ static void read_complete_cb(struct gatt_db_attribute *attr, int err,
 	uint16_t mtu;
 	uint16_t handle;
 
-	if (!server) {
-		async_read_op_destroy(op);
-		return;
-	}
-
 	util_debug(server->debug_callback, server->debug_data,
 				"Read Complete: err %d", err);
 
@@ -954,16 +919,10 @@ static void handle_read_req(struct bt_att_chan *chan,
 	if (ecode)
 		goto error;
 
-	if (server->pending_read_op) {
-		ecode = BT_ATT_ERROR_UNLIKELY;
-		goto error;
-	}
-
 	op = new0(struct async_read_op, 1);
 	op->chan = chan;
 	op->opcode = opcode;
-	op->server = server;
-	server->pending_read_op = op;
+	op->server = bt_gatt_server_ref(server);
 
 	if (gatt_db_attribute_read(attr, offset, opcode, server->att,
 							read_complete_cb, op))
-- 
2.26.2

