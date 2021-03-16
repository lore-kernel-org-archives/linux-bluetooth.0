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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09426C433E0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C70E564F92
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhCPXW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCPXW2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 19:22:28 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F5C06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:28 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id c7so27942163qka.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=n9X+bE9zIm1NtxvXj+jJRmsT8D7KM7qPYuN++zNq+PY=;
        b=WEwVC+UwK3Em65et5BVD0F9qxfQPu/dp2J52gyxqZ0/EsD8JrT/oKoPdLt6ySbB3vG
         xbZGXX0a5QItIeP51NUY+hFV/A2NMv6Y6QLU7vdlNoGUGHly6QAijDjJb+CZAxrflv/g
         8QJx1HPmSAtJ/2+GiWleuhigsyzxToc1R9F2S7ewXXN4kOo85abyfDTh1EKKDcfPWIB/
         QTBiR+SpuNZypSmovIomGhTf5paGKRRAnx7y3LhA39ewckyXInw6mLB/zj+1SiXIDdJD
         lWnk/lYkaJUtre7FAEPVgQJ/gMXI0+Hi0M6PUttTui2n+Y0vnm1kd3uj5pJlTIkPvADJ
         A3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=n9X+bE9zIm1NtxvXj+jJRmsT8D7KM7qPYuN++zNq+PY=;
        b=q0BQG/jj3M2ppAlSug5uxBujgOH15voJPcynGz6tiDc4Jbt7OEP0W8zdfafkLeZUNN
         alCVdfyBRcTHsCgYgUBAv31fLzimlQFmWdAqA8k0p+S7CIhg5jNwgf1ieMUuj3XLOdVF
         0vBvswOL38ccHAkPfQbvuas45NNqyng12l93lUc4FQsWVzAUGwB1+NhiKL5PAwYYCaXF
         q+u9U8NTimkQYjudz/hotWB8e+WBsANIm4wOOoJe2P2pRalkVoF+MU3vWs57B7oDMQV6
         NmsVu1wzqwaKyYXY/Epkk+auTR78RmrPUBHmNaV3LrAPDcu5aNl806Bo4mvc0s/LQZPV
         Lq4w==
X-Gm-Message-State: AOAM533fOYQyhxeMWH2d2ff07gbaUDIp5Gnp20UUZj0+GWU1+Ykl58m2
        ynPivfOBjX4OAhi4vR3S5lZTTk0l6NzU2+nHzJdrx6CfkyHuq+JJvSZUwhaJMH9rJBXDpPHVlJl
        qOmwiZgXoYq8cbuFHbwOMLI5A/GzaxK1grbzR6+UuCRwUscvNjx3PqPAn8G4IW0/8EeUMXcLVN2
        Q+7Ht1cEVhVhGn9M/c
X-Google-Smtp-Source: ABdhPJzt1a+0qztpChQKH0CzvMWXnLVIVu42BIRWIxOXyZYxUx4qkjA401BaDwL+2s+pLe6idbqbwL6KozRVwaSvlv0E
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:a05:6214:18d2:: with SMTP id
 cy18mr2441658qvb.50.1615936947651; Tue, 16 Mar 2021 16:22:27 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:22:17 -0700
In-Reply-To: <20210316232217.3344489-1-danielwinkler@google.com>
Message-Id: <20210316162044.Bluez.v4.3.Ieb6522963e3f54b0d63dd88ed3ce24a8942ed73e@changeid>
Mime-Version: 1.0
References: <20210316232217.3344489-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v4 3/3] doc/advertising-api: Add adv SupportedFeatures
 to doc
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add supported features to advertising dbus api.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4: None
Changes in v3:
- Rebased onto master

Changes in v2:
- Doc: Expect empty SupportedFeatures if no support available

 doc/advertising-api.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 541c57004..6c0e52358 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -257,3 +257,21 @@ Properties	byte ActiveInstances
 				int16 MaxTxPower
 
 					Max advertising tx power (dBm)
+
+		array{string} SupportedFeatures [readonly,optional,Experimental]
+
+			List of supported platform features. If no features
+			are available on the platform, the SupportedFeatures
+			array will be empty.
+
+			Possible values: "CanSetTxPower"
+
+						Indicates whether platform can
+						specify tx power on each
+						advertising instance.
+
+					 "HardwareOffload"
+
+						Indicates whether multiple
+						advertising will be offloaded
+						to the controller.
-- 
2.31.0.rc2.261.g7f71774620-goog

