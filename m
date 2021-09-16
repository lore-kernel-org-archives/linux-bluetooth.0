Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D38C433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE8A611EE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Sep 2021 22:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241096AbhIPWju (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbhIPWjt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Sep 2021 18:39:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35CCBC061756
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:38:28 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id q68so7630588pga.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Sep 2021 15:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UhOcez+Chf/Z1uyQsx/IHY7FfchQZXmU8JpeyyTsmm8=;
        b=Suc04o8+4pz3TAZ56U48pe+Mqw+4NxZH3eVaY69/DX9Ol2KC5jwPnpcIgAjIj7ClFF
         lG+iui8tiOoOJwNXMSK6j5LUwk9E0LTb9+3JVbrz/EgghSnN/hRU7TJ5V30qTBUJYfRT
         ICfZ7SVV70lf3wmwsdvS2QLP/54vAyPf1woHoZ84l6VseBgDUuRCpyuHimZgVJpp+ylw
         5UCJc7vD+grCZVnDpmwpQs2pcpkEHC1CpZjplg0h3eqPu4EdHp7BGKCM8RXQHm9T9voK
         TvVM23MZol/+VmANFwlk+geqX4FbZYxX6FXUbkPI8+HbjvV0imwzzTS3qIkkNqr+Q7iS
         4cDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhOcez+Chf/Z1uyQsx/IHY7FfchQZXmU8JpeyyTsmm8=;
        b=blkDbME4NmfKYcRTPe86dzANpOw2ZFCFRoLn5+PD0Znh2nNkcQZhyFJjRJp4orrz5D
         hVvU4nsOTksvjX3qAGiFfdBcMxUOxl1N5wyAn+HySi/oenPRNhVrh7N0NKRoOIFg7Y0t
         zytn6mMptFxDiAZHix5V8MvYCIO1GM07ebUIO7MzHObfOehveoxVoKPiS099XrbFwfK7
         o2nlDYIOkIWacEfg6bqRYHPno4rMSxBbKpQkFFWIHiM2xzdYAnp3Lu1t61iayAqBqxbY
         wnQ5h7LSGBH0XQ2KSBsbR/FJ0Qe+rnO+MuYt5uqhaPGspZHG767ZtUFR8K0h0MpZ8oTD
         Xvxg==
X-Gm-Message-State: AOAM532bZLTIlRnHGY26L29Dj17tgDNKoCnewjzcrNdeGx+vkB1TkQpn
        1ycW08yhE0MdAiRZWkQvV6w3ZPOY7nY=
X-Google-Smtp-Source: ABdhPJxmeMIFutMpGo6sopNx2zWU935zOHjoXCnXHdFPO73rNM/zwwqppzrLKa1iq9a5+mHI6zIhbg==
X-Received: by 2002:a63:d456:: with SMTP id i22mr6969991pgj.421.1631831907470;
        Thu, 16 Sep 2021 15:38:27 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t2sm8643778pje.5.2021.09.16.15.38.26
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:38:27 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] admin: Fix double free
Date:   Thu, 16 Sep 2021 15:38:25 -0700
Message-Id: <20210916223825.276530-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210916223825.276530-1-luiz.dentz@gmail.com>
References: <20210916223825.276530-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Fixes the following double free which happen due to exit calling
btd_unregister_adapter_driver:

Invalid read of size 8
   at 0x1CDA97: queue_foreach (queue.c:198)
   by 0x1318B8: admin_policy_remove (admin.c:591)
   by 0x18982A: plugin_cleanup (plugin.c:217)
   by 0x12E3FD: main (main.c:1214)
 Address 0x547ffb8 is 8 bytes inside a block of size 32 free'd
   at 0x483A9F5: free (vg_replace_malloc.c:538)
   by 0x1318CB: admin_policy_remove (admin.c:592)
   by 0x18F416: unload_driver (adapter.c:7215)
   by 0x496F50F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.6600.8)
   by 0x131988: admin_exit (admin.c:623)
   by 0x18982A: plugin_cleanup (plugin.c:217)
   by 0x12E3FD: main (main.c:1214)
 Block was alloc'd at
   at 0x4839809: malloc (vg_replace_malloc.c:307)
   by 0x1CDE1E: btd_malloc (util.c:33)
   by 0x1CD83D: queue_new (queue.c:47)
   by 0x13150D: admin_init (admin.c:614)
   by 0x18966B: plugin_init (plugin.c:187)
   by 0x12E358: main (main.c:1198)
---
 plugins/admin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index c232c057c..7b7190a06 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -590,6 +590,7 @@ static void admin_policy_remove(struct btd_adapter *adapter)
 
 	queue_foreach(devices, unregister_device_data, NULL);
 	queue_destroy(devices, g_free);
+	devices = NULL;
 
 	if (policy_data) {
 		admin_policy_destroy(policy_data);
@@ -621,7 +622,6 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	admin_policy_remove(NULL);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
-- 
2.31.1

