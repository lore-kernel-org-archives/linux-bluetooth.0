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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9375C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD290610CF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240142AbhHMMUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbhHMMUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:20:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCCBC061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:47 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id z8-20020a0ce9880000b02903528f1b338aso6901317qvn.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=1284gNRf72shSVowIWjGd7MUKlqYd7rRcUK80E8MgEs=;
        b=VOwWQzqe27QBHosB3XKzfsRu7J1BcpBir2vLkwPrjI4C7sxeNT7DvWOOQAdvUT+1D4
         qhLPCMfhs9vcLxjO2bP/9/C3VEJgyELJaWLTFLZrHSJlrRtBSqS4ofNL0uqS1sAX9/OG
         HaX2dAXRnbLSfQx7EO++wk9qGWjKajWJpaU3KIY9Y4tp/I7c6ZE2ErqG3cfOUi+WkQqg
         JONPpJmLde6xe0C6W52nO9rl0FOl/SGpU2YjN+OW0awC9sIYOdqUwdaOglKfKF2Llytm
         5nqeob43qlbci+Bcufek/2BpDsmpK6k5/AIiu6IeUbBnvDIeoX7LzPXgr2mDeqg63AoX
         yv8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=1284gNRf72shSVowIWjGd7MUKlqYd7rRcUK80E8MgEs=;
        b=QAX3NxeIrRYXh12QIYw+aGnTLu1Ic3Po020cBM1ufdWJHgub+ACeeuJbKDhYLf/6pq
         YYCkOpmimkeAkDJKpGT3fJupKGecKnnJBqJdXl4lY4sSnTQkwbayfoWJcAmFbw+Fk6GN
         P/T2qKsuaii+Cs6MYdYxXMAVmeILYP8R2KEDF5EiCl9Hw78VjVLgnVafPkUT8B4qEFRJ
         qQ6SOyDhm41SbZD9t3U0hn26UM7PhFCXRfma69haQbv5vdKsXHp9l1js/4+L8ucZowJP
         qgVgqdbt9xypDua1lTGFcACmbOIiYYJqnB1CXFNu5egO/3UXDpuiklCKw3m9tOlD5iGF
         so7A==
X-Gm-Message-State: AOAM533eycT5U/bkPgI8Gule/72nriodsQtLukN5rzLewEFFlRRN7tJN
        F48r6svlMD0V4YXd0xYQ5H2h6nyOoUHi7B5v5wPscSxWrg4WdHSGlJAMDIa6d97UDZ15xhwr/yD
        EMjQpisgOjd7gLZm3P+3ZG0RSkurJvPL6FYmOXKnHbHEQJznApVxDph5G3KaVv/4T9h0WAdjZzt
        4O
X-Google-Smtp-Source: ABdhPJzkpoGzvix84A4kADVXRXQdVotDpsgSXvsC/WoD6R3iouWr8sWRSxSYRJ41sSyLaoIcbQLTCEW4NDFc
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:ad4:4c4b:: with SMTP id
 cs11mr2202308qvb.56.1628857186715; Fri, 13 Aug 2021 05:19:46 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:17:48 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.3.I700d72f935b48346f2e74088152eeef41dc5b938@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 03/62] tools/hciconfig: Inclusive language update
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

Update the docs to reflect the changes in lib/hci.c
---

 tools/hciconfig.rst | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/hciconfig.rst b/tools/hciconfig.rst
index 7d59b4046e..6141fc2be7 100644
--- a/tools/hciconfig.rst
+++ b/tools/hciconfig.rst
@@ -216,16 +216,16 @@ revision
     Display revision information.
 
 lm [*mode*]
-    With no *mode*, prints link mode. **MASTER** or **SLAVE** mean,
-    respectively, to ask to become master or to remain slave when a connection
-    request comes in. The additional keyword **ACCEPT** means that baseband
-    connections will be accepted even if there are no listening *AF_BLUETOOTH*
-    sockets. *mode* is **NONE** or a comma-separated list of keywords, where
-    possible keywords are **MASTER** and **ACCEPT**. **NONE** sets link policy
-    to the default behaviour of remaining slave and not accepting baseband
-    connections when there are no listening *AF_BLUETOOTH* sockets.  If
-    **MASTER** is  present, the device will ask to become master if a
-    connection request comes in. If **ACCEPT** is present, the device will
+    With no *mode*, prints link mode. **CENTRAL** or **PERIPHERAL** mean,
+    respectively, to ask to become central or to remain peripheral when a
+    connection request comes in. The additional keyword **ACCEPT** means that
+    baseband connections will be accepted even if there are no listening
+    *AF_BLUETOOTH* sockets. *mode* is **NONE** or a comma-separated list of
+    keywords, where possible keywords are **CENTRAL** and **ACCEPT**. **NONE**
+    sets link policy to the default behaviour of remaining peripheral and not
+    accepting baseband connections when there are no listening *AF_BLUETOOTH*
+    sockets.  If **CENTRAL** is  present, the device will ask to become central
+    if a connection request comes in. If **ACCEPT** is present, the device will
     accept baseband connections even when there are no listening *AF_BLUETOOTH*
     sockets.
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

