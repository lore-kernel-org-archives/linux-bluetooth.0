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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31ABC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EACF60F46
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240491AbhHMMWT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240484AbhHMMWS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A48C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id p71-20020a25424a0000b029056092741626so8938781yba.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=hFED6TuRM/+XzE0+YqmrR4+hybFYu52VwoImVB7t2Hk=;
        b=Z6J4MlO8B4XvbLeczjE1DOy4BsvEI+Y3uVws6EKU0FDoZ7LBW70cjbLFqFKZAC6+xw
         RBpFS1nQglv8MGUdD19WfY7sdfK0zcJuyScBq8aXrG+jHIIhSwMBOYOPZ6XIJ9jwllmo
         v8oWBQoADBAktgQTcoIOBqgEZSI/NN+9re5tqaDsewIBUTrrsX1b6Vxzf+vKszNBNvw6
         SaQKdJFiJH/KqxaQl8v6tlzwbfRvjhKDtHVwoeJ+WFF19MhUKJJiWAFgDYOCWOO46x+8
         gCt5Ue6y9xlE6D5BQ/XUdUv6JcfmWhai0C6RkhCNeGvayrFAuA4uAL990dsPXx5tWCLc
         m3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=hFED6TuRM/+XzE0+YqmrR4+hybFYu52VwoImVB7t2Hk=;
        b=ktFJ+CpjS8lcoW931oLWm89zkB5e2zU1Gw5VfraWHtLfgO6wnQ8nk9rTKKARRKKj+M
         2yGd0q6yCnmWMOU3aSTDmmHHZ1FbCmdohHQKrA6Mbt2MCnw0Uv0DQWnyf0VHDiOQ7PAL
         q8A8jGj0DrY4Z44+u3by0JYE8cpaCq2CKpF67VBxjFZW78K6X3L9A4ODCkRizlLbzIBW
         unCnXcQhfe5zNl9+42q+fMvM9ro+K4U8tPA7d6xdygz4EVDa60NNc6hM7BGrGlxk/9Ql
         QHyXa7W3NbEE2cmgf0YOZ0Y+JSGi7wBs3VgHEY5ntRr8AEx6eK7uqDVv8CWPe4FsrGe1
         RNhQ==
X-Gm-Message-State: AOAM533CK77RmS/N0/3VjXJc5I035WRB0CGoELO6V5GY7b2exzp6W10R
        RnasegC8kOxXgSC3SP1KrlKbQBC8oHzmQ9pwIWbKDHVFOJWMREox5IQj7MFRdd9e0Gu7b7Wc9k/
        +Aw7etw4gfhEwEc9f1DWxnrlmuxOjD8eBCU9Ua6JXrVppH7k04tD1o0CWtQ2Tfm9pemvoUwWXf7
        84
X-Google-Smtp-Source: ABdhPJyDVDcwZB3LppmjZIoD36gqaSkyyfks+AKk3B/cmQJ9A0h1/xqC+XbMYG2pqV3qdYpZAO6fSkOMIR80
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a5b:7c4:: with SMTP id t4mr2556051ybq.368.1628857311337;
 Fri, 13 Aug 2021 05:21:51 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:22 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.37.I4b5bd03960384e2f0fab99057924e5dd409e53d4@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 37/62] tools/btpclientctl: Inclusive language changes
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

"peripheral" is preferred, as reflected in the BT core spec 5.3.
---

 tools/btpclientctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btpclientctl.c b/tools/btpclientctl.c
index 6553f2f3a7..c30d5bd4e7 100644
--- a/tools/btpclientctl.c
+++ b/tools/btpclientctl.c
@@ -676,7 +676,7 @@ const struct indexstr_data ad_type_table[] = {
 	{ 0x10, "BT_AD_DEVICE_ID" },
 	{ 0x10, "BT_AD_SMP_TK" },
 	{ 0x11, "BT_AD_SMP_OOB_FLAGS" },
-	{ 0x12, "BT_AD_SLAVE_CONN_INTERVAL" },
+	{ 0x12, "BT_AD_PERIPHERAL_CONN_INTERVAL" },
 	{ 0x14, "BT_AD_SOLICIT16" },
 	{ 0x15, "BT_AD_SOLICIT128" },
 	{ 0x16, "BT_AD_SERVICE_DATA16" },
-- 
2.33.0.rc1.237.g0d66db33f3-goog

