Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EFEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 22:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbiKIW3y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbiKIW3x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 17:29:53 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C82EF61
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 14:29:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id p18so145651qkg.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLY8KpeE8Egd3biw/bjn/d0MZKjfy02OzHvVagQIpyA=;
        b=C7vSILYrF7CMoh6vv7kQmWkWsxTQkO4jBm3HdXPNg0xA3PqWWJNZkAURoRsNG0Ko2i
         UQ0btzHqDBS4u3b7aowwCFfgIh8YL6Bbx+IjiqkmOaMWkjByDucBvqSV/ayCh5yeVeOL
         FUzhUcz1U3ir4SV6yC2yVBYkAqWvm2wm7Q410ZEHbsHVwHf0f7Faq6FeWPvAveCWQidM
         dB3jFyYqyh/C98Oqtc3fu+hTfRGRXladlWctBMiVMvrOPQgPFnRwjNt6b5zbMb6imV72
         NhsIyasFU6UdMrRjM93bvgt71BqByZ9ATnOs48eY4wWu9JNGyt4W0PeLbmdAFq00rRKC
         ihVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLY8KpeE8Egd3biw/bjn/d0MZKjfy02OzHvVagQIpyA=;
        b=pm1X3VIDXl0rOjnvlFqFmFVvLRprK8qx370EjHDmPBx6kUlxU1GA6l8q7TY51U10b1
         JAp/SWOntThsu57k2h2QAMUU/6VvHkE03AFmxqBcYxmMJhTqSC00+iWsU7yt6z/pnxAF
         SqBCz+ivpgLFq4m7RWH2l3w0ww0f/XYeUdcdDtRkyYWF92TbPnUBSz5d9T8BT+t6dNle
         nt6oCSuRDFj/Z/Rjg5oCliUMQAv7Ul+Wqh/clHjGUSS7NnSqBtO8iYWR95q2gKVit5CV
         EJIkUEYUCfFmAsdX36++yI25owzncuikmAAlcNG3aEnhNHIuopBRtQPS9pbSppRxbQCX
         sZ0Q==
X-Gm-Message-State: ACrzQf06ZxRIwvWqXzloIjAv7rHWiVIEB06MNxDaOI5t/mkskXlItQkD
        NMuVwYW5mkkMYeMzZMXDzTfiKyGkByo=
X-Google-Smtp-Source: AMsMyM7sqW/Unnpl+RuGX9g1gbyzxkSR2NBD6d1dORi4ILaz/+0v7VrkU6AFl7kShGTk2nfOE5ba6g==
X-Received: by 2002:a37:e107:0:b0:6fa:4c1a:54ee with SMTP id c7-20020a37e107000000b006fa4c1a54eemr32760634qkm.728.1668032989919;
        Wed, 09 Nov 2022 14:29:49 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id z9-20020a05622a028900b0039bde72b14asm10518732qtw.92.2022.11.09.14.29.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:29:49 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/util: Add iovec helpers
Date:   Wed,  9 Nov 2022 14:29:44 -0800
Message-Id: <20221109222947.1137901-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds iovec helpers functions.
---
 src/shared/util.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  6 ++++++
 2 files changed, 59 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 0a0308cb0786..228044be459a 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -189,6 +189,59 @@ void util_clear_uid(uint64_t *bitmap, uint8_t id)
 	*bitmap &= ~(((uint64_t)1) << (id - 1));
 }
 
+struct iovec *util_iov_dup(const struct iovec *iov, size_t cnt)
+{
+	struct iovec *dup;
+	size_t i;
+
+	if (!iov)
+		return NULL;
+
+	dup = new0(struct iovec, cnt);
+
+	for (i = 0; i < cnt; i++)
+		util_iov_memcpy(&dup[i], iov[i].iov_base, iov[i].iov_len);
+
+	return dup;
+}
+
+int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2)
+{
+	if (!iov1)
+		return 1;
+
+	if (!iov2)
+		return -1;
+
+	if (iov1->iov_len != iov2->iov_len)
+		return iov1->iov_len - iov2->iov_len;
+
+	return memcmp(iov1->iov_base, iov2->iov_base, iov1->iov_len);
+}
+
+void util_iov_memcpy(struct iovec *iov, void *src, size_t len)
+{
+	if (!iov)
+		return;
+
+	iov->iov_base = realloc(iov->iov_base, len);
+	iov->iov_len = len;
+	memcpy(iov->iov_base, src, len);
+}
+
+void util_iov_free(struct iovec *iov, size_t cnt)
+{
+	size_t i;
+
+	if (!iov)
+		return;
+
+	for (i = 0; i < cnt; i++)
+		free(iov[i].iov_base);
+
+	free(iov);
+}
+
 static const struct {
 	uint16_t uuid;
 	const char *str;
diff --git a/src/shared/util.h b/src/shared/util.h
index 554481e1e1ea..765a4e956636 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -15,6 +15,7 @@
 #include <byteswap.h>
 #include <string.h>
 #include <sys/types.h>
+#include <sys/uio.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
@@ -109,6 +110,11 @@ ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
 uint8_t util_get_uid(uint64_t *bitmap, uint8_t max);
 void util_clear_uid(uint64_t *bitmap, uint8_t id);
 
+struct iovec *util_iov_dup(const struct iovec *iov, size_t cnt);
+int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2);
+void util_iov_memcpy(struct iovec *iov, void *src, size_t len);
+void util_iov_free(struct iovec *iov, size_t cnt);
+
 const char *bt_uuid16_to_str(uint16_t uuid);
 const char *bt_uuid32_to_str(uint32_t uuid);
 const char *bt_uuid128_to_str(const uint8_t uuid[16]);
-- 
2.37.3

