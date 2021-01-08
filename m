Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19619C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D110423A80
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Jan 2021 21:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbhAHVP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Jan 2021 16:15:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbhAHVPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Jan 2021 16:15:55 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65876C061757
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Jan 2021 13:15:15 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v1so4332259pjr.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 08 Jan 2021 13:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ylsb5NyQ3oFVpAQCIHeIiDlXNUKeqObj9MTroL10KcE=;
        b=WiQa6uLaEAImOKmyuyDkdvQ877KCudHQbVvHf1T2Zca+yH1uQmCceYKH2ba9F3N11G
         CX8EOw2ZK6BU0Gz0lgwkgT1jw9Us5yHg+w41SwS2sRs3e53T1nAW/JfxVQqgKiLujb18
         sM2AxQOWdIycL5Lz1dIE4BoRSruZ5mecFfg/U5ee5bEDhvJmF/8lM5Txa4kj/6sxd57y
         uX3Evd+GSWE9NiXXkz+aEvSahZZM7sKNeO+GbKMTLk0ZegI05t+f5k3eprCDymI+aPQi
         saIJ3O90NQf8wnsVHTR5I3DF/g/c3Z0882q0QnLPC5dCNTb+PlmfPegWZWydyamn66uv
         ybCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ylsb5NyQ3oFVpAQCIHeIiDlXNUKeqObj9MTroL10KcE=;
        b=d8K74mRiisZnr+fpP0/Jogh0UucESoD2E+SxHQackjSNGeyRVDGJXhSwO3uhC0O1Ts
         x4GtkOJFaXeTmhzFEfzqf8IU1kDspnmyEn0kXLw1srxknwnBbVR6doogjyFVbibyBSJI
         3PpjwMbohw8JdBse73428oRO0wN0974p0LxPhRb3XzDSZjTl/ajTTYmIs/ZtKlDy6xnW
         s/Q2rp4lkeSJJKDNatxeHx4YlO+86gl+C9BbRWAnPC6c4AKdHEtk6v8ZZMXxQAOgdZVS
         IVk7W6zuLHkllHUdSw1r7k2/G4yoJw0qHGcv9BFwN3bnpanTFCpASDgmDmkDm8KazpT3
         zM0g==
X-Gm-Message-State: AOAM5308/hzBpJ3dN3JmdlKDdh4FUKZSjBdiuuJAN4AUoLr/6/e8/6si
        ZwWoXIifGHGe5Wu6T3zEAnDsXzTfK5U=
X-Google-Smtp-Source: ABdhPJwOsM4zWjcQej4XxaOUdbDnNZeZGHN1qm2MIoTWahGyUfo8cKZDKmr4m5NGcTisl1kfZtJ3mw==
X-Received: by 2002:a17:902:ea94:b029:da:a547:b6a6 with SMTP id x20-20020a170902ea94b02900daa547b6a6mr5703029plb.78.1610140514709;
        Fri, 08 Jan 2021 13:15:14 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 21sm9721699pfx.84.2021.01.08.13.15.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 13:15:14 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] util: Introduce util_debug_va
Date:   Fri,  8 Jan 2021 13:15:10 -0800
Message-Id: <20210108211513.5180-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This introduces util_debug_va which can take a va_list that enables
callers to create wrapper functions if they need to.
---
 src/shared/util.c | 19 ++++++++++++++-----
 src/shared/util.h |  4 ++++
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 525302164..9c2054211 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -15,7 +15,6 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <ctype.h>
-#include <stdarg.h>
 #include <stdbool.h>
 #include <sys/types.h>
 #include <sys/stat.h>
@@ -42,20 +41,30 @@ void *btd_malloc(size_t size)
 	return NULL;
 }
 
+void util_debug_va(util_debug_func_t function, void *user_data,
+				const char *format, va_list va)
+{
+	char str[78];
+
+	if (!function || !format)
+		return;
+
+	vsnprintf(str, sizeof(str), format, va);
+
+	function(str, user_data);
+}
+
 void util_debug(util_debug_func_t function, void *user_data,
 						const char *format, ...)
 {
-	char str[78];
 	va_list ap;
 
 	if (!function || !format)
 		return;
 
 	va_start(ap, format);
-	vsnprintf(str, sizeof(str), format, ap);
+	util_debug_va(function, user_data, format, ap);
 	va_end(ap);
-
-	function(str, user_data);
 }
 
 void util_hexdump(const char dir, const unsigned char *buf, size_t len,
diff --git a/src/shared/util.h b/src/shared/util.h
index 6fb702797..d6de55885 100644
--- a/src/shared/util.h
+++ b/src/shared/util.h
@@ -10,6 +10,7 @@
 
 #include <stdint.h>
 #include <stdlib.h>
+#include <stdarg.h>
 #include <alloca.h>
 #include <byteswap.h>
 #include <string.h>
@@ -89,6 +90,9 @@ void *btd_malloc(size_t size);
 
 typedef void (*util_debug_func_t)(const char *str, void *user_data);
 
+void util_debug_va(util_debug_func_t function, void *user_data,
+				const char *format, va_list va);
+
 void util_debug(util_debug_func_t function, void *user_data,
 						const char *format, ...)
 					__attribute__((format(printf, 3, 4)));
-- 
2.26.2

