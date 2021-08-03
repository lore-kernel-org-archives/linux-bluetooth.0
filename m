Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7410BC432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AF96023B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Aug 2021 11:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236038AbhHCLop (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Aug 2021 07:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234693AbhHCLn5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Aug 2021 07:43:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA48CC06175F
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Aug 2021 04:43:45 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id f3-20020a25cf030000b029055a2303fc2dso22574803ybg.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Aug 2021 04:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=sOR0vGFXbXEJ7HK7fHJQ0NbV+cMlmdzOlXAwaTfCkqpvTcYMO4YYyFtXffII8yQZEY
         iteQg1cscKQCaEWm9uVTF3pH4PsWYpaFjXwjKlUIkeOFCAlegAVAYJmIf0jhzy11bD4f
         /AZX7DjjqXWBq3o8WsIatSn9twe72/PHwlmLe7EdyS2gF8JWHkIWJ852GqLXsd965slW
         6ZBRwzo6oNNRFb+su+M1KTMxe/8v/xYvO6GnKHK+JcuJqXHu27VPqB72C/4fCskOZfsz
         9wbdL9ZGh9uiOLNIhSvgaR1/9yvcWq52RrB36IU3N4h2yf64ICoovjUonyWZgptY/nal
         Otzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mDdEFCjpHD/uWglCa7g2e7wWzLT0QoSSZnVpKWZCPo4=;
        b=KR08obdu0HyJS3I6lJ3elUYKhJycG1KVkrAunSTy7RZ689BELF4AB68T/IVvU2nVt2
         0hI4aTQXFJazhwVtW1SG4e30whFg2g4EHDVlJhqvmJR9W/2pVVVvoQy/qDPuFBpQi5Mn
         ptcWoWYSUIi08Gh19sV441wC0+qN8Bqxq+Q3dCTdFWdnuYWFXTL1RB2tgEqL/xd98rRx
         lVm/lpu2mk2BSSEbZvHb+ue5SUGIBzgy5iJ0EVNon8GTjkMwi9Rl1RZO5nxyZ+8oQUu5
         d16Dp5CPbpFlJFgULo8K7GSdVNALeqzoInDs6MqAMFVjVmAlTGTkBYaLvuQ6EGqv+eH/
         c+Vg==
X-Gm-Message-State: AOAM531SVRLSVGl5wnidQLer9vaXVs8Pb6ma3iPXX6PyQt0sZHqr/3yX
        00B161xbEa0Hg+MIm1i300kII5w9klbGOsnexrho8lQpsZgmldT0al175LAxrye2AvQKWvwymdd
        mwc8N52tcT4k5LmAdFIDULseUa7xfE5+i829+bEy9uPDLcFWZhlrvKBA16bB1nU2X8A1cby7U6n
        ijMtMMyFE2loc=
X-Google-Smtp-Source: ABdhPJzfAv8QlMxiz1QTtRIa/LijjVoqNVeHFt0WCJW+JTcumD70cyDiSCo5xNsQznbEgQWFcpAJFPIW5oqbxbDBOQ==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:ef55:8161:c77b:7a8d])
 (user=howardchung job=sendgmr) by 2002:a25:2785:: with SMTP id
 n127mr26741690ybn.235.1627991025047; Tue, 03 Aug 2021 04:43:45 -0700 (PDT)
Date:   Tue,  3 Aug 2021 19:43:09 +0800
In-Reply-To: <20210803114317.801840-1-howardchung@google.com>
Message-Id: <20210803194127.Bluez.v9.5.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210803114317.801840-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v9 05/13] plugins: new plugin
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

