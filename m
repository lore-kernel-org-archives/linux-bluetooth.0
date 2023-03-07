Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2B1C6FA99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Mar 2023 22:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjCGWZY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Mar 2023 17:25:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjCGWZB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Mar 2023 17:25:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F0D90095
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Mar 2023 14:24:31 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id ky4so15768407plb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Mar 2023 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678227864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2fMO3DDvUJJeV0Q226fQtHUTjSXAJS4amcasCJTxOgo=;
        b=baut4pRknQmtSOiNrFOvRC5T+hL1Xi+k4T3XKC71MGFyHEwhwPJNwBWUF6p5EUkRkz
         NlY7R9ukJzhOrfBT9owOMnnrNCMWvNBxAEpK/4ofTKJFlVJf9kdt3K3YGL5RJOrK72p2
         9dHefnfUiu8vkFS4oQGHXkVakK8c0pdzf6D5CHA8O0quBqA6tSj4Ed1Tdq16q4o529yw
         iPf6JS7sKO7SzXmVF8UoD0dwY3K5SJxf/3VSTgVOgvPEAdQdeqwbmOaSJKASyhEbI2/P
         SdiMSIYWlVyfikai3wcYH6Hz/SMyTOGt8tiADr+zWUI/ChDWLa03O6EGoNWXhOwqMU9K
         pcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678227864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2fMO3DDvUJJeV0Q226fQtHUTjSXAJS4amcasCJTxOgo=;
        b=dCgIKo5XbzlUA71Hpbc5QNEOeN7uGtXzNMV5PJoZnUuZZyWSfGhcIi9a0dB5/zBo9Q
         VXVARpqLt+9OVdcRwLKiE9J9/QUczj8D/yCtJqdyMPDTxhJP4Lj2uyPWQIfiCEz20xTj
         P9+25U6A9sPSgVngAvCcPY2eN2Z/44VnQuHlhU6bSx/DsulLHkQ5EkkfT/jmSo6AviGr
         pfTAeX2UhLwdl/Xm3cX7bQZgHFE5trdyo0aUocQULBtrq3O7cVTG29hq/FzwsjBfhJcS
         Hu7/znTKYO3zX6+s8+G4mmL4cbs32CMbfOXXoZPCtC56BIse6xT4CJEo0plA+BrJZHnW
         0QYA==
X-Gm-Message-State: AO0yUKVGLVY9J8fKLwmDWy4AIolEbk4ouZDkAQ5QBjWrDgNwHs0ukR1z
        BkxJ8WENoR4KfiQjd0q9PrtpJXI36PA=
X-Google-Smtp-Source: AK7set9j79BlJ1H7xhvzqvNuittwP8TVj37nhEKqt9SDKwCzRF5NJST2f3KF3IAxMWCl3TiMunh3rw==
X-Received: by 2002:a17:902:ab0c:b0:19b:c491:21be with SMTP id ik12-20020a170902ab0c00b0019bc49121bemr14787919plb.64.1678227864305;
        Tue, 07 Mar 2023 14:24:24 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902729200b0019c901b35ecsm8814392pll.106.2023.03.07.14.24.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 14:24:23 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
Date:   Tue,  7 Mar 2023 14:24:11 -0800
Message-Id: <20230307222422.2608483-1-luiz.dentz@gmail.com>
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

