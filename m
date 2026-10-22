Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792684045;
	b=XAjN9hte60ig44dmWemmLWMQnyQZdX5T9YsI+BZt9sivnRIaJVy5hExHVL1xRyUw/wDE
	 i/1BPIEGbBs06gBQG2IRUz8VSzu7gSDxzkzzENmO/E0yirEFFaUqC2jA2wr9uXNAZQ37C
	 7FDBIMilJiogCFYInpgMLy984qVjN1wG+9ez5T12u1mGQf8dYT9t1jygM9STMvAc1Zf+p
	 fzcpJpqn+Qurkkf2sYIrWzQFRm04Z1H65vA5etIvn27diS0/0n/nwW+vdKw7TuhTB6JAM
	 bgD9hopQD5nocYtGENmz+uB7OpkzDfqAWChLunoknHdlLGSPGjmwYPB/YyP+YmyiNnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792684045;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yPfhAr/kgFvvrIbHOQqVZI7AEw1UttCFlOhR50EBP2o=;
	b=aPLhTZrSvHN5fir8kOw5BCUr04l5FyGyh9MUq/mhf2p3XujCHv+6AmQTeIq0aQDNAtgK
	 ek2cPDk/N4r87Qb+7n9Uqoe3JrZ8owe4xXJkmZYRUKmA8wTjTYp1sbL94hAndptk3KJCn
	 I47BsbM6PKI0haIHjfzVAsftKq3Nuk5AUPlF12NAJkbOH56wXAIQ5DqKnlSOv3ax0vaHW
	 74NwcEx2uVBq4k6p9TCgQwIUg/xn1LJH0AdM2AA4La7LFqYb3L+gqsrzyF6h4f08asz99
	 Pi3gV9hRKg3tU5NfGmAFlonB0RJq+HfnqYoZ4yhrqxdE+oTzaE7B4K0oi4qvoSjicww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="HB/R2kx5";
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E31606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 15:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23E31606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HB/R2kx5
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eadadf23e5so7138e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 08:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792684044; x=1793288844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yPfhAr/kgFvvrIbHOQqVZI7AEw1UttCFlOhR50EBP2o=;
        b=HB/R2kx5vgWImwV+gRCyywJhurQk6PYAHhk+ykR0kiSKStPZnzHtlu92xI59sxNWUv
         b9QTzdrVuAkdmHl0SpeoUPNYBIftyFQzBIaZKxIbLTv2Qx5EScfgln9QJS1iPWDq7zLo
         QyFfLPAouFxJYh9eEfdW/9CGwmRjucgz60Uby6SKqJ2qc9W9bZ+2t8jL2H6pfoOs3iNM
         sC8qT3+5lo6yXpNIGhwEVT//lXS7iLYlaseB/f8769C3GWB/RgH8IPFaECYrQd3B/Yl9
         7UPVsLbS1GQBckQIoZxNU6mqFtKv0/s3/Rx/fK8vcSpwA27hSEdMbgLtEBKUXiSTlHOX
         bFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792684044; x=1793288844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yPfhAr/kgFvvrIbHOQqVZI7AEw1UttCFlOhR50EBP2o=;
        b=HVYuhyPeAZtRcJrSXAL1EKjzaLP0QwG9gFq2ZO33LXHkLM5n7kbwX4WkdT/2qJJqM2
         JfLHVsiVBgORLOEu7bfh9y184uE4TT/Z3BDqyPyRTjE5Ufx8v1jlWQNADfk6A3p1POZx
         VohYSTD/51CC7aMUOkOHmeRbpBSks/6p0B/ZtowP1+6vlylpeDUOto945PjwIyM///Eu
         MGrqeCQXR1iBfYSOUb78R4CRRb+zkTcU3v1c637vtxeIoEHwpWFM0eFRI93TIUla5vZL
         1kT15xkYjztcEMAEIP7nX7kFWB490tyc3PCAE6NVSYm73oAl24mHMcNK38JbxHCZapuo
         cuwA==
X-Gm-Message-State: AFq9FYKJJHP6HmhUjfAnhHkFbYehPjGC5JltygBXHDMhMfoniHRhzAd2
	Tn2xW40GGCGSK2r4mHAHdHigjAsJALCBniWj9KDxirX2YQJVI66LiEubBC2Z1XxA6yk=
X-Gm-Gg: AYBFou2d1MARA6E0fp6aJv5VFmOSh3b9HeNFAs9eWfOR8xRL4BagQ4Fzq/JRcl3Ioyi
	l5VY4pSw3HsgUcyqeTYDtAoL0ZuwGSx70PLTYK4PgQ32wt4kuYA1kUk0VAdwVib0IoPYPpSfE2f
	vhDLeQ+jzitZSsvYqh4llVtsdZ7bM1dgLlI/ccZlTrfr6Zz1MCrBijkShK8Vos1kfrFav1Bg76/
	UyHaUkREZF31e7ZdmhvOhX9rKF+jnLQii3lTh90ZDSLovE0/bWSxkcj72kcNHhsIpQqrWTAe6Bp
	olsdGLMr3k1HgYLBLK6HOsIsrbBU/mEXmfLIZHxpAI3a1nu3FbRoSwpC07Ge9N3+o2SN4XJnYOR
	FuqXi9EUblrCWps032PdRQ5RvtK1rN+UV95PYIH34eTizD1hQkRoNHt3HCNjaDdT5+mDI8B0i4S
	7LwX5wjyJDtxw2WwGVXMptdyvfVJBn8sSKWsR35ZxMRSPcwjhP56F160vRgp+PMzJ25ttqjGweL
	veNn7QP8cHkA2AtTLWBraHx6ZnEc8hURvHvFGx10hIMVTFsWJ2Dv7n3qUh25JQgVZaCK61Kpi14
	JvosHe8O+mbmeFS/FZEjjI0FPrj2FE/oE7N7XjTDkek8fQ==
X-Received: by 2002:a05:6122:4b86:b0:5ea:cfd9:8fbd with SMTP id 71dfb90a1353d-5eaebe45a71mr2469688e0c.17.1792684043850;
        Thu, 22 Oct 2026 08:47:23 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eae97df494sm7307079e0c.10.2026.10.22.08.47.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 08:47:23 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 15/27] tools/test-runner: Add User Mode Linux support
Date: Thu, 22 Oct 2026 11:46:48 -0400
Message-ID: <20261022154701.3959500-16-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Accept a User Mode Linux kernel with -k, detected by its .uml.setup.init
section, and run it directly with the host filesystem as root and
test-runner as init, as is done with QEMU. Options given with -o are
passed as kernel parameters, e.g. virtio_uml.device=<socket>:<id> for
devices served from the host. The guest powers off at the end, as
rebooting User Mode Linux starts it again, and mounts the coverage
directory with hostfs instead of 9p.

Add -T, --time-travel, which starts btvirt --time as time travel
calendar and joins the guest to it, so the same kernel runs with or
without simulated time by adding -T. The calendar is stopped when the
guest exits. The kernel needs CONFIG_UML_TIME_TRAVEL_SUPPORT, checked
with its --help, which only lists time-travel=ext with it.

Wall clock time of the testers, all tests passing, same kernel version
and machine, User Mode Linux with seccomp:

  tester            tests    KVM    UML    UML -T
  mgmt-tester         514   83.6  111.6     42.6
  l2cap-tester        111    9.6   13.7     10.2
  iso-tester          141   13.7   24.3     16.3
  sco-tester           30    5.1    4.1      3.6
  rfcomm-tester        11    3.6    2.0      2.6
  smp-tester            8    4.1    1.5      1.5
  ioctl-tester         28    4.1    2.6      3.1
  userchan-tester       4    2.6    1.5      1.5
  bnep-tester           1    2.6    1.0      1.0

Assisted-by: Claude:claude-opus-5-5
---
 doc/test-runner.rst |  46 ++++-
 tools/test-runner.c | 399 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 431 insertions(+), 14 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 52178244fce8..02d69b06f54c 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -26,9 +26,12 @@ OPTIONS
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-H/--qemu-host-cpu: Use host CPU (requires KVM support)
-:-k/--kernel=<image>: Kernel image (bzImage)
+:-k/--kernel=<image>: Kernel image (bzImage) or User Mode Linux binary
 :-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
-:-o/--option=<opt>: Additional argument passed to QEMU
+:-T/--time-travel: Run a User Mode Linux kernel on simulated time, with
+    btvirt as time travel calendar
+:-o/--option=<opt>: Additional argument passed to QEMU, or kernel
+    parameter with User Mode Linux
 :-h/--help: Show help options
 
 ARCHITECTURE
@@ -134,6 +137,28 @@ additional channels between the launcher and the guest are added, for
 example by **test-functional(1)**, which attaches its own virtio-serial
 ports and a writable shared directory this way.
 
+User Mode Linux
+---------------
+
+When ``-k`` is a User Mode Linux (UML) binary, recognized by its
+``.uml.setup.init`` section, test-runner runs it directly instead of QEMU,
+with the host filesystem mounted as root through hostfs, and powers it off
+at the end since rebooting UML starts it again. The kernel needs
+``CONFIG_HOSTFS``, and ``CONFIG_VIRTIO_UML`` for virtio devices.
+
+``-o`` then adds kernel parameters, which is how UML attaches devices served
+from the host, e.g. ``virtio_uml.device=<socket>:40`` for a virtio
+Bluetooth controller, or joins an external simulated clock with
+``time-travel=ext:<socket>``. See `virtio.rst <virtio.rst>`_. ``-u``,
+``-U``, ``-P``, ``-q`` and ``-H`` need QEMU.
+
+With ``-T``, test-runner starts **btvirt(1)** ``--time`` as time travel
+calendar and runs the guest on its simulated clock: time only advances when
+the guest waits, so it skips idle time and timeouts take no real time, while
+the guest sees the same timings on every run. This needs a kernel with
+``CONFIG_UML_TIME_TRAVEL_SUPPORT``, which test-runner checks; without
+``-T`` the same kernel runs on real time.
+
 Kernel
 ======
 
@@ -385,3 +410,20 @@ exits.
 Note that unlike the other modes, PCIe-passthrough boots the guest with ACPI
 and APIC enabled, as these are required for device enumeration and MSI
 interrupt delivery.
+
+Running mgmt-tester under User Mode Linux
+-----------------------------------------
+
+.. code-block::
+
+	$ make ARCH=um defconfig
+	$ scripts/kconfig/merge_config.sh -m .config <bluez>/doc/tester.config
+	$ make ARCH=um olddefconfig linux
+	$ tools/test-runner -k <linux>/linux -- tools/mgmt-tester
+
+On simulated time, with a kernel that also has
+``CONFIG_UML_TIME_TRAVEL_SUPPORT=y``:
+
+.. code-block::
+
+	$ tools/test-runner -T -k <linux>/linux -- tools/mgmt-tester
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 21de3a50da5e..8be4bfb09265 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -43,6 +43,8 @@
 #include "bluetooth/hci_lib.h"
 #include "tools/hciattach.h"
 
+#include <elf.h>
+
 #ifndef WAIT_ANY
 #define WAIT_ANY (-1)
 #endif
@@ -64,6 +66,7 @@ static bool start_dbus_session;
 static bool start_daemon = false;
 static bool start_monitor = false;
 static bool qemu_host_cpu = false;
+static bool time_travel;
 static int num_devs = 0;
 static int num_emulator = 0;
 static const char *device_path = "/tmp/bt-server-bredr";
@@ -155,9 +158,79 @@ static const char *kernel_table[] = {
 	"arch/x86/boot/bzImage",
 	"vmlinux",
 	"arch/x86/boot/vmlinux",
+	"linux",
 	NULL
 };
 
+/* A User Mode Linux kernel is an executable with the .uml.setup.init
+ * section, through which it registers its command line options.
+ */
+static bool is_uml_kernel(const char *path)
+{
+	Elf64_Ehdr ehdr;
+	Elf64_Shdr *shdrs = NULL;
+	char *names = NULL;
+	bool found = false;
+	size_t size;
+	FILE *fp;
+	int i;
+
+	fp = fopen(path, "re");
+	if (!fp)
+		return false;
+
+	if (fread(&ehdr, sizeof(ehdr), 1, fp) != 1 ||
+			memcmp(ehdr.e_ident, ELFMAG, SELFMAG) ||
+			ehdr.e_ident[EI_CLASS] != ELFCLASS64 ||
+			ehdr.e_shentsize != sizeof(Elf64_Shdr) ||
+			ehdr.e_shstrndx >= ehdr.e_shnum)
+		goto done;
+
+	shdrs = calloc(ehdr.e_shnum, sizeof(*shdrs));
+	if (!shdrs || fseek(fp, ehdr.e_shoff, SEEK_SET) ||
+			fread(shdrs, sizeof(*shdrs), ehdr.e_shnum, fp) !=
+							ehdr.e_shnum)
+		goto done;
+
+	size = shdrs[ehdr.e_shstrndx].sh_size;
+	names = calloc(1, size + 1);
+	if (!names || fseek(fp, shdrs[ehdr.e_shstrndx].sh_offset, SEEK_SET) ||
+			fread(names, size, 1, fp) != 1)
+		goto done;
+
+	for (i = 0; i < ehdr.e_shnum; i++) {
+		if (shdrs[i].sh_name < size &&
+				!strcmp(names + shdrs[i].sh_name,
+						".uml.setup.init")) {
+			found = true;
+			break;
+		}
+	}
+
+done:
+	free(names);
+	free(shdrs);
+	fclose(fp);
+	return found;
+}
+
+static bool is_uml_guest(void)
+{
+	char cmdline[CMDLINE_MAX];
+	bool uml = false;
+	FILE *fp;
+
+	fp = fopen("/proc/cmdline", "re");
+	if (!fp)
+		return false;
+
+	if (fgets(cmdline, sizeof(cmdline), fp))
+		uml = strstr(cmdline, "TESTUML=1") != NULL;
+
+	fclose(fp);
+	return uml;
+}
+
 static bool find_kernel(const char *root, char path[PATH_MAX])
 {
 	struct stat st;
@@ -615,6 +688,12 @@ static void coverage_mount(const char *dir)
 
 	printf("Mounting %s writable for coverage\n", dir);
 
+	if (is_uml_guest()) {
+		if (mount("none", dir, "hostfs", 0, dir) < 0)
+			perror("Failed to mount coverage directory");
+		return;
+	}
+
 	if (mount(COVERAGE_TAG, dir, "9p", 0,
 				"trans=virtio,version=9p2000.L") < 0)
 		perror("Failed to mount coverage directory");
@@ -952,6 +1031,254 @@ static int start_qemu(void)
 	return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
 }
 
+static const char *find_btvirt(void);
+
+#define TT_DIR_MAX	32
+
+/* A User Mode Linux kernel built with time travel support lists the
+ * external mode, time-travel=ext, in its help.
+ */
+static bool uml_has_time_travel(void)
+{
+	char *line = NULL;
+	bool found = false;
+	size_t size = 0;
+	int fds[2];
+	FILE *fp;
+	pid_t pid;
+
+	if (pipe(fds) < 0)
+		return false;
+
+	pid = fork();
+	if (pid < 0) {
+		close(fds[0]);
+		close(fds[1]);
+		return false;
+	}
+
+	if (pid == 0) {
+		dup2(fds[1], STDOUT_FILENO);
+		close(fds[0]);
+		close(fds[1]);
+		execl(kernel_image, kernel_image, "--help", NULL);
+		exit(EXIT_FAILURE);
+	}
+
+	close(fds[1]);
+
+	fp = fdopen(fds[0], "r");
+	if (!fp) {
+		close(fds[0]);
+		waitpid(pid, NULL, 0);
+		return false;
+	}
+
+	while (getline(&line, &size, fp) > 0) {
+		if (strstr(line, "time-travel=ext"))
+			found = true;
+	}
+
+	free(line);
+	fclose(fp);
+	waitpid(pid, NULL, 0);
+
+	return found;
+}
+
+/* Start btvirt as time travel calendar for the guest, in a new directory
+ * for its socket. Returns the pid of btvirt, or -1 on failure.
+ */
+static pid_t start_calendar(char dir[TT_DIR_MAX])
+{
+	const char *btvirt;
+	char opt[PATH_MAX], sock[PATH_MAX];
+	struct stat st;
+	pid_t pid;
+	int i;
+
+	btvirt = find_btvirt();
+	if (!btvirt) {
+		fprintf(stderr, "Failed to locate btvirt binary\n");
+		return -1;
+	}
+
+	snprintf(dir, TT_DIR_MAX, "/tmp/test-runner-tt.XXXXXX");
+	if (!mkdtemp(dir)) {
+		perror("Failed to create time travel directory");
+		return -1;
+	}
+
+	snprintf(opt, sizeof(opt), "--time=%s", dir);
+	snprintf(sock, sizeof(sock), "%s/bt-time", dir);
+
+	printf("Starting time travel calendar %s %s\n", btvirt, opt);
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		rmdir(dir);
+		return -1;
+	}
+
+	if (pid == 0) {
+		execl(btvirt, btvirt, opt, NULL);
+		exit(EXIT_FAILURE);
+	}
+
+	for (i = 0; i < 100; i++) {
+		if (!stat(sock, &st))
+			return pid;
+
+		if (waitpid(pid, NULL, WNOHANG) == pid)
+			break;
+
+		usleep(50000);
+	}
+
+	fprintf(stderr, "Time travel calendar did not start\n");
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+	rmdir(dir);
+
+	return -1;
+}
+
+static void stop_calendar(pid_t pid, const char *dir)
+{
+	char sock[PATH_MAX];
+
+	kill(pid, SIGTERM);
+	waitpid(pid, NULL, 0);
+
+	snprintf(sock, sizeof(sock), "%s/bt-time", dir);
+	unlink(sock);
+	rmdir(dir);
+}
+
+/* Run a User Mode Linux kernel with the host filesystem as root and this
+ * binary as init, as start_qemu() does for QEMU. Extra options (-o) are
+ * kernel parameters, e.g. time-travel=ext:<socket> or
+ * virtio_uml.device=<socket>:<id> for devices served from the host.
+ */
+static int start_uml(void)
+{
+	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
+	char dir[TT_DIR_MAX];
+	pid_t calendar = -1, pid;
+	int status = EXIT_FAILURE << 8;
+	char *argv_strv[EXTRA_OPT_MAX + 64];
+	struct strv _cleanup_(strv_cleanup) argv = { argv_strv,
+							ARRAY_SIZE(argv_strv) };
+	int i, pos;
+
+	if (!getcwd(cwd, sizeof(cwd)))
+		strcat(cwd, "/");
+
+	if (own_binary[0] == '/')
+		snprintf(initcmd, sizeof(initcmd), "%s", own_binary);
+	else
+		snprintf(initcmd, sizeof(initcmd), "%s/%s", cwd, own_binary);
+
+	pos = snprintf(testargs, sizeof(testargs), "%s", test_argv[0]);
+
+	for (i = 1; i < test_argc; i++) {
+		int len = sizeof(testargs) - pos;
+		int n = snprintf(testargs + pos, len, " %s", test_argv[i]);
+
+		if (n < 0 || n >= len) {
+			fprintf(stderr, "Buffer overflow detected in "
+					"testargs\n");
+			return EXIT_FAILURE;
+		}
+
+		pos += n;
+	}
+
+	strv_append(&argv, "%s", kernel_image);
+	strv_append(&argv, "mem=512M");
+	/* UML keeps its PID file in uml_dir, ~/.uml by default */
+	strv_append(&argv, "uml_dir=/tmp");
+	/* No block device, UML would otherwise try to open root_fs */
+	strv_append(&argv, "ubd0r=/dev/null");
+	strv_append(&argv, "root=/dev/root");
+	strv_append(&argv, "rootfstype=hostfs");
+	strv_append(&argv, "hostfs=/");
+	strv_append(&argv, "ro");
+	strv_append(&argv, "quiet");
+	/* Run the guest's processes with seccomp instead of ptrace */
+	strv_append(&argv, "seccomp=on");
+	strv_append(&argv, "con=null");
+	strv_append(&argv, "con0=fd:0,fd:1");
+	strv_append(&argv, "TESTUML=1");
+	strv_append(&argv, "init=%s", initcmd);
+	strv_append(&argv, "TESTHOME=%s", cwd);
+	strv_append(&argv, "TESTDBUS=%u", start_dbus);
+	strv_append(&argv, "TESTDAEMON=%u", start_daemon);
+	strv_append(&argv, "TESTDBUSSESSION=%u", start_dbus_session);
+	strv_append(&argv, "XDG_RUNTIME_DIR=/run/user/0");
+	strv_append(&argv, "TESTMONITOR=%u", start_monitor);
+	strv_append(&argv, "TESTEMULATOR=%u", num_emulator);
+	strv_append(&argv, "TESTDEVS=0");
+	strv_append(&argv, "TESTAUTO=%u", run_auto);
+	strv_append(&argv, "TESTAUDIO='%s'", audio_server ? audio_server : "");
+	strv_append(&argv, "TESTARGS='%s'", testargs);
+
+	for (i = 0; i < num_extra_opts; ++i)
+		strv_append(&argv, "%s", extra_opts[i]);
+
+	if (time_travel) {
+		calendar = start_calendar(dir);
+		if (calendar < 0)
+			return EXIT_FAILURE;
+
+		strv_append(&argv, "time-travel=ext:%s/bt-time", dir);
+	}
+
+	if (STRV_ERROR(argv)) {
+		fprintf(stderr, "Failed to build argument list\n");
+		goto done;
+	}
+
+	/* Exec directly if there is no calendar to stop afterwards */
+	if (!time_travel) {
+		execve(argv.strv[0], argv.strv, qemu_envp);
+		perror("Failed to start User Mode Linux");
+		return EXIT_FAILURE;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		goto done;
+	}
+
+	if (pid == 0) {
+		execve(argv.strv[0], argv.strv, qemu_envp);
+		perror("Failed to start User Mode Linux");
+		exit(EXIT_FAILURE);
+	}
+
+	qemu_pid = pid;
+
+	signal(SIGINT, qemu_signal);
+	signal(SIGTERM, qemu_signal);
+	signal(SIGHUP, qemu_signal);
+
+	while (waitpid(pid, &status, 0) < 0) {
+		if (errno != EINTR)
+			break;
+	}
+
+	qemu_pid = -1;
+
+done:
+	if (calendar > 0)
+		stop_calendar(calendar, dir);
+
+	return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
+}
+
 static int open_serial(const char *path)
 {
 	struct termios ti;
@@ -1328,6 +1655,20 @@ static const char *btvirt_table[] = {
 	NULL
 };
 
+static const char *find_btvirt(void)
+{
+	int i;
+
+	for (i = 0; btvirt_table[i]; i++) {
+		struct stat st;
+
+		if (!stat(btvirt_table[i], &st))
+			return btvirt_table[i];
+	}
+
+	return NULL;
+}
+
 static pid_t start_btvirt(const char *home, int num)
 {
 	const char *btvirt = NULL;
@@ -1818,9 +2159,14 @@ static void usage(void)
 		"\t-P, --pcie <qemu_args> Provide PCIe device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
-		"\t-k, --kernel <image>   Kernel bzImage or source tree path\n"
+		"\t-k, --kernel <image>   Kernel bzImage, User Mode Linux\n"
+		"\t                       binary or source tree path\n"
 		"\t-F, --virtiofs[=<path>]  Virtiofsd path or 'no'\n"
-		"\t-o, --option <opt>     Additional argument passed to QEMU\n"
+		"\t-T, --time-travel      Run User Mode Linux on simulated\n"
+		"\t                       time, with btvirt as calendar\n"
+		"\t-o, --option <opt>     Additional argument passed to QEMU,\n"
+		"\t                       or kernel parameter with User\n"
+		"\t                       Mode Linux\n"
 		"\t-h, --help             Show help options\n");
 }
 
@@ -1841,6 +2187,7 @@ static const struct option main_options[] = {
 	{ "pcie",    required_argument, NULL, 'P' },
 	{ "option",  required_argument, NULL, 'o' },
 	{ "virtiofs", optional_argument, NULL, 'F' },
+	{ "time-travel", no_argument,   NULL, 'T' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1848,7 +2195,7 @@ static const struct option main_options[] = {
 
 int main(int argc, char *argv[])
 {
-	char kernel_path[PATH_MAX];
+	static char kernel_path[PATH_MAX];
 	bool virtiofs_auto = true;
 
 	if (getpid() == 1 && getppid() == 0) {
@@ -1856,14 +2203,15 @@ int main(int argc, char *argv[])
 		run_tests();
 
 		sync();
-		reboot(RB_AUTOBOOT);
+		/* Rebooting User Mode Linux starts it again */
+		reboot(is_uml_guest() ? RB_POWER_OFF : RB_AUTOBOOT);
 		return EXIT_SUCCESS;
 	}
 
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:F::vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:F::Tvh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1918,6 +2266,9 @@ int main(int argc, char *argv[])
 			}
 			extra_opts[num_extra_opts++] = optarg;
 			break;
+		case 'T':
+			time_travel = true;
+			break;
 		case 'F':
 			virtiofs_auto = false;
 			if (optarg) {
@@ -1957,6 +2308,37 @@ int main(int argc, char *argv[])
 	test_argv = argv + optind;
 	test_argc = argc - optind;
 
+	if (!find_kernel(kernel_image, kernel_path)) {
+		fprintf(stderr, "No kernel image found\n");
+		return EXIT_FAILURE;
+	}
+
+	kernel_image = kernel_path;
+
+	if (is_uml_kernel(kernel_image)) {
+		if (num_devs || usb_dev || pcie_dev || qemu_binary ||
+							qemu_host_cpu) {
+			fprintf(stderr, "-u, -U, -P, -q and -H need QEMU, not "
+						"User Mode Linux\n");
+			return EXIT_FAILURE;
+		}
+
+		if (time_travel && !uml_has_time_travel()) {
+			fprintf(stderr, "%s has no time travel support "
+					"(CONFIG_UML_TIME_TRAVEL_SUPPORT)\n",
+					kernel_image);
+			return EXIT_FAILURE;
+		}
+
+		printf("Using User Mode Linux kernel %s\n", kernel_image);
+		return start_uml();
+	}
+
+	if (time_travel) {
+		fprintf(stderr, "-T needs a User Mode Linux kernel\n");
+		return EXIT_FAILURE;
+	}
+
 	if (!qemu_binary) {
 		qemu_binary = find_qemu();
 		if (!qemu_binary) {
@@ -1965,13 +2347,6 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	if (!find_kernel(kernel_image, kernel_path)) {
-		fprintf(stderr, "No kernel image found\n");
-		return EXIT_FAILURE;
-	}
-
-	kernel_image = kernel_path;
-
 	printf("Using QEMU binary %s\n", qemu_binary);
 	printf("Using kernel image %s\n", kernel_image);
 
-- 
2.56.0

