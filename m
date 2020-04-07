Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC02C2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B12820748
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ucUQYalJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgDGI4i (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:56:38 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:45515 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGI4h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:56:37 -0400
Received: by mail-pg1-f202.google.com with SMTP id v29so1904832pgo.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qeg3a+GT/t1CBST+N2dWD+HdLtuOyVVP4PFOkkE3kV0=;
        b=ucUQYalJDVip2CzNCTR+kxrQn3bouuD1OPeAi994xT35k+WZcAKFoum97a2iQMrgvM
         sX1KFhSy/5Vxu4aWb95AYr1ha5tc2CvUvCKGcEcQumw+5RqR0BmX1GPNE+0086L8fZdn
         QwjXWJR9t38PfQ60V9rxVV+xZsYnFg2EGhmDHJxcYwYzRPZlvE6mPkpOclqkoIpfFh3S
         6KlcGoWTA5GZSHTYDPq/RHChQ04bbagzYYeuzTcxatzjj7hCZZHepDpOwZnIZGJq/W50
         qaZl0FfmMeYNrau/av0YmNpUi8NYX9r8n9r432i3IybBDD2OjsTlFVMNZwz5MpXMF6bk
         jvFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qeg3a+GT/t1CBST+N2dWD+HdLtuOyVVP4PFOkkE3kV0=;
        b=JNzynEOnoyCpdY0dndprkzINzsPH/TCMoAZH+qv8ICDIGTxE4+DKxrifEI2rBxF6Q6
         kwf1/+U2PYX9VfFCJ2JVLyRMHFWEKFANx41J44QeTewGuD2gN/ZSv0jkn07Be+u8SOtP
         wlSd2v+hGia7bRTw2XLm/si3SFzbSOPyhrTrgvogn1RveIila5MDpiihYiBddsOy3Zpg
         1akOjuhd0zY9I+2ESOkeNYNSsVA8ScletfSmNPG+a1GuWoXDpSOqzMdrNGX3t51s2zk/
         LPTaUX2vjdQCvajUvw3tgL7CAzODsAaRE2q186K0FH+fRnYlnbQK9vs7+RPUUC20bXoq
         EY9Q==
X-Gm-Message-State: AGi0PuZMkijm+Bh+2H8Fv87dcC+2RILkWX/sc6TcWo9CWRknUTkvpw1U
        VAP+b1o9q8qdSxM3WW1Ogd53TePaALsSrBBHQ6Lmjl2IehquJ6ShlgVRhYLkpMrP/QQNYiJqIjO
        jwbr3HJJ3KoPkwtqYQx4vwEBeDCMQBKZLk1TyAqkkh5yAfrukci0wd2G3gvHCIOltbgx2hg4iNt
        E3
X-Google-Smtp-Source: APiQypJutldv//2AmFQEKLU5PoCCOXflKXTelYmQV18FJsfii4bv/sbf9VGMG5K/Cmm7388gGkJGleyBe47I
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr1037234pgg.50.1586249794429;
 Tue, 07 Apr 2020 01:56:34 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:56:09 +0800
In-Reply-To: <20200407085610.231013-1-apusaka@google.com>
Message-Id: <20200407165521.Bluez.v4.3.I28a54f18ca82b58e44689a0c76663e735fefb6f1@changeid>
Mime-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v4 3/4] shared/att: Check the signature of att packets
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

Changes in v4: None
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

