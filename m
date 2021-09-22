Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17493C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 01:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E623A611AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 01:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbhIVBPO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Sep 2021 21:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbhIVBPO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Sep 2021 21:15:14 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC8FC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 18:13:44 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id az30-20020a05620a171e00b00432eb71d467so5974242qkb.18
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Sep 2021 18:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LUkTouXVptb2w1fLzS/6eN9YdRiSGEQDTx4Omuh6lfM=;
        b=o89AdwlDYT/EnQ7BY971VNMSjvR3Ch85Kj9BHsFsZ3VNVDtoZg4FBi22iT15e6BsI7
         hjGMgKK3xscSJ8PPqb+4QpTbzp4Ing1+HR4lBG718rEt3fkXEnYc9eIRiGSLSiILbPWI
         nxTeByIokrbJvxhDjWDPTJkHQ2cnzFciMDtN7dLWZHbOWGtG8FdFwzr9kic0uI+1ZKkl
         MrAiuInpy6lgt/osWrGbE9v0xQDvmftfKh2RodilE4jfpqP14qms8Ho7CAUNjnaPwLkK
         ViOM4VQ+edMNw7Rvu8mdYEu27XPQ/aDPapNOsGWjh4Ph523uFc/nr43akJ9DEftQj0f7
         5szg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LUkTouXVptb2w1fLzS/6eN9YdRiSGEQDTx4Omuh6lfM=;
        b=Noyyt3bkL+P88m6xt5w9EYzI6rwQGX410YRQXJNnn+ixOdCItsP/9aIPISWsIAvcJx
         NfGJZSEPWxQvpNl0D3mgZCG0hpMoIjYvVdSLJtkJr/yEGbbBMlPamNPoZK7GkDZgJBl0
         I5GBIt73S0898rtDiBqxpVGRHu6tEhs6mOI1YYgrhHlM0dPf2PvbVCExtJw5srU60Ecx
         SFYuer5Es49FlIPAXPFK6Iet75OjDh0J74ZsN4ks+KfaMGhJpukv7ILeuo9l1yJINdEH
         GlFGZaWIoUxeA6GCZ9CC8ylcfmb/7wPM/NPXSA5B7iGc61M8IZHZyLIW28Fe3aM7eA9e
         9kFQ==
X-Gm-Message-State: AOAM531Rh7xLpywAa4DVYH+/o3dWDfTx6TxZix+qoG1dP+jPIttKGN5o
        ELKeNm+lxyGQFIg4y+XtiCHYIT8xAma0xQ==
X-Google-Smtp-Source: ABdhPJwwrPNW/HCcqzh7H5fvqzU5z9UtTYVInOCFt+Lr5r50dgK5DxKmZT2WzK8XigtRh8nZ7vsswwo4xEpc8Q==
X-Received: from mmandlik.mtv.corp.google.com ([2620:15c:202:201:98fb:b541:26ee:9c8a])
 (user=mmandlik job=sendgmr) by 2002:a25:cc0a:: with SMTP id
 l10mr43286936ybf.10.1632273223960; Tue, 21 Sep 2021 18:13:43 -0700 (PDT)
Date:   Tue, 21 Sep 2021 18:13:23 -0700
Message-Id: <20210921181243.BlueZ.v1.1.I261f9c1ee78b90f81a6c323c23065615be917c33@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [BlueZ PATCH v1] adv_monitor: Mark the device as lost on device_lost_timeout
From:   Manish Mandlik <mmandlik@google.com>
To:     luiz.dentz@gmail.com, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Manish Mandlik <mmandlik@google.com>,
        Yun-Hao Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Mark the device as lost on device_lost_timeout so that it can be found
again next time.

Verified this by adding a monitor using bluetoothctl and confirming that
the DeviceLost event is getting triggered when bt peer stops advertising
and DeviceFound event gets triggered again when the bt peer restarts the
advertising.

Reviewed-by: Yun-Hao Chung <howardchung@google.com>
---

 src/adv_monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 715ac5904..a55e1ea2d 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1892,7 +1892,9 @@ static bool handle_device_lost_timeout(gpointer user_data)
 	g_dbus_proxy_method_call(monitor->proxy, "DeviceLost",
 				 report_device_state_setup,
 				 NULL, dev->device, NULL);
+
 	dev->lost_timer = 0;
+	dev->found = false;
 
 	return FALSE;
 }
-- 
2.33.0.464.g1972c5931b-goog

