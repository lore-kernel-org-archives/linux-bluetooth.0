Return-Path: <SRS0=JXiH=C3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0520DC43463
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B401B21734
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Sep 2020 22:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TXQEXe1k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgIRWOO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Sep 2020 18:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbgIRWOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Sep 2020 18:14:14 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 166FEC0613CE
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:14 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id mv5so3603113pjb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2020 15:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=hB0CpivhDfyrDY9Ky1oVzGJab7x3ciX7ZMWxakjiGGU=;
        b=TXQEXe1kV0LP+DE8LvhEzoe6PveY3xealaHWcfatqc7Z+oFPCdM3W7bHvpxITMkyb6
         FVP8GyDdrCIHCm6y9U14hpuPaoxtIFv2j/HzEM9QjDRSt+Bzi8SGibRb4OeX4xFXCt7J
         fzEryB5WlRl09BFmAndUTGrwdEQrTSQrN/9O5lcelvPrlhOV4PWKZOg7vvrkhlaRJabq
         jA4OAAVFY74aumHbXbmIyKa/pfVbKuIb6WwdpVHriMxUkCFj8wtpIoKW/7dre3v12zY1
         PU8sBhpRvTV5erpQt8xlskINtUHoG5V4XAHNFRqOjaVw4KjYtSxSXC33Ne8DZKUheF8V
         2UyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hB0CpivhDfyrDY9Ky1oVzGJab7x3ciX7ZMWxakjiGGU=;
        b=n/RT+/tzsyMWYnJCU9BiJVernYFHlQxL/XTxSCcuxnOw5g1vUCjH+C1TAzrs5XzSU2
         mf2QQwH8ObinfYka5RHXv8VfEB6HgHOsrRfj0tyXoKWqwMHopnFcW3Zvw3KRtIE/eUh4
         oQEwUS/BzK7iYQCCnlYU2bhrgc/S2M/Fpz61n9ygTZht7suCKd4OEGpoqq75yF73E8wV
         gePLm6zziBGY5b7DvZmIexULAg8cexP6GAlMW483zXWqErtj0ZMnyAt9VeyDcgYEWBlt
         xDG1vv9nIKkaqAPzgvYDd+os6CW5wdP6q/mabd6up6v+qlMs4ZXHiPVIrpm0jHAfuJwv
         r7sg==
X-Gm-Message-State: AOAM532ZjwWnfBWiWNzPlGz4kD/GRXlqqGFRDmID42FdTc1ErIr9MjWt
        u0pSWuE6GbFJhK+oDduv6H7JPVgOMZi8l5JdV9pf
X-Google-Smtp-Source: ABdhPJwPXMH/JE4kdxOYkSfG85dgz6sxitqLGz1qadcsD2L1zFZprCm6+yhaIOHi4sWb7J7zsg/wSekFHGYz8k/W9MLL
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a63:f342:: with SMTP id
 t2mr28928663pgj.313.1600467253441; Fri, 18 Sep 2020 15:14:13 -0700 (PDT)
Date:   Fri, 18 Sep 2020 15:13:50 -0700
In-Reply-To: <20200918221357.3436905-1-danielwinkler@google.com>
Message-Id: <20200918151041.Bluez.v2.3.I50d9faa25e9da6e71d77c83c7d47a5b135e88799@changeid>
Mime-Version: 1.0
References: <20200918221357.3436905-1-danielwinkler@google.com>
X-Mailer: git-send-email 2.28.0.681.g6f77f65b4e-goog
Subject: [Bluez PATCH v2 03/10] advertising: Detect if extended advertising
 mgmt commands are supported
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        linux-bluetooth@vger.kernel.org,
        Daniel Winkler <danielwinkler@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

We need to know if kernel supports the new MGMT interface. To do so, we
check the return from adapter's MGMT_OP_READ_COMMANDS call for the new
commands. This will later be used to route our requests for new
advertisements.

The change is tested by manually verifying that the correct MGMT
commands are used when the feature is and is not available in kernel.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

Changes in v2:
- Uses btd_has_kernel_features to detect kernel command support

 src/adapter.c     | 4 ++++
 src/adapter.h     | 1 +
 src/advertising.c | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b2bd8b3f1..7811122c4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9653,6 +9653,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports exp features");
 			kernel_features |= KERNEL_EXP_FEATURES;
 			break;
+		case MGMT_OP_ADD_EXT_ADV_PARAMS:
+			DBG("kernel supports ext adv commands");
+			kernel_features |= KERNEL_HAS_EXT_ADV_ADD_CMDS;
+			break;
 		default:
 			break;
 		}
diff --git a/src/adapter.h b/src/adapter.h
index b4d872b15..99802e287 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -246,6 +246,7 @@ enum kernel_features {
 	KERNEL_SET_SYSTEM_CONFIG	= 1 << 2,
 	KERNEL_EXP_FEATURES		= 1 << 3,
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
+	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
diff --git a/src/advertising.c b/src/advertising.c
index e5f25948d..ad2eeefb9 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -57,6 +57,7 @@ struct btd_adv_manager {
 	uint8_t max_ads;
 	uint32_t supported_flags;
 	unsigned int instance_bitmap;
+	bool extended_add_cmds;
 };
 
 #define AD_TYPE_BROADCAST 0
@@ -1426,6 +1427,8 @@ static struct btd_adv_manager *manager_create(struct btd_adapter *adapter,
 	manager->mgmt_index = btd_adapter_get_index(adapter);
 	manager->clients = queue_new();
 	manager->supported_flags = MGMT_ADV_FLAG_LOCAL_NAME;
+	manager->extended_add_cmds =
+			btd_has_kernel_features(KERNEL_HAS_EXT_ADV_ADD_CMDS);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					adapter_get_path(manager->adapter),
-- 
2.28.0.681.g6f77f65b4e-goog

