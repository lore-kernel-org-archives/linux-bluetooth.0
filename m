Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2430C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CA7610CE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 18:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbhIMSHK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhIMSHJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 14:07:09 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001EFC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:05:53 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id k23-20020a17090a591700b001976d2db364so649367pji.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A76cooCpSZl8MrGzyyuDAXU2K6jHx/FCZWRJCRunqAM=;
        b=EXn9ekIVTtju0Z6YCVLhJhgc2je6Dkrg5HPkjAVjNtniU+PrxQGirqksnxP/0dRce8
         SFQKF8KUZ0VlW03JD2kezgWNK1fuxp9grIZfGAf9MsDS/VghCP5jMUv3BDM/9RWTG+Lj
         OuqD0U+Uj2SD5pjJJufUAaQGCIR8uMNAjPsExy4ERvCS8cgF91VGTMDOqKbEUtV16CXK
         9APXmkq6oUVtNeez0dutbu6ozSlqLdH/tOj0Hd62hFlEmmMJfUtc7lPo8fJXbhpC1HlH
         pvwQEt+f4U+kgXNkVDBCiaIrSvdN7D+APFacyDRkk1nF5VJ//BhS8lWy8ZqDwfW+u1yU
         RifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A76cooCpSZl8MrGzyyuDAXU2K6jHx/FCZWRJCRunqAM=;
        b=Ljunnfaz30P3Foi0Md2l0Q34So/Fk+pROl+KV2sf7pOBi6SnxPnIbPe+f6uf24Eg7u
         CHyhGKcpRenKKJI9RP0t39FRxKEEDrWIt5AH9HhpVl4Bfbkjxrv/8VfrSxl5Y0lVklOI
         O3mfyGMcJFgxJnKoXpdEyhltxoUXfdg+rKFbWlJceP3c99zezf3O528o7s7g4OLH+xhG
         h+9/4o4X9IUKGYk6uBD93fx0g1IGog4BF2LclpX2qx47SWLJyCXFmysb2OM98tSOB81V
         qFoY3O8odvRWcDWDm0xq/3Q47oJKhTp4U3R4qFeIAzR3a+4xvX/207nE4JgJvL2XxRkD
         +LZQ==
X-Gm-Message-State: AOAM533FAjSjWNGwA6KHrZrHbK8q54MeGS6dSdskD4EgI3GfS48+vM0s
        jbFc3pgVgS8elHW8QmHeTDgXaE74A+M=
X-Google-Smtp-Source: ABdhPJx9qo4+1wIkwEY0VwpLh6LW2Kl1eIqJAxW8sDLU5pok6SAc6pZGXkRUZzZKq1SIvCisy5x0ZQ==
X-Received: by 2002:a17:902:6e02:b0:13a:41f5:1666 with SMTP id u2-20020a1709026e0200b0013a41f51666mr11564683plk.39.1631556353116;
        Mon, 13 Sep 2021 11:05:53 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u24sm8303812pfm.27.2021.09.13.11.05.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:05:52 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/util: Add convertion function for 24 bits
Date:   Mon, 13 Sep 2021 11:05:51 -0700
Message-Id: <20210913180552.3468107-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds get/put 24 bits variants.
---
 src/shared/util.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/src/shared/util.h b/src/shared/util.h
index 60908371d..ac70117ca 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -131,6 +131,20 @@ static inline uint16_t get_be16(const void *ptr)
 	return be16_to_cpu(get_unaligned((const uint16_t *) ptr));
 }
 
+static inline uint32_t get_le24(const void *ptr)
+{
+	const uint8_t *src = ptr;
+
+	return ((uint32_t)src[2] << 16) | get_le16(ptr);
+}
+
+static inline uint32_t get_be24(const void *ptr)
+{
+	const uint8_t *src = ptr;
+
+	return ((uint32_t)src[0] << 16) | get_be16(&src[1]);
+}
+
 static inline uint32_t get_le32(const void *ptr)
 {
 	return le32_to_cpu(get_unaligned((const uint32_t *) ptr));
@@ -161,6 +175,18 @@ static inline void put_be16(uint16_t val, const void *ptr)
 	put_unaligned(cpu_to_be16(val), (uint16_t *) ptr);
 }
 
+static inline void put_le24(uint32_t val, void *ptr)
+{
+	put_le16(val, ptr);
+	put_unaligned(val >> 16, (uint8_t *) ptr + 2);
+}
+
+static inline void put_be24(uint32_t val, void *ptr)
+{
+	put_unaligned(val >> 16, (uint8_t *) ptr + 2);
+	put_be16(val, ptr + 1);
+}
+
 static inline void put_le32(uint32_t val, void *dst)
 {
 	put_unaligned(cpu_to_le32(val), (uint32_t *) dst);
-- 
2.31.1

