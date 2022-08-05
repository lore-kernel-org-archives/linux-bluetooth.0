Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C111CC3F6B0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Aug 2022 20:10:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240859AbiHEUKx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Aug 2022 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241431AbiHEUKn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Aug 2022 16:10:43 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 318416247
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Aug 2022 13:10:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z19so3564964plb.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Aug 2022 13:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=2U+OrRxI1HgMvk3L3jRUx0E8fWcZUrhN11dXKy4YZzE=;
        b=VTIrkjbcDlmjBESwLzspWfZj9OWEvv+8J/vLEXSw0fiBDufifhYCyKLI3LeywCnNyx
         vyogMRE6nbPvDEZm7PV8pqRPzl27sfImlhQ91pBKTK57BmJKe9+E5HaNceJLNVFfj36T
         ns92tHdnu7BLZmcMNgoS2PqjnKn1aam63+NOET3QUW3jweVB7DO1QbdCNlZnW80TuZ2Q
         BH2rXYHhFY/JcubgvQHLa0umVU2IPUtZlrMHlLp1/fU0vF4ZEjlfyZCAO8Vu6uYeE6CG
         teZe3N+nCTAdigUq66ainJQ8w7abZBdlFWSmh7nJ2RphYFAFtYreLfyHoAyHeH6m6mEc
         WiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2U+OrRxI1HgMvk3L3jRUx0E8fWcZUrhN11dXKy4YZzE=;
        b=T379YbDLYoeGh69o2VoxAuKvGDq/AnaTS+vm47CRYRp0ZFgPk//iD9fowyoUsxVT5o
         XZ9XijDnbaRr8x5LQsDhWJitv82PiYCV5ahbus3bz2okUEA8VMjVjr25INMmnrCpqQNb
         llq1Q5D5J9PXDBks3vMqQAFBsVYkeZofzv7UOyRLeWSn2oEJ+2p+g1UnQzLOlLalGQlY
         J9wdndQJhoOy+wrNjHTfadB9hdw9PQ//I3ntvAc4y/mlukFovBiTB2QVakPIiiBQ9Rmr
         bv3J6SmKjnkNoBC82LRsiCwiKa1mZzhDky0Jj74Mu3wz9dFpQzv8A5lYP/2yJ5jAe7CR
         EyDg==
X-Gm-Message-State: ACgBeo3lfJQCSgE/S+9egkXX6aNdR7GSAfffVnwg+0OUUKrstt/pHZXD
        iIINGQrRa8IqB2JU2kPIZbu0J0+P72hoPg==
X-Google-Smtp-Source: AA6agR5A56rQKTnScU9bBBajh64TgkYV8Yp4wwwM/GNq17QPkoU453gzcl4oT0uCp3ggx0UvlmhNmg==
X-Received: by 2002:a17:90a:9286:b0:1f1:bf7b:7602 with SMTP id n6-20020a17090a928600b001f1bf7b7602mr17802116pjo.83.1659730241093;
        Fri, 05 Aug 2022 13:10:41 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e2-20020aa79802000000b0052b94e757ecsm3356051pfl.213.2022.08.05.13.10.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 13:10:39 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] test-tester: This add tests for tester
Date:   Fri,  5 Aug 2022 13:10:34 -0700
Message-Id: <20220805201034.3838529-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805201034.3838529-1-luiz.dentz@gmail.com>
References: <20220805201034.3838529-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds tests for the tester itself:

> unit/test-tester

Test Summary
------------
/tester/basic                           Passed       0.000 seconds
/tester/setup_io                        Passed       0.000 seconds
/tester/io_send                         Passed       0.000 seconds
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
Overall execution time: 0.000355 seconds
---
 Makefile.am        |  5 +++
 unit/test-tester.c | 92 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)
 create mode 100644 unit/test-tester.c

diff --git a/Makefile.am b/Makefile.am
index cebe2f9df..960bf21bc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -408,6 +408,11 @@ EXTRA_DIST += tools/magic.btsnoop
 
 AM_CPPFLAGS += $(DBUS_CFLAGS) $(GLIB_CFLAGS) -I$(builddir)/lib
 
+unit_tests += unit/test-tester
+
+unit_test_tester_SOURCES = unit/test-tester.c
+unit_test_tester_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
+								$(GLIB_LIBS)
 
 unit_tests += unit/test-eir
 
diff --git a/unit/test-tester.c b/unit/test-tester.c
new file mode 100644
index 000000000..7cdfc87b8
--- /dev/null
+++ b/unit/test-tester.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2022  Intel Corporation.
+ *
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define _GNU_SOURCE
+#include <unistd.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <fcntl.h>
+
+#include <glib.h>
+
+#include "src/shared/util.h"
+#include "src/shared/tester.h"
+
+static void test_basic(const void *data)
+{
+	tester_test_passed();
+}
+
+static bool test_io_recv(struct io *io, void *user_data)
+{
+	const struct iovec *iov = user_data;
+	unsigned char buf[512];
+	int fd;
+	ssize_t len;
+
+	fd = io_get_fd(io);
+
+	len = read(fd, buf, sizeof(buf));
+
+	g_assert(len > 0);
+	g_assert_cmpint(len, ==, iov->iov_len);
+	g_assert(memcmp(buf, iov->iov_base, len) == 0);
+
+	tester_test_passed();
+
+	return false;
+}
+
+static const struct iovec iov[] = {
+	IOV_DATA(0x01),
+	IOV_DATA(0x01, 0x02),
+};
+
+static void test_setup_io(const void *data)
+{
+	struct io *io;
+	ssize_t len;
+
+	io = tester_setup_io(iov, ARRAY_SIZE(iov));
+	g_assert(io);
+
+	io_set_read_handler(io, test_io_recv, (void *)&iov[1], NULL);
+
+	len = io_send(io, (void *)&iov[0], 1);
+	g_assert_cmpint(len, ==, iov[0].iov_len);
+}
+
+static void test_io_send(const void *data)
+{
+	struct io *io;
+
+	io = tester_setup_io(iov, ARRAY_SIZE(iov));
+	g_assert(io);
+
+	io_set_read_handler(io, test_io_recv, (void *)&iov[0], NULL);
+
+	tester_io_send();
+}
+
+int main(int argc, char *argv[])
+{
+	tester_init(&argc, &argv);
+
+	tester_add("/tester/basic", NULL, NULL, test_basic, NULL);
+	tester_add("/tester/setup_io", NULL, NULL, test_setup_io, NULL);
+	tester_add("/tester/io_send", NULL, NULL, test_io_send, NULL);
+
+	return tester_run();
+}
+
-- 
2.37.1

