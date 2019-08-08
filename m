Return-Path: <SRS0=RGGC=WE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F24DC0650F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F29DC2086D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Aug 2019 04:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbfHHEqg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Aug 2019 00:46:36 -0400
Received: from mga07.intel.com ([134.134.136.100]:10619 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfHHEqg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Aug 2019 00:46:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 21:46:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,360,1559545200"; 
   d="scan'208";a="182484286"
Received: from ingas-nuc1.sea.intel.com ([10.255.95.214])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Aug 2019 21:46:35 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1] shared/mainloop: Add ell-based mainloop implementation
Date:   Wed,  7 Aug 2019 21:46:33 -0700
Message-Id: <20190808044633.29515-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190808044633.29515-1-inga.stotland@intel.com>
References: <20190808044633.29515-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds implementation of wrapper mainloop functions to interact with
ell main APIs, enabling support for the applications that link with ell
library and use mainloop functionality.
---
 Makefile.am               |  13 +++-
 src/shared/mainloop-ell.c | 129 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 139 insertions(+), 3 deletions(-)
 create mode 100644 src/shared/mainloop-ell.c

diff --git a/Makefile.am b/Makefile.am
index 9d25a815b..d175d3572 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -162,6 +162,10 @@ CLEANFILES += $(ell_built_sources)
 
 noinst_LTLIBRARIES += src/libshared-glib.la src/libshared-mainloop.la
 
+if LIBSHARED_ELL
+noinst_LTLIBRARIES += src/libshared-ell.la
+endif
+
 shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/queue.h src/shared/queue.c \
 			src/shared/util.h src/shared/util.c \
@@ -206,10 +210,13 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/mainloop-notify.c
 
 if LIBSHARED_ELL
-noinst_LTLIBRARIES += src/libshared-ell.la
-
 src_libshared_ell_la_SOURCES = $(shared_sources) \
-				src/shared/io-ell.c
+				src/shared/io-ell.c \
+				src/shared/timeout-mainloop.c \
+				src/shared/mainloop.h \
+				src/shared/mainloop-ell.c \
+				src/shared/mainloop-notify.h \
+				src/shared/mainloop-notify.c
 endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
new file mode 100644
index 000000000..027c8a0ef
--- /dev/null
+++ b/src/shared/mainloop-ell.c
@@ -0,1 +1,125 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <errno.h>
+#include <unistd.h>
+#include <stdlib.h>
+
+#include <ell/ell.h>
+
+#include "mainloop.h"
+
+static bool is_initialized;
+static int exit_status;
+static mainloop_signal_func sig_func;
+
+static void l_sig_func(uint32_t signo, void *user_data)
+{
+	if (sig_func)
+		sig_func(signo, user_data);
+}
+
+void mainloop_init(void)
+{
+	is_initialized = l_main_init();
+}
+
+void mainloop_quit(void)
+{
+	l_main_quit();
+}
+
+void mainloop_exit_success(void)
+{
+	exit_status = EXIT_SUCCESS;
+	l_main_quit();
+}
+
+void mainloop_exit_failure(void)
+{
+	exit_status = EXIT_FAILURE;
+	l_main_quit();
+}
+
+int mainloop_run(void)
+{
+	if (!is_initialized)
+		return -EINVAL;
+
+	l_main_run();
+
+	is_initialized = false;
+	sig_func = NULL;
+
+	return exit_status;
+}
+
+int mainloop_run_with_signal(mainloop_signal_func func, void *user_data)
+{
+	if (!is_initialized || !func)
+		return -EINVAL;
+
+	/* Workaround for sign discrepancy in ell and bluez */
+	sig_func = func;
+
+	return l_main_run_with_signal(l_sig_func, user_data);
+}
+
+int mainloop_add_fd(int fd, uint32_t events, mainloop_event_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
+
+int mainloop_modify_fd(int fd, uint32_t events)
+{
+	return -ENOSYS;
+}
+
+int mainloop_remove_fd(int fd)
+{
+	return -ENOSYS;
+}
+
+int mainloop_add_timeout(unsigned int msec, mainloop_timeout_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
+
+int mainloop_modify_timeout(int fd, unsigned int msec)
+{
+	return -ENOSYS;
+}
+
+int mainloop_remove_timeout(int id)
+{
+	return -ENOSYS;
+}
+
+int mainloop_set_signal(sigset_t *mask, mainloop_signal_func callback,
+				void *user_data, mainloop_destroy_func destroy)
+{
+	return -ENOSYS;
+}
-- 
2.21.0

