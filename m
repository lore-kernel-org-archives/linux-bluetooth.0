Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62D3C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A31BE613B5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 May 2021 02:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbhEFCTc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 22:19:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:27107 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231345AbhEFCT3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 22:19:29 -0400
IronPort-SDR: RNVKjBBOol7+YDSFi5ADi+kZfIxqXc/SeQ/BiHQqxz7Gb/vHVUfkUJ/QT1X33iJfSpj4tb33X2
 Ve5W+O3Lo9tw==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="259631481"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="259631481"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:31 -0700
IronPort-SDR: qqe5msM0Puod651j1FkIndrDfiZOR/mjYc1wEnjSSjRprYjNfWqILc34Q4W0qSC0LD7zdiWsIr
 bnNoD+VwDCTg==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; 
   d="scan'208";a="469230405"
Received: from zloh1-mobl.gar.corp.intel.com (HELO istotlan-desk.intel.com) ([10.254.6.126])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2021 19:18:30 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 01/11] shared/bttester: tester framework wrapper to use ELL
Date:   Wed,  5 May 2021 19:18:07 -0700
Message-Id: <20210506021817.289939-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210506021817.289939-1-inga.stotland@intel.com>
References: <20210506021817.289939-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 Makefile.am           |   4 +-
 src/shared/bttester.c | 280 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/bttester.h |  28 +++++
 3 files changed, 310 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/bttester.c
 create mode 100644 src/shared/bttester.h

diff --git a/Makefile.am b/Makefile.am
index 52e0e9ed8..9a45f6fc7 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -253,8 +253,8 @@ if LIBSHARED_ELL
 src_libshared_ell_la_SOURCES = $(shared_sources) \
 				src/shared/io-ell.c \
 				src/shared/timeout-ell.c \
-				src/shared/mainloop.h \
-				src/shared/mainloop-ell.c
+				src/shared/mainloop-ell.c \
+				src/shared/bttester.h src/shared/bttester.c
 endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
diff --git a/src/shared/bttester.c b/src/shared/bttester.c
new file mode 100644
index 000000000..28a9fbaf9
--- /dev/null
+++ b/src/shared/bttester.c
@@ -0,0 +1,280 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2014  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <getopt.h>
+#include <syslog.h>
+
+#include <ell/ell.h>
+
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+
+#include "src/shared/util.h"
+#include "src/shared/bttester.h"
+#include "src/shared/log.h"
+
+#define COLOR_WHITE    "\x1B[0;37m"
+#define COLOR_OFF      "\x1B[0m"
+
+static char *tester_name;
+
+static bool option_quiet;
+static bool option_debug;
+static bool option_monitor;
+static bool option_list;
+static const char *option_prefix;
+static const char *option_string;
+
+struct l_tester *tester;
+
+struct monitor_hdr {
+	uint16_t opcode;
+	uint16_t index;
+	uint16_t len;
+	uint8_t  priority;
+	uint8_t  ident_len;
+} __attribute__((packed));
+
+struct monitor_l2cap_hdr {
+	uint16_t cid;
+	uint16_t psm;
+} __attribute__((packed));
+
+static void tester_vprintf(const char *format, va_list ap)
+{
+	if (bttester_use_quiet())
+		return;
+
+	printf("  %s", COLOR_WHITE);
+	vprintf(format, ap);
+	printf("%s\n", COLOR_OFF);
+}
+
+void bttester_print(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	tester_vprintf(format, ap);
+	va_end(ap);
+
+	va_start(ap, format);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_INFO, format, ap);
+	va_end(ap);
+}
+
+void bttester_debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	tester_vprintf(format, ap);
+	va_end(ap);
+
+	va_start(ap, format);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_DEBUG, format, ap);
+	va_end(ap);
+}
+
+void bttester_warn(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	tester_vprintf(format, ap);
+	va_end(ap);
+
+	va_start(ap, format);
+	bt_log_vprintf(HCI_DEV_NONE, tester_name, LOG_WARNING, format, ap);
+	va_end(ap);
+}
+
+static void monitor_debug(const char *str, void *user_data)
+{
+	const char *label = user_data;
+
+	bttester_debug("%s: %s", label, str);
+}
+
+static void monitor_log(char dir, uint16_t cid, uint16_t psm, const void *data,
+								size_t len)
+{
+	struct iovec iov[3];
+	struct monitor_l2cap_hdr hdr;
+	uint8_t term = 0x00;
+	char label[16];
+
+	if (snprintf(label, sizeof(label), "%c %s", dir, tester_name) < 0)
+		return;
+
+	hdr.cid = cpu_to_le16(cid);
+	hdr.psm = cpu_to_le16(psm);
+
+	iov[0].iov_base = &hdr;
+	iov[0].iov_len = sizeof(hdr);
+
+	iov[1].iov_base = (void *) data;
+	iov[1].iov_len = len;
+
+	/* Kernel won't forward if data is no NULL terminated */
+	iov[2].iov_base = &term;
+	iov[2].iov_len = sizeof(term);
+
+	bt_log_sendmsg(HCI_DEV_NONE, label, LOG_INFO, iov, 3);
+}
+
+void bttester_monitor(char dir, uint16_t cid, uint16_t psm, const void *data,
+								size_t len)
+{
+	monitor_log(dir, cid, psm, data, len);
+
+	if (!bttester_use_debug())
+		return;
+
+	util_hexdump(dir, data, len, monitor_debug, (void *) tester_name);
+}
+
+bool bttester_use_quiet(void)
+{
+	return option_quiet;
+}
+
+bool bttester_use_debug(void)
+{
+	return option_debug;
+}
+
+static const struct option options[] = {
+	{ "version",	no_argument,		NULL, 'v' },
+	{ "quiet",	no_argument,		NULL, 'q' },
+	{ "monitor",	no_argument,		NULL, 'm' },
+	{ "debug",	no_argument,		NULL, 'd' },
+	{ "list",	no_argument,		NULL, 'l' },
+	{ "prefix",	required_argument,	NULL, 'p' },
+	{ "string",	required_argument,	NULL, 's' },
+	{ }
+};
+
+static void usage(void)
+{
+	fprintf(stderr,
+		"Usage:\n"
+		"\%s [options]\n", tester_name);
+	fprintf(stderr,
+		"Options:\n"
+		"\t-v, --version Show version information and exit\n"
+		"\t-q, --quiet   Run tests without logging\n"
+		"\t-d, --debug   Run tests with debug output\n"
+		"\t-d, --monitor Enable monitor output\n"
+		"\t-l, --list	 Only list the tests to be run\n"
+		"\t-p, --prefix	 Run tests matching the provided prefix\n"
+		"\t-s, --string	 Run tests matching the provided string\n");
+}
+
+static void parse_options(int *argc, char ***argv)
+{
+	tester_name = strrchr(*argv[0], '/');
+
+	for (;;) {
+		int opt;
+
+		opt = getopt_long(*argc, *argv, "s:p:dvlm", options, NULL);
+		if (opt < 0)
+			break;
+
+		switch (opt) {
+		case 'v':
+			printf("%s\n", VERSION);
+			exit(EXIT_SUCCESS);
+		case 'd':
+			option_debug = true;
+			l_debug_enable("*");
+			break;
+		case 'l':
+			option_list = true;
+			break;
+		case 'm':
+			option_monitor = true;
+			break;
+		case 'p':
+			option_prefix = optarg;
+			break;
+		case 's':
+			option_string = optarg;
+			break;
+		default:
+			usage();
+			exit(0);
+		}
+	}
+}
+
+static bool terminated;
+
+static void signal_callback(unsigned int signum, void *user_data)
+{
+	switch (signum) {
+	case SIGINT:
+	case SIGTERM:
+		if (!terminated)
+			l_main_quit();
+
+		terminated = true;
+		break;
+	}
+}
+
+static void done_callback(struct l_tester *tester)
+{
+	if (terminated)
+		return;
+
+	l_main_quit();
+	terminated = true;
+}
+
+struct l_tester *bttester_init(int *argc, char ***argv)
+{
+	l_log_set_stderr();
+
+	l_main_init();
+
+	tester_name = strrchr(*argv[0], '/');
+	parse_options(argc, argv);
+
+	tester = l_tester_new(option_prefix, option_string, option_list);
+
+	return tester;
+}
+
+int bttester_run(void)
+{
+	int status = EXIT_SUCCESS;
+
+	l_tester_start(tester, done_callback);
+
+	if (!option_list && !terminated)
+		l_main_run_with_signal(signal_callback, NULL);
+
+	if (!option_list && !l_tester_summarize(tester))
+		status = EXIT_FAILURE;
+
+	l_tester_destroy(tester);
+
+	return status;
+}
diff --git a/src/shared/bttester.h b/src/shared/bttester.h
new file mode 100644
index 000000000..9f0895c3e
--- /dev/null
+++ b/src/shared/bttester.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: LGPL-2.1-or-later */
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2014, 2021  Intel Corporation. All rights reserved.
+ *
+ *
+ */
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+
+struct l_tester *bttester_init(int *argc, char ***argv);
+int bttester_run(void);
+
+bool bttester_use_quiet(void);
+bool bttester_use_debug(void);
+
+void bttester_print(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+void bttester_warn(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+void bttester_debug(const char *format, ...)
+				__attribute__((format(printf, 1, 2)));
+void bttester_monitor(char dir, uint16_t cid,
+				uint16_t psm, const void *data, size_t len);
-- 
2.26.3

