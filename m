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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384EC433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 20:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C2B464F8C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 20:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCPU7J (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 16:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhCPU6q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 16:58:46 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 612B0C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 13:58:42 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id n9so22478641pgi.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 13:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvzI20I3mgu4HbInl4dmoTga5b4o+6oBfDUwhvS/QFU=;
        b=bsCPxwaKVrGNOn2UBPgrJXnyqGw5UQBEvsVOTm9k4s9XKRBiGOae0CGlybdaDqFI4S
         7seJqE8RSS6NRSFgexvcZ18clM8w2ElUKEKldHyecPf5rxaD0BMINm77sBT+NWxBqJel
         qMzDiVFl5wf16YRAfZzN++aWe/PIGvPQJ34OSqu5y0k0EWYVsY5LZmga24c8iNyL7s+R
         Z+UZCqNQIR37/wIlgG6yMdqM4LIHABVUCYfwYIDv56W8YVkjl1YDTEdR4KuvwIk0wxh2
         DbF/TDteA7nuOqc1yM0FXO9q64c50D0qPJ3lfLUGA4XWHrisizKANBvEkByC6QiWWXnC
         R3FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OvzI20I3mgu4HbInl4dmoTga5b4o+6oBfDUwhvS/QFU=;
        b=AdgCZfDVuD99VcK7U5WxLrfjflwKDSRo0JQN2pdR4PYcXtcan87baC4IJMnCZZd5W/
         +YebI/RlpTON3cyfcE8VDqFNsmtC/5c3FhI1Z8IP0g//v6m8SmkGyL7QQq3xUVbxFQW9
         EPfk9mYNTCxnVxqOxRacOElSIIOvaz0FVUWHZIyBd0mEulxCR40IWCXhcAtdS10aUa++
         8J+dIQjWrWCyxzIdkj/FdZTJqVhVXmJ7fvDd/5j8OT9wLVD1lu0xMjFNdjzT9CJxSOmt
         rnlFpRkF9HaONpkLFpLTTjPpGG0UjUz3yZbPmRe4dV6u/c5BCO1DZ2Y/W2Y3PL7FTqKc
         3lcw==
X-Gm-Message-State: AOAM5321puzjcP3gKPd5oVo5sKShilet2rJEq214fIX0g6UNm4ruHYnv
        sxjaw9qNWzFkdRL/wjDb5s6wfuo5vB83EQ==
X-Google-Smtp-Source: ABdhPJyl9omO7uXkSU6n3ifxJm4sg9lUrknBlfEIhRnvph4lu5cKv6kwFim7+kCc4Dbf00RGY4yGtQ==
X-Received: by 2002:a62:7f45:0:b029:205:9617:a819 with SMTP id a66-20020a627f450000b02902059617a819mr1114481pfd.17.1615928321480;
        Tue, 16 Mar 2021 13:58:41 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t12sm17340812pga.85.2021.03.16.13.58.40
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 13:58:40 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix build with latest tree
Date:   Tue, 16 Mar 2021 13:58:38 -0700
Message-Id: <20210316205838.2164464-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Latest ell tree has introduced useful.h and main-private.h which are
required to build:

ell/cert-crypto.c:35:10: fatal error: useful.h: No such file or
directory
   35 | #include "useful.h"
         |          ^~~~~~~~~~
...
---
 Makefile.am | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index ff0df2196..7fce2e7c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -135,7 +135,9 @@ ell_headers = ell/util.h \
 			ell/asn1-private.h \
 			ell/cert-private.h \
 			ell/pem-private.h \
-			ell/uuid.h
+			ell/uuid.h \
+			ell/useful.h \
+			ell/main-private.h
 
 ell_sources = ell/private.h ell/missing.h \
 			ell/util.c \
-- 
2.30.2

