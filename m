Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1893C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Nov 2022 00:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiKOAao (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Nov 2022 19:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbiKOAan (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Nov 2022 19:30:43 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0A21CFFB
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:42 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b1-20020a17090a7ac100b00213fde52d49so12345354pjl.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Nov 2022 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NNiMOLVQp06Z6ykn1e6kwojsIWfRd4etqlKeAPwou0A=;
        b=j9DRTU6vWZR/1alwXhsTLKC/dSELy02lAqZiJs6F9J3Dkrk048vX7fVBbyH+vb/aPQ
         MB0+7bw11LnTjO8zBZCiP0j2hXAS0JF61XJIExFTRhWbxdmXbXUuk81j2VmGAAnpuRMd
         YXSuMl4Vpeh6OKdQua9mzCx9e1xkuam8mmsogHbXsv4iNJjlq3Tdx0UMLei0ClaySiv2
         AMQBw2BojmL+jXTuo6AiMtHHx2F47HH8JkzekVp62vycgCRnRV8PJdmZMt/7BBbd/pUY
         53Z0Czfc1xNRV3XjsOeKMNFZ4Oz8ffyCh1aTBpXVllOdVTo43vMUBdb/3lEma8LMNBEu
         Q6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNiMOLVQp06Z6ykn1e6kwojsIWfRd4etqlKeAPwou0A=;
        b=r9gU3kDvZnHLqLKrTugWy6oomdEpZAz0r6tSe8KoQWPWExv6M7i0iBTrEcj+gpzLvo
         BcwVtk1sZG8XhvneaBJyb+EzYte7SPGnSzk/TuNr4Cp/4Juhm9z/TrD8EOCv9PIiL55D
         1TGl/v8SrHznqTI8MvCNf9n08rQcRp7DJl116uX7Bf/GQ5B/F30vbY3MQyyjQf0PhJLN
         elUyreIWreQt+JqLrCdCEqxQsPSbdZf7EcsFRsOhahjYC4QKwyWbBvMaPwqdumMYFibs
         Jn5oWvjFpCgXrmOGQf65Mb54trMWnY0qjFrpgUps5AjlRZAj+v17XaKdrVKnkvwgr5zV
         v4/w==
X-Gm-Message-State: ANoB5pkuTv9hATF2P9Enrx4VTDWBUrJBjd0/hciF6jWtWqPp/vwbeq1j
        DLETwonwnRVMjWtkRyqwc9I9xN6ctVk=
X-Google-Smtp-Source: AA0mqf41d2Xy9iBefH66nMhNV3uwJZA0uDUJyIFa88FUVLKhIz28QmnVm0IsS+wnytQ6SeILIQBtog==
X-Received: by 2002:a17:902:da90:b0:186:8518:6c95 with SMTP id j16-20020a170902da9000b0018685186c95mr1550505plx.149.1668472241755;
        Mon, 14 Nov 2022 16:30:41 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id h3-20020a17090a3d0300b0020a28156e11sm10307888pjc.26.2022.11.14.16.30.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 16:30:41 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/6] shared/util: Add iovec helpers
Date:   Mon, 14 Nov 2022 16:30:34 -0800
Message-Id: <20221115003038.2134340-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221115003038.2134340-1-luiz.dentz@gmail.com>
References: <20221115003038.2134340-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds iovec helpers functions.
---
 src/shared/util.c | 103 ++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/util.h |  10 +++++
 2 files changed, 113 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 0a0308cb0786..333023e0dcac 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -189,6 +189,109 @@ void util_clear_uid(uint64_t *bitmap, uint8_t id)
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
+void *util_iov_push(struct iovec *iov, size_t len)
+{
+	void *data;
+
+	if (!iov)
+		return NULL;
+
+	data = iov->iov_base + iov->iov_len;
+	iov->iov_len += len;
+
+	return data;
+}
+
+void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data)
+{
+	void *p;
+
+	p = util_iov_push(iov, len);
+	if (!p)
+		return NULL;
+
+	memcpy(p, data, len);
+
+	return p;
+}
+
+void *util_iov_pull(struct iovec *iov, size_t len)
+{
+	if (!iov)
+		return NULL;
+
+	if (iov->iov_len < len)
+		return NULL;
+
+	iov->iov_base += len;
+	iov->iov_len -= len;
+
+	return iov->iov_base;
+}
+
+void *util_iov_pull_mem(struct iovec *iov, size_t len)
+{
+	void *data = iov->iov_base;
+
+	if (util_iov_pull(iov, len))
+		return data;
+
+	return NULL;
+}
+
 static const struct {
 	uint16_t uuid;
 	const char *str;
diff --git a/src/shared/util.h b/src/shared/util.h
index 554481e1e1ea..dc84f963588f 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -15,6 +15,7 @@
 #include <byteswap.h>
 #include <string.h>
 #include <sys/types.h>
+#include <sys/uio.h>
 
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 #define BIT(n)  (1 << (n))
@@ -109,6 +110,15 @@ ssize_t util_getrandom(void *buf, size_t buflen, unsigned int flags);
 uint8_t util_get_uid(uint64_t *bitmap, uint8_t max);
 void util_clear_uid(uint64_t *bitmap, uint8_t id);
 
+struct iovec *util_iov_dup(const struct iovec *iov, size_t cnt);
+int util_iov_memcmp(const struct iovec *iov1, const struct iovec *iov2);
+void util_iov_memcpy(struct iovec *iov, void *src, size_t len);
+void *util_iov_push(struct iovec *iov, size_t len);
+void *util_iov_push_mem(struct iovec *iov, size_t len, const void *data);
+void *util_iov_pull(struct iovec *iov, size_t len);
+void *util_iov_pull_mem(struct iovec *iov, size_t len);
+void util_iov_free(struct iovec *iov, size_t cnt);
+
 const char *bt_uuid16_to_str(uint16_t uuid);
 const char *bt_uuid32_to_str(uint32_t uuid);
 const char *bt_uuid128_to_str(const uint8_t uuid[16]);
-- 
2.37.3

