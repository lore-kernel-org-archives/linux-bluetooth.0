Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CB2C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 03:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087A42312F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 03:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbhAMD45 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Jan 2021 22:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbhAMD44 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Jan 2021 22:56:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6997C061575
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 19:56:16 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id y187so373928qke.20
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Jan 2021 19:56:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=l0hCJRtVZm5fGBZ6qy6cOSoEq1HcYT8wahklNYf/koo=;
        b=Z+4HZ/DLiuTLFCmsO9l/JakJb9pm3jjW98LrvoumPPXvIyFiywEepQDeJk7GEXAvpF
         gSCzEILIYNcHzH1tG4Ys3WuK6ysoDIU4lzEvF0FVxLNZVhE06lWIiX0OKy52Ovi3bLRg
         hsy1OVAoZ1pXiVHIMCaHtGKFezpR/DyfnJjnzeISXvpI9LOhsGukfbRXnGdZ5GYvR+la
         ZN3I6TDSAVHv//IuiXhAXZqS1V2C1q8lHf3aN9ioIopSfZEQICqQQ5JMzkBSgvvtakH5
         ObngX3ul135v/pQ+nEVFqndbEO3TSvNnOVFAnSqjaqFw+FYIbNLt/Yfg87u8XuLSJKCo
         h4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=l0hCJRtVZm5fGBZ6qy6cOSoEq1HcYT8wahklNYf/koo=;
        b=iymYp7dwYtS08+TSJeDPn1VeL+kCBLS/5y1ZxT78LHxAYpRl0VwvqCm10gMdDqsWtj
         Dv3ZkXjNKiFX4PKFPrAMGY/FdZA8faIN1ljhGFT9PjXm58WT4XXPV6zyQ4TFym8NaQZo
         ZT8B4QDHRbB+3AHzOxvIzhf8OBqUk6gh42eAmuZIWsYl3CNWemXjawFh2xKfHBBsI0I9
         Imdw8FZIVld78fscs8lpFQvJsKM1lWtz3z+tCr2SWBQLZc05PeAktAzirf6ypa4k2AwB
         KaIenLzPOgiDXqG5qOXGaD1H17zJ9z6WQUYEYZCU1xFTH5zdo7XwGXo6zgsPHesPAwnH
         ilTg==
X-Gm-Message-State: AOAM5310ujpLVNT/cresKy2Q2B+z7JvGSrHZ8/URoyEunsMT9P9zzEXH
        7SxvLO01NeOvHQdCLTyxWeGR6+5wx5vuksma7QccFsEwpoMNywfGcj/dXt2PL/deb5ccepbgDLP
        KcHycO6/slLrDKyqhG/ejfeswRiaDqfeGarq8H915vL07cGpUIiGO1yzt9jGlRJNO7yJ6bmFPFD
        jw1hj9MA9gE68=
X-Google-Smtp-Source: ABdhPJzQQFU1znCpWWhVJYCeJOag9MaAYtFHvoQ0eMmyfgF6k1BzHkoYwBT3UbjGVsuJnXxdIuslYrrxbV3+yN3qOg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1754:: with SMTP id
 dc20mr129368qvb.7.1610510175746; Tue, 12 Jan 2021 19:56:15 -0800 (PST)
Date:   Wed, 13 Jan 2021 11:56:01 +0800
Message-Id: <20210113115556.Bluez.1.Ib657f37256b0e7adf3915ac5341c9d20db2fd2ef@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [Bluez PATCH] core: Align parameters name of ScanAdvMonitoring
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Miao-chen Chou <mcchou@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ScanAdvMonitor parameters are defined as '-AdvMonitoring' in main.c
le_options, while they are referred to '-AdvMonitor' in other places.
This replaces '-AdvMonitoring' with '-AdvMonitor'

Reviewed-by: Archie Pusaka <apusaka@chromium.org>
---

 src/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/main.c b/src/main.c
index b66e2b8cb061..8fbfb29000b0 100644
--- a/src/main.c
+++ b/src/main.c
@@ -106,8 +106,8 @@ static const char *le_options[] = {
 	"ScanWindowSuspend",
 	"ScanIntervalDiscovery",
 	"ScanWindowDiscovery",
-	"ScanIntervalAdvMonitoring",
-	"ScanWindowAdvMonitoring",
+	"ScanIntervalAdvMonitor",
+	"ScanWindowAdvMonitor",
 	"ScanIntervalConnect",
 	"ScanWindowConnect",
 	"MinConnectionInterval",
-- 
2.30.0.284.gd98b1dd5eaa7-goog

