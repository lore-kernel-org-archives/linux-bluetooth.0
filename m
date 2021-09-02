Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2246CC4320E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD7761054
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 10:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343726AbhIBKwR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242540AbhIBKv6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 06:51:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B16A9C0617A8
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Sep 2021 03:50:27 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id o22-20020ac872d60000b029029817302575so994483qtp.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Sep 2021 03:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1+Zx0XWf8h4j6Dg1qISGa1tBtRY84aMcPWTfznuCr8I=;
        b=EpN0Erpv7RkWl+clNb+nneQacEtuwqhGoPqRHZame5Q/KfRPJnrDD66Anad9SVnXYU
         TOFrvMv8DeW3L+NwBapUOACUUiJIPwkaLuWKYlMU0KjtKlfdBXkzTrVyMf8Dn/jTdCRY
         6Vv/Ym+Cu+8YlV+gjvj/BI+hUC0913JX0buwiXf8qyhzblS+o6/PXSDkgUDz0AZjdms2
         mAzl1tIumT2dDhYOdpAOM0+BviDrcPYmA7AIX1w6WmfYz7Rm6fVbUZpLslL6SvgDXXjf
         P1xvp68qFz5oJ0PPk0DZuO5U+YccHbpAyFv8Mv1hRlWuMw4yEDZoAwkoVT9yxUOcIcYA
         tRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1+Zx0XWf8h4j6Dg1qISGa1tBtRY84aMcPWTfznuCr8I=;
        b=eGR26nNVz5G+UeakSe4DJN3Lgmg4qWYNONnU4FWnNT+4ayB1Z462NCqWTZpVxMGSr3
         0fuCq4Mvnp+44m1ssc7iuR+g1+HOjX7Cc3MwHTTuzXEKUjf8c8BJrzAujMNjVmCcnVTV
         fO1nDf6HUySuxxBV6Q7aviF74WDgflr8iXjPim6ai25KLJtOQSWHpeNRxxZLW68oM460
         yK4ulkrP3XVm6QUYQwapTL8LhQYSyHPKXHIJxZg5HAQlovjj3+QxYsqWPGv+Pjm21uSi
         9+0VBNiRcfRlTJLpcj4JbhC411ha5I7Sw82UnU6JFsL1pWMyUdnLnIgyHkpO1E6fzXct
         EsxQ==
X-Gm-Message-State: AOAM533K6/XmS0ag8uAnQg8feU6iPrLQuTDCOq5c39d2/SNgMmn+aspk
        TfjF9FNuegphNeXN2HcDcQmFgmSfJElOvwVfIVS66dRaybdqp6rZ88I+lbeq0tzIkExAoJa58+d
        sH6j2rS6VoORcETxr9zyQNK1jAeaFEhuB4GLMlrgOaiIGglm0UZ5DRKD4zFYAY+vkp6rC58zCy5
        7K
X-Google-Smtp-Source: ABdhPJx9lNNfGhPQAVf10dSphPfw5HN4+rMN34LVIKL9QlSwB8cqIjY1zaXjNnAIPV3xGPbDNKL5jv5Tz/O/
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:10eb:: with SMTP id
 q11mr2495008qvt.7.1630579826897; Thu, 02 Sep 2021 03:50:26 -0700 (PDT)
Date:   Thu,  2 Sep 2021 18:49:35 +0800
In-Reply-To: <20210902104938.824737-1-apusaka@google.com>
Message-Id: <20210902184744.Bluez.v3.9.I222c5f74a0e9d3c7c08c0682494150bdec037dd6@changeid>
Mime-Version: 1.0
References: <20210902104938.824737-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v3 09/12] client: Inclusive language changes
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

(no changes since v1)

 client/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/client/main.c b/client/main.c
index 506602bbdb..b70cf1a186 100644
--- a/client/main.c
+++ b/client/main.c
@@ -365,19 +365,19 @@ static void print_uuids(GDBusProxy *proxy)
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
2.33.0.259.gc128427fd7-goog

