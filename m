Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A133C678D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 01:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjCCB1q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCCB1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 20:27:46 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57101557C
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 17:27:44 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id z2so1134231plf.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 17:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2fMO3DDvUJJeV0Q226fQtHUTjSXAJS4amcasCJTxOgo=;
        b=RRQknOM9/ZUGOM8aWVJSJIU0DoP1hU9vT7tnaCQDJtPJe+6farCIf8yUmpoNE7cST7
         BN/v6vEKUs3kdktk4NIo8MTG35VUpB9xCbfEZKaLgAIN/QV+FYXOjUksyzLSPlluu2LU
         s1CHu2rRTtrUGEwFj3vG9Kbpe1DWysC2AWCp7d2M3lXUS1uUSguWZC15xJJTEUxcU1JM
         IFkyrBNObDnpNtNxxs42WVLPv7xZw1KvUcwcR5WAQdF153/h9MrZ0FEOZ9VMvikyrdi8
         ROkMLDreajLM1yPMwvkhKp9F5ap3vaybmXXYR6fHMXnvvWKaKCB224yFjQJD8xKVH7nk
         m9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fMO3DDvUJJeV0Q226fQtHUTjSXAJS4amcasCJTxOgo=;
        b=NaZ1/0uvAB9fAR4y1R6ngtjm5wj76kkWvozQK9xZ5QR0IiF+NHzItRpzp3DI9qFG0Z
         PWp/PWZ38rjTjxiZ99c4DoK0CgljYjygFz5xRVEvMMLHijKh+4QZn272hDlWxoAdiPqz
         jpwtzUrSd9xwzKmpuruCteD6JCR6aPl5r3ON3js91vf7+tAev1LQ53jXBxAAiAxX+OhL
         bs/WrNp62TDo29FG+0+BRI5zfHXhBgaCZri+eYsAdZUseFPQLEn8fXJMojn/7ZoVg1Pm
         O58mFgV7oYXtKBZCHegf/1U5Eu5CD0GG9WOUlXVRkTyhs7X6I3+TJJgm5pASSZNU50CG
         R+GA==
X-Gm-Message-State: AO0yUKXWxXVwweEHw87bfn1Q3qpTUWkU3UcJQIyKX6LKUs2gTj69Afj4
        XyKR7UOr9OL/qsNR2nywatWXWmGC320=
X-Google-Smtp-Source: AK7set+4q4haMHBa6lcrNeHiuvqZSa2yZMf7bZP715uuBulO6c44ZDNkuKdMXPtR7NyfvPiwEQh0Pw==
X-Received: by 2002:a17:903:22cc:b0:19c:ff35:35d1 with SMTP id y12-20020a17090322cc00b0019cff3535d1mr351265plg.6.1677806863599;
        Thu, 02 Mar 2023 17:27:43 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id kd3-20020a17090313c300b0019a6d3851afsm284622plb.141.2023.03.02.17.27.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 17:27:43 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 1/9] shared/crypto: Add bt_crypto_sirk
Date:   Thu,  2 Mar 2023 17:27:34 -0800
Message-Id: <20230303012742.1386291-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_crypto_sirk which attempts to generate a unique SIRK using
the following steps:

 - Generate a hash (k) using the str as input
 - Generate a hash (sirk) using vendor, product, version and source as input
 - Encrypt sirk using k as LTK with sef function.
---
 src/shared/crypto.c | 40 ++++++++++++++++++++++++++++++++++++++++
 src/shared/crypto.h |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 4cb2ea857ea8..5449621b55ea 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -926,3 +926,43 @@ bool bt_crypto_sef(struct bt_crypto *crypto, const uint8_t k[16],
 
 	return true;
 }
+
+/* Generates a SIRK from a string using the following steps:
+ *  - Generate a hash (k) using the str as input
+ *  - Generate a hash (sirk) using vendor, product, version and source as input
+ *  - Encrypt sirk using k as LTK with sef function.
+ */
+bool bt_crypto_sirk(struct bt_crypto *crypto, const char *str, uint16_t vendor,
+			uint16_t product, uint16_t version, uint16_t source,
+			uint8_t sirk[16])
+{
+	struct iovec iov[4];
+	uint8_t k[16];
+	uint8_t sirk_plaintext[16];
+
+	if (!crypto)
+		return false;
+
+	iov[0].iov_base = (void *)str;
+	iov[0].iov_len = strlen(str);
+
+	/* Generate a k using the str as input */
+	if (!bt_crypto_gatt_hash(crypto, iov, 1, k))
+		return false;
+
+	iov[0].iov_base = &vendor;
+	iov[0].iov_len = sizeof(vendor);
+	iov[1].iov_base = &product;
+	iov[1].iov_len = sizeof(product);
+	iov[2].iov_base = &version;
+	iov[2].iov_len = sizeof(version);
+	iov[3].iov_base = &source;
+	iov[3].iov_len = sizeof(source);
+
+	/* Generate a sirk using vendor, product, version and source as input */
+	if (!bt_crypto_gatt_hash(crypto, iov, 4, sirk_plaintext))
+		return false;
+
+	/* Encrypt sirk using k as LTK with sef function */
+	return bt_crypto_sef(crypto, k, sirk_plaintext, sirk);
+}
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index fc1ba0c4feeb..d45308abf90a 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -57,3 +57,6 @@ bool bt_crypto_sef(struct bt_crypto *crypto, const uint8_t k[16],
 			const uint8_t sirk[16], uint8_t out[16]);
 bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
 					const uint8_t r[3], uint8_t hash[3]);
+bool bt_crypto_sirk(struct bt_crypto *crypto, const char *str, uint16_t vendor,
+			uint16_t product, uint16_t version, uint16_t source,
+			uint8_t sirk[16]);
-- 
2.39.2

