Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7090C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01AE61108
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Oct 2021 21:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhJDV2p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Oct 2021 17:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbhJDV2o (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Oct 2021 17:28:44 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C38C061745
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Oct 2021 14:26:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id l6so812884plh.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Oct 2021 14:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zuu2MMsVUHGTX+V/QwYrfuWltouxp3ZzUBUJkH9tyhc=;
        b=B7qzJ4TlE9y12P9e+uFU1bOUaFCJjFENaab7QkYt/kc/mG6fx1+2KPi0uJ4wDXtViv
         Qu4NM1CxBfzN1/TtJtJ+yyY3hq/JVqClY7w15tugTSMDK+Ceyr8ZaJcTw9t8M3XIA/SJ
         XW8VZp12b4F3URwSoKyUOvyHIxTyD6zBs0Bub/dArW/Zg5k3YWTqNknR3qT1iaAeDm5+
         1ez+m65aU4ep6D+Yg2403hgO6WrphlmJEwkd+yoAVWvPppl6YdR+sjOg4Qk3Al3uXD1q
         Cp9nkbQyqUuBW4lw1+MiHFFt5IOWa/zQKm19T3wO5W8+ultl+gHnjW77CGwqJzyA/nyn
         +mkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zuu2MMsVUHGTX+V/QwYrfuWltouxp3ZzUBUJkH9tyhc=;
        b=ASRqsAAwYNmGH6wrM6q2u3T8mUw5BMc/3AHl70E4V0CbzqcqvVD1Nll/ZBFwmEd4J8
         sH1zWkWgYnJHofZcbnDi9ravqkCmHnWVr1iaC7E+cyHl2NBSaGp2I3+5Hp77lfX16JlZ
         DGHgOwx61ZfpMECqQYfZ+iHrK84vFmepRLY0+g/c1xfiyNBHZj8JCtFFudRVlUjr7p7V
         AA+zD8MgCWKY2OrJF26LQ7LXyVVC5tqMY2JedwkYYfieZEXZDgiIUwIMcextXmXLUJ3a
         l7mcOBxyeQIxhoW95/X4lY4bHqlRQobNF3xt1kmwwk/VgbHeU5XaH6QGI7w+pNveS+9s
         G1rg==
X-Gm-Message-State: AOAM531c94kGfiSQkI2EQj3WGybBl5JMsGqCWmSajw4DxcOe02Xi46Uk
        f9x/BMqmccQ0MUKBpTFjQCyoxCoaZNo=
X-Google-Smtp-Source: ABdhPJxx/aTc/ltNLFA9R06U8AZGkSGItomoYOdcs0EShr55nb37Z8PFDtfFzSibQmo/gyTx/vs+6A==
X-Received: by 2002:a17:90a:d58b:: with SMTP id v11mr32507191pju.207.1633382814736;
        Mon, 04 Oct 2021 14:26:54 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 126sm16722965pgi.86.2021.10.04.14.26.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 14:26:54 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/2] shared/gatt-client: Make use of bt_att_resend
Date:   Mon,  4 Oct 2021 14:26:52 -0700
Message-Id: <20211004212652.4074831-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211004212652.4074831-1-luiz.dentz@gmail.com>
References: <20211004212652.4074831-1-luiz.dentz@gmail.com>
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

