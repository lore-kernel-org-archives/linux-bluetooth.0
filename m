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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A81C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 18:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E3926105A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 18:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbhEESpF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbhEESpE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 14:45:04 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC51C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 11:44:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id e15so2623585pfv.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 11:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CgBYmRk0gUh5MkdGk8tLwYIrT5PtzLUpvM3joEDIqLU=;
        b=pea9aJPPsC8dZXx1FOvmCVYzoqpEi7TcoUUQkcjEVFkIRsKwET7gthuhB4yuJpfn2G
         awMkZlHJFzqKqI5cbLUqTUAdOlAEobwKJZOcXgzNk27hHVhj6C7zQ+q9a/we2HF4+PEJ
         vxaAvKJXFDjmU/Ph3nHK47mQMGMwXcqBS1q9YNFJqNC5raiB4G5AHpzsAvZvikoYDBbJ
         00dOtUNMPahItiq7N7Todhj9TQKdPqbELjJLuL9Xtsq5/MrWNA5jNYFsVxuOw3jaPA/u
         6LQC+RhBSYDinpcy0xkXwULoehx80jGXH9LF5cgysiqxHjv52+klq1ejqAV8GAynDMX7
         edJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CgBYmRk0gUh5MkdGk8tLwYIrT5PtzLUpvM3joEDIqLU=;
        b=TAoMKhzuyqphCwkER1a2k6p/5QFqPEevMnuCtX/BhmEHvNtzhk2evH+vMBmjmUE0VZ
         pL657axuX8oIeQQmKqRL+bPrkh8mFbVLcix+Y01HB3J3Nrz1J6IAzHRyLPsWgH/tLjUw
         hHHS1ov6UR62UQj1CNNOGOzvv68x2y99SauHrWuhmq88QJzGztUl90wz3v/v9GYNzrhM
         IqbfQ/EPQVFuaM9o9cRuZ0fYnlxg3DPck2IW1eyEUcU+s9jmr11hxWUyDMtI/ei2ZVzL
         Gm1ftIs7Np9p4qM186GEQQGx/gKMrGY+2PRh2OKap5AMkvz27Rvs8CY8E7VzqosZGCsI
         m9zw==
X-Gm-Message-State: AOAM533EajrWvQXb9VwqHd3xYtsocRILyiuqTYWO8HPu+4USUxDtEgDi
        48cwBgd/1d9+RI85yegp7JdPU+NzzdKiyw==
X-Google-Smtp-Source: ABdhPJxtIpfVALzuIpAiNqiDUHptF6CfIAjiU6D6bxqMe6iG6dAoeB5kDkDjH4IjtWvcCrcHjZzPxw==
X-Received: by 2002:a62:8c09:0:b029:28e:bca9:5985 with SMTP id m9-20020a628c090000b029028ebca95985mr246447pfd.10.1620240247247;
        Wed, 05 May 2021 11:44:07 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::f7ee])
        by smtp.gmail.com with ESMTPSA id z16sm7855584pjq.42.2021.05.05.11.44.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 11:44:06 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/2] build: Add generated manpages to distribute list
Date:   Wed,  5 May 2021 11:44:05 -0700
Message-Id: <20210505184405.1077111-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210505184405.1077111-1-hj.tedd.an@gmail.com>
References: <20210505184405.1077111-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds generated manpages to the distribution list.
---
 Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index 52e0e9ed8..42c1d0d9a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -594,7 +594,8 @@ if LIBRARY
 pkgconfig_DATA = lib/bluez.pc
 endif
 
-EXTRA_DIST += $(manual_pages:.1=.rst)
+EXTRA_DIST += $(manual_pages) $(patsubst %.1,%.rst, \
+				$(patsubst %.8,%.rst,$(manual_pages)))
 
 DISTCHECK_CONFIGURE_FLAGS = --disable-datafiles --enable-library \
 						--enable-health \
-- 
2.26.3

