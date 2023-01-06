Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93151C53210
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 00:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjAFAie (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 19:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236493AbjAFAhj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 19:37:39 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFEB161338
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 16:37:32 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id g16so59703plq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 16:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pxWnQGC8WNpA1O4HBAgYHtD/W/elHvXVW3AqL9SqjsU=;
        b=OvYspuoeLulN/MxKym4c5593kP1QWQIdROWS8FIVy2BJxplSGx+4EDo+Y0wXtTX+/i
         VLi4SmQCw9MnsLOea6hjMS5dzOEj6oNtNbORXpBlFN3fhTOVqsauqOr/FIcBKSM9RYE3
         q4m9xHESznwOBKChJnGD/L8wHt0YQ7La5t23tXl56oBYi3og34C+D81rzsmvFF03ViST
         8lDI53V83Ddj7YKnfBTAo3xAIH6DsI0WdWrygr75u8o3V2Z//UVdMi2HxRf2HoEEHuPX
         Z5EtzBrU1eIiWRxJyLLGR//5BLhoxgjsMXqqfZo2LvH1pk98/ZNMQ7tBAe1pogP6NH1d
         /Rrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxWnQGC8WNpA1O4HBAgYHtD/W/elHvXVW3AqL9SqjsU=;
        b=09aurZMgxM7PNaKFmVYO+FsIXwn4dKOYmZlxrS/SKiBRRz/iX45byrDn2WlkFmUUTY
         aSGJsIcCAvVYfUGzKoPdnSx6LfV7QZCRBh+AzsiUQFnrN61Dlm2wnaJ+pRfB/vLDZt2U
         LO/QO1DFqoAhRiUQ/nqs5Bf0ZLY5ch6oijltM3gEuZlIvcLXY/L4T/I7vI0IDDz3pOp0
         yXHwcYTJEZbxlN6fcPDQVZ+MPvIa1nZJySRZY6/So4CTYdf0XHyQ9hsx3QtkvPCKz25D
         EvwX/a7dpGJ6YMuWUvcdG19vqfrB7NnNSU+4SZOHrT5uQFuMAWKMewCiWK80TURWNIdp
         Ty9Q==
X-Gm-Message-State: AFqh2kqJ7c0Af+5DmBUK9kiWCFcieJ1YFjC9QFBqfd/dyt6T0gXWmNlU
        agn5U642t9/GY3bTFDNA3gr2bT/kbEA=
X-Google-Smtp-Source: AMrXdXsiEt2rlfqu3CgSSBkUN1qtZCaSAu1gk5bIl94Odhu9GkzfdZYF6ZL7gTkeQLZaSFpiTG/loQ==
X-Received: by 2002:a17:903:1315:b0:192:ccfc:c178 with SMTP id iy21-20020a170903131500b00192ccfcc178mr16443597plb.52.1672965451463;
        Thu, 05 Jan 2023 16:37:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id i18-20020a17090332d200b00174c1855cd9sm26694843plr.267.2023.01.05.16.37.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 16:37:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-client: Fix smatch warnings
Date:   Thu,  5 Jan 2023 16:37:29 -0800
Message-Id: <20230106003729.2526075-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the following warnings:

shared/gatt-client.c:2764:33: warning: Variable length array is used.
shared/gatt-client.c:2994:23: warning: Variable length array is used.
shared/gatt-client.c:3075:23: warning: Variable length array is used.
shared/gatt-client.c:3514:23: warning: Variable length array is used.
---
 src/shared/gatt-client.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 593b0f27f871..baff68f28c65 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2761,7 +2761,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 					void *user_data,
 					bt_gatt_client_destroy_func_t destroy)
 {
-	uint8_t pdu[num_handles * 2];
+	uint8_t *pdu = newa(uint8_t, num_handles * 2);
 	struct request *req;
 	struct read_op *op;
 	uint8_t opcode;
@@ -2798,7 +2798,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 		BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
 		BT_ATT_OP_READ_MULT_REQ;
 
-	req->att_id = bt_att_send(client->att, opcode, pdu, sizeof(pdu),
+	req->att_id = bt_att_send(client->att, opcode, pdu, num_handles * 2,
 							read_multiple_cb, req,
 							request_unref);
 	if (!req->att_id) {
@@ -2991,7 +2991,7 @@ unsigned int bt_gatt_client_write_without_response(
 					uint16_t value_handle,
 					bool signed_write,
 					const uint8_t *value, uint16_t length) {
-	uint8_t pdu[2 + length];
+	uint8_t *pdu = newa(uint8_t, 2 + length);
 	struct request *req;
 	int security;
 	uint8_t op;
@@ -3014,7 +3014,7 @@ unsigned int bt_gatt_client_write_without_response(
 	put_le16(value_handle, pdu);
 	memcpy(pdu + 2, value, length);
 
-	req->att_id = bt_att_send(client->att, op, pdu, sizeof(pdu), NULL, req,
+	req->att_id = bt_att_send(client->att, op, pdu, 2 + length, NULL, req,
 								request_unref);
 	if (!req->att_id) {
 		request_unref(req);
@@ -3072,7 +3072,7 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 {
 	struct request *req;
 	struct write_op *op;
-	uint8_t pdu[2 + length];
+	uint8_t *pdu = newa(uint8_t, 2 + length);
 
 	if (!client)
 		return 0;
@@ -3096,7 +3096,7 @@ unsigned int bt_gatt_client_write_value(struct bt_gatt_client *client,
 	memcpy(pdu + 2, value, length);
 
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_WRITE_REQ,
-							pdu, sizeof(pdu),
+							pdu, 2 + length,
 							write_cb, req,
 							request_unref);
 	if (!req->att_id) {
@@ -3511,7 +3511,7 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 {
 	struct request *req;
 	struct prep_write_op *op;
-	uint8_t pdu[4 + length];
+	uint8_t *pdu = newa(uint8_t, 4 + length);
 
 	if (!client)
 		return 0;
@@ -3570,7 +3570,7 @@ unsigned int bt_gatt_client_prepare_write(struct bt_gatt_client *client,
 	 * Note that request_unref will be done on write execute
 	 */
 	req->att_id = bt_att_send(client->att, BT_ATT_OP_PREP_WRITE_REQ, pdu,
-					sizeof(pdu), prep_write_cb, req,
+					length, prep_write_cb, req,
 					NULL);
 	if (!req->att_id) {
 		op->destroy = NULL;
-- 
2.37.3

