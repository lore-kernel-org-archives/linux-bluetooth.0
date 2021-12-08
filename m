Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2462EC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Dec 2021 00:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhLHA61 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Dec 2021 19:58:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238835AbhLHA60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Dec 2021 19:58:26 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C4AC061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Dec 2021 16:54:55 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id z6so436998plk.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Dec 2021 16:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ced3sO1DZKwcuGIFJwU6z7OT390K7VCxMmJJd5tHGXY=;
        b=DS0lbyYUHICCeG2kDqAzY6UWSwu+OY2d+afCS07ewj2E1Ud49uMTLi7jJ8ui1aOuq3
         DRY/6IYbRAbSL8+YdeAsx5JWYe+XhM2BODgfWBjjMYmoXi5XSmkTROfQZ9lLMakQkhxs
         lVCqHWUExvrG2vC9D8gq1qP6xih7UJveJx4MAKQ3luLVZ6SHNKOOk7WpK0NjfbU81fpa
         n2wj4KLk+V0MTL3bcfKUOECjD3PmtzfgIVs+b2LdsGuVMPHJ4bI0JKCbpIvt3r1TzBlX
         5e/VSXXBNoT3926dnUqoT26xpYo2EG0vMW594otRmIeXGaPHHG0qY6fSMCaUXBT0MC1U
         14cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ced3sO1DZKwcuGIFJwU6z7OT390K7VCxMmJJd5tHGXY=;
        b=IA+dYRNRGpowQXdYyz2qq9k1a5PHtvNrQexXd8LuFRbRju4NbUiXh2gcxSQdP6nnYh
         iVp83LiwUiSgmqP/UVc0XcmdPruZqQ51GGA06rlPFPwosdMrjEIZlGaFS19XYA63lkrK
         CJgdhxWUHuNIFT7OJYckMbuDCJHC+xaIhHL8ld/sIA76i3QNNEkA8MXj/JDIGiyn82UL
         PKocIr6GADQHfnD+neE7sUAyJ/7sQGPV6buPLgJWLIsA9kKrayLNOVO2g3PVtVtjKrzd
         raGPGBBJeEgsc+Yo9XqlzuGkCgIG6MV39dbgpT1tGtoSa1P4mOzQh+RCagFZJvD0GcQh
         eneg==
X-Gm-Message-State: AOAM533Rl8IgI78RCmyyfiptF6CbJbKH7MFWDJrk94YKxFzHpedE9v8u
        374w7FXh7mNfGQroiyKFJTHa1WpP1D4=
X-Google-Smtp-Source: ABdhPJzJpDtvJH+WdR+jvukPS9C87qIZXB9DQGUA0J0mxE5nUWeo2IoQ2B5mG6o8IF5KRqi8HcuJCg==
X-Received: by 2002:a17:902:aa43:b0:142:6919:73da with SMTP id c3-20020a170902aa4300b00142691973damr55197717plr.39.1638924895056;
        Tue, 07 Dec 2021 16:54:55 -0800 (PST)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:52cb:f76a:51b5:e541])
        by smtp.gmail.com with ESMTPSA id d195sm604191pga.41.2021.12.07.16.54.54
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 16:54:54 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 4/5] plugins: Replace random number generation function
Date:   Tue,  7 Dec 2021 16:54:45 -0800
Message-Id: <20211208005446.196637-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208005446.196637-1-hj.tedd.an@gmail.com>
References: <20211208005446.196637-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch replaces the rand() function to the l_getrandom() from ELL,
which uses the getrandom() system call.

It was reported by the Coverity scan
  rand() should not be used for security-related applications, because
  linear congruential algorithms are too easy to break
---
 Makefile.plugins   | 1 +
 plugins/autopair.c | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 7693c767f..c771b2dfb 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -7,6 +7,7 @@ builtin_sources += plugins/wiimote.c
 
 builtin_modules += autopair
 builtin_sources += plugins/autopair.c
+builtin_ldadd += src/libshared-ell.la $(ell_ldadd)
 
 builtin_modules += policy
 builtin_sources += plugins/policy.c
diff --git a/plugins/autopair.c b/plugins/autopair.c
index 665a4f4a6..474209fd2 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -17,6 +17,7 @@
 #include <fcntl.h>
 #include <unistd.h>
 #include <errno.h>
+#include <ell/ell.h>
 
 #include <glib.h>
 
@@ -130,7 +131,7 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 				return 0;
 
 			snprintf(pinstr, sizeof(pinstr), "%06u",
-						rand() % 1000000);
+						l_getrandom_uint32() % 1000000);
 			*display = true;
 			memcpy(pinbuf, pinstr, 6);
 			return 6;
-- 
2.25.1

