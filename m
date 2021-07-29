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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389F8C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B41460F23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 08:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235297AbhG2I5d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 04:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbhG2I5c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 04:57:32 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB641C061757
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:28 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id o5-20020a2581050000b029055ab4873f4cso6052054ybk.22
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=BgMhzD3RjVUi9qqY9wsPDmqr2KGXDKN/FBLAYrHuQS1fTjxz0PldaXiAhvQs0Ah+7J
         ciY1EUMKNkExaIorB7T77Q0fMphBWeMxrrNY8GMWIrx4lRjKih0Ub9GNO6rFq4UvYv8N
         r+M/AKKtOE9qZxZkel4H7gdJcYVVRPRLfq32/B0SAfO4wyqzGAYb25tYpYZVPGJtsZmd
         cqwwmTo337R5IBOXvNgDfLnAhxOCkFdSMVtP5n8GlFYFlJQFiaJXpR0vfTgITgzHA3ce
         jocd9s7KijhqpmsbrTe2gWEIrwAmwwBTqnbZVe3Jc60/+e1zPcTz62kVOGvF+gr3VmYu
         p+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=NdOyEuOMvLYBuIYwMXa6zYWDcJbfQRwbM6XHWykeI7mCu2c8k6LN5FR0s0/mb1R3K6
         l+Kowf3hdi2gyFJqOhIczBFooFLfQaaLLqN/DIGXKj17oZMd1gLidz1jJHHyDKhjptWA
         y/p+IqhUAfScSJ1WuqjFyRgaQz83BldGemheF8zN/rFGIemaijTcMsRG4ZXdO/x8DCZI
         qjH4dsmylIxkjR8v3GQmtRb3AOUv2vYGioe1kTmmgGh12FmU5WQ+AUa13lWFi7e8dO+t
         il31rI1I8XH04H7h88P0n81p7NNSx1wcrxqS5ab6yjSQqVTLq7QUttZYxDp0PEIwsbRd
         WAoA==
X-Gm-Message-State: AOAM53362h6zF+nnxNxxhV02CjsKV73kKYHhzwrIW5I1ZxB0I1ovdjnu
        pvdGF2k3PPnsr95o5uGfnposfFmOBVAB8oZ52MX5aq0t9MwNz4IlzwfTL6sj2drdWGkI6mAX9BF
        6oTVbWg0rdMslhiFkGFYweIyMLc824hM4/bqNsuQt1QkI4LQkw2t406KVsRDQMrzh0+m43cren3
        S7XnJE86FGjrY=
X-Google-Smtp-Source: ABdhPJz9D80rLYRqYLI0etwvWu3s/IomArSdR512DyygbipwaWmK0m1YxC3I/QRf/JEXWO1WqSsBNvw0OLhh8lFFHg==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a25:2008:: with SMTP id
 g8mr4995955ybg.502.1627549048046; Thu, 29 Jul 2021 01:57:28 -0700 (PDT)
Date:   Thu, 29 Jul 2021 16:56:44 +0800
In-Reply-To: <20210729085651.3600926-1-howardchung@google.com>
Message-Id: <20210729165211.Bluez.v5.6.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210729085651.3600926-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v5 06/13] plugins: new plugin
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds an initial code for a new plugin admin.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

(no changes since v1)

 Makefile.plugins    |  5 +++++
 bootstrap-configure |  1 +
 configure.ac        |  4 ++++
 plugins/admin.c     | 30 ++++++++++++++++++++++++++++++
 4 files changed, 40 insertions(+)
 create mode 100644 plugins/admin.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 4e6a72b0bdf6..69fb01001cc6 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -11,6 +11,11 @@ builtin_sources += plugins/autopair.c
 builtin_modules += policy
 builtin_sources += plugins/policy.c
 
+if ADMIN
+builtin_modules += admin
+builtin_sources += plugins/admin.c
+endif
+
 if NFC
 builtin_modules += neard
 builtin_sources += plugins/neard.c
diff --git a/bootstrap-configure b/bootstrap-configure
index 0efd83abc2c4..a34be832068e 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -30,4 +30,5 @@ fi
 		--enable-pie \
 		--enable-cups \
 		--enable-library \
+		--enable-admin \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index a5afaea6cfcd..0744860b89fb 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,6 +364,10 @@ AC_ARG_ENABLE(logger, AC_HELP_STRING([--enable-logger],
 		[enable HCI logger service]), [enable_logger=${enableval}])
 AM_CONDITIONAL(LOGGER, test "${enable_logger}" = "yes")
 
+AC_ARG_ENABLE(admin, AC_HELP_STRING([--enable-admin],
+		[enable admin policy plugin]), [enable_admin=${enableval}])
+AM_CONDITIONAL(ADMIN, test "${enable_admin}" = "yes")
+
 if (test "${prefix}" = "NONE"); then
 	dnl no prefix and no localstatedir, so default to /var
 	if (test "$localstatedir" = '${prefix}/var'); then
diff --git a/plugins/admin.c b/plugins/admin.c
new file mode 100644
index 000000000000..42866bcf7be2
--- /dev/null
+++ b/plugins/admin.c
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
+static int admin_init(void)
+{
+	DBG("");
+}
+
+static void admin_exit(void)
+{
+	DBG("");
+}
+
+BLUETOOTH_PLUGIN_DEFINE(admin, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			admin_init, admin_exit)
-- 
2.32.0.554.ge1b32706d8-goog

