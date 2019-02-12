Return-Path: <SRS0=8P1K=QT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98720C282C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0BD2075C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="Q028XBu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbfBLPPZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:15:25 -0500
Received: from mail-lj1-f180.google.com ([209.85.208.180]:35641 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730011AbfBLPPZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Feb 2019 10:15:25 -0500
Received: by mail-lj1-f180.google.com with SMTP id j13-v6so2549476ljc.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Feb 2019 07:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IISQ1QmfLnVqQk+Wx7vSmpJ+oYb0V/eKuCkAmrqO9TE=;
        b=Q028XBu4ULRxz1GGY9NVb/bbOrfjmw4Xy64BbGSVzz9zztD0I8LrliDkpz9qo6kc/f
         CwHP0OGl3H16uDSz35isw1rpVV6fvzZzIPlydz6D69B7Xunow7XA48kApRlpLqs2a3uq
         hI3qSBmPIPGVfFsspFs9RMt3dk8Wcstk98BPmwN986SJH9qTgBRIcWwGV44vYqEVsQw7
         HnnYa2Co7JbJQ6RSvvpvGrNyW62XazLrGtfJtWRKTGM+v8D841KQSMu/3FFuxUogyr5S
         KAtwM04XrxaD+/1exxbOHR00MLiJG8yDJRpaQaSILwFZCGclAKcq2X2E3q0ZrV8ui4LG
         af5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IISQ1QmfLnVqQk+Wx7vSmpJ+oYb0V/eKuCkAmrqO9TE=;
        b=sPG1/K8wi3j9pVAc1kVV9vlDHsRfdB/LlRyzCaOYXkt21cABQ2d72CrpzRmatuWOxX
         DbwViUVVun4CqNnMOW8R+HxtyTcnawdKvC1mf79UBC9T8fGqs15fRAYSZ28H5AdNh2G+
         Csl5mOQLTCkUGRyHY987W78zKYEVMZe6N9HCk9jUKPNFiWSEv/l8NJKyQ8sZZNgfG1/Q
         bMVAH4EuAQO/RN+Mky2BMHGs20t+BbLgHyzAIyLCsmkzlmrco7R/5ekTXaktEwRI2vk7
         ZSFDR5CepnmZ9vh3XjUeM1Xr+8PZTlAJ6oablqsJTjj0WwM6V2UzbfZdTUTitcsPy4Yh
         bnUg==
X-Gm-Message-State: AHQUAuZhrYr5sbvVO+yWOietUaxUoabHUsMcxezdgkXhlk7C0GaDezA7
        uWSeBlgUj0tNGKomwmZmvjV3XsaXXss=
X-Google-Smtp-Source: AHgI3IZvKSXlj4OoCPeFx9FF07e1euqT9Rwmxi7/aAARWNHeF7Y3q0tF0s6nzxIMj2UTuWhEqiIG5Q==
X-Received: by 2002:a2e:9ad1:: with SMTP id p17mr1028846ljj.30.1549984522967;
        Tue, 12 Feb 2019 07:15:22 -0800 (PST)
Received: from localhost.localdomain ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id u11sm2996636lfb.85.2019.02.12.07.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 07:15:22 -0800 (PST)
From:   Szymon Janc <szymon.janc@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] gitignore: Fix bluetooth-meshd name
Date:   Tue, 12 Feb 2019 16:15:15 +0100
Message-Id: <20190212151515.13436-2-szymon.janc@codecoup.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151515.13436-1-szymon.janc@codecoup.pl>
References: <20190212151515.13436-1-szymon.janc@codecoup.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

meshd was renamed to bluetooth-meshd
---
 .gitignore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitignore b/.gitignore
index d145ccdcd..68bbbf780 100644
--- a/.gitignore
+++ b/.gitignore
@@ -129,7 +129,7 @@ emulator/b1ee
 emulator/hfp
 client/bluetoothctl
 tools/meshctl
-mesh/meshd
+mesh/bluetooth-meshd
 
 src/bluetoothd.8
 src/bluetooth.service
-- 
2.20.1

