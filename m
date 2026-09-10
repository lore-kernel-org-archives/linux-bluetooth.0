Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D925952BE58
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789058918; cv=pass; b=gK7JF3sqXXlyJPzt9dPnGNHkO6wah7wqAqi/rY+78fhntOwXNEtSOFjrstloG3LKrkZuzZL8fc/ex0dL6P+8Wzk0oI67dx0hFrF+pokrcEUZZdy1m/phYrstak706sXc5Vy0bwKy7xl+XRwTt0NMtJ0SFXZdLtDN/GTgXqq0oO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789058918; c=relaxed/simple;
	bh=z92cNZlJpyVNm1YWKGvShHnmr0rhONYiFZV6DWxUYaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cn9Db/GYd1f06ZZnWqImPhxHnhICtPppB4TPIlsACz5OTFCxkKbsr7Ugn+H+bf7cb7aQ3lnXkjYu+nTaviJgJKjHs1KEqEt51VqWRNl8AnLu7+rB9O7LYO86fm2cu57LysvZ8z5O8YF4yf6UXxjmDTZDhSKxQzjz2/ppVR0DdTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=E4Y2Lhc1; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="E4Y2Lhc1"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:4::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hgkBs1ywQz10Hf;
	Thu, 10 Sep 2026 19:48:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789058901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9ZF+wRdFjCfvD5FtE78uSmc1jm/bAONO49iRqT63po=;
	b=E4Y2Lhc1sDeVqERkX/tR7L0GZQqRgfPJNlvTwjTyVXq5h6Uabyl/+BIqhb83QVzywyuhf7
	UUFn4GkhWaJ3EGid0IBQBt9VO55sg6Ah5nctaiTj7ugeBA0ozCOvh4Af/dZT6yPgrEb7Jp
	NZsnMG1TylQj/hqCklzirupeYhYhoJA=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789058901;
	b=pJ/1IPT16buk99GIrseCZoWM7a0cqIG0Ah6esnV/rrHxt54iBvuAus3jZT8ZQ4Yc7LusbW
	Mn2IfOHUHJnR9rWa5e48nuJCFKvULHMFOtlyKe7BMucSf+GZSigCEJ39D7JQfaIFi8ohMF
	COoACwuTGft7rrba/LlW1kIRUGb0ah8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789058901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9ZF+wRdFjCfvD5FtE78uSmc1jm/bAONO49iRqT63po=;
	b=uMK4E0qB+1i+NgXfgeIWw0Z7SGcbn9NuvolkGQ0lYnE3wKOnoaTQfHPxEdlHxfBayx2WoS
	hxojKme8v+Uh89hxCI0p3tw3Rkvi8UByGyq906VhACxuek088apPMhOKx1sAVjBjEWbJfR
	BYj2eukvxANI5zqSco0VrgNwtSzYQBg=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/2] tools: test-runner: use virtiofsd for filesystem passthrough
Date: Thu, 10 Sep 2026 19:48:07 +0300
Message-ID: <7644e092347c63f2777c86ac687eb2cb01c3c6c8.1789058875.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789058875.git.pav@iki.fi>
References: <cover.1789058875.git.pav@iki.fi>
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
 doc/test-runner.rst |   3 +
 tools/test-runner.c | 210 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 199 insertions(+), 14 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index 6787507c3..ac8f22c19 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -26,6 +26,7 @@ OPTIONS
 :-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-k/--kernel=<image>: Kernel image (bzImage)
+:-F/--virtiofs=<virtiofsd / no>: Enable/disable use of virtio-fs.
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
diff --git a/tools/test-runner.c b/tools/test-runner.c
index 63fedece0..d6589f7a9 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -64,6 +64,7 @@ static char *usb_dev;
 static char *pcie_dev;
 static char *extra_opts[EXTRA_OPT_MAX];
 static int num_extra_opts;
+static const char *virtiofsd = "/usr/libexec/virtiofsd";
 
 static const char *qemu_table[] = {
 	"qemu-system-x86_64",
@@ -235,9 +236,6 @@ static char *const qemu_argv[] = {
 	"-m", "256M",
 	"-net", "none",
 	"-no-reboot",
-	"-fsdev", "local,id=fsdev-root,path=/,readonly=on,security_model=none,"
-	"multidevs=remap",
-	"-device", "virtio-9p-pci,fsdev=fsdev-root,mount_tag=/dev/root",
 	"-chardev", "stdio,id=con,mux=on",
 	"-serial", "chardev:con",
 	"-device", "virtio-serial",
@@ -495,6 +493,98 @@ static void pcie_unbind_vfio(void)
 	pcie_probe(pcie_bdf);
 }
 
+static bool check_virtiofsd(void)
+{
+	if (!virtiofsd)
+		return false;
+
+	if (access(virtiofsd, X_OK)) {
+		fprintf(stderr, "%s not available", virtiofsd);
+		return false;
+	}
+
+	return true;
+}
+
+static pid_t start_virtiofsd(const char *tmpdir)
+{
+	pid_t pid;
+	char path[PATH_MAX];
+	struct stat st;
+
+	printf("Using virtiofsd %s\n", virtiofsd);
+
+	snprintf(path, sizeof(path), "%s/virtiofs", tmpdir);
+
+	pid = fork();
+	if (pid < 0)
+		return pid;
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
+		exit(EXIT_SUCCESS);
+	}
+
+	while (1) {
+		int status;
+		pid_t ret;
+
+		if (!stat(path, &st))
+			break;
+
+		ret = waitpid(pid, &status, WNOHANG);
+		if (ret < 0 && errno == -EINTR)
+			continue;
+		else if (ret)
+			return -EIO;
+
+		sleep(1);
+	}
+
+	return pid;
+}
+
+static void cleanup_virtiofsd(pid_t pid, const char *tmpdir)
+{
+	char path[PATH_MAX];
+	int status;
+
+	if (pid > 0) {
+		kill(pid, SIGTERM);
+		while (waitpid(pid, &status, 0) < 0) {
+			if (errno != EINTR)
+				break;
+		}
+	}
+
+	if (tmpdir[0]) {
+		snprintf(path, sizeof(path), "%s/virtiofs", tmpdir);
+		unlink(path);
+		snprintf(path, sizeof(path), "%s/virtiofs.pid", tmpdir);
+		unlink(path);
+		rmdir(tmpdir);
+	}
+}
+
 static pid_t qemu_pid;
 
 /* Forwards the signal to QEMU so it can shutdown, the host driver is then
@@ -509,10 +599,13 @@ static void qemu_signal(int sig)
 static int start_qemu(void)
 {
 	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
+	const char *fscmdline;
 	char cmdline[CMDLINE_MAX];
+	char tmpdir[PATH_MAX] = {0};
 	char **argv;
 	int i, pos, status = 0;
 	pid_t pid;
+	pid_t virtiofsd_pid = -1;
 
 	check_virtualization();
 
@@ -539,15 +632,20 @@ static int start_qemu(void)
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
@@ -559,6 +657,7 @@ static int start_qemu(void)
 				testargs);
 
 	argv = alloca(sizeof(qemu_argv) +
+			sizeof(char *) * 8 +
 			(sizeof(char *) * (8 + (num_devs * 4))) +
 			(sizeof(char *) * (usb_dev ? 4 : 0)) +
 			(sizeof(char *) * (pcie_dev ? 2 : 0)) +
@@ -567,6 +666,60 @@ static int start_qemu(void)
 
 	pos = (sizeof(qemu_argv) / sizeof(char *)) - 1;
 
+	if (!virtiofsd) {
+		argv[pos++] = "-fsdev";
+		argv[pos++] = "local,id=fsdev-root,path=/,readonly=on,"
+				"security_model=none,multidevs=remap";
+		argv[pos++] = "-device";
+		argv[pos++] = "virtio-9p-pci,fsdev=fsdev-root,"
+				"mount_tag=/dev/root";
+	} else {
+		char *chrdev;
+		const char *tmp_base;
+		const char *mem = "256M";
+		char *memdev;
+
+		tmp_base = getenv("TMPDIR");
+		if (!tmp_base)
+			tmp_base = "/tmp";
+
+		snprintf(tmpdir, sizeof(tmpdir), "%s/bluez-test-runner.XXXXXX",
+								tmp_base);
+		if (!mkdtemp(tmpdir)) {
+			perror("mkdtemp failed");
+			return EXIT_FAILURE;
+		}
+
+		chrdev = alloca(48 + strlen(tmpdir));
+		sprintf(chrdev, "socket,id=virtiofs0,path=%s/virtiofs", tmpdir);
+
+		argv[pos++] = "-chardev";
+		argv[pos++] = chrdev;
+		argv[pos++] = "-device";
+		argv[pos++] = "vhost-user-fs-pci,queue-size=1024,"
+					"chardev=virtiofs0,tag=/dev/root";
+
+		/* Find out memory size */
+		for (i = 0; i < pos; ++i) {
+			if (strcmp(argv[i], "-m") == 0 && i + 1 < pos)
+				mem = argv[i+1];
+		}
+		for (i = 0; i < num_extra_opts; ++i) {
+			if (strcmp(extra_opts[i], "-m") == 0 &&
+							i + 1 < num_extra_opts)
+				mem = extra_opts[i+1];
+		}
+
+		memdev = alloca(48 + strlen(mem));
+		sprintf(memdev, "memory-backend-memfd,id=mem0,size=%s,share=on",
+									mem);
+
+		argv[pos++] = "-object";
+		argv[pos++] = memdev;
+		argv[pos++] = "-numa";
+		argv[pos++] = "node,memdev=mem0";
+	}
+
 	/* Make sure qemu_binary is not null */
 	if (!qemu_binary) {
 		fprintf(stderr, "No QEMU binary is set\n");
@@ -616,21 +769,29 @@ static int start_qemu(void)
 
 	argv[pos] = NULL;
 
-	if (!pcie_dev) {
+	/* Exec directly if no setup/cleanup needed */
+	if (!pcie_dev && !virtiofsd) {
 		execve(argv[0], argv, qemu_envp);
 		return EXIT_FAILURE;
 	}
 
-	/* With a device passed through the host driver has to be restored
-	 * once the guest is done with it, so QEMU cannot simply replace this
-	 * process here.
-	 */
-	pcie_bind_vfio();
+	if (virtiofsd) {
+		virtiofsd_pid = start_virtiofsd(tmpdir);
+		if (virtiofsd_pid < 0) {
+			perror("Failed to start virtiofsd");
+			cleanup_virtiofsd(virtiofsd_pid, tmpdir);
+			return EXIT_FAILURE;
+		}
+	}
+
+	if (pcie_dev)
+		pcie_bind_vfio();
 
 	pid = fork();
 	if (pid < 0) {
 		perror("Failed to fork new process");
 		pcie_unbind_vfio();
+		cleanup_virtiofsd(virtiofsd_pid, tmpdir);
 		return EXIT_FAILURE;
 	}
 
@@ -655,7 +816,11 @@ static int start_qemu(void)
 
 	qemu_pid = -1;
 
-	pcie_unbind_vfio();
+	if (pcie_dev)
+		pcie_unbind_vfio();
+
+	if (virtiofsd)
+		cleanup_virtiofsd(virtiofsd_pid, tmpdir);
 
 	return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
 }
@@ -1524,6 +1689,7 @@ static void usage(void)
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel bzImage or source tree path\n"
+		"\t-F, --virtiofs[=no / virtiofsd] Virtiofsd disable / path\n"
 		"\t-o, --option <opt>     Additional argument passed to QEMU\n"
 		"\t-h, --help             Show help options\n");
 }
@@ -1544,6 +1710,7 @@ static const struct option main_options[] = {
 	{ "usb",     required_argument, NULL, 'U' },
 	{ "pcie",    required_argument, NULL, 'P' },
 	{ "option",  required_argument, NULL, 'o' },
+	{ "virtiofs", optional_argument, NULL, 'F' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
 	{ }
@@ -1552,6 +1719,7 @@ static const struct option main_options[] = {
 int main(int argc, char *argv[])
 {
 	char kernel_path[PATH_MAX];
+	bool virtiofs_auto = true;
 
 	if (getpid() == 1 && getppid() == 0) {
 		prepare_sandbox();
@@ -1565,7 +1733,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:F::vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1620,6 +1788,15 @@ int main(int argc, char *argv[])
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
@@ -1631,6 +1808,11 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	if (virtiofs_auto && !check_virtiofsd()) {
+		fprintf(stderr, ": virtiofs disabled\n");
+		virtiofsd = NULL;
+	}
+
 	if (run_auto) {
 		if (argc - optind > 0) {
 			fprintf(stderr, "Invalid command line parameters\n");
-- 
2.55.0

