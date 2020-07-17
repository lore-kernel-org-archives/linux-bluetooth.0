Return-Path: <SRS0=OLf3=A4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C902C433E5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 23:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5971020759
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jul 2020 23:14:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aoxHqdmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgGQXOP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgGQXOO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jul 2020 19:14:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4BC0619D2
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 16:14:14 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 1so6080802pfn.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2020 16:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nppnqGQdyrmLaloqOb/xJexNPUqspC/+yZWe6iO5RTQ=;
        b=aoxHqdmwYI7Z90ufEZxMQKhdT6c+XESjhWndlCQ/JSBs13ECudKa815QwXEjJNb0E5
         xG6En0nujGh8LVft4r2rK3FguSqE9GnKdLA8uB+ZzVT4YpfNnfvHIazuKjbWbJ/3j/qS
         4Cw91GVmnxYvtO/Kam1jsIn4f0IgJxHobjYnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nppnqGQdyrmLaloqOb/xJexNPUqspC/+yZWe6iO5RTQ=;
        b=cBC3Eo+TVuD+hR0aDgGRWBA2fdX6QAyu//RsO5XS5U+NDYSd9QBvpVrhzHjE90HBQ+
         Toa8dtDWgESKDrfwdMYufzZp97D0EPwsCJClSd6BLWkuqR5XaYyWiu+87enkVfINuw66
         NmniuzA9M3GOiQiypnkyKakUJN8NaT770IA4dNMOGtXviXOo7tkTS+LXU4jDyvwhbFL4
         /P8Sy7g2JuFlodnC6y0pGQ60cAh3dOxW4GVO9fGbMF4k08TY7Sh+/LIp569dRo1zkKZk
         xDDY7Or5kKUITtaxyOoMEGlh+gY7F3R7aqZwuucLRjPSJ7B/lJgUj6hatYgc/dbrVQ5J
         h3ZQ==
X-Gm-Message-State: AOAM531pc8t0MDLYTS+mlAlnx0edUDfoCiiXDDdcmv81pnw0KO23eByc
        DQ+h3dbKFHxad1Zy9HW0VK6WJ/7I0lY=
X-Google-Smtp-Source: ABdhPJy+6q9UdEAcO4FZHXj1i01vCDUktucECy54qdSNsqHF1xDvfZDGQZH3QCLU6tpWmPZrWXt5GA==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr9583406pfh.203.1595027653675;
        Fri, 17 Jul 2020 16:14:13 -0700 (PDT)
Received: from sonnysasaka-chrome.mtv.corp.google.com ([2620:15c:202:201:4a0f:cfff:fe66:e60c])
        by smtp.gmail.com with ESMTPSA id y7sm8194469pgk.93.2020.07.17.16.14.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jul 2020 16:14:13 -0700 (PDT)
From:   Sonny Sasaka <sonnysasaka@chromium.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Subject: [PATCH BlueZ] Add a presubmit configuration file for Chromium OS repo
Date:   Fri, 17 Jul 2020 16:14:04 -0700
Message-Id: <20200717231404.240644-1-sonnysasaka@chromium.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Chromium OS developers use gerrit and repo in their workflow.
(https://gerrit.googlesource.com/git-repo/). This configuration file
makes it easier when uploading patches to gerrit with the repo tool.

---
 PRESUBMIT.cfg | 8 ++++++++
 1 file changed, 8 insertions(+)
 create mode 100644 PRESUBMIT.cfg

diff --git a/PRESUBMIT.cfg b/PRESUBMIT.cfg
new file mode 100644
index 000000000..10f89b741
--- /dev/null
+++ b/PRESUBMIT.cfg
@@ -0,0 +1,8 @@
+# This is a configuration for Chromium OS repo pre-upload hooks.
+# repohooks doc: https://chromium.googlesource.com/chromiumos/repohooks/
+# Chromium OS BlueZ git repo: https://chromium.googlesource.com/chromiumos/third_party/bluez/
+
+[Hook Overrides]
+cros_license_check: false
+tab_check: false
+checkpatch_check: true
-- 
2.26.2

