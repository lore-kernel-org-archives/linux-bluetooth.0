Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A71AC4361B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 07:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE86E2313B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Dec 2020 07:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725914AbgLPHTr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLPHTq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Dec 2020 02:19:46 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A70FC061793
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 23:19:06 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id mz17so1119112pjb.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Dec 2020 23:19:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=4LeI1/Q+4N/V1XOG+szv3ZUGJVC+gkma0bXHRTrB7GQ=;
        b=mx9hbmoY2A9xVuLrWgjUwbGHrdzFCawDnRNgN3HEg8iUt2Xpby1+LtyrXxkmCUTgM7
         0ihro8kPx+XWWf/4vFxqKo7lPeF7I9op0gIzkPiM6JVNx9l/xgKTxgDsrFDE0+iCz2HR
         n0D0hC/ZXWrzvW4/YhBMsFehEyY39p+T3o7LpwjckjK+WqndmkamOxSLYKkVqWUY3xwC
         GxywdKD1IjiYq5QV/+HrwQ4liwDHEQRGyfUc69vfmeXeaPP3k/YjaYEDcmCuBLOHzoN/
         R4aqxCt050hKy9q6Kjb4Ss4g8zeLkD9bPhW7IB6Anz/IVsLGOT4GATULOo4J6dNu+xKA
         7ZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=4LeI1/Q+4N/V1XOG+szv3ZUGJVC+gkma0bXHRTrB7GQ=;
        b=VlYK/nTpizl/UwhoHW4H7I5V/eyVlNxhw7A5fhqgs++AEgH0/VQBXMxjCDm4zgzSjC
         KLj+eKpSYGI82VxGkYFM9MeO9U0cplBGN4XWRkHqUKwomvw4wLX4H4ig+rxpVcPWO78o
         +7eR+0ng3JUNbwv+7yirwXN2lKCGbayQJW1VGhh45BniEqPn8a9/+mHgTnUt9QnTAchm
         rzAiURxWtgozR78LzOtjUzM8vTwxAYSsOgI9QrkkmXP54ZA9n6VRt6l7eJ/gaPAVVFyP
         hN+y+qbPgppyLGVnK8JeAoNw554gZdCieJ5xvpCbuVzwQgzMSSycjpmFTKdxVHd/X4Xz
         vrfg==
X-Gm-Message-State: AOAM531/h8lTjno4dvycBHdtZUXER3P6pm5s0iKbf8XCy4wWzaxV0rr4
        Zx+lyKNKNARufTAl00nvIhWXT6KaBwe38drhr7Wpkn/1Igfh65iohBz+ZdQF/fh4jjenE7kSUUW
        +tRJqs1FDMr9FOSFxvIJ228luk2FzMLR5GbWinDB2J3GM4Lgwnnxcd/d/O77xiikMODCWqcwQpk
        ZbOqWq7dgV47s=
X-Google-Smtp-Source: ABdhPJxGl1JNyaQVksQl/y6xZK9zbAS3KaKW/KElaKguojphdjoQvBYpKO3ghWy8zWly2Nw3JI+aEohTQ2SbSEOUBQ==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a05:6a00:acc:b029:198:2ba6:c0f6 with
 SMTP id c12-20020a056a000accb02901982ba6c0f6mr30887281pfl.53.1608103145784;
 Tue, 15 Dec 2020 23:19:05 -0800 (PST)
Date:   Wed, 16 Dec 2020 15:18:22 +0800
Message-Id: <20201216151748.BlueZ.v1.1.I6e3ace32f08a22879ede97a1433f524189bf24df@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
Subject: [BlueZ PATCH v1] core: Disable advmon manager interface for old kernel
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This disables Advertisement monitor manager interface if the underlying
kernel does not support necessary MGMT commands such as add/remove
filters, so clients can know that they are not able to register any
filters before actually register one.
---

 src/adapter.c | 9 +++++++--
 src/adapter.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec6a6a64c50a..cbfbd5feecd9 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8649,7 +8649,8 @@ static int adapter_register(struct btd_adapter *adapter)
 	adapter->adv_manager = btd_adv_manager_new(adapter, adapter->mgmt);
 
 	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		if (adapter->supported_settings & MGMT_SETTING_LE) {
+		if (adapter->supported_settings & MGMT_SETTING_LE &&
+			btd_has_kernel_features(KERNEL_ADV_MONITOR_CMDS)) {
 			adapter->adv_monitor_manager =
 				btd_adv_monitor_manager_create(adapter,
 								adapter->mgmt);
@@ -8661,7 +8662,7 @@ static int adapter_register(struct btd_adapter *adapter)
 			}
 		} else {
 			btd_info(adapter->dev_id, "Adv Monitor Manager "
-					"skipped, LE unavailable");
+					"skipped, kernel or LE unavailable");
 		}
 	}
 
@@ -9721,6 +9722,10 @@ static void read_commands_complete(uint8_t status, uint16_t length,
 			DBG("kernel supports controller cap command");
 			kernel_features |= KERNEL_HAS_CONTROLLER_CAP_CMD;
 			break;
+		case MGMT_OP_ADD_ADV_PATTERNS_MONITOR:
+			DBG("kernel supports adv monitor commands");
+			kernel_features |= KERNEL_ADV_MONITOR_CMDS;
+			break;
 		default:
 			break;
 		}
diff --git a/src/adapter.h b/src/adapter.h
index 60b5e3bcca34..39bb3990abbe 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -237,6 +237,7 @@ enum kernel_features {
 	KERNEL_HAS_RESUME_EVT		= 1 << 4,
 	KERNEL_HAS_EXT_ADV_ADD_CMDS	= 1 << 5,
 	KERNEL_HAS_CONTROLLER_CAP_CMD	= 1 << 6,
+	KERNEL_ADV_MONITOR_CMDS		= 1 << 7,
 };
 
 bool btd_has_kernel_features(uint32_t feature);
-- 
2.29.2.684.gfbc64c5ab5-goog

