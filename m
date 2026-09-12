Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683A847B436
	for <linux-bluetooth@vger.kernel.org>; Sat, 12 Sep 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789237129; cv=pass; b=VHcJT22N/cDbmQIsmWipdY91v1coiJYODuUdGM15r+q4yUlxrIztTPYBLb/rkBiaqJlEaJULK6lp3WbEj1Ux7JWCKn62F2kVPsLagy7aOolTJnZu6ap6cSr+S09tl1HZmwbogwnQBt1HASx7Yw/BpLG6FG0cGW9GICo1hjaQR1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789237129; c=relaxed/simple;
	bh=/hpU4ub8E0tDrShu57KWu4L2URHhpsCvXrRYlcmAOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxdFYt4qDoO23OXCRDUhKGfXX9LvRrjVpabMkal/ILFk1vOCKGzLBfZrWYoe743DvtwPn9cpaXijtKZRMAN+Fgtimh4u1q+0/+zJi3jZQMN4sh32RJEol9HEmYx0VqIZ2cxak4u0q4Vm2p7zk+xQcNA58EcZH0fBYdncnYa/BOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vaPGxQCR; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vaPGxQCR"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:5:f011:6::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hj0690YJczySb;
	Sat, 12 Sep 2026 21:18:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789237121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFH8AUyFi6K8OzFurXywFL1Jpf2kIMEG4SpBb6ltxGs=;
	b=vaPGxQCRbyxVg3v+wRYOmAFW+nSC/yYBBW6bUWGvHE++VjJheWrQEORYW7XlHUt9uYGtC7
	Vzuhbjgb3ugqA36GB7EjYawqSJqqwpdP5fnpYJw9CU2YVqe1r1rK5srnxpvS2onC8siwEm
	TWtcedaWIbj2+T2Keo2aCymhIFSQyrw=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789237121;
	b=wwh/3f6MrLKkg5yS25we5wiZ7vUCvP/o91iku9q8MXF66ljTyBOXmnfzWOv5+PTS96B0XP
	WMOKwoMV/DM0azXxOVHMaNWe2fsrkEegsTZSkaa69PJVnyBNh2yyXsjpNgXLD4BBEnLFbH
	SnVydjMKI2lyJZSfmYa6pIPbB5XDGC4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789237121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PFH8AUyFi6K8OzFurXywFL1Jpf2kIMEG4SpBb6ltxGs=;
	b=OgSBsBpAz+HGs+FVZXjaVJJSEPqKt5tqDtgRyYCtWcP7dmDcrqzLvu05Tu9yCV1lLMSmIE
	WcB7SUCcEiTOoEX+4CZjCeY936jNa91tM0nIIt4VCUJ6s6+zJ83L+gt/nfED39t0QYorF5
	0JtqpoqhELQHyi2f7feSwaeJLS1gQHM=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 3/4] tools/test-runner: use virtiofsd for filesystem passthrough
Date: Sat, 12 Sep 2026 21:18:22 +0300
Message-ID: <9b697d7e371fc68ddef4cf4cc1f2ddf70fffaf82.1789237077.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789237077.git.pav@iki.fi>
References: <cover.1789237077.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 9p mount passthrough I/O is fairly CPU hungry and slow. This matters
for e.g. running Python in test-runner, since it has to read some amount
of files for startup.

Add support for virtio-fs, which is significantly less CPU intensive.

Enable it by default if /usr/libexec/virtiofsd is available, fall back
to 9p if virtiofsd not usable.

Before:
$ time make check-functional
real	2m9,736s
user	1m29,570s
sys	0m32,715s

After:
$ time make check-functional
real	1m35,703s
user	0m28,938s
sys	0m7,453s
---
 doc/test-runner.rst |  10 +-
 tools/test-runner.c | 233 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 227 insertions(+), 16 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 6787507c3..12f80df04 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -8,8 +8,8 @@ DESCRIPTION
 ===========
 
 **test-runner(1)** is used to test Kernel changes to the Bluetooth subsystem,
-it launches a virtual machine using qemu(1) and mounts the local filesystem
-using virtio (9p).
+it launches a virtual machine using qemu(1) with the host filesystem mounted
+read-only inside the guest.
 
 OPTIONS
 =======
@@ -26,6 +26,7 @@ OPTIONS
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-k/--kernel=<image>: Kernel image (bzImage)
+:-F/--virtiofs[=<path>]: Path to virtiofsd, or no to disable virtio-fs
 :-h/--help: Show help options
 
 Kernel
@@ -47,6 +48,8 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 	CONFIG_VIRTIO=y
 	CONFIG_VIRTIO_PCI=y
 	CONFIG_VIRTIO_CONSOLE=y
+	CONFIG_VIRTIO_FS=y
+	CONFIG_FUSE_FS=y
 
 	CONFIG_NET=y
 	CONFIG_INET=y
@@ -69,6 +72,9 @@ option (like the Bluetooth subsystem) can be enabled on top of this.
 	CONFIG_DEVTMPFS=y
 	CONFIG_DEBUG_FS=y
 
+Filesystem passthrough uses virtio-fs when ``virtiofsd`` is installed on the
+host, otherwise 9p. Use ``-Fno`` for kernels without ``CONFIG_VIRTIO_FS``.
+
 Bluetooth
 ---------
 
diff --git a/tools/test-runner.c b/tools/test-runner.c
index a0ac321ca..9eaf39d35 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -69,6 +69,7 @@ static char *usb_dev;
 static char *pcie_dev;
 static char *extra_opts[EXTRA_OPT_MAX];
 static int num_extra_opts;
+static const char *virtiofsd = "/usr/libexec/virtiofsd";
 
 struct strv {
 	char **strv;
@@ -291,9 +292,6 @@ static const char *const qemu_argv[] = {
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
-	"-fsdev", "local,id=fsdev-root,path=/,readonly=on,security_model=none,"
-	"multidevs=remap",
-	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
 	"-chardev", "stdio,id=con,mux=on",
 	"-serial", "chardev:con",
 	"-device", "virtio-serial",
@@ -551,6 +549,183 @@ static void pcie_unbind_vfio(void)
 	pcie_probe(pcie_bdf);
 }
 
+static bool check_virtiofsd(void)
+{
+	if (!virtiofsd)
+		return false;
+
+	if (access(virtiofsd, X_OK)) {
+		fprintf(stderr, "%s not available: virtiofs disabled\n",
+								virtiofsd);
+		return false;
+	}
+
+	return true;
+}
+
+struct rootfs {
+	char tmpdir[PATH_MAX - 16];
+	pid_t pid;
+};
+
+static volatile sig_atomic_t terminate;
+
+static void terminate_signal(int sig)
+{
+	terminate = 1;
+}
+
+static bool rootfs_setup(struct rootfs *r, struct strv *argv)
+{
+	const char *mem = "256M";
+	size_t i;
+
+	memset(r, 0, sizeof(*r));
+
+	if (!virtiofsd) {
+		strv_append(argv, "-fsdev");
+		strv_append(argv, "local,id=fsdev-root,path=/,readonly=on,"
+					"security_model=none,multidevs=remap");
+		strv_append(argv, "-device");
+		strv_append(argv, "virtio-9p-pci,fsdev=fsdev-root,"
+							"mount_tag=/dev/root");
+		return true;
+	}
+
+	/* Make sure to clean up the tmpdir always on SIGINT */
+	signal(SIGINT, terminate_signal);
+	signal(SIGTERM, terminate_signal);
+	signal(SIGHUP, terminate_signal);
+
+	snprintf(r->tmpdir, ARRAY_SIZE(r->tmpdir),
+					"/tmp/bluez-test-runner.XXXXXX");
+	if (!mkdtemp(r->tmpdir)) {
+		perror("mkdtemp failed");
+		return false;
+	}
+
+	strv_append(argv, "-chardev");
+	strv_append(argv, "socket,id=virtiofs0,path=%s/virtiofs", r->tmpdir);
+	strv_append(argv, "-device");
+	strv_append(argv, "vhost-user-fs-pci,queue-size=1024,"
+					"chardev=virtiofs0,tag=/dev/root");
+
+	/* Find out memory size */
+	for (i = 0; i + 1 < argv->i; ++i) {
+		if (strcmp(argv->strv[i], "-m") == 0)
+			mem = argv->strv[i+1];
+	}
+	for (i = 0; i + 1 < (size_t)num_extra_opts; ++i) {
+		if (strcmp(extra_opts[i], "-m") == 0)
+			mem = extra_opts[i+1];
+	}
+	if (!mem[0] || !strchr("kKmMgGtT", mem[strlen(mem) - 1])) {
+		fprintf(stderr, "Can't parse -m %s for virtiofs\n", mem);
+		return false;
+	}
+
+	strv_append(argv, "-object");
+	strv_append(argv, "memory-backend-memfd,id=mem0,size=%s,share=on", mem);
+	strv_append(argv, "-numa");
+	strv_append(argv, "node,memdev=mem0");
+
+	return true;
+}
+
+static bool rootfs_start(struct rootfs *r)
+{
+	pid_t pid;
+	char path[PATH_MAX];
+	struct stat st;
+
+	if (!virtiofsd)
+		return true;
+
+	printf("Using virtiofsd %s\n", virtiofsd);
+
+	snprintf(path, sizeof(path), "%s/virtiofs", r->tmpdir);
+
+	pid = fork();
+	if (pid < 0) {
+		perror("fork");
+		return false;
+	}
+
+	if (pid == 0) {
+		char *envp[1];
+		const char *cmd[] = {
+			virtiofsd,
+			"--socket-path", path,
+			"--shared-dir", "/",
+			"--readonly",
+			"--tag", "/dev/root",
+			/* Drop unnecessary capabilities, if run as root */
+			"--modcaps=-chown:-dac_override:-fowner:-fsetid:"
+					"-setgid:-setuid:-mknod:-setfcap",
+			/*
+			 * Disabling namespace sandbox is needed to allow the
+			 * guest to mount other virtio/9p filesystems.
+			 */
+			"--sandbox", "none",
+			NULL
+		};
+
+		envp[0] = NULL;
+		execve(cmd[0], (char **)cmd, envp);
+		exit(EXIT_FAILURE);
+	}
+
+	r->pid = pid;
+
+	while (!terminate) {
+		int status;
+		pid_t ret;
+
+		if (!stat(path, &st))
+			break;
+
+		ret = waitpid(pid, &status, WNOHANG);
+		if (ret < 0 && errno == EINTR) {
+			continue;
+		} else if (ret < 0) {
+			perror("waitpid");
+			return false;
+		} else if (ret) {
+			fprintf(stderr, "%s failed to start\n", virtiofsd);
+			r->pid = 0;
+			return false;
+		}
+
+		sleep(1);
+	}
+
+	return !terminate;
+}
+
+static void rootfs_cleanup(struct rootfs *r)
+{
+	char path[PATH_MAX];
+	int status;
+
+	if (r->pid > 0) {
+		kill(r->pid, SIGTERM);
+		while (waitpid(r->pid, &status, 0) < 0) {
+			if (errno != EINTR)
+				break;
+		}
+	}
+
+	if (r->tmpdir[0]) {
+		snprintf(path, sizeof(path), "%s/virtiofs", r->tmpdir);
+		unlink(path);
+		snprintf(path, sizeof(path), "%s/virtiofs.pid", r->tmpdir);
+		unlink(path);
+		rmdir(r->tmpdir);
+	}
+
+	memset(r, 0, sizeof(*r));
+}
+
 static pid_t qemu_pid;
 
 /* Forwards the signal to QEMU so it can shutdown, the host driver is then
@@ -565,10 +740,12 @@ static void qemu_signal(int sig)
 static int start_qemu(void)
 {
 	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
+	const char *fscmdline;
 	char cmdline[CMDLINE_MAX];
 	char *argv_strv[EXTRA_OPT_MAX + 64];
 	struct strv _cleanup_(strv_cleanup) argv = { argv_strv,
 							ARRAY_SIZE(argv_strv) };
+	struct rootfs _cleanup_(rootfs_cleanup) rootfs = {{0}};
 	int i, pos, status = 0;
 	pid_t pid;
 
@@ -597,15 +774,20 @@ static int start_qemu(void)
 		pos += n;
 	}
 
+	if (!virtiofsd)
+		fscmdline = "rootfstype=9p "
+				"rootflags=trans=virtio,version=9p2000.u";
+	else
+		fscmdline = "rootfstype=virtiofs root=/dev/root";
+
 	snprintf(cmdline, sizeof(cmdline),
 				"console=hvc0 earlyprintk=serial "
-				"no_hash_pointers=1 rootfstype=9p "
-				"rootflags=trans=virtio,version=9p2000.u "
-				"%s quiet ro init=%s "
+				"no_hash_pointers=1 %s %s quiet ro init=%s "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTAUDIO='%s' TESTARGS=\'%s\'",
+				fscmdline,
 				/* PCIe passthrough requires ACPI and APIC for
 				 * device enumeration and MSI interrupts.
 				 */
@@ -654,6 +836,9 @@ static int start_qemu(void)
 		strv_append(&argv, "%s", pcie_dev);
 	}
 
+	if (!rootfs_setup(&rootfs, &argv))
+		return EXIT_FAILURE;
+
 	for (i = 0; i < num_extra_opts; ++i)
 		strv_append(&argv, "%s", extra_opts[i]);
 
@@ -662,16 +847,17 @@ static int start_qemu(void)
 		return EXIT_FAILURE;
 	}
 
-	if (!pcie_dev) {
+	if (!rootfs_start(&rootfs))
+		return EXIT_FAILURE;
+
+	/* Exec directly if no setup/cleanup needed */
+	if (!pcie_dev && !rootfs.pid) {
 		execve(argv.strv[0], argv.strv, qemu_envp);
 		return EXIT_FAILURE;
 	}
 
-	/* With a device passed through the host driver has to be restored
-	 * once the guest is done with it, so QEMU cannot simply replace this
-	 * process here.
-	 */
-	pcie_bind_vfio();
+	if (pcie_dev)
+		pcie_bind_vfio();
 
 	pid = fork();
 	if (pid < 0) {
@@ -694,6 +880,9 @@ static int start_qemu(void)
 	signal(SIGTERM, qemu_signal);
 	signal(SIGHUP, qemu_signal);
 
+	if (terminate)
+		kill(qemu_pid, SIGTERM);
+
 	while (waitpid(pid, &status, 0) < 0) {
 		if (errno != EINTR)
 			break;
@@ -701,7 +890,8 @@ static int start_qemu(void)
 
 	qemu_pid = -1;
 
-	pcie_unbind_vfio();
+	if (pcie_dev)
+		pcie_unbind_vfio();
 
 	return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
 }
@@ -1570,6 +1760,7 @@ static void usage(void)
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel bzImage or source tree path\n"
+		"\t-F, --virtiofs[=<path>]  Virtiofsd path or 'no'\n"
 		"\t-o, --option <opt>     Additional argument passed to QEMU\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -1590,6 +1781,7 @@ static const struct option main_options[] = {
 	{ "usb",     required_argument, NULL, 'U' },
 	{ "pcie",    required_argument, NULL, 'P' },
 	{ "option",  required_argument, NULL, 'o' },
+	{ "virtiofs", optional_argument, NULL, 'F' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1598,6 +1790,7 @@ static const struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	char kernel_path[PATH_MAX];
+	bool virtiofs_auto = true;
 
 	if (getpid() == 1 && getppid() == 0) {
 		prepare_sandbox();
@@ -1611,7 +1804,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:F::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1666,6 +1859,15 @@ int main(int argc, char *argv[])
 			}
 			extra_opts[num_extra_opts++] = optarg;
 			break;
+		case 'F':
+			virtiofs_auto = false;
+			if (optarg) {
+				if (strcmp(optarg, "no") == 0)
+					virtiofsd = NULL;
+				else
+					virtiofsd = optarg;
+			}
+			break;
 		case 'v':
 			printf("%s\n", VERSION);
 			return EXIT_SUCCESS;
@@ -1677,6 +1879,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (virtiofs_auto && !check_virtiofsd())
+		virtiofsd = NULL;
+
 	if (run_auto) {
 		if (argc - optind > 0) {
 			fprintf(stderr, "Invalid command line parameters\n");
-- 
2.55.0

