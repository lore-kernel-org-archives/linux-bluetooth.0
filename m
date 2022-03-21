Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DD0C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Mar 2022 01:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244605AbiCUBii (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Mar 2022 21:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244224AbiCUBih (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Mar 2022 21:38:37 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF7DDD97C
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2e62857e0d2so15123267b3.14
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Mar 2022 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uLPcmR4K6QwbWhmkn/cTqz/cPCrfSkt7khr1jCpbRs0=;
        b=ly6XuN0pDqdkZaJ9yeM+zvnu8PRlOFNeXixNmFxAJ992SmfXVxJ4T/6WWlnGH46/Ah
         INwSaZiEkuXKjch6wrbU0vE7qKN0FMQZ5Zv6jtB3jW+JFBcbgWMbbWEsDRagH3EiipmK
         XPa9DSG5pG3orYP0C+Q15h7yjV+FINL3OQvJ9tH+WoONfW/kf/DxXWaVQI4NWJfBAX1Z
         p/IFXmphlA5j5MhsG0uO8rbTXr2L9nrfS2PRy0SxbYfUPCXlrg1Lm3fASSOSnLOp7KRD
         L6kJn73PW+HHfsc8EINqhdJF45JN+uD1/BjFmfbqjj7t/vhvUU8Gfmjr7ElCwrUxNzPz
         ABuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uLPcmR4K6QwbWhmkn/cTqz/cPCrfSkt7khr1jCpbRs0=;
        b=BBJ29aIpkxSnOwodfyH6wl4IbtAcaLHTKvh+FdL/93y6u7VqXJtNu8Aub5W3NY96i4
         7Lb/2SsoT6RINYFove+AZKJW01QgkUjHNiFMykWvbKmuAIm/4uQT7AJrEc1BNv3iVCfb
         1wZ4b08ulX/SCbH6Ttb+PCQfKw+auJSDF3sZyyisrUnBtkokpSFHRCERUYDRdj9vyiLb
         T1HWxz0WGu8inzxzTZSbe+gKm38eDZRuVUWl2AtGY8ivddbRifOimO0NVz8DqwM726qD
         2v+qTfK2T/dju5+/MWzOjrc8Pv1t3BaYZ20DlVnTpjrR/g91X6AzGrVMRO9h83BncnaN
         UtQw==
X-Gm-Message-State: AOAM5332Pd7l9VWu3F9ciL64MatRn2TGdtIQLRsSuDKnxTzXdLwTO+fR
        SMAWkgpF0NuEWH328zd5myXXxQRtxMI6rA==
X-Google-Smtp-Source: ABdhPJxk1wPMuV6Wx4tC8zsSiqQ106ZbFVmes2t7GZrW92nyTQT79KNi/lYuZxGPlh6sc7ajJKFhFM6W1wFkrQ==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:e0cb:81c1:7b8f:ab9f])
 (user=mmandlik job=sendgmr) by 2002:a81:1458:0:b0:2e5:fa20:3531 with SMTP id
 85-20020a811458000000b002e5fa203531mr9455347ywu.387.1647826632782; Sun, 20
 Mar 2022 18:37:12 -0700 (PDT)
Date:   Sun, 20 Mar 2022 18:36:57 -0700
In-Reply-To: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
Message-Id: <20220320183445.BlueZ.3.Icb5e0b991a133d9b8a91a23f1c9b2ca41e151a27@changeid>
Mime-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [BlueZ PATCH 3/9] adv_monitor: Clear tracked devices on resume
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
index a7763df10..35d9bc9c8 100644
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
+	if (!btd_adv_monitor_offload_supported(manager))
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
2.35.1.894.gb6a874cedc-goog

