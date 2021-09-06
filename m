Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F7960F43
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Sep 2021 08:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240504AbhIFIGh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Sep 2021 04:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240430AbhIFIGg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Sep 2021 04:06:36 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F314C061575
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Sep 2021 01:05:32 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id s2-20020a17090a948200b001927a323769so4142916pjo.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Sep 2021 01:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xWhxgwRXpb1zqab3leVkvQYCgM4lU3zP1k6do4dy33A=;
        b=coARLSX8dSpOzHxtzYD4ZmVWAI41Kv7odh1uIq3WewpnzlEx9v8QmT0xO89lZBbM8Q
         1Ke42KVgY9ubRQqj2XoFCnIkH9+HrCIQncd2qjd6WVMqD5srEgOyReWMghf84invFEl2
         fpCaX7PCCaJqVaKRJuCIE7VUlHusMkxwRpbdORVFUent8giHqwwjHnzEtFvzOImQabyv
         qFz2JJ9e8EzMngfVxaWrVAt/6i5chF89J6X9yRw7rUaodDGipWVwyVfE1b4fCblqR6xm
         NJP60fz3SdG5fR/Gay78NzlTTsaMBItPmc1tmPTlwdAXtS5aiJYMiRqEVYcLOYqMfDy+
         pqxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xWhxgwRXpb1zqab3leVkvQYCgM4lU3zP1k6do4dy33A=;
        b=oUg8221JUoDGsC8RsfSCz+y896nqFBZIDOF6EY2iil/hO2063wcK9z7iR14gg/cLQZ
         6u1jlEepql0hWEJdDCDScKoaqnLVk0OD0OIsXsQbG7vlSmPK+z3jK3t6aMyPBWoMTR/R
         RFnfHM3g7OUAA9kNgnpa/+iFxr12o5shDbbPQJuWpcZ4dP95NhYTlCQfCmG+7Tt7SRCz
         wNxEl1j7bLq8bU1hG0BE1tQaLTmPqHORyGWVqatjTx7Vw6RHcP8qA+F66JQoJXCntBA1
         wQ3Ra2gWCxxuu1rAJ/Z2gA7KpG7COgPGdvcZmTlFfKr/gZU3v8ejVWmoC1PjmE+LjEOf
         z5Tg==
X-Gm-Message-State: AOAM533CiuQaX+2IhmLrYjwNrGq+REFzVERBchsSBAyv3M1FPRXL8hEm
        dWsBaHv4HDtkZ0GUjNTYoFXjzfk461Ra5SJjcN6jI7CUvOy+tiTcmOnKhmX8D4SYeH1gfgp193n
        KYJU6QV3Ktm78YvH7H3Yk4EXnmQ4fh1XohuLKRaBILRIunZ3uM+Pw4PeVeU4CN0dUZp1uqPuZGk
        st
X-Google-Smtp-Source: ABdhPJzEvBXycFnMtVBSbanMA0bc4rpAZzeAvgn2/7h+bwwUlQ2cWFLsZGVgJGV4uk20gXsv1Q4hNoDV6ENL
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:3b13:95ba:12e5:7134])
 (user=apusaka job=sendgmr) by 2002:a17:90b:ed7:: with SMTP id
 gz23mr860196pjb.1.1630915531550; Mon, 06 Sep 2021 01:05:31 -0700 (PDT)
Date:   Mon,  6 Sep 2021 16:04:47 +0800
In-Reply-To: <20210906080450.1771211-1-apusaka@google.com>
Message-Id: <20210906160340.Bluez.v4.9.I222c5f74a0e9d3c7c08c0682494150bdec037dd6@changeid>
Mime-Version: 1.0
References: <20210906080450.1771211-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [Bluez PATCH v4 09/12] client: Inclusive language changes
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
2.33.0.153.gba50c8fa24-goog

