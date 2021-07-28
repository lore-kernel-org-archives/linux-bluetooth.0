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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058A8C432BE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4F4D60295
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 13:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhG1NQO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 09:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbhG1NQM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 09:16:12 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041BCC061765
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d69-20020a25e6480000b02904f4a117bd74so2764351ybh.17
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sSwyhyBbbT8FDD76nL3HeaEtb8Ol8lNd71HJ8NDZ5UI=;
        b=iYNlkWgUbVDMvemLAN8D/WiY7VusExFjMjlsCqF5UJtAyB3HpKWGTl+G5Hu8xdcBEy
         7S2I8Fyy5FEumkLrMC8ouFMa4NADLtqwoSfCpnSRJ2zTb5x0GOA0efCCuKlfimanWnHc
         ADzLc2VsOIDnqvQ9OxS6w8j6wteXxl9W6ohyzUFyj4aF64zq0rWhhkYapDVJujwOek2m
         pcDZv1YZp6l77SHg7RQxY9b/x2ZGwr726pTgVelB4ULVRLOHwkr45aK4a8AYWwF7H3hl
         kwvwGDtemS9039/2/2vqRaHhnftxp34kxqybqIfvfs1IreGNi5WCWRhA7y5Hu8DwZKmH
         mQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sSwyhyBbbT8FDD76nL3HeaEtb8Ol8lNd71HJ8NDZ5UI=;
        b=Ay2OTxsbDk0gqETP/LEUFcoCTEOoPlpsq5FG9yiNmxYLtfUQgABgKAxzv8wr5VlR/9
         l+/30bZcdoqpwvfH1EB4fpDKmIdAlsDtq5xqYxNcoLNlAC4sCRQIEaR6D7AdUkeqJfKD
         kwXf/rcsTC7Xt6xuQ4CXjVhQhOfMor7wUEYN6kOWDa/ULkwsHwuNox9cfvDdIFA2TYcM
         1h5wh+naKBP1/d8xsFw8Ob/A6HeyGhLFqWYrayWpFYwxVr00095AENTUjlZu8XsjMoJg
         B9LAng7kjeKjvMmQlCdKMxGDItkFuA2cnsIUlwnBpt0ug01/l2uxDG72cSdwyAynRmGh
         Zo5g==
X-Gm-Message-State: AOAM532JthJDszQkYryC8Fm9pwYOy0qO9qOSm5U8+N2GgKOM57UyHPSQ
        WlwXJlSlHS22Ftmm2YHN0CIaiJNBnYjM29IIJVhtepriGnFdT3mk93Oxbki3yMXnRQzfNSISlHh
        UYvdk623DOPyYGwKQpgb630OcU1QACrzuzqWnnohC9W2w01bNlwCemW6dRXdVDx91edV3jzJRsk
        3xRGJdU0QkySU=
X-Google-Smtp-Source: ABdhPJxjDEQfyxX1eXDM2OUB5O1Z6kIq+OSHjh0JcXwfp8mb6AZGS6ut0aJiwPfOXwm6//uoblRjeU7/Mi/f4wiX6g==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9b6a:9d1f:2f3e:45de])
 (user=howardchung job=sendgmr) by 2002:a25:28a:: with SMTP id
 132mr38752095ybc.458.1627478170184; Wed, 28 Jul 2021 06:16:10 -0700 (PDT)
Date:   Wed, 28 Jul 2021 21:15:22 +0800
In-Reply-To: <20210728131529.3310558-1-howardchung@google.com>
Message-Id: <20210728211405.Bluez.v3.6.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210728131529.3310558-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.432.gabb21c7263-goog
Subject: [Bluez PATCH v3 06/13] plugins: new plugin
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
 plugins/admin.c        | 30 ++++++++++++++++++++++++++++++
 plugins/admin_policy.c | 30 ++++++++++++++++++++++++++++++
 5 files changed, 70 insertions(+)
 create mode 100644 plugins/admin.c
 create mode 100644 plugins/admin_policy.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 4e6a72b0b..69fb01001 100644
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
index 0efd83abc..a34be8320 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -30,4 +30,5 @@ fi
 		--enable-pie \
 		--enable-cups \
 		--enable-library \
+		--enable-admin \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index a5afaea6c..0744860b8 100644
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
index 000000000..42866bcf7
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
diff --git a/plugins/admin_policy.c b/plugins/admin_policy.c
new file mode 100644
index 000000000..dd8d89736
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
2.32.0.432.gabb21c7263-goog

