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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 924E5C3F2D4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69C9C246B5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Feb 2020 23:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUcOj83b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgB1XrP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:47:15 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42992 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgB1XrO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Feb 2020 18:47:14 -0500
Received: by mail-pl1-f196.google.com with SMTP id u3so1826775plr.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2020 15:47:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QWDfGgp0E1rqcdY0x4qxjaOMAPigahCylDGC8zfCPCs=;
        b=mUcOj83btugphxtskZuyFh/hffkA+yTaBHTdo1pYOYxrveUsrI78LYQsl1ANX1bqjD
         ZSnXJk+mjnsu5FKRl9J59jHMgTKEP7r04rlLuAV6TUH0+rufAHpXLR2hNek9Sn5wbcIq
         5rJNI2pH2TSew9zcJ1xg1PSkksbEn/SW7Nvgnk8htv5OAAY6OedHoTk2DZfj4j+uEBW5
         NQWQctazIwcUQpb3/4ZCoHGsi7XoASdqkE5X6fCV6a/0Jt6pK9JHZIzqz93TUtNuzKjy
         9ASu5ozPFdDFy9d5se7RIN2H3L7mFCu9/wySExJl36ynWPeNwv5ta5mL3SvMzjKxPp3e
         vlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QWDfGgp0E1rqcdY0x4qxjaOMAPigahCylDGC8zfCPCs=;
        b=bgLQtyYwvwqYQaTGmsQM/xXa33ClXrhDZvP4C2U3X4GXpfnXiEzG1TZz4r6NqumV+J
         Ftkl+evZTtZ5LBsLmHMW+73A12r2jKbZYuLPRmKztRdqNVlGJBPtUqg7NX+fVuNMy8ew
         Z6ZXSwvzfmCfrF23dpiQx78iuPSHui8cYjz1646iFh3nABTaLmMLIZZhjNIZuejKO827
         GajnsFOVzFRi7a4K5bT7Djvdfgm2X/4iKBnKBGA41dugFmHQC2AWJ7D9tXlKCzbC5Zjd
         ho+fNt3UPhme6WZIXAfCbw5+nerWen1qUfhfq72w9eIjzTHRsU+KUp2N3s8OdzN8A/ZS
         8LYw==
X-Gm-Message-State: ANhLgQ00aooePaG3hrR5PS0Y3VmZU5jm9RLdeF6QyzgCkZ4AvG0vY+dI
        fIYz/VMHYOe4RtRDqiGsvem5QNnzxPI=
X-Google-Smtp-Source: ADFU+vu9JfHadDKuXms5KfoT3PsGOmDgWr/jxwHK07pZ+EYpqbwHtk+s+CHx2vhumVk6j4bakIndwQ==
X-Received: by 2002:a17:90a:3a86:: with SMTP id b6mr1403835pjc.96.1582933631765;
        Fri, 28 Feb 2020 15:47:11 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q13sm13643954pfn.162.2020.02.28.15.47.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:47:11 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 08/12] shared/gatt-client: Add support for Read Multiple Variable Length
Date:   Fri, 28 Feb 2020 15:46:57 -0800
Message-Id: <20200228234701.14614-9-luiz.dentz@gmail.com>
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
 src/shared/gatt-client.c | 42 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 2c5fe14dc..5b6723f97 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2642,7 +2642,9 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 	uint8_t att_ecode;
 	bool success;
 
-	if (opcode != BT_ATT_OP_READ_MULT_RSP || (!pdu && length)) {
+	if ((opcode != BT_ATT_OP_READ_MULT_RSP &&
+			opcode != BT_ATT_OP_READ_MULT_VL_RSP) ||
+			(!pdu && length)) {
 		success = false;
 
 		if (opcode == BT_ATT_OP_ERROR_RSP)
@@ -2657,8 +2659,36 @@ static void read_multiple_cb(uint8_t opcode, const void *pdu, uint16_t length,
 		att_ecode = 0;
 	}
 
-	if (op->callback)
+	if (!op->callback)
+		return;
+
+	if (opcode == BT_ATT_OP_READ_MULT_RSP || att_ecode) {
 		op->callback(success, att_ecode, pdu, length, op->user_data);
+		return;
+	}
+
+	if (length < 2) {
+		op->callback(success, att_ecode, pdu, length, op->user_data);
+		return;
+	}
+
+	/* Parse response */
+	while (length >= 2) {
+		uint16_t len;
+
+		len = get_le16(pdu);
+		length -= 2;
+		pdu += 2;
+
+		/* The Length Value Tuple List may be truncated within the
+		 * first two octets of a tuple due to the size limits of the
+		 * current ATT_MTU.
+		 */
+		if (len > length)
+			length = len;
+
+		op->callback(success, att_ecode, pdu, len, op->user_data);
+	}
 }
 
 unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
@@ -2670,6 +2700,7 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 	uint8_t pdu[num_handles * 2];
 	struct request *req;
 	struct read_op *op;
+	uint8_t opcode;
 	int i;
 
 	if (!client)
@@ -2699,8 +2730,11 @@ unsigned int bt_gatt_client_read_multiple(struct bt_gatt_client *client,
 	for (i = 0; i < num_handles; i++)
 		put_le16(handles[i], pdu + (2 * i));
 
-	req->att_id = bt_att_send(client->att, BT_ATT_OP_READ_MULT_REQ,
-							pdu, sizeof(pdu),
+	opcode = bt_gatt_client_get_features(client) &
+		BT_GATT_CHRC_CLI_FEAT_EATT ? BT_ATT_OP_READ_MULT_VL_REQ :
+		BT_ATT_OP_READ_MULT_REQ;
+
+	req->att_id = bt_att_send(client->att, opcode, pdu, sizeof(pdu),
 							read_multiple_cb, req,
 							request_unref);
 	if (!req->att_id) {
-- 
2.21.1

