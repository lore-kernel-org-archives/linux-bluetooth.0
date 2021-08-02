Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DDEC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8EBB60EE8
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhHBGN2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbhHBGN2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:28 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22AC06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id cb3-20020ad456230000b02903319321d1e3so12069399qvb.14
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=XGEurvnpC1zYSYBDjsaBZXd5uB3U4MDptNyQM2hsogJwbyb2FdeQuGI7SOjBJhVkVf
         Kuf4JowVcdDE+2ghAo0b9fFvHDJflEGwG6oeLQO9QH5clGZyG3vF7X9cTdpZIX94SLYw
         lK1TEVdfDatPJ924fnhYXEw8TVOYj3v0Fzh0B/vIxapsDKlIAImeO7T8agICC9iZnCND
         EepWgm9adkFS+ZFGdPjqjobozWzrjZEik+/ypM8YPCp/XjT9YFaI4jD05L2D5uoohzPh
         ya+Ypex1e6GzZPl0U61IliD/vNuf0US2f0xTO6eEBtasHczYr9SOyv5Cc0iridwNSf6W
         mTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=mDu/lyD2EucEcTr2q4MQRwL6kdTWTsacQjHmPeG0TRKIKu+5wCMS8lAWE3Jvc4qyxI
         PZZJJGZLubWJZ2cEi+eU/WZ33YvY2Efel5bShVRao8OgFqmljAa2CL9eDXZSg1hKRA+J
         X0CxsahFWmyB/77d5W6858a8uju99pmeybDorlEDYxY0bPv56VEwy6suMNjJdwiGbOrW
         ilMxdzXvsPrg28JVP1m355Ho+ZNykMdwraGSA0yMeqw4v8ioXO8AYPFdj3eRjce4TUK7
         Vr0JI3UDiRbej2vWFrsOnUA685aBlzOKiO5jaoFdgI9RaV35loNF55JmT35XJ576BHac
         lIeQ==
X-Gm-Message-State: AOAM5325+BRJIkqNYUDrmrpmaYO0CVMO8nFOvEXOJRppsLLH45eld5PT
        OYa3ZwCE89D3OOmsAWwQ+SBkCvuhs2XmfHLKTE4tJOq9cybsJMWfkiAScb6uddcklq6oMN54w8e
        mNu8yUmfyPWKPXccfuX9gCs87r3CURGj35wWz8LyrNbXk0hKPZwHi0/VU/BteC62LlLMQVP5CAI
        aJ6LbsCUnYXoo=
X-Google-Smtp-Source: ABdhPJwhFi9qsIPkjfVf+BN0cL1dXTuKJya9QGZ6sgL8Z+jfGB49G+9MvtvYI2PMveME9nmRW3JpEoRzqHXB2o/HYQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:ad4:5aa1:: with SMTP id
 u1mr1382055qvg.2.1627884798237; Sun, 01 Aug 2021 23:13:18 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:43 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.6.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 06/13] plugins: new plugin
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

