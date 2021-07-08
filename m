Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-27.0 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEA6C07E96
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D26B61C59
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jul 2021 06:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbhGHG0b (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jul 2021 02:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHG0a (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jul 2021 02:26:30 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E93C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jul 2021 23:23:49 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id k11-20020a056902070bb029055a2303fc2dso5718993ybt.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jul 2021 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=w16n9MQt4OHipTQ2Rw2GOOnH2k4YMLK6G//sUcAoKMU=;
        b=kkvXW4I3g8f/D/1Xb5QHu8Ahzq2iKwNVLywHzVslnd3xC+Oe7quG6JZsmic7Kj9CYd
         iEIZ3mHudshC6LH6vW1eJUoEm2XnIrQupZD6jjrpmkdAcb078Nf0WTPOtqjb6nXKpDgr
         0BMJprbrOMa3Q0YEBF1+IGyQF3vdaoi34Ddnjm1VfoWC7V7qHpbaeJcjQNvH+ZM4+CKs
         DwE+6+jjD0FKap8xPT6c4AYf38O0N1TasFVWzIRyfCd9WRdouaB5myZpfK/CSHjbCu1S
         26Jm7JKvjIUM4aM9Q3PUFIzVRmHrW8TEWouRNacCbmo39rJMjo0EVcx1r0rYw9E8yaik
         n8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=w16n9MQt4OHipTQ2Rw2GOOnH2k4YMLK6G//sUcAoKMU=;
        b=kavhH6wbOizZ/dZ7p9Pu/SvGL1nbB8QcVZ6isfDZqKlZTR/34L6b7gSak6vqwc/EhF
         yjcwuEbYs0x6Sq1478EEMicRkpBjcd16Sv1swOl1HkGcoUSShUdyu/VjvXggor8f6nVa
         jXMma5g0vZ0FspvdEkKJGEnmMjx4McDcROqON6z60cedTpe2cmGb005HIumPTFxB6J0H
         3xSDUq5aZ7RyuGSf+EDEkw+2lbrozsfcVTIVgztIO3Nrdxt5H8AZ30SIv4WSuyK2Niju
         Q7ulueeyIgmsuQv6c8Su2Sed9z6T5bVzWSpYLD+UppS7/SwghTmc97jw5PZ3xwGLPOV6
         hZvw==
X-Gm-Message-State: AOAM533z2g5acNQdMvdxd+K5qIDMuEc3o7Xve43jhse0BnfEJWwE1UkD
        LhpeuLTE3HP+VplJgpaFLJBHx0s4YXbNXONrpsurPRpK9KYPbcn08AESZ0JMH8Mvao7KKpIrsZg
        jLM35X9gJAWgzbTMZ0z6iXcVNcWyS5683ZhXzofjyCpAapE0F/MoLdikb9qX/MiIe1dGIhL7DrH
        OH38+CoDy6Czs=
X-Google-Smtp-Source: ABdhPJzhW2Avk6PlIWoxSGo70MvRtRK82AVZ7uzJ6yQhOq5oVINIgKixdkuANBV/VLmFCWt0rclvW8n2p93HCFpVNA==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:de70:7033:67f7:8d0b])
 (user=howardchung job=sendgmr) by 2002:a25:3486:: with SMTP id
 b128mr40693149yba.523.1625725428653; Wed, 07 Jul 2021 23:23:48 -0700 (PDT)
Date:   Thu,  8 Jul 2021 14:23:07 +0800
In-Reply-To: <20210708062314.245754-1-howardchung@google.com>
Message-Id: <20210708142059.Bluez.v1.7.Id0842634d98a21fbdfa5cc72c76a462a98bf6f40@changeid>
Mime-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [Bluez PATCH v1 07/14] plugins: add a new plugin for admin_policy
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        Shyh-In Hwang <josephsih@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds an initial code for a new plugin admin_policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
Reviewed-by: Shyh-In Hwang <josephsih@chromium.org>
---

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
2.32.0.93.g670b81a890-goog

