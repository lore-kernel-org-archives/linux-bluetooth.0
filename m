Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DF4C2BA16
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C75E20748
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ib+pPA5F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgDGI40 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:56:26 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55530 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGI40 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:56:26 -0400
Received: by mail-qk1-f202.google.com with SMTP id h186so2438297qkc.22
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ixePdWgFw7g7y9K8+PNzUptUWWtYVQio9P5eRJlOWfI=;
        b=Ib+pPA5Far2EmK+YIW23DQtUF7TXviRk//RDVLoD4Zr1KTennPsvSDKCGTvs70lVRP
         0tsya6iYtFeRIAn4yzOaEWBogEEdwK/oeFISCcO7imMSuv0CGuIlV3ejJu6tLotp1Osl
         BlcedprkajcfNqwKMAucVFAOoLuZNG5nZRkHsfmPn+yZrP/jOWl2ENUX8yS47UARg/60
         YVBqgeCABLVFUny76miAV/G1uo3hz5sLb9PBLzwVshj1kg6dJTijdY2rDo2KVCfoakI6
         QGPVfgVrTObihhPT9/cNUsazwKtHfMhlrs6RlxP/qTMmARxJkXKBV/+wIk8wH47UcaQc
         y3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ixePdWgFw7g7y9K8+PNzUptUWWtYVQio9P5eRJlOWfI=;
        b=jQtvJgrWaCXWTzFrj3e/evcVu45r0fYyhW8jpMSemfvPP+ZqGdwLXpIRIotuCzVZM0
         nIvCzPtxuoD6GZNPD3vWBM6zdps86SXzfYHF8xJIFyiXKs4nXkK42Kvr9Aho2PtUQtvN
         LGMpBNBMM7Xk4ugAKDAnHoTCkCSKzCLAITLOjugADaGbvpwOk25c8p9X1YNu8mPvP/dU
         ga9ua9/lTOGZX8vlh69eOiC58ByncpIKsIegdGn9OsOJQuy7q4zVmYVR4ySc7LoeiYTs
         2AywZUIZ8JPyTBflD1SrJj2RXx3pe9lNpXZjg2sJ1ymnuAVput4acTWQNu/DmnYNNDd1
         yfkA==
X-Gm-Message-State: AGi0Pub9bJywMChMyk6d0Dpt+KuGm97H7YkXumDwkHq0idmC4o0HZJrQ
        zDVE+9nawqdqVGVRiaxaORGB8q3H4+8R8aL6lNn7Zx1nSpPc7Y0Fuk309YaojWxBCjqTShDjJnk
        vknjVTKX29YmoCZsyp+738ltv9CNcXj4Dgqyykji9XQYCkLSgCRfG446KUs6yD+Y2nm6uxIIH+v
        Gm
X-Google-Smtp-Source: APiQypJsRFhF1zyvxTU5lV5ZiJzefbJZCK1qaiXgagAdsNe2GESx9bGWQ3QSW5V5TUXZGDd2etzBbWOzMQEj
X-Received: by 2002:a0c:b90e:: with SMTP id u14mr1110360qvf.177.1586249783485;
 Tue, 07 Apr 2020 01:56:23 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:56:07 +0800
In-Reply-To: <20200407085610.231013-1-apusaka@google.com>
Message-Id: <20200407165521.Bluez.v4.1.I6373c573d8c831d0c96974911469e2ac6bff1e42@changeid>
Mime-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v4 1/4] shared/crypto: Add bt_crypto_verify_att_sign
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

This is used to verify the signature of incoming ATT packets.
---

Changes in v4: None
Changes in v3:
- Add check for the case where pdu_len < ATT_SIGN_LEN

Changes in v2: None

 src/shared/crypto.c | 28 ++++++++++++++++++++++++++--
 src/shared/crypto.h |  2 ++
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 5c5e1217d..5cc88ce4a 100644
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
@@ -319,10 +322,31 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
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
+	const uint8_t *sign;
+	uint32_t sign_cnt;
+
+	if (pdu_len < ATT_SIGN_LEN)
+		return false;
+
+	sign = pdu + pdu_len - ATT_SIGN_LEN;
+	sign_cnt = get_le32(sign);
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
2.26.0.292.g33ef6b2f38-goog

