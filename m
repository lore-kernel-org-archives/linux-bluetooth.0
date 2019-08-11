Return-Path: <SRS0=QoSK=WH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2839BC433FF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Aug 2019 07:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA12C2085B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Aug 2019 07:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbfHKHBr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Aug 2019 03:01:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:18129 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfHKHBr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Aug 2019 03:01:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 00:00:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,372,1559545200"; 
   d="scan'208";a="183280813"
Received: from ingas-nuc1.sea.intel.com ([10.254.104.35])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Aug 2019 00:00:48 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 1/1 v3] shared/mainloop: Add ell-based mainloop implementation
Date:   Sun, 11 Aug 2019 00:00:45 -0700
Message-Id: <20190811070045.15406-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811070045.15406-1-inga.stotland@intel.com>
References: <20190811070045.15406-1-inga.stotland@intel.com>
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
 Makefile.am               |  11 +++-
 src/shared/mainloop-ell.c | 126 ++++++++++++++++++++++++++++++++++++++
 src/shared/timeout-ell.c  |  72 ++++++++++++++++++++++
 3 files changed, 206 insertions(+), 3 deletions(-)
 create mode 100644 src/shared/mainloop-ell.c
 create mode 100644 src/shared/timeout-ell.c

diff --git a/Makefile.am b/Makefile.am
index 9d25a815b..e3986a718 100644
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
@@ -206,10 +210,11 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/mainloop-notify.c
 
 if LIBSHARED_ELL
-noinst_LTLIBRARIES += src/libshared-ell.la
-
 src_libshared_ell_la_SOURCES = $(shared_sources) \
-				src/shared/io-ell.c
+				src/shared/io-ell.c \
+				src/shared/timeout-ell.c \
+				src/shared/mainloop.h \
+				src/shared/mainloop-ell.c
 endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
diff --git a/src/shared/mainloop-ell.c b/src/shared/mainloop-ell.c
new file mode 100644
index 000000000..63e254ac6
--- /dev/null
+++ b/src/shared/mainloop-ell.c
@@ -0,0 +1,126 @@
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
diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
new file mode 100644
index 000000000..8419d4617
--- /dev/null
+++ b/src/shared/timeout-ell.c
@@ -0,0 +1,72 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2019  Intel Corporation. All rights reserved.
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
+#include <ell/ell.h>
+
+#include "timeout.h"
+
+struct timeout_data {
+	timeout_func_t func;
+	timeout_destroy_func_t destroy;
+	unsigned int timeout;
+	void *user_data;
+};
+
+static void timeout_callback(struct l_timeout *timeout, void *user_data)
+{
+	struct timeout_data *data = user_data;
+
+	if (data->func)
+		data->func(data->user_data);
+
+	l_timeout_modify(timeout, data->timeout);
+}
+
+static void timeout_destroy(void *user_data)
+{
+	struct timeout_data *data = user_data;
+
+	if (data->destroy)
+		data->destroy(data->user_data);
+
+	l_free(data);
+}
+
+unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
+			void *user_data, timeout_destroy_func_t destroy)
+{
+	struct timeout_data *data;
+	uint32_t id;
+
+	data = l_new(struct timeout_data, 1);
+
+	data->func = func;
+	data->destroy = destroy;
+	data->user_data = user_data;
+	data->timeout = timeout;
+
+	id = L_PTR_TO_UINT(l_timeout_create(timeout, timeout_callback,
+						user_data, timeout_destroy));
+	return id;
+}
+
+void timeout_remove(unsigned int id)
+{
+	l_timeout_remove(L_UINT_TO_PTR(id));
+}
-- 
2.21.0

