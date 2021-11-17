Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78BD9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 621E861B6F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 Nov 2021 19:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbhKQTSL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Nov 2021 14:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240420AbhKQTSK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Nov 2021 14:18:10 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA08C061766
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:12 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id p24-20020a170902a41800b001438d6c7d71so1630428plq.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Nov 2021 11:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=caF73V05VAN5SrnvUb/tr/Mu5EsXFnwrIedVE9l5TzA=;
        b=Yekdrs8naalFBDFLp/FQys6wcES2NK8B8uNSpGYBpVphyAyxai3Tr+RebOizZE1btx
         2fRSEN3pCq/h56cGEVoA8J2ddK2qfsFtt2LF5F4eFcshHzmqDDNKxHV6gvZl1gnu+cbo
         ujKferdNYWeSMdbUue/ISserLL+6X9yE8J/exlqTfWbFf4so8zbNaWTkvLfPshVivAPh
         78xF0X9xBeWE/b215zGgKf/owqbGiCUy+r7/ll1+s1888D37vjYcwfHStSEEZRWx0vyJ
         0eP+Ja5cDcyPvLrUR1apdMWBRAqCASU4uQ5o98ANSuO7KeRTmBZAhvmT4LVDFZz7f05C
         a+oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=caF73V05VAN5SrnvUb/tr/Mu5EsXFnwrIedVE9l5TzA=;
        b=7t3bAQzAlZm0jzYRoUp1YEMIDIoNGjPKUMYRDrU8d8aKP3nMEQ47YOXyy0uY4SfvWH
         ifX1ZBnOaJnPAeJaBYAPyXKCuMFOzK7WihpGtHjKjhIGtjYhGbRWf8SUUplsRYB5r6VC
         Nvt3NWoipHP+Oq27kb48FpajLvpx0zZCDjQPxDkTbksvlEQXgDQ7fh2l79TIYMIL22Cb
         P8cF35su9v4hfv1KvRai0ODwXNpIKL3zntX/4AuPAWdGJ+Q6ZoT1WojWtbxSWgbwXFlc
         cIY35TrEbZVRarSJijnN5QlkJfM8RAfwM0M5MkU14ikqZGrreApeciD55mqL9sGQNEU6
         q3Vg==
X-Gm-Message-State: AOAM531Mt9K6V11PRsAxFUL17QEm9+uCp6MBO6HQ1KGE4+83LDwKQ0Tp
        knxtwQezLTKW4/K7PJnx/fUMCIPdMx8ONQ==
X-Google-Smtp-Source: ABdhPJxvID29vJHyN8qT9tZgOY2pujjv/zZEawePXXSGYu3QNceR3gybZSlm4FWsffZNkMfQ6Xl8MobrMvxFOQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:b1b3:555c:d0fb:8921])
 (user=mmandlik job=sendgmr) by 2002:a17:90a:cb98:: with SMTP id
 a24mr2507596pju.153.1637176511809; Wed, 17 Nov 2021 11:15:11 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:14:49 -0800
In-Reply-To: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
Message-Id: <20211117110627.BlueZ.v5.5.Ib85d2d946d853ea8c879dc922ad8e47587d3c603@changeid>
Mime-Version: 1.0
References: <20211117110627.BlueZ.v5.1.I7f6bdb9282c1e12ffc6c662674678f2b1cb69182@changeid>
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [BlueZ PATCH v5 5/6] adv_monitor: Change sampling period to uint16_t
From:   Manish Mandlik <mmandlik@google.com>
To:     marcel@holtmann.org, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Manish Mandlik <mmandlik@google.com>,
        Archie Pusaka <apusaka@google.com>,
        Miao-chen Chou <mcchou@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the Advertisement Monitor API, RSSISamplingPeriod is an unsigned
value. Change sampling_period variable to uint16_t in the code.

More info: doc/advertisement-monitor-api.txt

Reviewed-by: Archie Pusaka <apusaka@google.com>
Reviewed-by: Miao-chen Chou <mcchou@google.com>
---

Changes in v5:
- New patch in the series. Update 'sampling_period' data type to the
  correct type.

 src/adv_monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 1a8397259..fbb5277dc 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -772,7 +772,7 @@ static bool parse_rssi_and_timeout(struct adv_monitor *monitor,
 	int16_t l_rssi = ADV_MONITOR_UNSET_RSSI;
 	uint16_t h_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
 	uint16_t l_rssi_timeout = ADV_MONITOR_UNSET_TIMEOUT;
-	int16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
+	uint16_t sampling_period = ADV_MONITOR_UNSET_SAMPLING_PERIOD;
 	uint16_t adapter_id = monitor->app->manager->adapter_id;
 
 	/* Extract RSSIHighThreshold */
-- 
2.34.0.rc1.387.gb447b232ab-goog

