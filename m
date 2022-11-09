Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D333C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Nov 2022 22:29:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbiKIW3o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Nov 2022 17:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232217AbiKIW3i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Nov 2022 17:29:38 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C82EF77
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Nov 2022 14:29:34 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id fz10so56491qtb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Nov 2022 14:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XLY8KpeE8Egd3biw/bjn/d0MZKjfy02OzHvVagQIpyA=;
        b=Gzz6P4OZ55yVkH+wMdZvOlSQ0AeYLvPt4DjmcRcgFGST732eWvAKvF5kbPzGxzfdHH
         DuwZE4YxcklTpwS46LN4qPFV9zoNOqUtOxXeJy5M9eWFdJDRPNlT48XvcMeVu/yJgPgM
         A1xE86PORFjgpUv3T7gyvRIeoNwnanGH5Vcti3UDrKqLsk93hfx1nBcD6TceBgDitF+g
         kq7SsYspQjzlC5Yzn8Yp5msB9HBoyjAWT2C/MWUTRSEvlDiU/5Py7edas3iqCgZtxQVA
         WCeE4lK3XGBmH8cpLYPifxcPnUq4GZp+uMiHTuxY+6p5Dc42r6fFseY5YDaIw1KrAmJ8
         fvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XLY8KpeE8Egd3biw/bjn/d0MZKjfy02OzHvVagQIpyA=;
        b=d/5XFtAKX/t042Naai7t1cev1aVJkg1kYNTe7kWyXosxg5F4HG09U9PtZ46cBAP46P
         I1onr64j7AfcHrU2Q9BYxia+9A6JUzI+7JcYZH/KAOILggo4cj+QHPetvkLKC0uAEp5m
         YN/bZX7Ug2Z81jbvUMz1VkLXmHF0qYdKe3LyTEpUBUTTtn4rgoZXRoy4f/PxQJBWYk8h
         U38WCgGuo4Inw4eavZd40oWTJ8TcFxtrzcqarGMYRacuXMScIh365nMBeEM5wivWN054
         raaKp8HDxae1hOqK62yIVecQ5N6CIUXfkAGad6DfXtPw4wDHYI3thUHT9UhPC1fvPnE5
         ImAQ==
X-Gm-Message-State: ANoB5pm6XMhN6MQ149l+Xr8z2HD+97EhUHER+TymTBhKW0gqizGijZ0F
        lvAv5wkkL5mDE4Z1zSGIdIFw2okBL/s=
X-Google-Smtp-Source: AA0mqf5ojbybmso5i8ceFUf8QbjokqscWXdqN9IcrRmon6vt1bAoGgR32EcbWDduLJS7gDnHzODBJA==
X-Received: by 2002:a05:622a:144b:b0:3a5:abe2:51c8 with SMTP id v11-20020a05622a144b00b003a5abe251c8mr6856783qtx.433.1668032972865;
        Wed, 09 Nov 2022 14:29:32 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id q21-20020a37f715000000b006ed61f18651sm11499501qkj.16.2022.11.09.14.29.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 14:29:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/util: Add iovec helpers
Date:   Wed,  9 Nov 2022 14:29:26 -0800
Message-Id: <20221109222930.1137690-1-luiz.dentz@gmail.com>
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

