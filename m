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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F82C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 17:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46DFC61625
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 17:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231904AbhEKR7R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 13:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbhEKR7N (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 13:59:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6F0C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 10:58:06 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id i13so16768290pfu.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 10:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qZDwzy2nMHUs6TgK3apG4VfEIUTtWnOQyxOVKFgvAo=;
        b=OuuUJVimYP2FR8NLVWI5/h0Z/yqKk394+fLs1rUCSREUqmD9rVGlCMVzRlExdIyc6k
         3FgCNDMYkyIh8rwFwMUu+UWfirrNErXUYpAuZvHofElNDW6Zj/KwH2K0+E7z4Kh+9VvI
         9E2/y4YY2J256n3AD6QI9wCfBWS0AxZWv6XAPTj+TxjkWq80SynU806ELY3PValttUI6
         zMsGixiV0apobOL49ksuz0hJ2WnGXmohAIPn6RsJkqUrZuWU0xV7g3gyuehXAun33af1
         2bzz//4YmW7AWjszH/ToU+wxnw3LXajD/LWsFhV5Hhdry+Mt+5cHwN4fg1RROoMup7Q2
         /nKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3qZDwzy2nMHUs6TgK3apG4VfEIUTtWnOQyxOVKFgvAo=;
        b=Y9Y43AS5Mx7lIFO9arWe5vvNcf4dkLN9wuitrlhs1/A+2NCxUxs5kdr/tZVl/CTOVZ
         a9MbHuhqq9lmxubNWadHvxQnKr72oiWeWSW8uPy79KIH8pADkhgpa4vc+s5zIO+Tj9jt
         wZg7o8AGOtyKaRTCGRIJb6Iyy4I2mMu9Y6HTfyRDGMaeI9taRi/wA4ni4U37Ked4QgX/
         Biy0YfQtVIO2FWBFlZXP5dgHnucxsjjmfgf1SVv6AgvgkLDSnZvqm2LvlDSuPmCnLjfH
         oJ01S+niifS2odNX7GgbXYKKtXTka4/Tv0GK9v0M2K0Jtx7JtOZ8oQ8MJiNIWjrziYi3
         MJzA==
X-Gm-Message-State: AOAM531Yy2Qg8ivqk+8OCF+VW1HWXTqdAMpp7DVSEGWjY1x/XNNUtMgC
        SElp936TyafRBMfnTsiz93zHBJG644ThCA==
X-Google-Smtp-Source: ABdhPJwma/7sG8ncKbmIDuvnGLdyi8iHUYEgpv9kXneTZeccdcUNVSqraJ7oHK/xoGiJ/WhSnogbsA==
X-Received: by 2002:a63:982:: with SMTP id 124mr32075648pgj.37.1620755885100;
        Tue, 11 May 2021 10:58:05 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id p36sm14093788pgm.74.2021.05.11.10.58.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 10:58:04 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] config: Show error if rst2man not found when manpages are enabled
Date:   Tue, 11 May 2021 10:58:03 -0700
Message-Id: <20210511175803.1609438-1-hj.tedd.an@gmail.com>
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

