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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 925D4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7382C6103A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 03:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbhG2DOA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 23:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhG2DN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 23:13:58 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB89C061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:55 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id bm25-20020a05620a1999b02903a9c3f8b89fso2974217qkb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 20:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=p3tQ7nkxRsVAbhaTRV58Q03fkBS7gDnHQt2bj1gWi/QUu4qiROjBCr36TIu+sqvE3J
         98YQF59jiCZTNcg8BUAzDud3sjcOcU4ivObhFEX/pJsaxZbMrw2e9wWv4a8CNeq05n0z
         4+w/oR+UHW04e6FZQtEjJR684kxAmneSboLFGh/8NdiC831AGcdHbXenXNPFFaHa2ZEf
         EGXhYQMznFduTCeHNb07mcoDAIKAgiARbtgJ2u9gU+5OMxfcwOZ1JJzndbH2XyhYYy0T
         GEdIdmzM1+FkPVuE4pME+Cffo7UZX/0/r3Fd4+ldhdfIL5bMxJ9PLbspK6cJ6j/W1Faa
         Nh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=Khp/uxd0c42PeLPGQs1OcqFd8/HGbvmdkzT6Sr5HKrq34OSGGxjTdGrMrlU4GPobmF
         L5D5n/GtmxBEsoZ9aovBhwc9eMRmkqioeahm723wrgQyNXqfjbzRO8gx4Xju6/l/dO43
         CzvPZzPQLDYFrCA+h8NHiXnAiT063JQiUsiJ/r3gaJiRzBqZ6SKuiuwIKGRftq/u+J75
         eDgoxCOPXDxOkMCtK2gdi3375fASo3LNIWQm0oEO+7jg6IKwRkdJCmOnqbowSgHuB7+C
         Jlr0XEhEf4jL7zDxAmkZ6nBGbr6UcKVmxUjDYVjYPji+AwZ+99SCYW94xUSBJF8QLU8/
         NQ+A==
X-Gm-Message-State: AOAM533NbLr6Tj8kUW/MblvGpU118FOVqbGNIVuWg5C1c57zpT05aj0F
        k9V4PtEgxqzN2AEe/N39GNgNmyWse2MWjylMhDREbl5Xc2lORG61A8/GZkJ8nOE4LK2cQX0Ar3B
        5bNJ6Yqtnc/k/ZzKEagFC04Dn4vwHwOw1LnNct7j/8UCKYkVQHTPE0iezt772e47O4nTTOTlXdA
        yfsRaAGuEzQ+s=
X-Google-Smtp-Source: ABdhPJxgneRj7yuW/oKPOiKCOGre/k9lYaXBMfnCzTvd+KP2rkG3C0z8Ak3++D0qiLZx6TqNq7Xs/h1NLKgy9TLryQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ff72:1420:4502:fdaf])
 (user=howardchung job=sendgmr) by 2002:a05:6214:104b:: with SMTP id
 l11mr3396829qvr.40.1627528434162; Wed, 28 Jul 2021 20:13:54 -0700 (PDT)
Date:   Thu, 29 Jul 2021 11:12:52 +0800
In-Reply-To: <20210729031258.3391756-1-howardchung@google.com>
Message-Id: <20210729110956.Bluez.v4.6.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210729031258.3391756-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v4 06/13] plugins: new plugin
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

