Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5B40C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A580020795
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 10:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S313972AbhAZW6t (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 26 Jan 2021 17:58:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395427AbhAZTWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 26 Jan 2021 14:22:07 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A165C061573
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 11:21:26 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id g15so12063606pgu.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Jan 2021 11:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qabp3A0QirU7NzIAUmwFIpMT0tm0NZJBJg7oc9BbaJY=;
        b=ORCasCQWky5uMIUikZzfdC9qSQJxnMy1OA6mtValHUIfpW04nGIUTRpDNEP0Q8gRue
         T41rPQiSxfkPlLPa8tmAYiaAk158gqQ9HXSjvgYe83kqZqSQgl8Hoz8xxwuUfcWJhtnc
         SeUzfBM0XcRCgVbNC8HP0Qeet6lLLL8J7/v3vkWWaQLVgLCYnkWf8I3z0PHaKISgmnyt
         g91PhJcsZr5zxp4U+z02W1hv8tdSftFWZX7xtmiXraiGPxXxL2tLFTHTdin1XKQ/c1Va
         /B3CRxW8eLnIH3grX4znZNdMURV7mGpXCuMuTaYgNX9111TT6U9ifHw/FXN+pT0Tr00k
         iPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Qabp3A0QirU7NzIAUmwFIpMT0tm0NZJBJg7oc9BbaJY=;
        b=iQe+K/mzgz0jSa7nyDSNd7b/9+YHv/i7t6VzfWbWwPmQ/ru4qPOde6sITYly28ULvR
         Nf6njhRtglf+taT6WE+QCVFYpdte3Np9IP9ZKTMFUIqhsfYpntX0VlaXudvz5fTDA/Wg
         5FpYqrJzcgBF3L0ZjlwXGhDHdvuCh+YuQIa+b99Rr5xGDvROsTRnbjc8EZy3Em/O4Ua1
         FN5AJns9tv972qn6mnUVbzdwtQ96cTyuhUT+a12cqyPqRsDg1Bn4TvB59bmHkyPVjiNy
         BhOKh7FHSzroAmyDP+8p4jzbuWeOnHDOWj+15g7RD4/hxnhvCs4Y8xTkYEup6PPs7DrB
         2KQQ==
X-Gm-Message-State: AOAM532ynwu9zC6dmT5fFhHwqrfd9vNArb/i93A+X9Bqv4K7e/IUsRQO
        pqw5/nvI2YBBdB9Q4MomXE3Ao7HCnzK/MQ==
X-Google-Smtp-Source: ABdhPJxAzjUj1rai7BHiG4LQW23aQ/PBhIpJNAmfym6+jtxfj9K/ddbrSUsWdLVu3WGXiuBRXWSLbg==
X-Received: by 2002:a63:1c09:: with SMTP id c9mr7016120pgc.185.1611688885838;
        Tue, 26 Jan 2021 11:21:25 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id j5sm2995963pjf.47.2021.01.26.11.21.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jan 2021 11:21:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix undefined references when using slibtool
Date:   Tue, 26 Jan 2021 11:21:23 -0800
Message-Id: <20210126192123.126297-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

gh issue: https://github.com/bluez/bluez/issues/86
---
 Makefile.plugins | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile.plugins b/Makefile.plugins
index 3b673bf85..4e6a72b0b 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -107,8 +107,7 @@ builtin_sources += profiles/battery/battery.c
 if SIXAXIS
 plugin_LTLIBRARIES += plugins/sixaxis.la
 plugins_sixaxis_la_SOURCES = plugins/sixaxis.c
-plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version \
-						-no-undefined
+plugins_sixaxis_la_LDFLAGS = $(AM_LDFLAGS) -module -avoid-version
 plugins_sixaxis_la_LIBADD = $(UDEV_LIBS)
 plugins_sixaxis_la_CFLAGS = $(AM_CFLAGS) -fvisibility=hidden
 endif
-- 
2.26.2

