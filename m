Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742AEC432BE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564B860EE6
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Sep 2021 04:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhIBEJW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Sep 2021 00:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhIBEJK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Sep 2021 00:09:10 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB28DC061575
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Sep 2021 21:08:12 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e3-20020ac80b030000b029028ac1c46c2aso460274qti.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Sep 2021 21:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1+Zx0XWf8h4j6Dg1qISGa1tBtRY84aMcPWTfznuCr8I=;
        b=CFybdlLMaD3DSOZt3wI3UWsu543pjdz/FklP0kz8+gkQ4usW8Dmh9jvIDy90WATqeW
         8Qis+oCO5cc5c18dqr3RvmWVaEwXCuNkHf/1c5mL2XlkRxyX3H3TSBmQnfLuMjKgCNOj
         QT9Jy4RuSOPCROdOJVQi5FVT/zVP/jorAWlm14QtSIMexefgIMHymN2T3EbKFu5AhwZB
         X9l0bFJvwHkO9O0DnTPDDb/Ts7szXh0SP0vRVD73qoaGTUZD4oYQ/KEq85z2kFxzY+gA
         RFXMbra2GsBbD4iVJ68WrzsHT6Q+25mzHMJiqnfAXi6upi2f2OLhxbckGqgoVfXGgz+6
         rEZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1+Zx0XWf8h4j6Dg1qISGa1tBtRY84aMcPWTfznuCr8I=;
        b=bZFrWuSbufhoKVnChoykQ1JQkWR6NcUF62XEE/5fqCN7ir5waME3rLeC9F2ptfjqJ8
         W6zXPC2gqMitkMD3QX79X3HjOtXyn2bqNAtUe7oRqq9MZfRwYlttWJNQhdaRA+sOzkTX
         afLjaZtMvAvZbJoskKBb9kyB/eBl9FqOCtnTNk1SWBuav+kUgFxoLLYUGIWbcC5dEAAw
         UDazXASCXDVGkB3wuenqw639LsQlq4dufjtl+bl7EeNcYEkIoQTaTQ6n14AEAnpGeyBk
         VWDiEiX9I/9H3/OLxrvoji2UEQapIQBZzANrUM7Ay6OmkqDmg1Gn+pLM6O+QxEsnggQI
         S6ig==
X-Gm-Message-State: AOAM532NXehDkWg4VyffJK8mUFlp3ohRfbEQjaD3azBPMpq6jvYwoiMq
        7q/jffVhoLbeZ7ryB2qJhOKrummcG4be69fXHalvlcTnyFe2XDDXo1r/CQTnRAYcOL798j/x25K
        c7Re3naYYQwEBsDpZwNhHtKCBXT3nrtQylHC4SEsW+gIuPAHtWE6BFNTPnKSN2wD1iv3Ww6iJEm
        PQ
X-Google-Smtp-Source: ABdhPJx0zTh54hKWzR+Nc/J/SPZy+64qlfd/gy1JXWeMuTae6L4A6vrC8vGuLXvgbNxJRYaGyBm30NHTWiD5
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5249:e81c:3ce6:f50c])
 (user=apusaka job=sendgmr) by 2002:a05:6214:21cc:: with SMTP id
 d12mr1071466qvh.22.1630555691967; Wed, 01 Sep 2021 21:08:11 -0700 (PDT)
Date:   Thu,  2 Sep 2021 12:07:07 +0800
In-Reply-To: <20210902040711.665952-1-apusaka@google.com>
Message-Id: <20210902120509.Bluez.v2.9.I222c5f74a0e9d3c7c08c0682494150bdec037dd6@changeid>
Mime-Version: 1.0
References: <20210902040711.665952-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [Bluez PATCH v2 09/13] client: Inclusive language changes
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

