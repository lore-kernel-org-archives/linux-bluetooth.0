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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984D5C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5966D613AF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 20:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhEKUJx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 16:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhEKUJw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 16:09:52 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280DBC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:08:46 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gj14so12282969pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 13:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qZDwzy2nMHUs6TgK3apG4VfEIUTtWnOQyxOVKFgvAo=;
        b=Z1nWu/sw6Uu4OPDVvbMeRVRXSUsvyDhIx3Wu6qjgTB9rJxzYjG1fTnptUDHdN7ciF4
         3FJncFv7CKmUP8YICn50Jd0XG8mgislGTp7T1z5Mgf+0HrO0hbfPQ2kMS+8x/y1+0BEz
         LlK/suf94sRI1cJYNxfVfHEb8ZRxpGfcR0rs1taj13JW+3VuI3VIjwUkFFWBXu1nI6lY
         vBba79MuIAQslyNayKCsN2B3r4RheKTmD9/vYI/xaELGGDMc7wpRt8rXj+p5smCAwfsV
         UlN+6QJ6y06IHEsipRb6QY85C1ljlPfw4p0mmtRejX6jiRz/vrJDePflOKnr2iIi/ThH
         QycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qZDwzy2nMHUs6TgK3apG4VfEIUTtWnOQyxOVKFgvAo=;
        b=L7W0UVRDIpoip5HixMa4/8odU2MkG1P5E8jCQXUrRJNPP6eyDoEBjrXBPxtvPsnqc1
         o++Ge9o8RkCXkP0FgAS84A0oOD4y8zUlaOIBaGhsdr/xlcL1h+VvgavNPMz6N715hIRv
         F5luBHGlqipB2sb0VRNTYN0eUb5RZuK/8HRZ0cyOGxbJODoMl6FJYHkAQjn0YLFkQ02r
         wUTsPLhofDglwAxgKq4BBlkvsRFHtosRWb5h0tTIh8n3MYphScyQOIYgkgXkZPhmBXBq
         fyHreRQkpjdoWzFsXF5XOvkyfVqxzNvvMl5OJpHIol3XfWnHuRt1fHdU48aptLt+c3qA
         43sw==
X-Gm-Message-State: AOAM532e/2LXN36W8OysZxANEQBzVUAPNNSrUfaPRJWbuoQKckGnx0os
        WRNuscHLyOkVe6QlcNEurqoUdKYu0twAZQ==
X-Google-Smtp-Source: ABdhPJxgS4907vMnqBtlScEA4x0c8/GGQyjAV/kYmWn9Ns0a7dgznTXOGx2muPv1JgwZnzQtxXUc/A==
X-Received: by 2002:a17:90a:d493:: with SMTP id s19mr7050714pju.200.1620763725320;
        Tue, 11 May 2021 13:08:45 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u15sm2835224pju.44.2021.05.11.13.08.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 13:08:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/2] config: Show error if rst2man not found when manpages are enabled
Date:   Tue, 11 May 2021 13:08:42 -0700
Message-Id: <20210511200843.1741595-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a check if the conversion tool is installed when the
manpages is enabled, and show error if it is not installed.
---
 configure.ac | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure.ac b/configure.ac
index f445589b0..2b044f8e5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -328,6 +328,9 @@ AC_ARG_ENABLE(manpages, AC_HELP_STRING([--enable-manpages],
 					[enable_manpages=${enableval}])
 if (test "${enable_manpages}" != "no"); then
 	AC_CHECK_PROGS(RST2MAN, [rst2man rst2man.py], "no")
+	if (test "${RST2MAN}" = "no" ); then
+		AC_MSG_ERROR([rst2man is required])
+	fi
 fi
 AM_CONDITIONAL(MANPAGES, test "${enable_manpages}" = "yes")
 AM_CONDITIONAL(RUN_RST2MAN, test "${enable_manpages}" = "yes" && test "${RST2MAN}" != "no")
-- 
2.26.3

