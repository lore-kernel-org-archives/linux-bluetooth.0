Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA0DC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 10:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59D4720716
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 10:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H3RSlvL/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728788AbgC3Kgm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:36:42 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:36401 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728656AbgC3Kgm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 06:36:42 -0400
Received: by mail-yb1-f202.google.com with SMTP id u1so4655396ybm.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 03:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SJeKMKG0mEpNFe6waj8HgqpQAmJ2X8vTQ/aK8SaCZog=;
        b=H3RSlvL/zkAewnloFzWpsA+UICgzdOFdOMgxlQVsvVxh5EJEm3wiEt0QMxJknh6sDh
         jEAjHzGipt6zDJMnoMa0VvZmYSaiTtrXusjQ49kbFkjU9z1Hq5lAzfr7R1f1MJi3gj1U
         f2X02WY+9g4Z2CCAoSGU4YQ31Z+9KCnh/HT6vIGRI9Fbnf1SRnCMh8AKZSUpqM+8wI8F
         Ts0NarVEgOR/B6aSrYaTp+wkdYMuJcPPmKmZQnzBg1iYfWEoNnyZ+xOzvsq79vQZvH1W
         9TDIHxEUbXkwWCU3MPwnvmLSHHLQQWeYeXdjmoNCniM0ec4wGqW8zXGJWZvZhtic0ZNu
         mAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SJeKMKG0mEpNFe6waj8HgqpQAmJ2X8vTQ/aK8SaCZog=;
        b=JZsPOma3waiyI81P0DwC2wWXZIeg6pq555AT0PHfkOXLHGPqDbkK98ookm0d4MR0q/
         j1vZnYtYotV+FTCXklP7XKeTrypE4pzWipMWr5Qtr95IeWACVpOHtYoNnkZ0XH27NjPW
         qZjcCVdSj9/mAZ2TqXl4vqUOHE2C87INYbC5CsrfIvIEFi9rVqipnC7wJJMDek4JqA/4
         vURGJk1QtpzGTCHWaPa8qwrYlfFRzqyETziHZe8jfLDCqEcFTaqRG4+hUWipQMptqIKC
         17qfewmM4hdjFfHEffK9Ytw0jk4mFzMCZI8o7+JOKHPlZ/whVS5CWxhQ88Gafn+uDByp
         QpHA==
X-Gm-Message-State: ANhLgQ0V6V4xF0DHGo/ypkgqOVL4QjW5txCSSo1jdTuoILS51c0V3GRc
        /xJ3/PpXdTTIAN357fqccRG/5Z45UejHkLjRIWdREAcHUf84svnaCSyILokPnmX5bDYlNPlHT4D
        bytsifiRb0u1xI0SmdLaBcd/rTZS7d5mlueJuVpNmCRTJqaFjN7r5vN0K3nLHlXuSxZtuuVb6GF
        UW
X-Google-Smtp-Source: ADFU+vtzhGsp6WxY1/Qw+mNW8mHMgOOQ9JCJMV2S5Iw9BMbxYyCF89vkI6muvCrDh9tmHUYtCi+RJWv4Z+k1
X-Received: by 2002:a25:d9c1:: with SMTP id q184mr19985293ybg.349.1585564599463;
 Mon, 30 Mar 2020 03:36:39 -0700 (PDT)
Date:   Mon, 30 Mar 2020 18:36:31 +0800
Message-Id: <20200330183400.Bluez.v2.1.Id504860f0b01d123e0b29ed953dbdf02d738fed7@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v2] shared/att: Check the signature of att packets
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

Changes in v2:
- Move the signature verification part to crypto.c
- Attempt not to copy the whole pdu while verifying the signature
  by not separating the opcode from the rest of pdu too early, so
  we don't have to rejoin them later.

 src/shared/att.c    | 25 ++++++++++++-------------
 src/shared/crypto.c | 22 ++++++++++++++++++++--
 src/shared/crypto.h |  2 ++
 3 files changed, 34 insertions(+), 15 deletions(-)

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
 
diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 5c5e1217d..879ebd35d 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -75,6 +75,8 @@ struct af_alg_iv {
 /* Maximum message length that can be passed to aes_cmac */
 #define CMAC_MSG_MAX	80
 
+#define ATT_SIGN_LEN	12
+
 struct bt_crypto {
 	int ref_count;
 	int ecb_aes;
@@ -265,7 +267,8 @@ static inline void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
 
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 				const uint8_t *m, uint16_t m_len,
-				uint32_t sign_cnt, uint8_t signature[12])
+				uint32_t sign_cnt,
+				uint8_t signature[ATT_SIGN_LEN])
 {
 	int fd;
 	int len;
@@ -319,10 +322,25 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	 * 12 octets
 	 */
 	swap_buf(out, tmp, 16);
-	memcpy(signature, tmp + 4, 12);
+	memcpy(signature, tmp + 4, ATT_SIGN_LEN);
 
 	return true;
 }
+
+bool bt_crypto_verify_att_sign(struct bt_crypto *crypto, const uint8_t key[16],
+				const uint8_t *pdu, uint16_t pdu_len)
+{
+	uint8_t generated_sign[ATT_SIGN_LEN];
+	const uint8_t *sign = pdu + pdu_len - ATT_SIGN_LEN;
+	uint32_t sign_cnt = get_le32(sign);
+
+	if (!bt_crypto_sign_att(crypto, key, pdu, pdu_len - ATT_SIGN_LEN,
+						sign_cnt, generated_sign))
+		return false;
+
+	return memcmp(generated_sign, sign, ATT_SIGN_LEN) == 0;
+}
+
 /*
  * Security function e
  *
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index c58d2e104..d17daa835 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -62,5 +62,7 @@ bool bt_crypto_h6(struct bt_crypto *crypto, const uint8_t w[16],
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 				const uint8_t *m, uint16_t m_len,
 				uint32_t sign_cnt, uint8_t signature[12]);
+bool bt_crypto_verify_att_sign(struct bt_crypto *crypto, const uint8_t key[16],
+				const uint8_t *pdu, uint16_t pdu_len);
 bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
 				size_t iov_len, uint8_t res[16]);
-- 
2.26.0.rc2.310.g2932bb562d-goog

