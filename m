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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5482C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF4A361106
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Sep 2021 20:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242861AbhIMUPD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241556AbhIMUO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Sep 2021 16:14:59 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7540C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:13:42 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u13-20020a17090abb0db0290177e1d9b3f7so341784pjr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Sep 2021 13:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A76cooCpSZl8MrGzyyuDAXU2K6jHx/FCZWRJCRunqAM=;
        b=IUIawFj+uKB6vDDCaW1zKjPqQO7I2mIf/SLkiat/JEEf1hd6DBlz4iJ78QnmXHLL8G
         zKAFvjj+P8LEpysyF9J4I7f7ngXqF3gTSB60E6pWFaOOAoXcaKD7i9mcz1p/Ht/jugp6
         WuU1yULaIjDzLNtWDhSZccjVZeGDesYmC957VmG9W+aSp5zXY9YFbAspwmX7xQ2NqUHX
         dVWZeWyLNQfkYCje5gv+YEoB8JNKHktZf34mOTmobmFxafDm/6pnbuJRx6Je6kMCWvJT
         ALfRoaesP3wiZCmFcx7Tl1C45hZXt20r+KC8xOS0yM7ceRVBH+nnX3BX5e4WDvYSUr9S
         gELg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=A76cooCpSZl8MrGzyyuDAXU2K6jHx/FCZWRJCRunqAM=;
        b=RGyBUmqZ0BsWwS5ZJj4d71eo4uwd+5SQ/WL1X8J5Wqp6s+Qdcsz17MU/QkjiVuKLKt
         +VaopQTKn9Q0yYJfXvnaVRoIF/eDWC/wp/ZoQeVBMJ3FKYVJx0yJ/lITbGfhwdcnaaZ1
         DaEts+4XeZ7chafKVPYj/l/K9O9j4HDAF1xeL8K5UH+df3dOdMY40PAsFOOrjSMDBOl+
         D2pQd0XM/UabCtZCIAfGGCgVCaKWDmTXyn89UrKwkY8NAybQzlHpq5FfFcoKPBB8V4qn
         CPNUFgiQ9bamN1OOPYPteBteYeVivlTZ2vKt68RAsM6VwMmZ3vJaGIJ9VcpIskKcANWD
         iIaA==
X-Gm-Message-State: AOAM530E15h4uKiwB2VmnD2hb2SsT2vwAfwBifRmcgxCId/wTFd8p7Gm
        AZvoix7UIJtujIcTtP7UjhX+gBeniuk=
X-Google-Smtp-Source: ABdhPJxYojUOSgrkg7FURTf4BQlgCSytkKwrw1+6OCCsSNwpQjEbhsNDA0I2eIp+HZEMCpbDSoOdSw==
X-Received: by 2002:a17:90a:7185:: with SMTP id i5mr1346443pjk.236.1631564022158;
        Mon, 13 Sep 2021 13:13:42 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id u15sm8289651pfl.14.2021.09.13.13.13.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 13:13:41 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] shared/util: Add conversion function for 24 bits
Date:   Mon, 13 Sep 2021 13:13:40 -0700
Message-Id: <20210913201341.3515285-1-luiz.dentz@gmail.com>
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

