Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E045184540
	for <linux-bluetooth@vger.kernel.org>; Sun, 27 Sep 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790531413; cv=pass; b=TE7qrWsPzJpm1WFfuyxQ27A6ETZiaXBlHPkT0OTEoXRNlKeR7imvUGbOu9T3X+JOErGsbhyB0E/FCTVbKafHj215ey5hSXa2SBo0wAnG6Q3gX8kHTXwobXbGtaA/JJDyOx8eV5q0CWAf3XCxcUIM8+4OPXXmjWNHRK1vL1C88v8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790531413; c=relaxed/simple;
	bh=wrWXGlgAew16Qg89Sm2y0ez0eR/VK/hJAxR84oYidvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MCrjANBEkNV0DrAW/8Jp29wuMISkVBhkUPq29GarcLVcBIEsKpBRgNDyKSzWrxdMuzZkxRmWkCIznzbEik6TLvDPNfph4czO1YTjvlTQv6L2l9/78PM1H1SJL12ZwSTnnRThx+oEN1YC0SDtHGCVlGbStFRNcCCZyBPTog/WC0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uE5O0IAd; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uE5O0IAd"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4htBm63h8Bz117K;
	Sun, 27 Sep 2026 20:49:58 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1790531398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/0UB6C8Q0cDHUJbPG7Kl03l7+k04TZcJiZGAXxOTE=;
	b=uE5O0IAdSA7il+VQa232H2SIxwwIC65KkS63uyz2TlOWYql0BNjZKMZpnuLHYqz1pg/fE5
	bU0vL4f4BzHMkL5PL8e/Fdhht7QP09aUwtHoW9uyRuMWF9NI3LgI5SDz3VfLOg6PN5nL/8
	NgP180iR9yW6NAZliS3uIijAqZkaP3E=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1790531398;
	b=h2nD83fqMyIUihtImJF4OV1APzZmDLSzApSUU0P/kTB/vAV+DZdlulLxTtADrtgs7mMGB3
	ieKuWW6KC/sn20YWUX/D+CW6THWalFr+ttPrI2JCKThvITiau0ZJUvy8e9m2GZgh4VOPPX
	BMejaOhA+g9XypevqwQvFgxxzx237Wg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1790531398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mm/0UB6C8Q0cDHUJbPG7Kl03l7+k04TZcJiZGAXxOTE=;
	b=EDTSBWzIHNona5c6e7ewy7TVKPdLV/MznyiCcKaTeI04ciYWkPc4YU4FRqxYaZupu5IYD4
	BrczDo9xDEIGbf10pqok1QLFz8rqLdydEIw7nEV0ZWMoBhDjkTDtllAu03jgVmWvJCsn2e
	7oTg9MkSnXCrlFqolfgLDm4sMcID/DU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] unit: test-mainloop: add basic mainloop test
Date: Sun, 27 Sep 2026 20:49:50 +0300
Message-ID: <00daf8aa00f1b53e98fae0e4143fafeef22d8c2d.1790531371.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
References: <fc1baff935104e08b170f528477e31bfedc57c7c.1790531371.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise basic mainloop fd add / remove / modify and timeouts.

src/shared/tester.h depends on mainloop and cannot be used here, so
write tests without the framework.

Add tests:

Test Modify File Descriptor
Test Re-Add Other Callback
Test Timeout

Assisted-by: opencode:gpt-6-sol
---
 .gitignore           |   1 +
 Makefile.am          |   5 ++
 unit/test-mainloop.c | 171 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 177 insertions(+)
 create mode 100644 unit/test-mainloop.c

diff --git a/.gitignore b/.gitignore
index b1d63e1d4..a52e6eb1b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -97,6 +97,7 @@ tools/isotest
 tools/iso-tester
 test/bluezutils.pyc
 unit/test-tester
+unit/test-mainloop
 unit/test-ringbuf
 unit/test-queue
 unit/test-util
diff --git a/Makefile.am b/Makefile.am
index 1d46b9b93..53a3a15c3 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -593,6 +593,11 @@ unit_test_tester_SOURCES = unit/test-tester.c
 unit_test_tester_LDADD = src/libshared-glib.la lib/libbluetooth-internal.la \
 								$(GLIB_LIBS)
 
+unit_tests += unit/test-mainloop
+
+unit_test_mainloop_SOURCES = unit/test-mainloop.c
+unit_test_mainloop_LDADD = src/libshared-mainloop.la
+
 unit_tests += unit/test-eir
 
 unit_test_eir_SOURCES = unit/test-eir.c src/eir.c src/uuid-helper.c
diff --git a/unit/test-mainloop.c b/unit/test-mainloop.c
new file mode 100644
index 000000000..70ee03ee4
--- /dev/null
+++ b/unit/test-mainloop.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026 Pauli Virtanen
+ *
+ */
+
+#include <unistd.h>
+#include <stdio.h>
+#include <stdlib.h>
+
+#include "src/shared/mainloop.h"
+
+
+#define test_failed_msg(msg) \
+	fail_and_abort(msg, __FILE__, __LINE__, __func__)
+
+#define test_failed() \
+	test_failed_msg("")
+
+#define check(condition) \
+	({ if (!(condition)) test_failed_msg(#condition " not true"); })
+
+
+struct test_data {
+	int fds[4];
+	unsigned int old_calls;
+	unsigned int new_calls;
+	unsigned int destroys;
+	unsigned int timeout_calls;
+};
+
+
+static void fail_and_abort(const char *msg, const char *file, int line,
+							const char *func)
+{
+	fprintf(stderr, "test failed\n");
+	fprintf(stderr, "    %s in %s:%d (%s)\n", msg, file, line, func);
+	abort();
+}
+
+static void teardown(struct test_data *data)
+{
+	int i;
+
+	for (i = 0; i < 4; ++i)
+		if (data->fds[i] > 0)
+			close(data->fds[i]);
+}
+
+static void destroy(void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->destroys++;
+}
+
+static void fd_callback(int fd, uint32_t events, void *user_data)
+{
+	struct test_data *data = user_data;
+	char buf;
+
+	check(events & EPOLLIN);
+	check(read(fd, &buf, 1) == 1);
+	check(buf == 'a');
+	data->old_calls++;
+	mainloop_exit_failure();
+}
+
+static void test_modify_fd(struct test_data *data)
+{
+	check(pipe(data->fds) == 0);
+
+	mainloop_init();
+
+	check(mainloop_add_fd(data->fds[0], EPOLLOUT, fd_callback,
+						data, destroy) == 0);
+	check(mainloop_modify_fd(data->fds[0], EPOLLIN) == 0);
+	check(write(data->fds[1], "a", 1) == 1);
+	check(mainloop_run() == EXIT_FAILURE);
+	check(data->old_calls == 1);
+	check(data->destroys == 1);
+}
+
+static void new_callback(int fd, uint32_t events, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->new_calls++;
+}
+
+static void old_callback(int fd, uint32_t events, void *user_data)
+{
+	struct test_data *data = user_data;
+	int other_fd = fd == data->fds[0] ? data->fds[2] : data->fds[0];
+
+	data->old_calls++;
+	check(mainloop_remove_fd(other_fd) == 0);
+	check(data->destroys == 1);
+	check(mainloop_add_fd(other_fd, EPOLLIN, new_callback, data,
+								destroy) == 0);
+	mainloop_exit_success();
+}
+
+static void test_readd_other_callback(struct test_data *data)
+{
+	check(pipe(&data->fds[0]) == 0);
+	check(pipe(&data->fds[2]) == 0);
+
+	mainloop_init();
+
+	check(mainloop_add_fd(data->fds[0], EPOLLIN, old_callback,
+							data, destroy) == 0);
+	check(mainloop_add_fd(data->fds[2], EPOLLIN, old_callback,
+							data, destroy) == 0);
+	check(write(data->fds[1], "a", 1) == 1);
+	check(write(data->fds[3], "b", 1) == 1);
+
+	check(mainloop_run() == 0);
+
+	check(data->old_calls == 1);
+	check(data->new_calls == 0);
+	check(data->destroys == 3);
+}
+
+static void timeout_callback(int id, void *user_data)
+{
+	struct test_data *data = user_data;
+
+	data->timeout_calls++;
+	if (data->timeout_calls == 1) {
+		check(mainloop_modify_timeout(id, 1) == 0);
+		return;
+	}
+
+	check(mainloop_remove_timeout(id) == 0);
+	mainloop_quit();
+}
+
+static void test_timeout(struct test_data *data)
+{
+	int id;
+
+	mainloop_init();
+
+	id = mainloop_add_timeout(0, timeout_callback, data, destroy);
+	check(id > 0);
+	check(mainloop_modify_timeout(id, 1) == 0);
+	check(mainloop_run() == EXIT_SUCCESS);
+	check(data->timeout_calls == 2);
+	check(data->destroys == 1);
+}
+
+#define define_test(name, function)				\
+	do {							\
+		static struct test_data data = {};		\
+		fprintf(stderr, "%s - ", name);			\
+		function(&data);				\
+		fprintf(stderr, "test passed\n");		\
+		teardown(&data);				\
+	} while (0)
+
+int main(int argc, char *argv[])
+{
+	define_test("Test Modify File Descriptor", test_modify_fd);
+	define_test("Test Re-Add Other Callback", test_readd_other_callback);
+	define_test("Test Timeout", test_timeout);
+	return 0;
+}
-- 
2.55.0

