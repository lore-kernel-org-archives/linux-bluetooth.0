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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322B7C432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BB4760F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240454AbhHMMV6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240455AbhHMMV5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA73AC0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:30 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p71-20020a25424a0000b029056092741626so8938086yba.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0K76jy7xQ+CS7QZZBof7U3SDrGmRBJr5J4axI2I3BAI=;
        b=fl8DyJyk7GlyyKUSW7ydxbKkBroi7M395JGxopCNqvarZt2/xbYsjmfBHAtXkaugrh
         NR1MkldtcfekzUOVEEGXdTh4cDO59zC+dpgCD387ZwSfS5YuGzhnSw+QZXje/AiVqu8Y
         JepU6vnQYQHrOAX7lJIl3Zd+Dcd5DuAF77tjgW9uDfS4bvP8AdGhNyl6L6R96p4uTJNA
         2XlB2be8YADSc9cffQuyJrPIEP3rV8M1XWOitv0V88UfGJ1EIR8H74QGbbuH/8z8s1uP
         cSE3CQLNoc7J+MCjZ0EVQBCEtdlmsv5D2PdGtrs1f27luAQORZQnbMTg0TWbceRjYZhM
         XKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0K76jy7xQ+CS7QZZBof7U3SDrGmRBJr5J4axI2I3BAI=;
        b=Oe7aMSHHVocqp7+bdW4upCE4bYGppdsOEtW5uca27A4GWOIme6Y3V1BMgVKv5apMgH
         5g7W6hCOGHFvkP016Rmkc4dnjjVMb279ndOBrxS5ceMK+1ZzR3kf7xcAr1J/ARCvGDbE
         NeV1DTcY8m1LNr23rRUvkA87hKECqV37NYFIvUKoFP72X1gfqWxj07eY/qCNmbCzEiW6
         am/E/QjvPNAaEHF21m5haeEYb3XdP2EyBgOxBj/RZLH2n076/t201O10yGKqdYUaiUFc
         J08uOklI+FVp5kulUY9cAZswsZIHe5l4uhinIOF6Jt2nM6jhTcW9gr6aU26NfHM9wT3r
         Qs7A==
X-Gm-Message-State: AOAM531v+z2LhLxhWiZ0WfgpVibSqjkHgdo1Y7mYWrHn+VPT0IatR0Xe
        P7W/b9Y7TBEOmh7PcpbfbQm9chypB+CRm40dqBVZoZ//H70ClPUyj8Xz1O/7NozfPP7qIBIRBlg
        jC+E8ERCB9xCFdDno5SAjwBr8Zcr0DG7BTiZ9rHkmyLct4j4GPEN5FXWb6S+NuyWgoT+PbFQ+na
        tB
X-Google-Smtp-Source: ABdhPJxIqJz9fXOR7gWpqbGEcSYlTppifXGvi9Crj2DUtwZrdmHwQw6C6nzv+cm5nNhcCwe3i4XniQp2ozxU
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:cf82:: with SMTP id
 f124mr2817024ybg.58.1628857290120; Fri, 13 Aug 2021 05:21:30 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:16 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.31.Ib8aef56c04854b18342a791302d3460a40fff3e2@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 31/62] tools/meshctl: Inclusive language changes
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

Use "parent" to describe the hierarchy.
---

 tools/meshctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/meshctl.c b/tools/meshctl.c
index 9d7df2ccdc..18e20c40d2 100644
--- a/tools/meshctl.c
+++ b/tools/meshctl.c
@@ -541,19 +541,19 @@ static void print_uuids(GDBusProxy *proxy)
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

