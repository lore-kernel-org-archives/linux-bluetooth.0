Return-Path: <SRS0=2LFz=ID=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2F05C433E6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB47A650AC
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Mar 2021 23:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbhCEXwl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 18:52:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhCEXw1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 18:52:27 -0500
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05498C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 15:52:27 -0800 (PST)
Received: by mail-qv1-xf49.google.com with SMTP id iy2so2732382qvb.22
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 15:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hUg6I8D8GZwLQDAfRhk65G9y85zlIgD8R1KBTwKyx4c=;
        b=ALVBhPabaX2N5u0FtVXwRWphgqoaTjNt5kfBhPnXp4+dxgqPMt3JxIkQnxIiEw/Tvu
         D8WdzG+A10+739qU9VN06uFPlnfEJTanViAxCi5Q/RR89/PSlWL7Ds/PsnnYcYr9Vpjz
         2efuAoSsgKqm6MI8k8hd/sfLKGI0WbOuy13uH7uv1GP/N1ZNguwMVVQJhMN87cqq28gf
         oeUdKlG3O/aTk2sACnIQqO83Vl6m/dHM2s+1fSptLTsTbpZJYzSRKWu8Yr/DuhwKnt6F
         CaKW4OfCBnnvjlkZhSXuq+tcLPe3Yna8+AzC9tlLAbZ2rv7Yfq3sP17gyy9pVYQucryv
         8T1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hUg6I8D8GZwLQDAfRhk65G9y85zlIgD8R1KBTwKyx4c=;
        b=OttS5iRSpbpysjAgwkyk9feB0E+rmg0bPKnYu5kPaNBIZ5NE/DjZFVr3ZmaczG0B1j
         du3uNmJ4u86l54yOBDJuiKfoLaT+nQ0Sh5K1W+IkxCQDcJz9xqCKE7BBliCC0VOE8oj6
         uJ9aJJ72GEyURKtOHUgUCSi2hZBJRtTWk7/BXbJuIoIxWV8mm8MOr6qKLvRUypMep3kl
         yNAp/lQ1m6cxnZMsEfaFxLpl+gDH4sULlV0bNkPF7FzAVErSww6cSzhCsEQVhpdiaF/d
         Sxz1Gsoq/iy3AWaCphP6cOYX0v3N2T3JVeq1HTi9dTE7oz4KIN9leU4GU5ZcrMUsTmAa
         Tllg==
X-Gm-Message-State: AOAM5334MWADf04FwCbZvZVUoDSvQQ3r3KvYmo+QkWeUs9bPlGjYTQan
        kr3FuafkfwzIJ0dqdglvy9toSkB7d0qqJQDkXzsjgAVrOKmPbtx1ZkEIAQhUvndNqRPx79dQeM1
        Ebt+aAv+dER0FAoXLqkuN9yppX//hiQ4iyurfil5yL2uMfYQBeRGGnCevNKWT7PN0bDegKF4aOl
        u0AfH8lS2iqqZdfAwr
X-Google-Smtp-Source: ABdhPJwq7U1l0XiJsOvr2j0h2enRvFhHoYGAKjh2brSSNR5I73Q8zV3cyfe6BFOVyjAc+qS/NVV0SP3sSNlodL8YA0M7
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:94dd:309a:2fcb:13a])
 (user=danielwinkler job=sendgmr) by 2002:a0c:b998:: with SMTP id
 v24mr11895944qvf.4.1614988346080; Fri, 05 Mar 2021 15:52:26 -0800 (PST)
Date:   Fri,  5 Mar 2021 15:52:16 -0800
In-Reply-To: <20210305235217.2382976-1-danielwinkler@google.com>
Message-Id: <20210305155113.Bluez.v3.2.I33cf8432f94675b635ab429b3125f54048c5b66a@changeid>
Mime-Version: 1.0
References: <20210305235217.2382976-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [Bluez PATCH v3 2/3] client: Add adv SupportedFeatures to bluetoothctl
From:   Daniel Winkler <danielwinkler@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This change adds SupportedFeatures to be shown in "show" option of
bluetoothctl. It was tested with and without kernel support for features
to verify that they are shown or not shown correctly.

Change was tested by verifying SupportedFeatures were populated
correctly in bluetoothctl on hatch and kukui chromebooks

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v3: None
Changes in v2: None

 client/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/client/main.c b/client/main.c
index 79658a463..1669d2c89 100644
--- a/client/main.c
+++ b/client/main.c
@@ -942,6 +942,7 @@ static void cmd_show(int argc, char *argv[])
 		print_property(adapter->ad_proxy, "SupportedIncludes");
 		print_property(adapter->ad_proxy, "SupportedSecondaryChannels");
 		print_property(adapter->ad_proxy, "SupportedCapabilities");
+		print_property(adapter->ad_proxy, "SupportedFeatures");
 	}
 
 	if (adapter->adv_monitor_proxy) {
-- 
2.30.1.766.gb4fecdf3b7-goog

