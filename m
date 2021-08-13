Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC13C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E905160F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240266AbhHMMXR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhHMMXQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:23:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65832C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so9018400ybh.17
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6K0sVYRMx1SZAWIPQWHWh/C2l1GEoBtXt1rxZyyl+8M=;
        b=NAUdkPE5aoVvMONkRSEq/R2LaMdpbG+/p7p+WHn/TWjpyPY6TSVttCf4jIV26dY2DK
         FgMoCjWNuciN+DVMz/ST68EC3x9pdhVXZrENjuRh+9K5V2CGGBIMh5+vrXJerQ3gLbx5
         CFCFLzOFV4mo3Pri/rQViq/SgvSfCDXIDMq+z8vefTfl/q5oiO1Zp3wseOeeYi/Lmbly
         zVXXF8bQlX+b8NZSYdpNOQYYlGodhr+QQOM+wwk9OngjP3mkzKSh4Y36Wr1IhSxZ/pt3
         APTovyZCJlefUv1k2tP5zAUvkSQOcaLrleUXPHVtd/rNNs+7vKhBkvohcl47h4396cFa
         MB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6K0sVYRMx1SZAWIPQWHWh/C2l1GEoBtXt1rxZyyl+8M=;
        b=hy4rJRbasGi6JCIDzJxnWWeis0vDq7+hI4LU2CbF3ku5F3dKK3+fmo4YrpyRuV9olN
         APraQ6M3C2899zi6OX2gLELN66laIVkBSzDd0ig48cOVy/VQngPsRM3BDLXMkRMD/LXV
         NnhSufU87eBpwkQaBqfMDXAJwxf17yBT7k3vdCB1ISdqEyh4yKdyi/a5A6AKQQjiqL15
         WH9sZXMDLNRh4OvlA1rmcru0Sb9VC6mhyANuXln/UFwEksqQpOA3ghp1pzofQ9oeB5+1
         XsyCmqb39p9R75Av0zRS9hVo5hBQUie9bzgBBgJ3xeQze8HIsfHN9WbgXnmD2f+AWUmC
         pMGg==
X-Gm-Message-State: AOAM532aJnD0WxGKVby8KHIi5ujlC1cJuVlombqxKIAgrtnSTO4wB+mE
        lommM9LRyNzpaf6Dhais7tRuUfSyC00938u/VAau0aI8Zn5LD5v549PgQGoIBFwsUJAI3R9N6ly
        iHt3T3R4zfm+SZOYoHUyq10E98Xor6CyvvkMp0nlU5w383yTC/VgNWmXRmdHnH135W8WtIbF81U
        gJ
X-Google-Smtp-Source: ABdhPJxTfeZXc7LlvOTvwHYr0ep2K2b+JwhdI+NwnGtTHkRCKFrtxgzhfSsPOsQ3T1Yux012bHxNBx+Kenlw
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:55d6:: with SMTP id
 j205mr2584019ybb.395.1628857368582; Fri, 13 Aug 2021 05:22:48 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:38 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.53.I222c5f74a0e9d3c7c08c0682494150bdec037dd6@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 53/62] client: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Use "parent" to describe dbus hierarchy.
---

 client/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index c1a62edb7f..1e09fbbc73 100644
--- a/client/main.c
+++ b/client/main.c
@@ -363,19 +363,19 @@ static void print_uuids(GDBusProxy *proxy)
 	}
 }
 
-static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
+static gboolean device_is_child(GDBusProxy *device, GDBusProxy *parent)
 {
 	DBusMessageIter iter;
 	const char *adapter, *path;
 
-	if (!master)
+	if (!parent)
 		return FALSE;
 
 	if (g_dbus_proxy_get_property(device, "Adapter", &iter) == FALSE)
 		return FALSE;
 
 	dbus_message_iter_get_basic(&iter, &adapter);
-	path = g_dbus_proxy_get_path(master);
+	path = g_dbus_proxy_get_path(parent);
 
 	if (!strcmp(path, adapter))
 		return TRUE;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

