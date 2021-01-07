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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46267C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E848E2311E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Jan 2021 01:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbhAGBHO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 20:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbhAGBHO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 20:07:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AB2C0612F0
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Jan 2021 17:06:33 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id v19so3512178pgj.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Jan 2021 17:06:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypo6KUbt8G9AwKoRp6YtJqAtHS1v8rnjwZZOqfwVgWk=;
        b=sVkhfnEE2g/kSi2v5g+soajtxB4mb3futiED6fTUXOuaF7IUEVp7qcpNrub/v0rZRo
         8TQM5paTzoMa5TaXh/GDDN7hCO5l8nnxEs2JRodZd6Tutx4gTet+ymuc3RUEKfpnwuwi
         4w6WRISJrdFBfD7ZyZU77qYPnQEEZKC6W0XudoBO80BoscsmC7hnSgckfZ36tmo6CWp2
         m2RIt3M8hQKGswgrHMcoPFhIpD10487BI2kbGcRrE24XRbrhgsYPdsZnyrgq5IOH1t2N
         euNyTFC7hSRnzWjeP9dP+mbTnHFFY/EY7yvW1nbWk5F/9OBtRURSQk4aIoQTpMLni0MA
         g9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ypo6KUbt8G9AwKoRp6YtJqAtHS1v8rnjwZZOqfwVgWk=;
        b=ayp4dsiTMtE2m+NA3CFPvQXft8dKvxBJu2JG/fxuHRDLo9RP8uFwwNVNzxY2uOC7T8
         xnOvxXcxZUVK8B0OwQS/8n/LqeO/AF1GiO5x69xrpnKLghBZRkre9a9WMFxjwwU6ZL2n
         GGZBWVJiWLXZ6LfFA1ulPbBTFlchU671Dxu2cRXt89ACkhGbOcQR3FaH+n3rgRb+1af5
         2wPN7fc3xulJ9H501BPtBrfjMpc4y96j6NvNfbAym3g1UVez5Z/5xoHqmbBpkLmdRndi
         QeCMPll08rXDwgdxj95X7OW7MIpjE3sbV2uHmjnl7NgXR3w+ftndbn2SKAULn8j/5P1W
         ipLw==
X-Gm-Message-State: AOAM530pSsZcZwTv0XzygHV/wWI3hLQOsV0lrHxmk8I6xrOXVJ8tMI83
        Sdds2iSRLhi2Tc0Sng7msIvB52Eepb4=
X-Google-Smtp-Source: ABdhPJzcixc1WeDTmMG4caSO/ayAPbdbxzkL4OPhlwiRW5/RTjzPJkEOWdAZWdKCT3Mbh9ILx1yWjw==
X-Received: by 2002:aa7:9046:0:b029:1a4:aa3b:1f31 with SMTP id n6-20020aa790460000b02901a4aa3b1f31mr6165978pfo.77.1609981593128;
        Wed, 06 Jan 2021 17:06:33 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id gk4sm203163pjb.57.2021.01.06.17.06.32
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 17:06:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-server: Fix not accepting multiple requests
Date:   Wed,  6 Jan 2021 17:06:31 -0800
Message-Id: <20210107010631.3806496-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With introduction of EATT it is possible to send multiple requests using
different channels therefore bt_gatt_server shall not attempt to check
if there is already an oustanding request.

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

