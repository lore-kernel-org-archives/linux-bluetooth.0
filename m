Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90324C4743F
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 682EC61107
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Jun 2021 06:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhFFGjR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Jun 2021 02:39:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:34607 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230060AbhFFGjR (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Jun 2021 02:39:17 -0400
IronPort-SDR: 7kALOW5PqN2XW/xNyjPjuCgHLniJ0ouKMyG/sD2V3eP4092WFgI8wkTIna0J1ZM58nTYMEnFq6
 R3MYzsmdDAJw==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191815309"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191815309"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:28 -0700
IronPort-SDR: vJEfoBUUTsmOCLo+BddMnXtlyNufDXGt64Qg8US0io1STj39ilYq1DksnTyUmEuapgS1uq+Obx
 XgGFBprBYT0Q==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="481160881"
Received: from skambhat-mobl.amr.corp.intel.com (HELO istotlan-desk.intel.com) ([10.209.68.161])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:37:27 -0700
From:   Inga Stotland <inga.stotland@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, tedd.an@intel.com,
        Inga Stotland <inga.stotland@intel.com>
Subject: [PATCH BlueZ 01/11] shared/bttester: tester framework wrapper to use ELL
Date:   Sat,  5 Jun 2021 23:37:09 -0700
Message-Id: <20210606063719.339794-2-inga.stotland@intel.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210606063719.339794-1-inga.stotland@intel.com>
References: <20210606063719.339794-1-inga.stotland@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add BlueZ specific tester wrapper to combine using ELL primitives
and desired debug/monitor options
---
 Makefile.am           |   4 +-
 src/shared/bttester.c | 279 ++++++++++++++++++++++++++++++++++++++++++
 src/shared/bttester.h |  32 +++++
 3 files changed, 313 insertions(+), 2 deletions(-)
 create mode 100644 src/shared/bttester.c
 create mode 100644 src/shared/bttester.h

diff --git a/Makefile.am b/Makefile.am
index 497f05f06..b9c8fb043 100644
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
index 000000000..f079a6980
--- /dev/null
+++ b/src/shared/bttester.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2014, 2021  Intel Corporation. All rights reserved.
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
+} __packed;
+
+struct __packed monitor_l2cap_hdr {
+	uint16_t cid;
+	uint16_t psm;
+} __packed;
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
index 000000000..123105feb
--- /dev/null
+++ b/src/shared/bttester.h
@@ -0,0 +1,32 @@
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
+#ifndef __packed
+#define __packed __attribute__((packed))
+#endif
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

