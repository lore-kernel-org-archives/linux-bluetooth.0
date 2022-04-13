Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1150C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Apr 2022 20:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238669AbiDMU5Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237910AbiDMU5X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Apr 2022 16:57:23 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBDEF55BEA
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2ec08c1dd2dso26249087b3.20
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Apr 2022 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xWK0YHOGJv6pMBeiWUrPqa8co5ypF3AZhZlrNIFGl8s=;
        b=Zv4mgHJKAUoN290A0tMeH3nMjTefK74/4A6oWPrDt8Sw4FWprkc1Uk2J9knt96E5iT
         rxVWah42f/PkWALrP8cynxMmfIlN6hvwmVxrEaiF/QZcB+1hIBaAF1J8XvhBUnngbPnN
         DMcMP3f505Sefu5H65MbcdKsPizqhoWu9U0h51iUMldVySHdzsvgxxZR+hOyWZasaZKx
         JkC0lTjQLhtEqFF04aYU+MVKzViW4vtnnS8RDYS/3wP4Qa7AKrgLQbgJ+5d/vHxd+poT
         AUHFw4ZWsMKjb0ClaEdVnIpRN9IODcdKGOvIiT2zTQflxoY5salG+udQ6gh+6+W2fzB1
         sJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xWK0YHOGJv6pMBeiWUrPqa8co5ypF3AZhZlrNIFGl8s=;
        b=A8hX9Vol4/hNZK4n64n69jbLfwbqZy1uv6+ocst3xqBQ2qAw6n7U6U8iiz//su6OaS
         cE4j2gkq9hr6iOkP/NmmDVrz4j9SQzgoaUqc2i3PEbY6tqWnYFC/1vTD9x1jjakkdtBu
         KC4evSsk9F0tlRdAQMfJC4Eijrm70qaHQS2ltX4jPF8Wmp+0seesRezwI1GsIJSVsGGu
         E09Q+RIa/A6XxxLyFYZ3mYPR1bA7nMVodqeWUG73lfN2hoyt8FIoiyo5xiBzOLcfB21F
         VEWdM9tDmgqZKylhWZf8xp/LEzfmyHuyHov8Vs7ZscddVo12TEWJ9DjaRDiY+3HymfuW
         X9vQ==
X-Gm-Message-State: AOAM530LJk8Vt3tnlG9nW4Tn/kGw+lIjjCKmRpm1sjwXooMtQwKJDQNv
        1gNvoOiZ1bW0fcEKxDO81aXQMztZV1r3aQ==
X-Google-Smtp-Source: ABdhPJzqhDDekGpCrGY1YxnIkb46CE4TX1twmpg4pHGL25rov3TNCPKFBnKfUcWtkSNPi8bfYK8MVMsD7pk2Gw==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:2620:46aa:79ff:778d])
 (user=mmandlik job=sendgmr) by 2002:a25:32c3:0:b0:641:4d40:3065 with SMTP id
 y186-20020a2532c3000000b006414d403065mr635084yby.403.1649883301130; Wed, 13
 Apr 2022 13:55:01 -0700 (PDT)
Date:   Wed, 13 Apr 2022 13:54:43 -0700
In-Reply-To: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220413135223.BlueZ.v2.3.Icb5e0b991a133d9b8a91a23f1c9b2ca41e151a27@changeid>
Mime-Version: 1.0
References: <20220413135223.BlueZ.v2.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.36.0.rc0.470.gd361397f0d-goog
Subject: [BlueZ PATCH v2 3/9] adv_monitor: Clear tracked devices on resume
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

Clear any tracked devices on system resume. Matched devices will be
found again if they are in range after resume.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v2:
- Fix compiler error by replacing btd_adv_monitor_offload_supported()
  with btd_adv_monitor_offload_enabled().

 src/adapter.c     |  1 +
 src/adv_monitor.c | 19 +++++++++++++++++++
 src/adv_monitor.h |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 97ce26f8e..2ae8a9ae9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9183,6 +9183,7 @@ static void controller_resume_callback(uint16_t index, uint16_t length,
 	info("Controller resume with wake event 0x%x", ev->wake_reason);
 
 	controller_resume_notify(adapter);
+	btd_adv_monitor_resume(adapter->adv_monitor_manager);
 }
 
 static void device_blocked_callback(uint16_t index, uint16_t length,
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index a7763df10..18ce839e9 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -2248,6 +2248,7 @@ static void clear_device_lost_timer(void *data, void *user_data)
 	if (dev->lost_timer) {
 		timeout_remove(dev->lost_timer);
 		dev->lost_timer = 0;
+		dev->found = false;
 
 		monitor = dev->monitor;
 
@@ -2289,3 +2290,21 @@ void btd_adv_monitor_power_down(struct btd_adv_monitor_manager *manager)
 	/* Clear any running DeviceLost timers in case of power down */
 	queue_foreach(manager->apps, clear_lost_timers_from_app, NULL);
 }
+
+/* Handles wake from system suspend scenario */
+void btd_adv_monitor_resume(struct btd_adv_monitor_manager *manager)
+{
+	if (!manager) {
+		error("Unexpected NULL btd_adv_monitor_manager object upon "
+				"system resume");
+		return;
+	}
+
+	/* Clear any tracked devices on system resume. Matched devices will be
+	 * found again if they are in range after resume. (No need to do this if
+	 * the controller based monitoring is supported as the kernel clears all
+	 * monitored devices on resume.
+	 */
+	if (!btd_adv_monitor_offload_enabled(manager))
+		queue_foreach(manager->apps, clear_lost_timers_from_app, NULL);
+}
diff --git a/src/adv_monitor.h b/src/adv_monitor.h
index c6bb8a68a..3b5b1200a 100644
--- a/src/adv_monitor.h
+++ b/src/adv_monitor.h
@@ -42,4 +42,6 @@ void btd_adv_monitor_device_remove(struct btd_adv_monitor_manager *manager,
 
 void btd_adv_monitor_power_down(struct btd_adv_monitor_manager *manager);
 
+void btd_adv_monitor_resume(struct btd_adv_monitor_manager *manager);
+
 #endif /* __ADV_MONITOR_H */
-- 
2.36.0.rc0.470.gd361397f0d-goog

