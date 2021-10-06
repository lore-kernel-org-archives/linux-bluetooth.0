Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB053C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF3F4610CC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 21:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbhJFVjC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 17:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbhJFVjB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 17:39:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9A0C061753
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 14:37:08 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id 145so3494895pfz.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zuu2MMsVUHGTX+V/QwYrfuWltouxp3ZzUBUJkH9tyhc=;
        b=Xwv+uW5XApI1E6OSk49zAvh/YGJXcXh35nY94LcieUqNYJUD/graIrc5quMdk7Upcp
         qHa33ft1mMbJ1+f2W51tLMr4qHFE2UKuUfXr7lWE8CJAdZpwJPwcGq66OS0evkTu/mIV
         NE88MOX2GdWq3xqjJNPnkI9mFTiTiLFFi2jnU+qEkkd485hqbSRdobicWHPeiSYFDFKC
         3Rvzij2Pfa8QyS/dhT1XAs6hVCChoLoSqDJYHqlMbE6XWWVBCLaNSgxkEVIDQgdAILDc
         vsA1fKtO8Gt2QqlUpvCeFayZQt66DTGccce7MvUrBoL3rAac+sjgqfhp0FvcKS2O/vgD
         Yc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zuu2MMsVUHGTX+V/QwYrfuWltouxp3ZzUBUJkH9tyhc=;
        b=HL0t0hxVnlgIqcyE8sASK0WWNO13bHy7tZVCrTxmCi6jVpzCV0kAWWUYGZjh1BWLB5
         VxKiGWq9ti6e7xQlK82JntG/oBw98aeN7FKd0/2+fCCbTh09bcWa3wTtJiLw6YjSZh7d
         K6zQtNrwWtPTwr4QCaFHsrc6vxytspQfTbinfTWitAzDyk54X9AjSxkq2SCLvn0FHOyF
         FVKW52mZmZrP6g0yM7rwVTgrNsrGD2Jj9vQ2ncd5UXOLaSdR02YzUTYXLDb+Jn5R+P/8
         50xeautEnJr2nlMXTsSWjo2o7XW6sqzNWDC8mGVhoHF0w4jBMctZ+DzQBQ4HtrcL9V21
         y5HA==
X-Gm-Message-State: AOAM530egFWad326YHeEn79fxmxV9iawsCNEHkdfcMox5qh33aXbTAiU
        fpYxv1QZZHLFtjJnD0E9UXvIrFEtBKs=
X-Google-Smtp-Source: ABdhPJxJ6lAWB4SUkvyQVQcj8hjtflNuRrEJMA5BpTmoq4AO45SeoOKsUN9veJ6s22pXAbvEu0zqwQ==
X-Received: by 2002:a63:7d04:: with SMTP id y4mr320555pgc.131.1633556227541;
        Wed, 06 Oct 2021 14:37:07 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e6sm11858763pgf.59.2021.10.06.14.37.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 14:37:07 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] shared/gatt-client: Make use of bt_att_resend
Date:   Wed,  6 Oct 2021 14:37:02 -0700
Message-Id: <20211006213704.1093265-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211006213704.1093265-1-luiz.dentz@gmail.com>
References: <20211006213704.1093265-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of bt_att_resend when sending continuation of PDUs such
as BT_ATT_OP_READ_BLOB_REQ and BT_ATT_OP_PREP_WRITE_REQ to avoid having
it interleave with other procedures, which is both simpler for the
peripheral to handle as well as it should reduce the lifetime of the
objects used for tracking the state of these procedures.
---
 src/shared/gatt-client.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 094922486..be0d3b091 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -2865,17 +2865,18 @@ static void read_long_cb(uint8_t opcode, const void *pdu,
 
 	if (length >= bt_att_get_mtu(op->client->att) - 1) {
 		uint8_t pdu[4];
+		int err;
 
 		put_le16(op->value_handle, pdu);
 		put_le16(op->offset, pdu + 2);
 
-		req->att_id = bt_att_send(op->client->att,
+		err = bt_att_resend(op->client->att, req->att_id,
 							BT_ATT_OP_READ_BLOB_REQ,
 							pdu, sizeof(pdu),
 							read_long_cb,
 							request_ref(req),
 							request_unref);
-		if (req->att_id)
+		if (!err)
 			return;
 
 		request_unref(req);
@@ -3121,6 +3122,7 @@ static void handle_next_prep_write(struct request *req)
 	struct long_write_op *op = req->data;
 	bool success = true;
 	uint8_t *pdu;
+	int err;
 
 	pdu = malloc(op->cur_length + 4);
 	if (!pdu) {
@@ -3132,12 +3134,13 @@ static void handle_next_prep_write(struct request *req)
 	put_le16(op->offset + op->index, pdu + 2);
 	memcpy(pdu + 4, op->value + op->index, op->cur_length);
 
-	req->att_id = bt_att_send(op->client->att, BT_ATT_OP_PREP_WRITE_REQ,
-							pdu, op->cur_length + 4,
-							prepare_write_cb,
-							request_ref(req),
-							request_unref);
-	if (!req->att_id) {
+	err = bt_att_resend(op->client->att, req->att_id,
+						BT_ATT_OP_PREP_WRITE_REQ,
+						pdu, op->cur_length + 4,
+						prepare_write_cb,
+						request_ref(req),
+						request_unref);
+	if (err) {
 		request_unref(req);
 		success = false;
 	}
@@ -3207,6 +3210,7 @@ static void complete_write_long_op(struct request *req, bool success,
 {
 	struct long_write_op *op = req->data;
 	uint8_t pdu;
+	int err;
 
 	op->success = success;
 	op->att_ecode = att_ecode;
@@ -3217,12 +3221,13 @@ static void complete_write_long_op(struct request *req, bool success,
 	else
 		pdu = 0x00;  /* Cancel */
 
-	req->att_id = bt_att_send(op->client->att, BT_ATT_OP_EXEC_WRITE_REQ,
-							&pdu, sizeof(pdu),
-							execute_write_cb,
-							request_ref(req),
-							request_unref);
-	if (req->att_id)
+	err = bt_att_resend(op->client->att, req->att_id,
+					BT_ATT_OP_EXEC_WRITE_REQ,
+					&pdu, sizeof(pdu),
+					execute_write_cb,
+					request_ref(req),
+					request_unref);
+	if (!err)
 		return;
 
 	request_unref(req);
-- 
2.31.1

