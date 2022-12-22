Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC40CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 22:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiLVWng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiLVWne (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:34 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64F0EBE
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id f9so2229589pgf.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FREv2B+vzQnAcYjD62du1FNguIros7B8DOElyGaLYug=;
        b=JdBHurtsexgb6mf1WSLcvnWmwstFW1R/w1s29adGbYHnS3+xRw+NOLwBiXNW7kbZk+
         pFtNlEGf658K2H9uBGp/LWoOCEZ9W7uN00vJETpTCsn0xurUS9JAlrlafkiAWnHW/srf
         TbsIx5HSB3883cOsqMM1LeigZvLG5j1aCY3oBbCLqyWwNq6fZZpnUll2u7EbWxS4xQI3
         yzvstNMTDw4liq4MeoZcepyyDfr+DeUaYfVvP89a9ONDdpB3hhogenQp+wuFL8o2tAFE
         Vu2aP2S1r0OgMo4TcsA+UpB0jdDHCpBBGm9Glvh612LnaqrO+gwoQDhIHiSzFNT8INAb
         AYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FREv2B+vzQnAcYjD62du1FNguIros7B8DOElyGaLYug=;
        b=LYd0AqCGnJ+n37AiCJ2SJDn9fkqt4hrKYhnIPPO3hduoIaeOr/8Y0P8l0h5eH0RSnd
         eC+V9r0x/Aj1pXTCwL17DYR5E9XOa8gmluHDGYSp/tO+NRdNUNc4HfFY2DyGRP88JGrW
         zDomdHssT7+vbflbtibnMl3Y0rJkpB36DHqecVBtUViH7idYLGAifMQ/nji7VH1XnECJ
         0qvUivf4qt4Or8S853du1i2V6gfq28IPJmpI+e1A5EjxJ/BALc+gzXgnGpphN9E2IgXq
         3Q9GLmN2QLaZwT8mQql+BKlaOXlAxOmyr9+cHMgMPvjpyMZfmyNh6PknGUEcRy61f2Bp
         023Q==
X-Gm-Message-State: AFqh2kr77qnqiO/qzDT2qMMTiaxhzPvxPdey+DJQrenQvVcGQ0QrwT8Q
        fqJ94joqshqNRhTsjME+MYKnKLXeYFUExQ==
X-Google-Smtp-Source: AMrXdXudJxkBSEdpSSTcvxWEzdLA5FuxMxXVDVaQUZ9BvuNegHGFzjpV/jlresJjZUYEbTM5NfXCsg==
X-Received: by 2002:a05:6a00:a07:b0:580:9431:1b1a with SMTP id p7-20020a056a000a0700b0058094311b1amr333445pfh.5.1671749011755;
        Thu, 22 Dec 2022 14:43:31 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79d86000000b0056bbeaa82b9sm1187546pfq.113.2022.12.22.14.43.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:43:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] shared/crypto: Adds bt_crypto_sih
Date:   Thu, 22 Dec 2022 14:43:25 -0800
Message-Id: <20221222224329.685837-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_crypto_sih is is used to create a hash as stated on
CSIS[1] spec:

  '4.7. Resolvable Set Identifier hash function sih'

https://www.bluetooth.com/specifications/csis-1-0-1/
---
 src/shared/crypto.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/crypto.h |  2 ++
 2 files changed, 38 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index d5efa416dd99..f164ba69d2a5 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -737,3 +737,39 @@ bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
 
 	return true;
 }
+
+/*
+ * Resolvable Set Identifier hash function sih
+ *
+ * The RSI hash function sih is used to generate a hash value that is used in
+ * RSIs.
+ *
+ * The following variables are the inputs to the RSI hash function sih:
+ *
+ *   k is 128 bits
+ *   r is 24 bits
+ *   padding is 104 bits, all set to 0
+ *
+ * r is concatenated with padding to generate r', which is used as the 128-bit
+ * input parameter plaintextData to security function e:
+ *
+ *   r'=padding||r
+ *
+ * The LSO of r becomes the LSO of r', and the MSO of padding becomes the MSO
+ * of r'.
+ *
+ * For example, if the 24-bit value r is 0x3A98B5, then r' is
+ * 0x000000000000000000000000003A98B5.
+ *
+ * The output of the Resolvable Set Identifier function sih is:
+ *
+ *   sih(k, r)=e(k, r') mod 2^24
+ *
+ * The output of the security function e is truncated to 24 bits by taking the
+ * least significant 24 bits of the output of e as the result of sih.
+ */
+bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
+					const uint8_t r[3], uint8_t hash[3])
+{
+	return bt_crypto_ah(crypto, k, r, hash);
+}
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index 356326d75408..fca52e38e5e2 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -53,3 +53,5 @@ bool bt_crypto_verify_att_sign(struct bt_crypto *crypto, const uint8_t key[16],
 				const uint8_t *pdu, uint16_t pdu_len);
 bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
 				size_t iov_len, uint8_t res[16]);
+bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
+					const uint8_t r[3], uint8_t hash[3]);
-- 
2.37.3

