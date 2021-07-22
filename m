Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2285EC63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071C561283
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Jul 2021 07:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhGVGnG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Jul 2021 02:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbhGVGnF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Jul 2021 02:43:05 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95487C0613C1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:41 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id o11-20020a17090ad24bb02901760a3c63a2so3602139pjw.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jul 2021 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uAuWqyGgj1zVGvHP8Y5rWTY+zIrloT+cRDb63+cvFrs=;
        b=FL/FvIG7C7UH9b0dUiWeUXfCTFN7637EFmP3O7PF8HiXMPO2eIyHt+HBGL8r1ZzAtZ
         nnzf5T8MKnHpPe/pnRkcVbhcXdRONk6dEf341w9sqnIG/TZCg0KaQ7o8yelbGaDJvYu3
         riUherl24x2pKZ6T/b0YHu/ATLo+eRXTxvnq8zHrd1rerPzy7LABB0uDWLU+jO2mt7k4
         nQx8/yt7HPq3ZrnwJwtB7hmfnPsgKYPUDeNUAToY3JSbnJXq0KnokO2IWMPFqOFc3kiv
         pigWv+W2AVwtxWCAZl3/2RQoYvzJiNxuVTQ6uZgotJ7R7tF09IsCSUdp9nvTleAGMq9c
         K16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uAuWqyGgj1zVGvHP8Y5rWTY+zIrloT+cRDb63+cvFrs=;
        b=iH03WxjecWl8KfymK5y3AYtl2Cz3y1ajF9jnleAbw8NER/MShj1xIfJisLyGmJLylg
         V9WMMvZzMytgnW4VupEHb/37qoikXyj5SPZK8MVngoswj8gM1z+D7TsMCEshuIJOjkfK
         gxAxzUXjXVbJs+kcwfsL/XJEY3FwAZnZDWkcps4ILMVMglnamlpn7j5C/BxDP27IT+vx
         qKFhG13BuRQukutKS81Rv2k21NQL+mJN+xhAF5xbCZ2LPeGX8vYyuS//kLpp2kUE1kgA
         7Z/Ik6mKIv+I/RWvoztPxvuPytqSgOiSsvhv32xVo7pBjck7BuOA6or07V/SNEbT+Y5m
         /uFw==
X-Gm-Message-State: AOAM532v0kVdeiaWRBeJZdTaRv9pJSdUCnM67jt+VGt2JuQReHbS8AJg
        kcNLO+QLd6NKZqu8CthLFcdumbagam1wtvQ72PyiuayaePFKr+z2WguhBmt1CC9HT4l+2Dp3YvU
        P4VkEjTuqcvWjsUQJ8UC8HC/7aLaUC+NovM2NEqQTVdtv3KO0R6CFOL2Exy4Gg9W0ivISSl8unr
        9NXhsu+38fiwg=
X-Google-Smtp-Source: ABdhPJzrUG91fWSfP1QTV0iPWnzStDGcneTIyszycf70nYT07CZKhYTN45Gs3R9RN+2jiTjVH2S9CW0rgJ58O4DkMQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:69a3:595f:8267:f7e0])
 (user=howardchung job=sendgmr) by 2002:a17:902:f282:b029:12b:2b93:fbdd with
 SMTP id k2-20020a170902f282b029012b2b93fbddmr30877071plc.35.1626938620898;
 Thu, 22 Jul 2021 00:23:40 -0700 (PDT)
Date:   Thu, 22 Jul 2021 15:23:14 +0800
In-Reply-To: <20210722072321.1225119-1-howardchung@google.com>
Message-Id: <20210722152159.Bluez.v2.4.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210722072321.1225119-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.402.g57bb445576-goog
Subject: [Bluez PATCH v2 04/11] plugins: new plugin
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds an initial code for a new plugin admin_policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 Makefile.plugins       |  5 +++++
 bootstrap-configure    |  1 +
 configure.ac           |  4 ++++
 plugins/admin_policy.c | 30 ++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 plugins/admin_policy.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 4e6a72b0bdf6..b6be0e0d559d 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -11,6 +11,11 @@ builtin_sources += plugins/autopair.c
 builtin_modules += policy
 builtin_sources += plugins/policy.c
 
+if ADMIN_POLICY
+builtin_modules += admin_policy
+builtin_sources += plugins/admin_policy.c
+endif
+
 if NFC
 builtin_modules += neard
 builtin_sources += plugins/neard.c
diff --git a/bootstrap-configure b/bootstrap-configure
index 0efd83abc2c4..89c0747b0256 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -30,4 +30,5 @@ fi
 		--enable-pie \
 		--enable-cups \
 		--enable-library \
+		--enable-admin_policy \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index be32782a641d..53ed8911f95c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,6 +364,10 @@ AC_ARG_ENABLE(logger, AC_HELP_STRING([--enable-logger],
 		[enable HCI logger service]), [enable_logger=${enableval}])
 AM_CONDITIONAL(LOGGER, test "${enable_logger}" = "yes")
 
+AC_ARG_ENABLE(admin_policy, AC_HELP_STRING([--enable-admin_policy],
+		[enable admin policy plugin]), [enable_admin_policy=${enableval}])
+AM_CONDITIONAL(ADMIN_POLICY, test "${enable_admin_policy}" = "yes")
+
 if (test "${prefix}" = "NONE"); then
 	dnl no prefix and no localstatedir, so default to /var
 	if (test "$localstatedir" = '${prefix}/var'); then
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
new file mode 100644
index 000000000000..dd8d8973636f
--- /dev/null
+++ b/plugins/admin_policy.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2021 Google LLC
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "src/log.h"
+#include "src/plugin.h"
+
+static int admin_policy_init(void)
+{
+	DBG("");
+}
+
+static void admin_policy_exit(void)
+{
+	DBG("");
+}
+
+BLUETOOTH_PLUGIN_DEFINE(admin_policy, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			admin_policy_init, admin_policy_exit)
-- 
2.32.0.402.g57bb445576-goog

