Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF28C63798
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14DF2240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 20:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4vEMPXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgKTUHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 15:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730347AbgKTUHd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 15:07:33 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D562C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:33 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id v21so8249759pgi.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 12:07:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=Aka74bqXFA68BXE1RxfdOvwFymuRf+8vsT8BRQTSE04=;
        b=c4vEMPXruEODb/uG1I85f36UsCyaJjm8Udins9Kyqus1saGrOOTfPeTmHDhAv39ptN
         U9Sn/56c9qn9c8es5YyipGB2v6yiGOGzVMG4gJVbzt3Maig9631h9wTNngGWgMxdFcYN
         4mmkylVgu1RQuttXTeE2tBhltL9D9U1ubB7fEoiIwa2lXX/qA4UrFZiFDHmEcgWq1KzX
         vsOCNnCpT5S9g/J6xK+Jh0h8OEZ4IF8iSjRPDNGVABzlcwI/X9dEDr6j2wLOAg2xlzDe
         JnmyHTZke/qM+e6y77BAcV8svCTHT/1OJ1hxR41ZD1XzhMVUpoJFGeyvJUptk/UkwrL1
         D5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=Aka74bqXFA68BXE1RxfdOvwFymuRf+8vsT8BRQTSE04=;
        b=S3z1yNQYqPr0HwRgxDDE4Li/dYFF+dc598/7nQQEzYgzy5U0HhUdCyqNgtNgX+9LYA
         j2gLF00pNu6AyOfHSiZDSxYKbx4SzVwNEvDCAdkIr4adp32gzFHXHzHYL5QqLpo2rpMu
         2d3I8EaAMDqBX05hV4YRva1IQIZKrnLD9VmyhaL4SeAp4jZzvb5OTGi7e/WouratWhfj
         CL0lFmFu6fO7wvqVxKJZ4y8S3NIbQ38W9Xw+kbbRhSFbTmxxOineVODpI7nocOMNQ7qI
         GnJl/DuQr1BwjU0GiEygGTEuO1snOmnV/5NAxF1jsgsuPuNHi0YrB93KE715eXw1q9eP
         BV+A==
X-Gm-Message-State: AOAM530rkugv1YFa9ssPl49RuHkF5i/EVVzuA7/DdBCsszvQQE/TZce3
        98LK2krLXvNBJ2kqBzlYiCY/zvgKMrw8eQ==
X-Google-Smtp-Source: ABdhPJwT4GfoDlEAmZ/QJo7kxN6TT5e4LMCK2u+e1vsmCKU5psQrYvYfWoAOtPRzdeHaDOZBwpIT3g==
X-Received: by 2002:a05:6a00:4d:b029:197:7198:fc37 with SMTP id i13-20020a056a00004db02901977198fc37mr14623894pfk.7.1605902852564;
        Fri, 20 Nov 2020 12:07:32 -0800 (PST)
Received: from han1-mobl3.jf.net (c-73-164-224-32.hsd1.or.comcast.net. [73.164.224.32])
        by smtp.gmail.com with ESMTPSA id t5sm3979267pgt.15.2020.11.20.12.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 12:07:32 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Google-Original-From: Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     tedd.an@intel.com
Subject: [PATCH 5/6] profile/bnep: Fix the unchecked return value
Date:   Fri, 20 Nov 2020 12:07:11 -0800
Message-Id: <20201120200712.491219-5-tedd.an@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201120200712.491219-1-tedd.an@intel.com>
References: <20201120200712.491219-1-tedd.an@intel.com>
Reply-To: tedd.an@intel.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the unchecked return value.
---
 profiles/network/bnep.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/profiles/network/bnep.c b/profiles/network/bnep.c
index 4dde55786..7e777e29c 100644
--- a/profiles/network/bnep.c
+++ b/profiles/network/bnep.c
@@ -255,7 +255,11 @@ static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
 
 	memset(&timeo, 0, sizeof(timeo));
 	timeo.tv_sec = 0;
-	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+	if (setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo,
+							sizeof(timeo)) < 0) {
+		error("bnep: Set setsockopt failed: %s", strerror(errno));
+		goto failed;
+	};
 
 	sk = g_io_channel_unix_get_fd(session->io);
 	if (bnep_connadd(sk, session->src, session->iface) < 0)
-- 
2.25.4

