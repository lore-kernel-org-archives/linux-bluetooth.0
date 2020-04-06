Return-Path: <SRS0=77es=5W=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA385C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E89C2072A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Apr 2020 11:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dgpy4i6p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgDFLtL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Apr 2020 07:49:11 -0400
Received: from mail-qv1-f73.google.com ([209.85.219.73]:51058 "EHLO
        mail-qv1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbgDFLtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Apr 2020 07:49:11 -0400
Received: by mail-qv1-f73.google.com with SMTP id bp6so13139691qvb.17
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Apr 2020 04:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=P1CYYJxRJdXeawfgUg4+0ok7rGkImZ0tV/3+HASYTVE=;
        b=dgpy4i6p7yXLcenq+rUhFssSIXtRNX0bgAbECpdlws1VFSjJzM9UU5UnET0xM9Wt4I
         h3Rg/Xm0L1GoWTJaNWn85Yd+uLMvSP4o0swo9SET3RYxu5RNpkQqy5r9Lq7dIWhxqi9+
         FGrB3K7o/R1HCFRYPeDXLCPq9Xbix9DAcgY+1veNs0tcI5ovaUt/UkWm23m8foNY4pmN
         RO0iiLvEkTvxAcuf9fZji6y28+/00/pKY07dUSs6RwBNnIzy+8vISTaoa7jIpB+Z8o8k
         8ZMVwG4zU8KIszk9CT8pdaX5GDzLMP3TIwFhm0eGfj+UmjGNchJTOCQULatH7VQMWUye
         Zw4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=P1CYYJxRJdXeawfgUg4+0ok7rGkImZ0tV/3+HASYTVE=;
        b=dp32h4UuIcpaqmTYGXe2VBmOTGM8Yrl77/AybinUcYEauSmz0ALKv6cPBFo1fpYCkg
         0PNA/bAJq223TwtA6uAcxHh5r+HQ8G2m45Jbeht7NCjc1/jX7TP6Eqj9WQk5DB8gfETK
         ZxAb/5Y/1XMMIDClRT18JRc/ivZRzorKommJuelYCoHIrjJnfvQ9hoI7wPdQWEG9R7EJ
         khy3uzsFgJXPh13it2uTHnDJXHJ5ntagwum7h1NaW2syUx9dfZCQI43BRI/UkiGZNWs4
         pAhujmmgo1naqLOLW4UichaSk+HSZlnzRlRDciM+JqIvUhmWA9zUe3f3zkeVyRzI/FSV
         TeTw==
X-Gm-Message-State: AGi0PubpOKymH4e3yq1kw7zoN/poKW3fRYAQuVB463OLbdUYNvbjZUen
        JiB9eLyddKt4VgHm8iXJCevyUuzyLRsByFclJh5LQtxiAoOvYkTTe1hmLjFmvoVRINKWyQHEI7u
        S7Br1BT2WLBmO1dRD2c6IzWjkybHcYyGqIEkbP71CsPt6SrBUKP+XXq7qgmsmjx3u5EvTRgce/G
        mf
X-Google-Smtp-Source: APiQypLwgQN6Q9grdbJPw9pl+UK66kRo0hyUrBF0XoYVrmhIGVo0+LXsV4m09JgFEcEJuVbfEM8nO6jWA/uC
X-Received: by 2002:a05:620a:341:: with SMTP id t1mr19715568qkm.356.1586173749694;
 Mon, 06 Apr 2020 04:49:09 -0700 (PDT)
Date:   Mon,  6 Apr 2020 19:48:43 +0800
In-Reply-To: <20200406114845.255532-1-apusaka@google.com>
Message-Id: <20200406194749.Bluez.v3.1.I6373c573d8c831d0c96974911469e2ac6bff1e42@changeid>
Mime-Version: 1.0
References: <20200406114845.255532-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v3 1/3] shared/crypto: Add bt_crypto_verify_att_sign
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

