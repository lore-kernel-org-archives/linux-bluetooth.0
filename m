Return-Path: <SRS0=n6SA=5M=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E827C43331
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 12:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9B720774
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Mar 2020 12:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+pfWiIE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgC0MTN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:19:13 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:52752 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgC0MTM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Mar 2020 08:19:12 -0400
Received: by mail-pf1-f202.google.com with SMTP id i1so8114887pfo.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2020 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=q1a8YaBudmCWyQKVzo/+dlJ8UTOIxIR0+8G5uSTT6gs=;
        b=b+pfWiIE11Pke+7jEQ3Yo1DZe++TRhTk2wEhQQNAZjuTvtq0iAXBQiauTEIw6uDCcZ
         nHCl8tZ2S42teYeU1deHo1OggWmbsPo8VnHKkiTgmzYIQs/EkzUpghG9FNY2dJ7lZ3Kp
         HaYrW4NmmcJSpLY4puH0qFikyanPzup7A6Z7G9vMZVFYJI4VsKuCYyLNZpcQMDkVTkIq
         OBrO5qHc5DrjvdpwtOzJcstBkvsk79g3zviyDEudGlgMBSqRbxZQHHosNsz8hCddhWMs
         1aL/XeAFBdOCOMBd5rslU/zmik0d3nhEqcuWK10Bb3RfWU4wfFGesx3E71UpyaubCUgR
         O/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=q1a8YaBudmCWyQKVzo/+dlJ8UTOIxIR0+8G5uSTT6gs=;
        b=sdKwYPdfvYYGMZ4yiUrpfHQesJifipglHCOdF4fQIb2usPrlRK8szsTs5y6zcwMje0
         /VVLImN8cBb6KnV7BcDijBYLo4Cx3A03yvEp3csMV5QRx3pVU6yMvNXjpWIhXVUgEZp6
         yhz+fkQ+wmIYrhmY+TVc4bNWyCzhsvQPkEfxThR8xEUBjTW1iLk8kPaXHwliSrx7prfh
         hukkPEBve7S32fNFcJACFLcf7s08CIRZonfFIIk1iry9Zu8dcytjkmINwuGCgkGwTnQE
         lGGHgJ8FmEWUmAZPPqnYxEjUHD40KFlwVBDuEe1/YeGqz5ZOJ7FJf9a0uFCAXA98Rbri
         YJIQ==
X-Gm-Message-State: ANhLgQ11BahdJVqKUSdzxGi0vCvajaC9hzfap2uDYw36BuKS0JzMUqId
        zsY3LZZQ/OttHQqvFgxjVE3NGRYzg3/uA+DlMtVx4+wTuktw2ukv0mlXDsvU4BCbgk5vEt4JChh
        pfHX+M1av2mauFNNuRqhf9K9j7jdE7bPq8gt6c2dUc5kjbUpUOdU/TSrxPgveMtGUoI5y39dbKv
        lA
X-Google-Smtp-Source: ADFU+vs8z/YRjN7Y7K7PWG2IuaxsvpzEqVbb/UXrSJjpT02L29LTZLa01xmUQgxNZVml/uW+T3SfVdYznnEl
X-Received: by 2002:a63:d7:: with SMTP id 206mr13338783pga.366.1585311551473;
 Fri, 27 Mar 2020 05:19:11 -0700 (PDT)
Date:   Fri, 27 Mar 2020 20:18:59 +0800
Message-Id: <20200327201817.Bluez.v1.1.If919a39697a6506be273f879d752bd506e63b45b@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [Bluez PATCH v1] shared/att: Check the signature of att packets
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

According to bluetooth spec Ver 5.1, Vol 3, Part C (GAP), 10.4.2
A device receiving signed data shall authenticate it by performing
the Signing Algorithm. The signed data shall be authenticated by
performing the Signing Algorithm where m is the Data PDU to be
authenticated, k is the stored CSRK and the SignCounter is the
received counter value. If the MAC computed by the Signing
Algorithm does not match the received MAC, the verification fails
and the Host shall ignore the received Data PDU.

Currently bluez ignore the signature of received signed att
packets, as the function bt_crypto_sign_att() only generates the
signature, and not actually make any check about the genuineness
of the signature itself.

This patch also fix a wrong boolean condition which prevents
handle_signed() to be called.

Tested to pass these BT certification test
SM/MAS/SIGN/BV-03-C
SM/MAS/SIGN/BI-01-C
---

 src/shared/att.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/src/shared/att.c b/src/shared/att.c
index 948a5548b..0faac4d1d 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -886,6 +886,8 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 {
 	uint8_t *signature;
 	uint32_t sign_cnt;
+	uint8_t *copy_pdu = NULL;
+	uint8_t *generated_signature;
 	struct sign_info *sign;
 
 	/* Check if there is enough data for a signature */
@@ -903,15 +905,29 @@ static bool handle_signed(struct bt_att *att, uint8_t opcode, uint8_t *pdu,
 	if (!sign->counter(&sign_cnt, sign->user_data))
 		goto fail;
 
-	/* Generate signature and verify it */
-	if (!bt_crypto_sign_att(att->crypto, sign->key, pdu,
-				pdu_len - BT_ATT_SIGNATURE_LEN, sign_cnt,
-				signature))
+	/* Generate signature */
+	copy_pdu = malloc(pdu_len + 1);
+	if (!copy_pdu)
 		goto fail;
 
+	copy_pdu[0] = opcode;
+	memcpy(copy_pdu + 1, pdu, pdu_len - BT_ATT_SIGNATURE_LEN);
+	generated_signature = copy_pdu + pdu_len - BT_ATT_SIGNATURE_LEN + 1;
+
+	if (!bt_crypto_sign_att(att->crypto, sign->key, copy_pdu,
+				pdu_len - BT_ATT_SIGNATURE_LEN + 1, sign_cnt,
+				generated_signature))
+		goto fail;
+
+	/* Verify received signature */
+	if (memcmp(generated_signature, signature, BT_ATT_SIGNATURE_LEN))
+		goto fail;
+
+	free(copy_pdu);
 	return true;
 
 fail:
+	free(copy_pdu);
 	util_debug(att->debug_callback, att->debug_data,
 			"ATT failed to verify signature: 0x%02x", opcode);
 
@@ -925,7 +941,7 @@ static void handle_notify(struct bt_att_chan *chan, uint8_t opcode,
 	const struct queue_entry *entry;
 	bool found;
 
-	if ((opcode & ATT_OP_SIGNED_MASK) && !att->crypto) {
+	if ((opcode & ATT_OP_SIGNED_MASK) && att->crypto) {
 		if (!handle_signed(att, opcode, pdu, pdu_len))
 			return;
 		pdu_len -= BT_ATT_SIGNATURE_LEN;
-- 
2.25.1.696.g5e7596f4ac-goog

