Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A83DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237890AbiDMU5U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236230AbiDMU5S (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:18 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED40667D37
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:54:56 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2ebf1d99068so26637937b3.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1yL2+Y4GUqxYFta3/wv1O/TmKK0ceZlQg2jRfPzCsPM=;
        b=mGdJblY7xI+xg2PwT2tU6eFdZvuELBEL4zrx2BtaLnSxdMtJtZsha+jg2iawXhTOtN
         NSXhgTYQHFjXHowmiNf6LIEli8qgkH0mkBfaLki+qTNcMceBXczCv8lFp42zc+LYuxmE
         jr26A/JK9naMs1qtRiPAjHP/sypbla06D16YiIWzFFGDIPJkzCA9suYm/v3Cu5ju78pA
         t54+R818sVFUaifLj/xiIpSc2QNF47TX93QoGfWOSMwcmaCw1hsmHWscSECmLSSHG+Kj
         61ynzayOToAigORMjoxBiC2IxXhLnzay0bPhJYxZ7UhdE9esOWbrEuvC50fcuX2ZnBSM
         /FTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1yL2+Y4GUqxYFta3/wv1O/TmKK0ceZlQg2jRfPzCsPM=;
        b=pcLd7KI5pQGGfrGlUKJUmxG0slrcqzo6fC1A+RViVcpdY89WL7myCPV3+USLAE/3OC
         JqcI6syn4XOe28IRqtKAqWL/yLKSQMw8vIgwC5VrF9yGp5VwlEYVZCdLun6KikyJFobE
         dgU4qfUFviSVybvCM8ZVN7xZgzQkTBGAc34DXT+jJsZoQ/5ifGelhoZBYo6tQ4SsQkc9
         H1f7nhV5Eh70V0wJ31ATSf+HCS1utrCZB+MkPaAEYVVUWkIrD0t5bYILMN3yEUh+vQ3C
         VaCJIZCsZduV+cB1FErrijX7kTab9uk+cY5jL2+ZMnVFdH784EBp/WG0AJx5EqUh1PwP
         xdOA==
X-Gm-Message-State: AOAM531wUo4IUKsQUUYkA72evwQ4D/4UaMvnJdpRkHs6qmAalmqO9O4U
        f4nFboxsf0YgEMALtbfJ1L7ZmBl+Asu3Tg==
X-Google-Smtp-Source: ABdhPJwG3Nht98Rrmp+FuerPpOvVqGWoYT6K/hpuez/uewnvsRix8uQVd+TCBfLRCCl1ZoZXTiPcJQScRTVeNQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:2d63:0:b0:641:acd5:4316 with SMTP id
 s35-20020a252d63000000b00641acd54316mr622786ybe.388.1649883296064; Wed, 13
 Apr 2022 13:54:56 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:41 -0700
Message-Id: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 1/9] adv_monitor: Disable RSSIHighTimeout for SW
 based filtering
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Controller offloading does not support High RSSI Timeout. Disable High
RSSI Timeout for SW based filtering as well to provide a consistent
behavior between SW based and controller based monitoring.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 doc/advertisement-monitor-api.txt | 5 +++++
 src/adv_monitor.c                 | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/doc/advertisement-monitor-api.txt b/doc/advertisement-monitor-api.txt
index 9189f2cce..942d44b2f 100644
--- a/doc/advertisement-monitor-api.txt
+++ b/doc/advertisement-monitor-api.txt
@@ -79,6 +79,11 @@ Properties	string Type [read-only]
 			in-range (found). Valid range is 1 to 300 (seconds),
 			while 0 indicates unset.
 
+			NOTE: Controller offloading does not support High RSSI
+			Timeout. So, to provide a consistent behavior between
+			SW based and controller based monitoring, this property
+			has been disabled and deprecated.
+
 		Uint16 RSSISamplingPeriod [read-only, optional]
 
 			Grouping rules on how to propagate the received
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 33f4d9619..a1778248f 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -860,6 +860,12 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	monitor->rssi.low_rssi_timeout = l_rssi_timeout;
 	monitor->rssi.sampling_period = sampling_period;
 
+	/* Controller offloading does not support High RSSI Timeout. Disable
+	 * High RSSI Timeout for SW based filtering to provide a consistent
+	 * behavior between SW based and controller based monitoring.
+	 */
+	monitor->rssi.high_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
+
 done:
 	DBG("Adv Monitor at %s initiated with high RSSI threshold %d, high "
 		"RSSI threshold timeout %d, low RSSI threshold %d, low RSSI "
-- 
2.36.0.rc0.470.gd361397f0d-goog

