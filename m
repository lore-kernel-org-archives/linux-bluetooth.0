Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E845C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Jan 2022 21:03:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244081AbiAFVDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Jan 2022 16:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244010AbiAFVDW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Jan 2022 16:03:22 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C320C061245
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Jan 2022 13:03:22 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id h1so3324134pls.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 06 Jan 2022 13:03:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=GW0vDdGoAIj3Ni1gvZpjwO6DtFPUpzoP2usvIYep4wc=;
        b=CsmfHee7pIwNwEOCH0ihYK4tMEJQqdsboARgsi7vE9KueBYUkzU4tjk+hKXoNZUfYF
         jHzzmmubgLpF5CN2NqYfV7eH5m4cU++D4XyNej/BlwmO9Rvmjqpm1qSu0Pv6jYqU1Tpc
         TdRP20DZ4MiyQUkU4W04MuKzHj+a8R8J9AcFicrhVib1gCgpSi9Lhhtx2gKQXbBnsf63
         IY6WiFJ5+RA6uKzrzwHxoBv8nmhvPtN1+0sucB1m10csNfCy2lferB2MMHeMISROz06V
         J6rwi4QG4aF4wsgXom0i9XwkKx1FpD6M+PE8VOLQy+07bTv2MmA2ZIhOoOKtUp4aiGFh
         ibtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GW0vDdGoAIj3Ni1gvZpjwO6DtFPUpzoP2usvIYep4wc=;
        b=gPsvzbOSwSVfEBD+yazP7RjSfFvBFGD0y2VRr3k+NQ+i/IWjEFW4znsv3Bn2RUpIxa
         M8SFnqRXHseLQP+Um4MewmHQ8WByKutyxB0OIGX7g6j9Uvjmzwy/0v2MbGgOFszs1UAR
         e9s5Wp9Y/cSFnB/mOF1PsDmczx+KTTouMkRPzFYm/nVasP0eUC5oJNR0GPX66MF9y5IX
         w8hFa5WikuZiya0n/+oVMosgXDrKqH5uGrEhsvlVqZNqtwR9nSfxERDtALFujEj5SnAL
         AoHvUHsl0VWbI9F1aL+q3Je/5IC3iNfql9lSPL5nSQdi0Tnya0vM6UsJN/JkKhgaF8sl
         DzYQ==
X-Gm-Message-State: AOAM532Gs8pUxHw2lx31H+Y20tam6R1LlA2HmfJSZ+3xs8SkJYlySd96
        mDbGNFseRrqQhCAeh18uf7AkQPkYAzE=
X-Google-Smtp-Source: ABdhPJxh8ZgfyYtIyr8o/gH41nJuL+Qd1aXG4Snpz9De3JvuAchgQgvyi89QcoSxhTbQTcO+15VwXw==
X-Received: by 2002:a17:902:e54c:b0:149:a59c:145b with SMTP id n12-20020a170902e54c00b00149a59c145bmr31863364plf.138.1641503001913;
        Thu, 06 Jan 2022 13:03:21 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s25sm3091853pfg.208.2022.01.06.13.03.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 13:03:21 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/util: Add util_memdup
Date:   Thu,  6 Jan 2022 13:03:18 -0800
Message-Id: <20220106210319.3620823-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220106210319.3620823-1-luiz.dentz@gmail.com>
References: <20220106210319.3620823-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds util_memdup which is intended to replace g_memdup since
replacing that with g_memdup2 requires bumping the glib version.
---
 src/shared/util.c | 16 ++++++++++++++++
 src/shared/util.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 93110047b..6e1c83057 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -41,6 +41,22 @@ void *util_malloc(size_t size)
 	return NULL;
 }
 
+void *util_memdup(const void *src, size_t size)
+{
+	void *cpy;
+
+	if (!src || !size)
+		return NULL;
+
+	cpy = util_malloc(size);
+	if (!cpy)
+		return NULL;
+
+	memcpy(cpy, src, size);
+
+	return cpy;
+}
+
 void util_debug_va(util_debug_func_t function, void *user_data,
 				const char *format, va_list va)
 {
diff --git a/src/shared/util.h b/src/shared/util.h
index 11d09979d..8ef6132c4 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -87,6 +87,7 @@ char *strdelimit(char *str, char *del, char c);
 int strsuffix(const char *str, const char *suffix);
 
 void *util_malloc(size_t size);
+void *util_memdup(const void *src, size_t size);
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
-- 
2.33.1

