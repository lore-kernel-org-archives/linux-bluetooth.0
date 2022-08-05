Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB54C00140
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 20:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241332AbiHEUKm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237177AbiHEUKl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 16:10:41 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9D6165
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 13:10:40 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id u133so3127377pfc.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 13:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9B3bYx2gvQNRTpRNuhhlKjxl55kwx81fe3UqEnkYCE=;
        b=B8vwBSXp8VAjvKIMwMkkAoj03Xih/4ZuD+GmfzlyKdntv5Wcldl7z5snF6NEhFjSQ/
         oZ3WnmcRjkUJaE/1FeRIZQgSSwOkccN2eUCbznx7R34aRIIkPh+Tz12bqA1GOYo8MdLS
         W+6JXTVL8hpNjxbcRHaxnshhxvdkVflKzSof8u7o49kKxpSboQlhhMTBCQ0v0ZDZVWH/
         Niil/cgN0jcgPYvLuopXvDRbDYsRAWbVzXXL635LO/LUX0SgWZv88n5r51Dew3CmpH6N
         J7XLajpN1/Hmt8xb1FEwc2sHLYQyvZUEoCcqVWRFj6wfpvjPxE3gPTcQ3CQziWL1mBNl
         QT0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9B3bYx2gvQNRTpRNuhhlKjxl55kwx81fe3UqEnkYCE=;
        b=Zs2axzueOul41qziict/BJske9eRKZVS1zdKdsjQWmftaGcZ3l7T2/fZi8qRizGWpQ
         F6tE6npyrgny9LVB43ROAredwJ+kyJ2bFWtm9VsNGdGKmCPODPMsnS5tmQ/Bw/WbgRy+
         IWMNQ9XEYdJPU6jCxZ33OMLE451j5yuyFmZIaAY1oWBYlOsDZ8ESYaeDL8JYbDgiQrXv
         v9JcWMpPzaYt+72+tv0/ebRXL7J0+tPT7x5EWLV/lYnz4MIldf4v3trR6ml+GjnfDwY0
         Pq1q3oaRRrTgAd9N6m4yol4ANDG/MLKuzHRYdJ0qfmNauyulIhz2F8iLzGvJ3o/BRVNU
         b0tA==
X-Gm-Message-State: ACgBeo03AK8m4rwHCrvPDOi5YjORJ9oGz6wYE7SO1dwB1Q1eqpGIM3Bi
        kAFjE/PJa+xt/mY7m4AmcnoPYSJfbSS0Nw==
X-Google-Smtp-Source: AA6agR5GUNvP4I7M9+nEW7EJ7PrIN4jvT9OMXenAiM63qPNFruvS6jtpbzED2KRIyjSDBHkq4IUC1w==
X-Received: by 2002:a05:6a00:c96:b0:52e:979c:dd63 with SMTP id a22-20020a056a000c9600b0052e979cdd63mr7433106pfv.50.1659730239041;
        Fri, 05 Aug 2022 13:10:39 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b0052b94e757ecsm3356051pfl.213.2022.08.05.13.10.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 13:10:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] shared/tester: Add tester_setup_io
Date:   Fri,  5 Aug 2022 13:10:33 -0700
Message-Id: <20220805201034.3838529-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tester_setup_io which can be used to add a PDU list in the
form of iovec.
---
 src/shared/tester.c | 155 ++++++++++++++++++++++++++++++++++++++++++--
 src/shared/tester.h |  12 ++++
 2 files changed, 163 insertions(+), 4 deletions(-)

diff --git a/src/shared/tester.c b/src/shared/tester.c
index c07cbc11c..885b2591d 100644
--- a/src/shared/tester.c
+++ b/src/shared/tester.c
@@ -81,6 +81,8 @@ struct test_case {
 	enum test_result result;
 	enum test_stage stage;
 	const void *test_data;
+	const struct iovec *iov;
+	size_t iovcnt;
 	tester_data_func_t pre_setup_func;
 	tester_data_func_t setup_func;
 	tester_data_func_t test_func;
@@ -346,14 +348,20 @@ void tester_add(const char *name, const void *test_data,
 					teardown_func, NULL, 0, NULL, NULL);
 }
 
-void *tester_get_data(void)
+static struct test_case *tester_get_test(void)
 {
-	struct test_case *test;
-
 	if (!test_current)
 		return NULL;
 
-	test = test_current->data;
+	return test_current->data;
+}
+
+void *tester_get_data(void)
+{
+	struct test_case *test = tester_get_test();
+
+	if (!test)
+		return NULL;
 
 	return test->user_data;
 }
@@ -859,6 +867,142 @@ void tester_init(int *argc, char ***argv)
 	test_current = NULL;
 }
 
+static struct io *ios[2];
+
+static bool io_disconnected(struct io *io, void *user_data)
+{
+	if (io == ios[0]) {
+		io_destroy(ios[0]);
+		ios[0] = NULL;
+	} else if (io == ios[1]) {
+		io_destroy(ios[1]);
+		ios[1] = NULL;
+	}
+
+	return false;
+}
+
+static const struct iovec *test_get_iov(struct test_case *test)
+{
+	const struct iovec *iov;
+
+	if (!test || !test->iov || !test->iovcnt)
+		return NULL;
+
+	iov = test->iov;
+
+	test->iov++;
+	test->iovcnt--;
+
+	return iov;
+}
+
+static bool test_io_send(struct io *io, void *user_data)
+{
+	struct test_case *test = tester_get_test();
+	const struct iovec *iov = test_get_iov(test);
+	ssize_t len;
+
+	if (!iov)
+		return false;
+
+	len = io_send(io, iov, 1);
+
+	tester_monitor('<', 0x0004, 0x0000, iov->iov_base, len);
+
+	g_assert_cmpint(len, ==, iov->iov_len);
+
+	return false;
+}
+
+static bool test_io_recv(struct io *io, void *user_data)
+{
+	struct test_case *test = tester_get_test();
+	const struct iovec *iov = test_get_iov(test);
+	unsigned char buf[512];
+	int fd;
+	ssize_t len;
+
+	fd = io_get_fd(io);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+
+	tester_monitor('>', 0x0004, 0x0000, buf, len);
+
+	if (!iov)
+		return true;
+
+	g_assert_cmpint(len, ==, iov->iov_len);
+
+	g_assert(memcmp(buf, iov->iov_base, len) == 0);
+
+	if (test->iovcnt)
+		io_set_write_handler(io, test_io_send, NULL, NULL);
+
+	return true;
+}
+
+static void setup_io(void)
+{
+	int fd[2], err;
+
+	io_destroy(ios[0]);
+	io_destroy(ios[1]);
+
+	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, fd);
+	if (err < 0) {
+		tester_warn("socketpair: %s (%d)", strerror(errno), errno);
+		return;
+	}
+
+	ios[0] = io_new(fd[0]);
+	if (!ios[0]) {
+		tester_warn("io_new: %p", ios[0]);
+		return;
+	}
+
+	io_set_close_on_destroy(ios[0], true);
+	io_set_disconnect_handler(ios[0], io_disconnected, NULL, NULL);
+
+	ios[1] = io_new(fd[1]);
+	if (!ios[1]) {
+		tester_warn("io_new: %p", ios[1]);
+		return;
+	}
+
+	io_set_close_on_destroy(ios[1], true);
+	io_set_disconnect_handler(ios[1], io_disconnected, NULL, NULL);
+	io_set_read_handler(ios[1], test_io_recv, NULL, NULL);
+}
+
+struct io *tester_setup_io(const struct iovec *iov, int iovcnt)
+{
+	struct test_case *test = tester_get_test();
+
+	if (!ios[0] || !ios[1]) {
+		setup_io();
+		if (!ios[0] || !ios[1]) {
+			tester_warn("Unable to setup IO");
+			return NULL;
+		}
+	}
+
+	test->iov = iov;
+	test->iovcnt = iovcnt;
+
+	return ios[0];
+}
+
+void tester_io_send(void)
+{
+	struct test_case *test = tester_get_test();
+
+	if (test->iovcnt)
+		io_set_write_handler(ios[1], test_io_send, NULL, NULL);
+}
+
 int tester_run(void)
 {
 	int ret;
@@ -879,5 +1023,8 @@ int tester_run(void)
 	if (option_monitor)
 		bt_log_close();
 
+	io_destroy(ios[0]);
+	io_destroy(ios[1]);
+
 	return ret == 0 ? EXIT_SUCCESS : EXIT_FAILURE;
 }
diff --git a/src/shared/tester.h b/src/shared/tester.h
index a304d89fe..f2590970e 100644
--- a/src/shared/tester.h
+++ b/src/shared/tester.h
@@ -11,6 +11,15 @@
 #include <stdbool.h>
 #include <stddef.h>
 #include <stdint.h>
+#include "src/shared/io.h"
+
+#define data(args...) ((const unsigned char[]) { args })
+
+#define IOV_DATA(args...) \
+	{ \
+		.iov_base = (void *)data(args), \
+		.iov_len = sizeof(data(args)), \
+	}
 
 void tester_init(int *argc, char ***argv);
 int tester_run(void);
@@ -66,3 +75,6 @@ typedef void (*tester_wait_func_t)(void *user_data);
 
 void tester_wait(unsigned int seconds, tester_wait_func_t func,
 							void *user_data);
+
+struct io *tester_setup_io(const struct iovec *iov, int iovcnt);
+void tester_io_send(void);
-- 
2.37.1

