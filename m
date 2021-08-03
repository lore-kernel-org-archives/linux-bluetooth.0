Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BABC4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF85060EFF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 08:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234423AbhHCIYC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 04:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234469AbhHCIYC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 04:24:02 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747E1C06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 01:23:51 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id t191-20020a37aac80000b02903b9402486c5so16118560qke.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IspAzGAMuGHmQUhDBsbcIwOoqtAeGv0Fzajl8rOsFOg=;
        b=GdQMmOAxF0J6ek9RjsAE9MDaki+x9Z3zUrcK0Di+obQRHKN5TPsPVz+Mi0hAAJjFuU
         U9rW5ZF2/4DUwzdmchPKqQ/MDgfBcNeNBdB02OIwpwaI5+R/r9YLq8JcE6IvpVVJROEP
         ThWaF/TsYxB2FlEf5NYEGKWnf4VJA1A7TLZkRx8OswMwk8mJv8DSACorafHuVjLk4Tn+
         O//oEKIM/SSshpj0MJCP45eY0V+ZEcQFNiL2oCgquvIAhEILePXlSAVSHmF9e6Uq2pog
         pvs+lkd28gDxH9xErMz0i9TdtTRtouqb4EkR8If0p8byfLs0jT3P5Cmv0iLvFWoDgsZP
         DV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IspAzGAMuGHmQUhDBsbcIwOoqtAeGv0Fzajl8rOsFOg=;
        b=jZ5Bku/oj6blc0yJLRiZZCFTNF0lp3JJ9FNkjf/dNobn+btZ8yJt9U5rCrr7tmuOSd
         pvPEyJLJozNSPIcOGkvDVejNXVoJua6XqgtayCuOjg7aIr8gknLaADTatmMV6QOlPyfx
         OJQjuFP6XrfuxScYva+0L3AdAlfYS6jJZgmUZH14qaZZX7wjcRe9wYkTyhDYstzRI4nn
         qDBaLx1a/3x6XFJJciW4monnoOqRwoQo8r23XuStnTWZ86L4ZSBmWRY+TEB/yM8bR1YN
         gcOtO6sOZCxYU6tZ8mwFHlHW9XSQS4PoX/GFUSAbjGYiAkvbFB54B58GPouGknMe/+83
         tJFA==
X-Gm-Message-State: AOAM531Vn8Q4NoE+R3O6ohP84FEyxh1jZzPdiFvsbCp8yCqFlhGYe/vf
        VpY/xzku6GhJIrhVPECtUFHPVUwjItD7dzSqtl7qSmQRIwIr72gzel3diGnWha9pQFhj3NAL2Jf
        tCWP3643jXXky51KqGqftJvYhGk+L4B9o7qHXZ1QzpZbsZTtoRNg92rj7Jdi4o21Rft65cv/Jf+
        TAiHSdd20bRw4=
X-Google-Smtp-Source: ABdhPJx/2/B4d6cDTLcuDoyk6mTRBT6RdWkLUWnAG/MMTw53Qn/8U2tGCgdDv04/6qVVuQwBkYUkUqkY3w0REyUvEA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a05:6214:1d0a:: with SMTP id
 e10mr5607028qvd.15.1627979030541; Tue, 03 Aug 2021 01:23:50 -0700 (PDT)
Date:   Tue,  3 Aug 2021 16:22:37 +0800
In-Reply-To: <20210803082237.723766-1-howardchung@google.com>
Message-Id: <20210803161319.Bluez.v8.13.Ide727bc4654c80ce67a268b624a6c5a0f79a11e1@changeid>
Mime-Version: 1.0
References: <20210803082237.723766-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v8 13/13] doc: add admin policy file storage description
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds storage description of admin policy file in
doc/settings-storage.txt

---

(no changes since v1)

 doc/settings-storage.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index d21150f09ecb..1d96cd66d94f 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -36,6 +36,7 @@ root, named based on the address, which contains:
 
  - a settings file for the local adapter
  - an attributes file containing attributes of supported LE services
+ - an admin policy file containing current values of admin policies
  - a cache directory containing:
     - one file per device, named by remote device address, which contains
     device name
@@ -50,6 +51,7 @@ So the directory structure is:
     /var/lib/bluetooth/<adapter address>/
         ./settings
         ./attributes
+	./admin_policy_settings
         ./cache/
             ./<remote device address>
             ./<remote device address>
@@ -140,6 +142,24 @@ Sample:
   Value=4578616D706C6520446576696365
 
 
+Admin Policy file format
+======================
+
+The admin policy file stores the current value of each admin policy.
+
+[General] group contains:
+
+  ServiceAllowlist	List of		List of service UUID allowed by
+			strings		adapter in 128-bits format, separated
+					by ','. Default is empty.
+
+Sample:
+  [General]
+  ServiceAllowlist=
+
+
+
+
 CCC file format
 ======================
 
-- 
2.32.0.554.ge1b32706d8-goog

