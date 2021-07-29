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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4289AC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A95A60ED4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbhG2M2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236976AbhG2M2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:28:34 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA16EC061765
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:30 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id u22-20020ae9c0160000b02903b488f9d348so3702377qkk.20
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jul 2021 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=AyXyOWfBN7ZM6tBAQpok+eKjmCT++RGqnUTSOzcKp5APcOjqxsoiZVp9QDlW4O6/ne
         2WderqJU2PEEra8xg9gpYCfg58OWldSofqLqh7rOUsnji7HZ6B3T5f3G4OWB8MwTy+Pk
         Im5c3/hV69W9/e2IGIda89KsX3rMUJrVwroK40y3hcxNqnHFb0YZJ/rgF9lrJAQN+ftq
         XvMSrN+N9GJQFu7quBHy+HUWThgAjrgteonZuvO1Y2LSgNVhBlLaLZ7/cyfSoX+dDf2R
         o4Y5e8Kms+3zxkd6kVlk2es1KgQTjUh2wtfHuuA4UjNU3F8uJlSW3K5bZROeqngqIvRf
         Jlqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=h1Vg8Ymvp54dAt1XipTSMtUgKi8KREJ6wTzkEQwcW032A3XWo631vULKm3H1WpDgN5
         okBdgbFsaNYPB/CSq/jEmYGAw7J6FIE00teTPuiZ7shnBxBMTuUUzXVQgoAQYkKX137g
         Ispuio29YHDCFLvtMfrBmYwYw4UwswtMG3IBu60SCPCIAXSRCUCOHSlMsgK1CdbgrN35
         xl7JgTK6dCfomAMwfbh+muZTmRHdQtlDCRmBXBRInht0thek4y16xzAVmWERzInZ2y0S
         XE7j0diIFqROIKdTIm1nb98prqmYwp0Ppt7d4C3AhAgcVTuQo4kX4CUOnB6zgFqtM0+R
         t0Hw==
X-Gm-Message-State: AOAM531btjeIsaDVcVhtlHJUAu24jFgjv5uGcZxsJJ6KruE5PA4fo2CK
        2JNDeG5qmIfS0niUt57FTb1dFP0jB9nsf0vvqTaEB5i3dZsuCaN7jHnsK6OVrCd5BPI0tXcHA8Q
        +oS28EH7h7WJTr3xM33EpZ4iYEDuXH+gafgjofGrluoqPcjPLSJ1RHlkMFx81IUfWS+N09+oQnK
        ddfRZqU0cAROk=
X-Google-Smtp-Source: ABdhPJzpoGwaknHTjMZC7T9pwoZVi/YqD3mOEQ56jfwe60QQD5fNaEDLNOjJ9RjiHkVHx+LrDBKNi/0e80uRkdqnRw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a0c:fbd1:: with SMTP id
 n17mr5013725qvp.19.1627561710030; Thu, 29 Jul 2021 05:28:30 -0700 (PDT)
Date:   Thu, 29 Jul 2021 20:27:44 +0800
In-Reply-To: <20210729122751.3728885-1-howardchung@google.com>
Message-Id: <20210729202648.Bluez.v6.6.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210729122751.3728885-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v6 06/13] plugins: new plugin
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

