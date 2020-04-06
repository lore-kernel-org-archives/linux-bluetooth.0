Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E3CCC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF41206F8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ocm+D/cA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgDFLtX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:49:23 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:56812 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgDFLtX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 07:49:23 -0400
Received: by mail-pl1-f202.google.com with SMTP id k12so10802152pls.23
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZICTX6rmQU9UdgTWnjHU+NsOfmYGBlyCgKG+x77pXh8=;
        b=ocm+D/cAQrh2GK5UmSM0PBfhHns3t5dwkaPi10m17khqYkV77Z7DaGCYPXq00JlAB3
         mmOgDjPkMRBA4cOZtR22rLx+YOIs0dC6yYDSQBD9EXnmDMqfZByfc2C36ThDLpefErgP
         2EZUQmVjCoKOJ8AiyTrtBAFAYpvmi7r1IyMrbLAIn8FJpN1h/MfbaNrpae8T52si+eQ8
         6HgbNJNLCsJFyrXeQPuAt5mwAbUBuiFN7bt63zJ6O4VkDcf97wxVilauLRxD3QXqa5f4
         aRxZ3PWHKQ22fvzj+966Y7/WP6C2f56FtKBDKKoE5vwTthIRDqnB7bAqUsdURdwZHSZy
         PkMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZICTX6rmQU9UdgTWnjHU+NsOfmYGBlyCgKG+x77pXh8=;
        b=FCmDbWJK+N38bz2DZLdAS2GYq7KAV9ef9c1KPOaxDj5NCTmjHV1g55xiwF2CulkFxM
         mFIn0wfRDOabmg6U0zkDwcKhj1hrrZiHMcu17X6yeOdCU4n60IumvIJ558vcUh0ZoQiM
         99m18vuDg1chp2ASCYNj6dxw9yyrdO7h0Tz6NU+6IEiWY051xD4J9RDPdhYJ68ovjSCe
         b/apbXqJi1iXZWbYakWXDVQFQNnw3sOipLRJjHqqEkUlBCd7MBr4HzVuW0ZdhC6mwtY1
         6B+GRsXtThznRorU6dUg1gbFU7JOMOszyGh7Sk7vbOPgQkvAgConmz49DgmIdEYbGaw/
         cJnQ==
X-Gm-Message-State: AGi0PubZuhMFCMrgwa/YUB+5l3EbAJiO+LzZAqW90qguuAY78gbKp0zw
        4uDWiaVF486pTuVxRO2zrB6GXM3gr5+zCnChMWlFm1Y8fgu49HUKYv5yPL21F+cJJLdKSLh2tVY
        dnIUN0wypsRO2q47VzY0q/JOPdzMYfPxlhjx+lKAmNAlh/spgGfwCuhw8NxP1zjkPgdpkl6p5Zw
        Gw
X-Google-Smtp-Source: APiQypLIBBoB5odcb1Atlb7RXQ+kWgG80qyJFiQx+KLz5ZtyV5lnK/gZz8QbREtE4lzncQSiWzQKx8qN0VjU
X-Received: by 2002:a63:79c2:: with SMTP id u185mr19993934pgc.136.1586173762021;
 Mon, 06 Apr 2020 04:49:22 -0700 (PDT)
Date:   Mon,  6 Apr 2020 19:48:45 +0800
In-Reply-To: <20200406114845.255532-1-apusaka@google.com>
Message-Id: <20200406194749.Bluez.v3.3.I28a54f18ca82b58e44689a0c76663e735fefb6f1@changeid>
Mime-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v3 3/3] shared/att: Check the signature of att packets
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

Tested to pass these BT certification test
SM/MAS/SIGN/BV-03-C
SM/MAS/SIGN/BI-01-C

---

Changes in v3:
- Separate into three patches

Changes in v2:
- Move the signature verification part to crypto.c
- Attempt not to copy the whole pdu while verifying the signature
  by not separating the opcode from the rest of pdu too early, so
  we don't have to rejoin them later.

 src/shared/att.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 948a5548b..31c6901fb 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -881,15 +881,15 @@ static void respond_not_supported(struct bt_att *att, uint8_t opcode)
 									NULL);
 }
 
-static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
-								ssize_t pdu_len)
+static bool handle_signed(struct bt_att *att, uint8_t *pdu, ssize_t pdu_len)
 {
 	uint8_t *signature;
 	uint32_t sign_cnt;
 	struct sign_info *sign;
+	uint8_t opcode = pdu[0];
 
 	/* Check if there is enough data for a signature */
-	if (pdu_len < 2 + BT_ATT_SIGNATURE_LEN)
+	if (pdu_len < 3 + BT_ATT_SIGNATURE_LEN)
 		goto fail;
 
 	sign = att->remote_sign;
@@ -903,10 +903,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	if (!sign->counter(&sign_cnt, sign->user_data))
 		goto fail;
 
-	/* Generate signature and verify it */
-	if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
-				pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
-				signature))
+	/* Verify received signature */
+	if (!bt_crypto_verify_att_sign(att->crypto, sign->key, pdu, pdu_len))
 		goto fail;
 
 	return true;
@@ -918,15 +916,16 @@ fail:
 	return false;
 }
 
-static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
-						uint8_t *pdu, ssize_t pdu_len)
+static void handle_notify(struct bt_att_chan *chan, uint8_t *pdu,
+							ssize_t pdu_len)
 {
 	struct bt_att *att = chan->att;
 	const struct queue_entry *entry;
 	bool found;
+	uint8_t opcode = pdu[0];
 
-	if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
-		if (!handle_signed(att, opcode, pdu, pdu_len))
+	if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
+		if (!handle_signed(att, pdu, pdu_len))
 			return;
 		pdu_len -= BT_ATT_SIGNATURE_LEN;
 	}
@@ -963,7 +962,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
 		found = true;
 
 		if (notify->callback)
-			notify->callback(chan, opcode, pdu, pdu_len,
+			notify->callback(chan, opcode, pdu + 1, pdu_len - 1,
 							notify->user_data);
 
 		/* callback could remove all entries from notify list */
@@ -1054,7 +1053,7 @@ static bool can_read_data(struct io *io, void *user_data)
 		util_debug(att->debug_callback, att->debug_data,
 					"(chan %p) ATT PDU received: 0x%02x",
 					chan, opcode);
-		handle_notify(chan, opcode, pdu + 1, bytes_read - 1);
+		handle_notify(chan, pdu, bytes_read);
 		break;
 	}
 
-- 
2.26.0.292.g33ef6b2f38-goog

