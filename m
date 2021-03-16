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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A46C433E6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFC3E64F90
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 23:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbhCPXW4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 19:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCPXW0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 19:22:26 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5105AC06174A
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i1so26557818qvu.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Mar 2021 16:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VAHBH4eT4ZKRoaqOYqlb8FAmNIdURKvwxVSJUmrycdE=;
        b=pVKWnkjbeLBFKpw7iz34EudGthWz5/PWATPUR6l8D4rnkx+4ETYanJXR/BWI4DTEi0
         KYsO06l+hm+VkrxVfX7jjB6HCKm2RUihah085goKSk5LqEhnbw3J1Ot1E7iOWIk5sY3Z
         6mutEPawwjZnkjELNHcnp2mo7UtbgBHVOY0DWCwSqaOtiW6+qhap3JIsTZfqUvDqkFd0
         uz4Hz70SQ0stm8kBMwnkG4DzCw3TSTTlFAar2MJTST7dxgZyJU41HSCYQO9ZPu3W4iZ7
         jnjcOQkM4LX3uq/+snNU4sTPLHOPCYCk5YqJ6C90iSQ4LSRbIUAPLSJrIlbSUrQ61K/t
         ip0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VAHBH4eT4ZKRoaqOYqlb8FAmNIdURKvwxVSJUmrycdE=;
        b=TENu3XCskWM9hle+qfyZbyjO+0vtkjdldBq8UWc3aN7WYC+dC6/Hs3ilSDsA5ijUry
         fHkh5OQgVsKayu2ud2gTurjKJtagW1luZ6YeoX364ItupQkQIK3LmcJCxjUu17E3lw6G
         Wu3D4RXccwy0g3NXHB6OOajHVFW0ccmooLJZZIRLOYsBfxzV3+qGP5cFH9Enne/io2At
         TKbR4dZksh9pGkIwNEiwg4uvrWrB+QRATXeeyiFEbZclg27Kf/Jz9AXmjRd2ppxQfhNz
         Bjf0KjDR0+tT1GCTtw7efRhurkQEIOnBm4USkEFSiMcOcTV/TTQDQksVXHnhSPWP3yie
         pEaw==
X-Gm-Message-State: AOAM530FVohJeI7tJ0lhLUTIL8/3XvzKQdg3OB3Nmg3mcj5BPkiZ1guw
        LGqx0k8cpso1RzXg1gde0UHUrPJcQFCnCXsHJJZ4n/k1ZF0VwpPlz6sYo2vkHd0lACGmlvGpB83
        w9JIFVOc8LrBCS2JJXvF8wkKIN3wlr3mxap843lgI+B4uk26oBExvIAwURX0ObJSqB50WhgoXHI
        nmRMLs3BcOZeAYz0VR
X-Google-Smtp-Source: ABdhPJzZ3NnC62JfBKn4C7g3YnAWw94YAY+VapZenaOoJuokNLz/Hejs/1R6qHvuyLApkKju9LW1Gwgu3qEWWYLXKqJZ
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:8543:90a8:2e5c:1402])
 (user=danielwinkler job=sendgmr) by 2002:ad4:5851:: with SMTP id
 de17mr2108068qvb.6.1615936945482; Tue, 16 Mar 2021 16:22:25 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:22:16 -0700
In-Reply-To: <20210316232217.3344489-1-danielwinkler@google.com>
Message-Id: <20210316162044.Bluez.v4.2.I33cf8432f94675b635ab429b3125f54048c5b66a@changeid>
Mime-Version: 1.0
References: <20210316232217.3344489-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [Bluez PATCH v4 2/3] client: Add adv SupportedFeatures to bluetoothctl
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

Changes in v4: None
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
2.31.0.rc2.261.g7f71774620-goog

