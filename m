Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E74A35
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743336966; cv=pass; b=i5gXfpoNV+FugMSwFOpJXXOHbV6z4eBLn5wPAJQtuFUmKU/q7u5aW4fli5tEuBx0Ijy3iD5M4NibZgYOPjeSLQEHe/46lsWCN0OEmH7ajjRKh8SXMuAQU5Az8sW5IRAIkZ9d6lRHirwSUBTUc+O8gHSuQqa9dC9APWfADqwphiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743336966; c=relaxed/simple;
	bh=RxcK3wMl7RnX+MoZYt5gpArxqs8+85BEyEIoWpAklkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zuacy2af9Cg/QjdflHamkzs2gj4bNlQ/Giv7EY53ehrqouHtfvge1D38rI9iTwN7jqDF8LQnPk9ZQYPfxv3hEcvA6EPieTysQBk5yrRQ+tsdINEjhuc+zm3YKihJGvQZ0P+15a3Jy0tnjPRKshLcuNFjOKW446C3bVWbhlRKDDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lJvuipG9; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=Ovt7SyD7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lJvuipG9";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="Ovt7SyD7"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4ZQXzL2RNvz49Q2t
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Mar 2025 15:06:06 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1743336366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1AsYdzVkL8EHSPoX207glUVdvQfcCBuFa/iv/0qyOcQ=;
	b=lJvuipG9h0RNxENl+ie5N1l7E3ZuAKQBkXlT/P72SRRijoDXXNpR1V95otw6/ZJjMYtcY9
	kE0WncjeWNkspHaaYDQ+YkILy38XSU/sQm05okNRXeFGUKOTsV21DoG5V/MCA1cNSL4QHS
	AlzypnqRAudLFS9JDRHKyBN7ityHFs2Isp9FmQTpQ6dkNk9iGKQP9cMqzxFOIspU7jSNJi
	UjCVIDg8NxoZ9i3JHmbFFNVdLdBrbk7O4vczSHp2WP+QqFF9YfBv68jexkarjMeXxlQ1cK
	7L/j0RC8+WVaJyj/93GY8xonJ+YrnqWAszmOQqNLge1WM265E7hNpQGDZUWH/w==
Received: from monolith.lan (unknown [193.138.7.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4ZQXz13R4ZzyVF;
	Sun, 30 Mar 2025 15:05:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1743336357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1AsYdzVkL8EHSPoX207glUVdvQfcCBuFa/iv/0qyOcQ=;
	b=Ovt7SyD7i5wKPxKmQ3Ad6yxYIiCyWZPjeK/GqWOjU67iDPKJ6Wg6HOQPdh9Ynf1WWmGsRr
	4QmQ76j5NGTmOl2SYyv+eXwGc+6jGOKRzxQOYMdOjXgy9F+iqm4NHHb8FHfH86Ny7zjfNe
	u5r5yM99OC/vl9xB1/cuEoC0I5bd7qo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1743336357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1AsYdzVkL8EHSPoX207glUVdvQfcCBuFa/iv/0qyOcQ=;
	b=Six7HEUC+wktYSXeTnKB3899Fr3CpqfodjkxaHKomPAHhQhq+rk3MiFeGlMYAmRka5oYKO
	DDQoXeNNeCE5qAJLKuOxmEU4U2Gr/EP8vsfOxJs3/hJ8KrNiFwpC5hX7x3ecXmmuRfGfnE
	rL6Q9Cj/ERjh3jfpoiXUsMAXNhsOkso=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1743336357; a=rsa-sha256; cv=none;
	b=dGFg8t/cEoICsECmL658KzRtBXO/IGcs+K0iEz0P7WkUaalscSTWKIXsgYqQw+/nYUMDJb
	oLitAu08z0Syk/kO3r5B3wvYdnVufMMtjsm665Gkpu1AVyhQLf0IN0Xvc+POjGmL0qnIrb
	e53FYhLYeUtLoGe9SLlTJiV4F1zzI3Y=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] tools: add BPF timestamping tests
Date: Sun, 30 Mar 2025 15:05:43 +0300
Message-ID: <a74e58b9cf12bc9c64a024d18e6e58999202f853.1743336056.git.pav@iki.fi>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add some tests for BPF timestamping on Bluetooth sockets.

These require additional tester kernel config, and at build time
the vmlinux image.

Add cgroup mount to test-runner.

Add documentation to tester config for this.

Add tests:

ISO Send - TX BPF Timestamping
---

Notes:
    This probably needs to wait for the corresponding kernel patch series to
    settle down.

 Makefile.tools      |  29 ++++++
 configure.ac        |  36 ++++++-
 doc/test-runner.rst |  26 ++++-
 doc/tester.config   |   5 +
 tools/iso-tester.c  |  71 ++++++++++++-
 tools/test-runner.c |   1 +
 tools/tester.bpf.c  |  92 +++++++++++++++++
 tools/tester.bpf.h  |   7 ++
 tools/tester.h      | 244 ++++++++++++++++++++++++++++++++++++--------
 9 files changed, 463 insertions(+), 48 deletions(-)
 create mode 100644 tools/tester.bpf.c
 create mode 100644 tools/tester.bpf.h

diff --git a/Makefile.tools b/Makefile.tools
index e60c31b1d..a35af54fc 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -144,6 +144,7 @@ tools_l2cap_tester_SOURCES = tools/l2cap-tester.c tools/tester.h monitor/bt.h \
 				emulator/smp.c
 tools_l2cap_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
+tools_l2cap_tester_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS)
 
 tools_rfcomm_tester_SOURCES = tools/rfcomm-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -191,6 +192,7 @@ tools_sco_tester_SOURCES = tools/sco-tester.c tools/tester.h monitor/bt.h \
 				emulator/smp.c
 tools_sco_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
+tools_sco_tester_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS)
 
 tools_hci_tester_SOURCES = tools/hci-tester.c monitor/bt.h
 tools_hci_tester_LDADD = src/libshared-glib.la $(GLIB_LIBS)
@@ -212,6 +214,7 @@ tools_iso_tester_SOURCES = tools/iso-tester.c tools/tester.h monitor/bt.h \
 				emulator/smp.c
 tools_iso_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
+tools_iso_tester_CPPFLAGS = $(AM_CPPFLAGS) $(GLIB_CFLAGS)
 
 tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
 				emulator/hciemu.h emulator/hciemu.c \
@@ -221,6 +224,32 @@ tools_ioctl_tester_SOURCES = tools/ioctl-tester.c monitor/bt.h \
 				emulator/smp.c
 tools_ioctl_tester_LDADD = lib/libbluetooth-internal.la \
 				src/libshared-glib.la $(GLIB_LIBS)
+
+if TESTING_BPF
+tools/vmlinux.h: $(BPF_VMLINUX)
+	bpftool btf dump file $(BPF_VMLINUX) format c > $@.new
+	mv -f $@.new $@
+
+tools/tester.bpf.o: $(srcdir)/tools/tester.bpf.c tools/vmlinux.h
+	$(CLANG_BPF) -Wall -Werror -Os -g --target=bpf -Itools -c -o $@ $<
+
+tools/tester.skel.h: tools/tester.bpf.o
+	bpftool gen skeleton $< > $@.new
+	mv -f $@.new $@
+
+tools_sco_tester_SOURCES += $(builddir)/tools/tester.skel.h
+tools_iso_tester_SOURCES += $(builddir)/tools/tester.skel.h
+tools_l2cap_tester_SOURCES += $(builddir)/tools/tester.skel.h
+
+tools_sco_tester_CPPFLAGS += -I$(builddir)/tools $(LIBBPF_CFLAGS)
+tools_iso_tester_CPPFLAGS += -I$(builddir)/tools $(LIBBPF_CFLAGS)
+tools_l2cap_tester_CPPFLAGS += -I$(builddir)/tools $(LIBBPF_CFLAGS)
+
+tools_sco_tester_LDADD += $(LIBBPF_LIBS)
+tools_iso_tester_LDADD += $(LIBBPF_LIBS)
+tools_l2cap_tester_LDADD += $(LIBBPF_LIBS)
+endif
+
 endif
 
 if TOOLS
diff --git a/configure.ac b/configure.ac
index 0fa49f686..627b91e77 100644
--- a/configure.ac
+++ b/configure.ac
@@ -390,10 +390,38 @@ AC_ARG_ENABLE(testing, AS_HELP_STRING([--enable-testing],
 AM_CONDITIONAL(TESTING, test "${enable_testing}" = "yes")
 
 if (test "${enable_testing}" = "yes"); then
-   AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETION],
-	[], [], [[#include <time.h>
-		#include <linux/errqueue.h>
-		#include <linux/net_tstamp.h>]])
+	AC_CHECK_DECLS([SOF_TIMESTAMPING_TX_COMPLETION, SCM_TSTAMP_COMPLETION],
+		[], [], [[#include <time.h>
+			#include <linux/errqueue.h>
+			#include <linux/net_tstamp.h>]])
+fi
+
+AC_ARG_ENABLE(testing-bpf, AS_HELP_STRING([--enable-testing-bpf[=PATH/TO/VMLINUX]],
+			[enable BPF testing tools]),
+			[enable_testing_bpf=yes; enable_testing_bpf_arg=${enableval}],
+			[enable_bpf=no])
+AM_CONDITIONAL(TESTING_BPF, test "${enable_testing_bpf}" = "yes")
+
+if (test "${enable_testing_bpf}" = "yes"); then
+	AC_ARG_VAR(CLANG_BPF, [CLANG compiler (for BPF)])
+	AC_ARG_VAR(BPFTOOL, [bpftool])
+	AC_ARG_VAR(BPF_VMLINUX, [vmlinux image to use for BPF testing])
+	AC_PATH_PROG([CLANG_BPF], [clang], "no")
+	if (test "${CLANG_BPF}" == "no"); then
+		AC_MSG_ERROR([clang for BPF missing])
+	fi
+	AC_PATH_PROG([BPFTOOL], [bpftool], "no")
+	if (test "${BPFTOOL}" == "no"); then
+		AC_MSG_ERROR([bpftool missing])
+	fi
+	PKG_CHECK_MODULES(LIBBPF, libbpf >= 1.4, [], [AC_MSG_ERROR([libbpf missing])])
+        if (test "${enable_testing_bpf_arg}" != "yes"); then
+		BPF_VMLINUX=${enable_testing_bpf_arg}
+	elif (test "${BPF_VMLINUX}" = ""); then
+		BPF_VMLINUX=/sys/kernel/btf/vmlinux
+	fi
+	AC_MSG_NOTICE([using BPF_VMLINUX=${BPF_VMLINUX} for BPF testing])
+	AC_DEFINE(HAVE_BPF, 1, [Define to 1 if bpf testing is required])
 fi
 
 AC_ARG_ENABLE(experimental, AS_HELP_STRING([--enable-experimental],
diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 423a9379c..549b2bcba 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -91,8 +91,8 @@ Bluetooth
 
 	CONFIG_UHID=y
 
-Lock debuging
--------------
+Lock debugging
+--------------
 
 To catch locking related issues the following set of kernel config
 options may be useful:
@@ -110,6 +110,19 @@ options may be useful:
 	CONFIG_DEBUG_MUTEXES=y
 	CONFIG_KASAN=y
 
+BPF testing
+-----------
+
+For BPF related tests:
+
+.. code-block::
+
+	CONFIG_BPF=y
+	CONFIG_BPF_JIT=y
+	CONFIG_CGROUPS=y
+	CONFIG_CGROUP_BPF=y
+
+
 EXAMPLES
 ========
 
@@ -127,6 +140,15 @@ Running a specific test of mgmt-tester
 
 	$ tools/test-runner -k /pathto/bzImage -- tools/mgmt-tester -s "<name>"
 
+Compiling and running BPF tests
+-------------------------------
+
+.. code-block::
+
+	$ ./configure --enable-testing --enable-testing-bpf=/home/me/linux/vmlinux
+	$ make
+	$ tools/test-runner -k /home/me/linux/arch/x86_64/boot/bzImage -- tools/iso-tester -s BPF
+
 Running bluetoothctl with emulated controller
 ---------------------------------------------
 
diff --git a/doc/tester.config b/doc/tester.config
index 099eddc79..548e4c629 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -57,3 +57,8 @@ CONFIG_PROVE_RCU=y
 CONFIG_LOCKDEP=y
 CONFIG_DEBUG_MUTEXES=y
 CONFIG_KASAN=y
+
+CONFIG_BPF=y
+CONFIG_BPF_JIT=y
+CONFIG_CGROUPS=y
+CONFIG_CGROUP_BPF=y
diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 350775fdd..da164c771 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -517,6 +517,9 @@ struct iso_client_data {
 
 	/* Disable BT_POLL_ERRQUEUE before enabling TX timestamping */
 	bool no_poll_errqueue;
+
+	/* Enable BPF TX timestamping */
+	bool bpf_timestamping;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io,
@@ -697,6 +700,13 @@ static void test_pre_setup(const void *test_data)
 			return;
 	}
 
+#ifndef HAVE_BPF
+	if (isodata && isodata->bpf_timestamping) {
+		if (tester_pre_setup_skip_by_default())
+			return;
+	}
+#endif
+
 	data->mgmt = mgmt_new_default();
 	if (!data->mgmt) {
 		tester_warn("Failed to setup management interface");
@@ -738,6 +748,8 @@ static void test_post_teardown(const void *test_data)
 			  NULL, NULL, NULL);
 	}
 
+	tx_tstamp_teardown(&data->tx_ts);
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -776,7 +788,7 @@ static void test_data_free(void *test_data)
 		user->accept_reason = reason; \
 		tester_add_full(name, data, \
 				test_pre_setup, setup, func, NULL, \
-				test_post_teardown, 2, user, test_data_free); \
+				test_post_teardown, 3, user, test_data_free); \
 	} while (0)
 
 #define test_iso(name, data, setup, func) \
@@ -1094,6 +1106,19 @@ static const struct iso_client_data connect_send_tx_no_poll_timestamping = {
 	.no_poll_errqueue = true,
 };
 
+static const struct iso_client_data connect_send_tx_bpf_timestamping = {
+	.qos = QOS_16_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.so_timestamping = (SOF_TIMESTAMPING_SOFTWARE |
+					SOF_TIMESTAMPING_OPT_ID |
+					SOF_TIMESTAMPING_TX_SOFTWARE |
+					SOF_TIMESTAMPING_TX_COMPLETION),
+	.repeat_send = 1,
+	.repeat_send_pre_ts = 2,
+	.bpf_timestamping = true,
+};
+
 static const struct iso_client_data listen_16_2_1_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -2254,6 +2279,24 @@ static gboolean iso_fail_errqueue(GIOChannel *io, GIOCondition cond,
 	return FALSE;
 }
 
+static gboolean iso_bpf_io(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct test_data *data = user_data;
+	int err;
+
+	err = tx_tstamp_bpf_process(&data->tx_ts, &data->step);
+	if (err > 0)
+		return TRUE;
+	else if (err)
+		tester_test_failed();
+	else if (!data->step)
+		tester_test_passed();
+
+	data->io_id[2] = 0;
+	return FALSE;
+}
+
 static gboolean iso_timer_errqueue(gpointer user_data)
 {
 	struct test_data *data = user_data;
@@ -2293,7 +2336,24 @@ static void iso_tx_timestamping(struct test_data *data, GIOChannel *io)
 
 	sk = g_io_channel_unix_get_fd(io);
 
-	if (isodata->no_poll_errqueue) {
+	if (isodata->bpf_timestamping) {
+		GIOChannel *bpf_io;
+
+		err = tx_tstamp_bpf_start(&data->tx_ts, sk);
+		if (err < 0) {
+			tester_warn("BPF timestamping failed: %s (%d)",
+				strerror(-err), err);
+			tester_test_failed();
+			return;
+		}
+
+		bpf_io = g_io_channel_unix_new(err);
+		data->io_id[2] = g_io_add_watch(bpf_io,
+						G_IO_IN | G_IO_ERR | G_IO_HUP,
+						iso_bpf_io, data);
+		g_io_channel_unref(bpf_io);
+		return;
+	} else if (isodata->no_poll_errqueue) {
 		uint32_t flag = 0;
 
 		err = setsockopt(sk, SOL_BLUETOOTH, BT_POLL_ERRQUEUE,
@@ -2393,6 +2453,8 @@ static void iso_send(struct test_data *data, GIOChannel *io)
 	for (count = 0; count < isodata->repeat_send + 1; ++count)
 		iso_send_data(data, io);
 
+	g_io_channel_set_close_on_unref(io, FALSE);
+
 	if (isodata->bcast) {
 		tester_test_passed();
 		return;
@@ -3647,6 +3709,11 @@ int main(int argc, char *argv[])
 			&connect_send_tx_no_poll_timestamping, setup_powered,
 			test_connect);
 
+	/* Test TX timestamping using BPF */
+	test_iso("ISO Send - TX BPF Timestamping",
+			&connect_send_tx_bpf_timestamping, setup_powered,
+			test_connect);
+
 	test_iso("ISO Receive - Success", &listen_16_2_1_recv, setup_powered,
 							test_listen);
 
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 1d770330c..84c0f90ad 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -127,6 +127,7 @@ static const struct {
 	{ "tmpfs",    "/run",     "mode=0755", MS_NOSUID|MS_NODEV|MS_STRICTATIME },
 	{ "tmpfs",    "/tmp",              NULL, 0 },
 	{ "debugfs",  "/sys/kernel/debug", NULL, 0 },
+	{ "cgroup2",  "/sys/fs/cgroup", NULL, 0 },
 	{ }
 };
 
diff --git a/tools/tester.bpf.c b/tools/tester.bpf.c
new file mode 100644
index 000000000..9aed99aad
--- /dev/null
+++ b/tools/tester.bpf.c
@@ -0,0 +1,92 @@
+#include "vmlinux.h"
+
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include <bpf/bpf_core_read.h>
+
+#ifndef AF_BLUETOOTH
+#define AF_BLUETOOTH 31
+#endif
+
+#ifndef SOL_SOCKET
+#define SOL_SOCKET 1
+#endif
+
+#include "tester.bpf.h"
+
+struct {
+	__uint(type, BPF_MAP_TYPE_RINGBUF);
+	__uint(max_entries, 256 * 1024);
+} tx_tstamp_events SEC(".maps");
+
+static inline void tx_tstamp_event_emit(__u32 type, __u32 tskey)
+{
+	struct tx_tstamp_event *event;
+
+	event = bpf_ringbuf_reserve(&tx_tstamp_events, sizeof(*event), 0);
+	if (!event)
+		return;
+
+	event->type = type;
+	event->id = tskey;
+	event->nsec = bpf_ktime_get_ns();
+
+	bpf_ringbuf_submit(event, 0);
+}
+
+SEC("sockops")
+int skops_sockopt(struct bpf_sock_ops *skops)
+{
+	struct bpf_sock *bpf_sk = skops->sk;
+	struct bpf_sock_ops_kern *skops_kern;
+	struct skb_shared_info *shinfo;
+	const struct sk_buff *skb;
+
+	if (!bpf_sk)
+		return 1;
+
+	if (skops->family != AF_BLUETOOTH)
+		return 1;
+
+	skops_kern = bpf_cast_to_kern_ctx(skops);
+	skb = skops_kern->skb;
+	shinfo = bpf_core_cast(skb->head + skb->end, struct skb_shared_info);
+
+	switch (skops->op) {
+	case BPF_SOCK_OPS_TSTAMP_SENDMSG_CB:
+		bpf_sock_ops_enable_tx_tstamp(skops_kern, 0);
+		break;
+	case BPF_SOCK_OPS_TSTAMP_SCHED_CB:
+		tx_tstamp_event_emit(SCM_TSTAMP_SCHED, shinfo->tskey);
+		break;
+	case BPF_SOCK_OPS_TSTAMP_SND_SW_CB:
+		tx_tstamp_event_emit(SCM_TSTAMP_SND, shinfo->tskey);
+		break;
+	case BPF_SOCK_OPS_TSTAMP_ACK_CB:
+		tx_tstamp_event_emit(SCM_TSTAMP_ACK, shinfo->tskey);
+		break;
+	case BPF_SOCK_OPS_TSTAMP_COMPLETION_CB:
+		tx_tstamp_event_emit(SCM_TSTAMP_COMPLETION, shinfo->tskey);
+		break;
+	}
+
+	return 1;
+}
+
+SEC("cgroup/setsockopt")
+int _setsockopt(struct bpf_sockopt *ctx)
+{
+	if (ctx->level == SOL_CUSTOM_TESTER) {
+		int flag = SK_BPF_CB_TX_TIMESTAMPING;
+
+		bpf_setsockopt(ctx->sk, SOL_SOCKET,
+			SK_BPF_CB_FLAGS, &flag, sizeof(flag));
+
+		ctx->optlen = -1;
+		return 1;
+	}
+
+	return 1;
+}
+
+char _license[] SEC("license") = "GPL";
diff --git a/tools/tester.bpf.h b/tools/tester.bpf.h
new file mode 100644
index 000000000..1b3d06bc8
--- /dev/null
+++ b/tools/tester.bpf.h
@@ -0,0 +1,7 @@
+struct tx_tstamp_event {
+	__u32 type;
+	__u32 id;
+	__u64 nsec;
+};
+
+#define SOL_CUSTOM_TESTER	0x89abcdef
diff --git a/tools/tester.h b/tools/tester.h
index 4e7d7226b..02d2f1d34 100644
--- a/tools/tester.h
+++ b/tools/tester.h
@@ -11,13 +11,22 @@
 #include <stdlib.h>
 #include <stdint.h>
 #include <time.h>
+#include <fcntl.h>
+#include <sys/stat.h>
 #include <sys/socket.h>
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 
 #include <glib.h>
 
-#define SEC_NSEC(_t)  ((_t) * 1000000000LL)
+#ifdef HAVE_BPF
+#include <linux/bpf.h>
+#include <bpf/libbpf.h>
+#include "tester.bpf.h"
+#include "tester.skel.h"
+#endif
+
+#define SEC_NSEC(_t)  ((_t) * 1000000000ULL)
 #define TS_NSEC(_ts)  (SEC_NSEC((_ts)->tv_sec) + (_ts)->tv_nsec)
 
 #if !HAVE_DECL_SOF_TIMESTAMPING_TX_COMPLETION
@@ -39,6 +48,12 @@ struct tx_tstamp_data {
 	unsigned int sent;
 	uint32_t so_timestamping;
 	bool stream;
+#ifdef HAVE_BPF
+	struct tester_bpf *skel;
+	struct ring_buffer *buf;
+	int cgroup_fd;
+	int bpf_err;
+#endif
 };
 
 static inline void tx_tstamp_init(struct tx_tstamp_data *data,
@@ -88,6 +103,51 @@ static inline int tx_tstamp_expect(struct tx_tstamp_data *data, size_t len)
 	return steps;
 }
 
+static inline int tx_tstamp_validate(struct tx_tstamp_data *data,
+				const char *source, uint32_t type, uint32_t id,
+				uint64_t nsec, uint64_t now)
+{
+	unsigned int i;
+
+	if (now < nsec || now > nsec + SEC_NSEC(10)) {
+		tester_warn("nonsense in timestamp");
+		return -EINVAL;
+	}
+
+	if (data->pos >= data->count) {
+		tester_warn("Too many timestamps");
+		return -EINVAL;
+	}
+
+	/* Find first unreceived timestamp of the right type */
+	for (i = 0; i < data->count; ++i) {
+		if (data->expect[i].type >= 0xffff)
+			continue;
+
+		if (type == data->expect[i].type) {
+			data->expect[i].type = 0xffff;
+			break;
+		}
+	}
+	if (i == data->count) {
+		tester_warn("Bad timestamp type %u", type);
+		return -EINVAL;
+	}
+
+	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
+				id != data->expect[i].id) {
+		tester_warn("Bad timestamp id %u", id);
+		return -EINVAL;
+	}
+
+	tester_print("Got valid %s TX timestamp %u (type %u, id %u)",
+							source, i, type, id);
+
+	++data->pos;
+
+	return data->count - data->pos;
+}
+
 static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 {
 	unsigned char control[512];
@@ -99,7 +159,6 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 	struct scm_timestamping *tss = NULL;
 	struct sock_extended_err *serr = NULL;
 	struct timespec now;
-	unsigned int i;
 
 	iov.iov_base = buf;
 	iov.iov_len = sizeof(buf);
@@ -159,42 +218,147 @@ static inline int tx_tstamp_recv(struct tx_tstamp_data *data, int sk, int len)
 
 	clock_gettime(CLOCK_REALTIME, &now);
 
-	if (TS_NSEC(&now) < TS_NSEC(tss->ts) ||
-			TS_NSEC(&now) > TS_NSEC(tss->ts) + SEC_NSEC(10)) {
-		tester_warn("nonsense in timestamp");
-		return -EINVAL;
-	}
-
-	if (data->pos >= data->count) {
-		tester_warn("Too many timestamps");
-		return -EINVAL;
-	}
-
-	/* Find first unreceived timestamp of the right type */
-	for (i = 0; i < data->count; ++i) {
-		if (data->expect[i].type >= 0xffff)
-			continue;
-
-		if (serr->ee_info == data->expect[i].type) {
-			data->expect[i].type = 0xffff;
-			break;
-		}
-	}
-	if (i == data->count) {
-		tester_warn("Bad timestamp type %u", serr->ee_info);
-		return -EINVAL;
-	}
-
-	if ((data->so_timestamping & SOF_TIMESTAMPING_OPT_ID) &&
-				serr->ee_data != data->expect[i].id) {
-		tester_warn("Bad timestamp id %u", serr->ee_data);
-		return -EINVAL;
-	}
-
-	tester_print("Got valid TX timestamp %u (type %u, id %u)", i,
-						serr->ee_info, serr->ee_data);
-
-	++data->pos;
-
-	return data->count - data->pos;
+	return tx_tstamp_validate(data, "socket", serr->ee_info, serr->ee_data,
+					TS_NSEC(tss->ts), TS_NSEC(&now));
 }
+
+
+#ifdef HAVE_BPF
+
+static inline int tx_tstamp_event_handler(void *ctx, void *buf, size_t size)
+{
+	struct tx_tstamp_data *data = ctx;
+	struct tx_tstamp_event *event = buf;
+	struct timespec now;
+
+	if (size < sizeof(*event)) {
+		tester_warn("Bad BPF event");
+		return -EIO;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+
+	data->bpf_err = tx_tstamp_validate(data, "BPF", event->type, event->id,
+						event->nsec, TS_NSEC(&now));
+	return data->bpf_err;
+}
+
+static inline int tx_tstamp_bpf_start(struct tx_tstamp_data *data, int sk)
+{
+	int flag;
+
+	data->cgroup_fd = open("/sys/fs/cgroup", O_RDONLY);
+	if (data->cgroup_fd < 0) {
+		tester_warn("opening cgroup failed");
+		goto fail;
+	}
+
+	data->skel = tester_bpf__open_and_load();
+	if (!data->skel)
+		goto fail;
+
+	data->buf = ring_buffer__new(
+			bpf_map__fd(data->skel->maps.tx_tstamp_events),
+			tx_tstamp_event_handler, data, NULL);
+	if (!data->buf) {
+		tester_warn("ringbuffer failed");
+		goto fail;
+	}
+
+	if (tester_bpf__attach(data->skel)) {
+		tester_warn("attach failed");
+		goto fail;
+	}
+
+	data->skel->links.skops_sockopt =
+		bpf_program__attach_cgroup(data->skel->progs.skops_sockopt,
+							data->cgroup_fd);
+	if (!data->skel->links.skops_sockopt) {
+		tester_warn("BFP sockops attach cgroup failed");
+		goto fail;
+	}
+
+	data->skel->links._setsockopt =
+		bpf_program__attach_cgroup(data->skel->progs._setsockopt,
+							data->cgroup_fd);
+	if (!data->skel->links._setsockopt) {
+		tester_warn("BFP setsockopt attach cgroup failed");
+		goto fail;
+	}
+
+	flag = 0;
+	if (setsockopt(sk, SOL_CUSTOM_TESTER, 0, &flag, sizeof(flag))) {
+		tester_warn("BFP setsockopt failed");
+		goto fail;
+	}
+
+	tester_print("BPF test program attached");
+	return ring_buffer__epoll_fd(data->buf);
+
+fail:
+	if (data->buf)
+		ring_buffer__free(data->buf);
+	if (data->skel)
+		tester_bpf__destroy(data->skel);
+	if (data->cgroup_fd > 0)
+		close(data->cgroup_fd);
+	data->buf = NULL;
+	data->skel = NULL;
+	data->cgroup_fd = 0;
+	return -EIO;
+}
+
+static inline bool tx_tstamp_bpf_process(struct tx_tstamp_data *data, int *step)
+{
+	int err;
+
+	err = ring_buffer__consume(data->buf);
+	if (err < 0) {
+		data->bpf_err = err;
+	} else if (step) {
+		if (*step >= err)
+			*step -= err;
+		else
+			data->bpf_err = -E2BIG;
+	}
+
+	return data->bpf_err;
+}
+
+static inline void tx_tstamp_teardown(struct tx_tstamp_data *data)
+{
+	if (data->skel)
+		tester_bpf__detach(data->skel);
+	if (data->cgroup_fd > 0)
+		close(data->cgroup_fd);
+	if (data->buf)
+		ring_buffer__free(data->buf);
+	if (data->skel) {
+		tester_bpf__destroy(data->skel);
+		tester_print("BPF test program removed");
+	}
+
+	data->buf = NULL;
+	data->skel = NULL;
+	data->cgroup_fd = 0;
+}
+
+#else
+
+static inline int tx_tstamp_bpf_start(struct tx_tstamp_data *data, int sk)
+{
+	tester_warn("Tester compiled without BPF");
+	return -EOPNOTSUPP;
+}
+
+static inline bool tx_tstamp_bpf_process(struct tx_tstamp_data *data, int *step)
+{
+	return false;
+}
+
+static inline void tx_tstamp_teardown(struct tx_tstamp_data *data)
+{
+}
+
+#endif
+
-- 
2.49.0

