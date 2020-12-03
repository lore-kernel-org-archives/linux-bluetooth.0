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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE85CC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CD3C22225
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Dec 2020 21:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgLCVag (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Dec 2020 16:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLCVaf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Dec 2020 16:30:35 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAA2C061A4F
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Dec 2020 13:29:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 4so1894033plk.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Dec 2020 13:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ornTYnJRHNQpOn/YJOva2HYFpKIE2lfXTqxXBfI0mk=;
        b=Dab+gL4jHckqVkC4fQ3GrWYKr5Id6HvS7Rn3FdT9+qRkb8Etj9BFwl6zTlg2wjh7ge
         /ri2wI8PF4ollqJJ4zNbt957X2fLrzdDiDrcluEVrNKj2+brXtToZPvV9nzfI9g87pCl
         pu23HUx1PT3HwD8lGuMSElYbBMcnS1xqdXG035XZdwJWNU0oTuKrB1sKG703NQbn1q/0
         E3bSMalVJn7vlPoKrQ+zJd7C8RR7TbzoCMZysWulUnJvG4gE9sturpED9zkRB6ZXspoU
         90yF2XTGwu5PsRxAu9KX6LTxPIe+eGN3dgyUjyo8HER7YeEY0FCfn3b8aPJ7RYJcJOxE
         QJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3ornTYnJRHNQpOn/YJOva2HYFpKIE2lfXTqxXBfI0mk=;
        b=ZGhgo6FwqH5fCCJAAWqmlLjYAeWCeNwBbrlVunFeVExvfQ3HKfB2H1WAOy5lqyEq78
         w8U8HCep3i1gvX6eRjDSDTIgrZS6HoJhxdsEp+K1B8X8D0cB1iEB3BchILYa6phV2BWM
         OJFYvH7TEcAJyyF6VFd5VM8N974clIqdmOtWoZukfY8BK5oET05pK1I1y1o+/c9clcLX
         xN6/GAe0FV9qup9C8BYv337bbAPXodmH+6odPYlsEOJethxCjjyka+A3ze4GBA/iTrGh
         z55oVd42yPyx5aJ4+oEqb14QeTaRV+N+zveta8Jor4Yn9LDq8kSiYEQaU9brHOPYAxuW
         5ZYw==
X-Gm-Message-State: AOAM530bFh5CNFFbmtD5i80xIjJW0dKNdTokJVJ8syTPgTUMz5G91NAI
        pdAcjezi2w38lup7v7gtE4HSGvha6Vg=
X-Google-Smtp-Source: ABdhPJz96SMaFjC2rd8wnXYdNT0QCD9jKcpGAULPHnZy3ZuUSiSW8jAk7vbwPHzy6KzDO8dELXq5rw==
X-Received: by 2002:a17:902:8ec8:b029:d9:d4a5:dc40 with SMTP id x8-20020a1709028ec8b02900d9d4a5dc40mr1106154plo.4.1607030989080;
        Thu, 03 Dec 2020 13:29:49 -0800 (PST)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y19sm2777407pfp.211.2020.12.03.13.29.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:29:48 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC] sbc_primitives: Fix build on non-x86 arch
Date:   Thu,  3 Dec 2020 13:29:47 -0800
Message-Id: <20201203212947.2680393-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Check if SBC_BUILD_WITH_MMX_SUPPORT is defined otherwise
sbc_init_primitives_mmx will not be declared and
_builtin_cpu_supports(“mmx”)) likely fail:

CC    sbc/sbc_primitives.lo
sbc/sbc_primitives.c: In function ‘sbc_init_primitives_x86’:
sbc/sbc_primitives.c:599:3: warning: implicit declaration of function
‘sbc_init_primitives_mmx’; did you mean ‘sbc_init_primitives_x86’?
[-Wimplicit-function-declaration]
 599 |  sbc_init_primitives_mmx(state);
   |  ^~~~~~~~~~~~~~~~~~~~~~~
   |  sbc_init_primitives_x86
sbc/sbc_primitives.c: In function ‘sbc_init_primitives’:
sbc/sbc_primitives.c:598:6: error: hwcap ‘mmx’ is an invalid argument to
builtin ‘__builtin_cpu_supports’
 598 | if (__builtin_cpu_supports(“mmx”))
   |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
make[1]: *** [Makefile:711: sbc/sbc_primitives.lo] Error 1
make: *** [Makefile:453: all] Error 2
---
 sbc/sbc_primitives.c     | 2 ++
 sbc/sbc_primitives_mmx.c | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sbc/sbc_primitives.c b/sbc/sbc_primitives.c
index c9d1045..97a75be 100644
--- a/sbc/sbc_primitives.c
+++ b/sbc/sbc_primitives.c
@@ -595,8 +595,10 @@ static void sbc_init_primitives_x86(struct sbc_encoder_state *state)
 {
 	__builtin_cpu_init();
 
+#ifdef SBC_BUILD_WITH_MMX_SUPPORT
 	if (__builtin_cpu_supports("mmx"))
 		sbc_init_primitives_mmx(state);
+#endif
 
 #ifdef SBC_BUILD_WITH_SSE_SUPPORT
 	if (__builtin_cpu_supports("sse4.2"))
diff --git a/sbc/sbc_primitives_mmx.c b/sbc/sbc_primitives_mmx.c
index 6984ce5..c7655ac 100644
--- a/sbc/sbc_primitives_mmx.c
+++ b/sbc/sbc_primitives_mmx.c
@@ -360,9 +360,4 @@ void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
 	state->sbc_calc_scalefactors = sbc_calc_scalefactors_mmx;
 	state->implementation_info = "MMX";
 }
-
-#else
-void sbc_init_primitives_mmx(struct sbc_encoder_state *state)
-{
-}
 #endif
-- 
2.26.2

