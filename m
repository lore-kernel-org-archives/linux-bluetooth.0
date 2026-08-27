Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCFC47013F
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787849616; cv=none; b=QenmSZeE796Ve3SLrwS2eXnMiLDPaqvHyYICfF31j/yzUazkRlnNag1L+k3//zJY21ry6m7FxN9asQ0/hXwOap2P8R3wft0qGnC1m2TkveitW6RnQN0NGxyLNj69eFTSvrmfY+0HpywIeb39vcqckh+U7k4740enjkmae7VHAMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787849616; c=relaxed/simple;
	bh=iTV4xca70yfDU9vzLdwgEIM3u1tCsC1w2Xz5UWar3J4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=M/6hqdzUcdP5a+C0I2LVYFwR9mocmz1/h9l4Fkfa0vMjo+ZWJoDqYNUzoduivsEwEQ8CdI+Jb+3bGI2YKZDuM1ZkUD0SE554BuWWVbMjggLSooJuk3+SscooKQa3LE7MTZjWV1dAT9ovof+4hOcQ29XyBt01EfqabATeElNp8zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qtsHVv7e; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qtsHVv7e"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5bfaa014978so44209e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787849613; x=1788454413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YiCnvhJz9tyQAOTuAqf4QzecYnE6UUOzKe5KpEzmhlM=;
        b=qtsHVv7eKpeQabeXvsB28H3jeD2e6gksvvOYIfQd0pGroN2mIwa2kvy1PKiO83AX5G
         l2FWl5urgl4/cVOwjVt3zS+WtY5i/uXtXklzU4aGUYhaxSCflZYX3pf2LZ2QX/qqZKWX
         rG4ysTk2i/0s6FSzpZ+hlTUHClieexzEHlJaMA7b0BhteKu27oD3EmPt1x8njWiYOQoL
         pgaCimgZPNq59eCrTFbNHxIR5nDg8kx8EaEW0enFduKKDxx7x8grefTZyYVKg9wBFHvW
         dBMr4iDtQYWMRcKoWUhs7JZhMpcfJncGZol7PuXrRf+haL2ER4rOPtIGnWoDVQU1E1lp
         qnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787849613; x=1788454413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YiCnvhJz9tyQAOTuAqf4QzecYnE6UUOzKe5KpEzmhlM=;
        b=JkkP0LQxShVYQyhk+vHiVd5OxIZmFgxOVR0ljDappPNyBUJjsTHm49e/KqoUQWlQck
         DpSdUiocK3pYCc48yDxUxdu2u027Ud2i78ZfEWWfIJNZF7uYBye03SXVqKPPyQSYUpOl
         dD6iqKTIFlO9BR6SdHnUBWfQ0TJjCc5Yw8Nhf5uEH6AbGsU1QKWG6miHEhG4I616FCTJ
         k8Ni8eZBD1SkX4boarWCngL0bkTuQ1ehUlvMLqtaI8ZmtsW41RUS5DPEz9t8eEtT24xl
         oxGpCMo8FKhZa8wqJV1+5hcGr74Qllt7WHDecWs4BngGmEVDC1pFmeBAwpmOgBpJ+N59
         3M2Q==
X-Gm-Message-State: AFuF++kuGpdaCTd7zhhHkPyPOyUW0VElN4v8dlraRHx3ufeRIrv2aEYl
	MF9F7EDhKJYuDLCw6U53IvumjEusD1qs17b3b8wHwB6pYSCSSkWCNWgoRgpz+ap+
X-Gm-Gg: AR+sD12BHVq4BXV694xrAy0WLg+VxPUQwBuiBk0FW6ot8pL4feNWesR78ya0RXSpnNo
	eIvAxsRdnUev+kMDoyHOopywm7y7CsT4RHH1mpQfDJpIto7PzRQ+zzfniCbKYscOO+mau4WTCkj
	4XmETmZNkbtO+XLzT2EBewdk81rhNkTQ0VO/ieKvMJLXurymJmkXZ6WLO3CsSM/OT+HC2Ikybpx
	7ddW3hmPQ5z8ww0kuUxfJRDP+9JpcC5aLHcelswtZ/DfAEj48GYf+cou3la52PYALvYQcKycPBa
	1NT34fA1PBL53DE/OYTKuF/R2bFYNRqOhuNgt8DGZ+vVMhp/N2Spgb1vSNaTwB5hHcedDzk6ZWs
	p2tY75ELPEvM+Sy2gpfSh6EpZ2TJSbhoIEYDS7JU+TFVvX0cgyh3v2TUSWHx42BpYA88N5F7KbP
	q5qaQNUbWRicoQEbx1IGtL6cmvvUQ3c1uxWksr/iFKEFD0V/2J98/vpN7dKYp6Zw0x50qcQbXOc
	glm/aJ5NogravNS1tL3MFQ3Vbx3Q7o4vsTVFtiyrNc1K70DJSo1r8NFdnchMBfXnw==
X-Received: by 2002:a05:6122:da5:b0:5bd:b2e1:e1f5 with SMTP id 71dfb90a1353d-5c680febed9mr169971e0c.2.1787849613156;
        Thu, 27 Aug 2026 09:53:33 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c6600aeabcsm4155489e0c.17.2026.08.27.09.53.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 09:53:32 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ vRFC 1/4] test-runner: Add support for PCIe passthrough
Date: Thu, 27 Aug 2026 12:53:23 -0400
Message-ID: <20260827165326.350079-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add a -P/--pcie option which passes the given QEMU device arguments
through to QEMU, in the same way -U/--usb does for USB devices, so a
host controller can be handed to the guest:

  $ tools/test-runner -P "vfio-pci,host=0000:00:14.3" \
        -d -k /pathto/bzImage -- /bin/bash

The device does not have to be prepared by hand: the BDF is taken from
the host= argument and bound to vfio-pci, and the driver it was bound to
before is restored once the guest exits. As VFIO can only pass through a
device if the rest of its IOMMU group is unbound or already handled by
VFIO, the group is checked before the device is taken away from its
driver, so a group that cannot be used is reported instead of leaving
the device behind on vfio-pci.

Restoring the driver means QEMU can no longer simply replace this
process, so with -P it is started as a child and SIGINT, SIGTERM and
SIGHUP are forwarded to it, leaving this process to restore the driver
once QEMU is reaped.

Since vfio-pci requires ACPI for device enumeration and an APIC for MSI
delivery, the guest command line drops "acpi=off pci=noacpi noapic" when
-P is given. All other modes keep the previous command line and are
still exec'ed directly.

Tested by passing a PCIe card reader through to the guest, checking that
it is bound to vfio-pci while the guest runs and bound back to its own
driver afterwards.

The model drafted the option handling, the vfio binding, the command
line change and the documentation section; all of it was reviewed and
tested by the author.

Assisted-by: Claude:claude-opus-5
---
 doc/test-runner.rst |  28 ++++
 tools/test-runner.c | 317 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 337 insertions(+), 8 deletions(-)

diff --git a/doc/test-runner.rst b/doc/test-runner.rst
index a650c6fae571..6787507c3f40 100644
--- a/doc/test-runner.rst
+++ b/doc/test-runner.rst
@@ -23,6 +23,7 @@ OPTIONS
 :-A/-audio[=path]: Start audio server
 :-u/--unix[=path]: Provide serial device
 :-U/--usb=<qemu_args>: Provide USB device
+:-P/--pcie=<qemu_args>: Provide PCIe device
 :-q/--qemu=<path>: QEMU binary
 :-k/--kernel=<image>: Kernel image (bzImage)
 :-h/--help: Show help options
@@ -230,3 +231,30 @@ In addition the above kernel config option the following is required:
 
 	$ tools/test-runner -U "usb-host,vendorid=<0xxxxx>,productid=<0xxxxx>" \
 	-d -k /pathto/bzImage -- /bin/bash
+
+Running shell with host controller PCIe-passthrough
+---------------------------------------------------
+
+In addition the above kernel config option the following is required:
+
+.. code-block::
+
+	CONFIG_PCI=y
+	CONFIG_PCI_MSI=y
+	CONFIG_ACPI=y
+	CONFIG_BT_HCIBTINTEL_PCIE=y
+
+On the host, an IOMMU must be enabled in the firmware and on the host kernel
+command line (``intel_iommu=on`` or ``amd_iommu=on``). The controller itself
+does not need any manual preparation: test-runner unbinds it from its current
+driver, binds it to vfio-pci, and restores the original driver once the guest
+exits.
+
+.. code-block::
+
+	$ tools/test-runner -P "vfio-pci,host=0000:00:14.3" \
+	-d -k /pathto/bzImage -- /bin/bash
+
+Note that unlike the other modes, PCIe-passthrough boots the guest with ACPI
+and APIC enabled, as these are required for device enumeration and MSI
+interrupt delivery.
diff --git a/tools/test-runner.c b/tools/test-runner.c
index a11dc01a9ee4..63fedece0023 100644
--- a/tools/test-runner.c
+++ b/tools/test-runner.c
@@ -23,6 +23,7 @@
 #include <string.h>
 #include <getopt.h>
 #include <poll.h>
+#include <dirent.h>
 #include <limits.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
@@ -60,6 +61,7 @@ static const char *qemu_binary = NULL;
 static const char *kernel_image = NULL;
 static char *audio_server;
 static char *usb_dev;
+static char *pcie_dev;
 static char *extra_opts[EXTRA_OPT_MAX];
 static int num_extra_opts;
 
@@ -260,12 +262,257 @@ static void check_virtualization(void)
 #endif
 }
 
-static void start_qemu(void)
+#define PCI_DEVICES_PATH "/sys/bus/pci/devices"
+
+static char pcie_bdf[16];
+static char pcie_driver[64];
+
+static bool sysfs_write(const char *path, const char *value)
+{
+	int fd;
+	ssize_t len;
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		perror(path);
+		return false;
+	}
+
+	len = write(fd, value, strlen(value));
+	close(fd);
+
+	if (len < 0) {
+		perror(path);
+		return false;
+	}
+
+	return true;
+}
+
+static bool pcie_parse_bdf(const char *opts, char *bdf, size_t size)
+{
+	unsigned int domain, bus, dev, func;
+	const char *ptr;
+	char addr[32];
+	size_t len;
+
+	ptr = strstr(opts, "host=");
+	if (!ptr)
+		return false;
+
+	ptr += 5;
+	len = strcspn(ptr, ",");
+	if (!len || len >= sizeof(addr))
+		return false;
+
+	memcpy(addr, ptr, len);
+	addr[len] = '\0';
+
+	if (sscanf(addr, "%x:%x:%x.%x", &domain, &bus, &dev, &func) != 4) {
+		domain = 0;
+		if (sscanf(addr, "%x:%x.%x", &bus, &dev, &func) != 3) {
+			fprintf(stderr, "Invalid PCI address %s\n", addr);
+			return false;
+		}
+	}
+
+	snprintf(bdf, size, "%04x:%02x:%02x.%x", domain, bus, dev, func);
+
+	return true;
+}
+
+static void load_module(const char *name)
+{
+	pid_t pid;
+
+	pid = fork();
+	if (pid < 0)
+		return;
+
+	if (pid == 0) {
+		char *argv[3] = { "/sbin/modprobe", (char *) name, NULL };
+
+		execv(argv[0], argv);
+		exit(EXIT_FAILURE);
+	}
+
+	waitpid(pid, NULL, 0);
+}
+
+/* Returns the name of the driver currently bound to the given device, or
+ * NULL if the device is not bound to any driver.
+ */
+static const char *pcie_get_driver(const char *bdf, char *buf, size_t size)
+{
+	char path[PATH_MAX], link[PATH_MAX];
+	const char *name;
+	ssize_t len;
+
+	snprintf(path, sizeof(path), PCI_DEVICES_PATH "/%s/driver", bdf);
+
+	len = readlink(path, link, sizeof(link) - 1);
+	if (len < 0)
+		return NULL;
+
+	link[len] = '\0';
+
+	name = strrchr(link, '/');
+	name = name ? name + 1 : link;
+
+	snprintf(buf, size, "%.*s", (int) size - 1, name);
+
+	return buf;
+}
+
+static bool pcie_probe(const char *bdf)
+{
+	return sysfs_write("/sys/bus/pci/drivers_probe", bdf);
+}
+
+/* VFIO can only pass through a device if every other device in its IOMMU
+ * group is either unbound or already handled by VFIO, so check that before
+ * taking the device away from its driver.
+ */
+static bool pcie_group_viable(const char *bdf)
+{
+	char path[PATH_MAX], driver[64];
+	struct dirent *entry;
+	bool viable = true;
+	DIR *dir;
+
+	snprintf(path, sizeof(path),
+			PCI_DEVICES_PATH "/%s/iommu_group/devices", bdf);
+
+	dir = opendir(path);
+	if (!dir) {
+		fprintf(stderr, "No IOMMU group for %s, "
+				"is the IOMMU enabled?\n", bdf);
+		return false;
+	}
+
+	while ((entry = readdir(dir))) {
+		const char *name = entry->d_name;
+
+		if (name[0] == '.' || !strcmp(name, bdf))
+			continue;
+
+		if (!pcie_get_driver(name, driver, sizeof(driver)) ||
+				!strcmp(driver, "vfio-pci") ||
+				!strcmp(driver, "pci-stub"))
+			continue;
+
+		fprintf(stderr, "Device %s in the same IOMMU group is bound "
+				"to %s\n", name, driver);
+		viable = false;
+	}
+
+	closedir(dir);
+
+	if (!viable)
+		fprintf(stderr, "IOMMU group of %s is not viable for "
+				"passthrough\n", bdf);
+
+	return viable;
+}
+
+/* Binds the device given with -P to vfio-pci so it can be handed to the
+ * guest, remembering the driver it was bound to so it can be restored once
+ * the guest is done with it.
+ */
+static void pcie_bind_vfio(void)
+{
+	char path[PATH_MAX];
+	const char *driver;
+	struct stat st;
+
+	if (!pcie_parse_bdf(pcie_dev, pcie_bdf, sizeof(pcie_bdf)))
+		return;
+
+	snprintf(path, sizeof(path), PCI_DEVICES_PATH "/%s", pcie_bdf);
+	if (stat(path, &st) < 0) {
+		fprintf(stderr, "PCI device %s not found\n", pcie_bdf);
+		exit(EXIT_FAILURE);
+	}
+
+	load_module("vfio-pci");
+
+	driver = pcie_get_driver(pcie_bdf, pcie_driver, sizeof(pcie_driver));
+	if (driver && !strcmp(driver, "vfio-pci")) {
+		printf("Device %s already bound to vfio-pci\n", pcie_bdf);
+		pcie_bdf[0] = '\0';
+		return;
+	}
+
+	if (!pcie_group_viable(pcie_bdf))
+		exit(EXIT_FAILURE);
+
+	if (driver) {
+		printf("Unbinding %s from %s\n", pcie_bdf, driver);
+
+		snprintf(path, sizeof(path),
+				PCI_DEVICES_PATH "/%s/driver/unbind", pcie_bdf);
+		if (!sysfs_write(path, pcie_bdf)) {
+			fprintf(stderr, "Failed to unbind %s\n", pcie_bdf);
+			exit(EXIT_FAILURE);
+		}
+	} else {
+		pcie_driver[0] = '\0';
+	}
+
+	printf("Binding %s to vfio-pci\n", pcie_bdf);
+
+	snprintf(path, sizeof(path),
+			PCI_DEVICES_PATH "/%s/driver_override", pcie_bdf);
+	if (!sysfs_write(path, "vfio-pci") || !pcie_probe(pcie_bdf)) {
+		fprintf(stderr, "Failed to bind %s to vfio-pci\n", pcie_bdf);
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Undoes pcie_bind_vfio() */
+static void pcie_unbind_vfio(void)
+{
+	char path[PATH_MAX];
+
+	if (!pcie_bdf[0])
+		return;
+
+	printf("Unbinding %s from vfio-pci\n", pcie_bdf);
+
+	snprintf(path, sizeof(path),
+			PCI_DEVICES_PATH "/%s/driver/unbind", pcie_bdf);
+	sysfs_write(path, pcie_bdf);
+
+	snprintf(path, sizeof(path),
+			PCI_DEVICES_PATH "/%s/driver_override", pcie_bdf);
+	sysfs_write(path, "\n");
+
+	if (!pcie_driver[0])
+		return;
+
+	printf("Binding %s back to %s\n", pcie_bdf, pcie_driver);
+
+	pcie_probe(pcie_bdf);
+}
+
+static pid_t qemu_pid;
+
+/* Forwards the signal to QEMU so it can shutdown, the host driver is then
+ * restored once it is reaped.
+ */
+static void qemu_signal(int sig)
+{
+	if (qemu_pid > 0)
+		kill(qemu_pid, sig);
+}
+
+static int start_qemu(void)
 {
 	char cwd[PATH_MAX/2], initcmd[PATH_MAX], testargs[PATH_MAX];
 	char cmdline[CMDLINE_MAX];
 	char **argv;
-	int i, pos;
+	int i, pos, status = 0;
+	pid_t pid;
 
 	check_virtualization();
 
@@ -296,11 +543,15 @@ static void start_qemu(void)
 				"console=hvc0 earlyprintk=serial "
 				"no_hash_pointers=1 rootfstype=9p "
 				"rootflags=trans=virtio,version=9p2000.u "
-				"acpi=off pci=noacpi noapic quiet ro init=%s "
+				"%s quiet ro init=%s "
 				"TESTHOME=%s TESTDBUS=%u TESTDAEMON=%u "
 				"TESTDBUSSESSION=%u XDG_RUNTIME_DIR=/run/user/0 "
 				"TESTMONITOR=%u TESTEMULATOR=%u TESTDEVS=%d "
 				"TESTAUTO=%u TESTAUDIO='%s' TESTARGS=\'%s\'",
+				/* PCIe passthrough requires ACPI and APIC for
+				 * device enumeration and MSI interrupts.
+				 */
+				pcie_dev ? "" : "acpi=off pci=noacpi noapic",
 				initcmd, cwd, start_dbus, start_daemon,
 				start_dbus_session,
 				start_monitor, num_emulator, num_devs,
@@ -310,6 +561,7 @@ static void start_qemu(void)
 	argv = alloca(sizeof(qemu_argv) +
 			(sizeof(char *) * (8 + (num_devs * 4))) +
 			(sizeof(char *) * (usb_dev ? 4 : 0)) +
+			(sizeof(char *) * (pcie_dev ? 2 : 0)) +
 			(sizeof(char *) * num_extra_opts));
 	memcpy(argv, qemu_argv, sizeof(qemu_argv));
 
@@ -354,12 +606,58 @@ static void start_qemu(void)
 		argv[pos++] = usb_dev;
 	}
 
+	if (pcie_dev) {
+		argv[pos++] = "-device";
+		argv[pos++] = pcie_dev;
+	}
+
 	for (i = 0; i < num_extra_opts; ++i)
 		argv[pos++] = extra_opts[i];
 
 	argv[pos] = NULL;
 
-	execve(argv[0], argv, qemu_envp);
+	if (!pcie_dev) {
+		execve(argv[0], argv, qemu_envp);
+		return EXIT_FAILURE;
+	}
+
+	/* With a device passed through the host driver has to be restored
+	 * once the guest is done with it, so QEMU cannot simply replace this
+	 * process here.
+	 */
+	pcie_bind_vfio();
+
+	pid = fork();
+	if (pid < 0) {
+		perror("Failed to fork new process");
+		pcie_unbind_vfio();
+		return EXIT_FAILURE;
+	}
+
+	if (pid == 0) {
+		execve(argv[0], argv, qemu_envp);
+		exit(EXIT_FAILURE);
+	}
+
+	qemu_pid = pid;
+
+	/* Terminate QEMU rather than this process, so the host driver can be
+	 * restored below.
+	 */
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
+	pcie_unbind_vfio();
+
+	return WIFEXITED(status) ? WEXITSTATUS(status) : EXIT_FAILURE;
 }
 
 static int open_serial(const char *path)
@@ -1222,6 +1520,7 @@ static void usage(void)
 		"\t-A, --audio[=path]     Start audio server\n"
 		"\t-u, --unix[=path]      Provide serial device\n"
 		"\t-U, --usb <qemu_args>  Provide USB device\n"
+		"\t-P, --pcie <qemu_args> Provide PCIe device\n"
 		"\t-q, --qemu <path>      QEMU binary\n"
 		"\t-H, --qemu-host-cpu    Use host CPU (requires KVM support)\n"
 		"\t-k, --kernel <image>   Kernel bzImage or source tree path\n"
@@ -1243,6 +1542,7 @@ static const struct option main_options[] = {
 	{ "kernel",  required_argument, NULL, 'k' },
 	{ "audio",   optional_argument, NULL, 'A' },
 	{ "usb",     required_argument, NULL, 'U' },
+	{ "pcie",    required_argument, NULL, 'P' },
 	{ "option",  required_argument, NULL, 'o' },
 	{ "version", no_argument,       NULL, 'v' },
 	{ "help",    no_argument,       NULL, 'h' },
@@ -1265,7 +1565,7 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:o:vh",
+		opt = getopt_long(argc, argv, "au::bdsl::mq:Hk:A::U:P:o:vh",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -1310,6 +1610,9 @@ int main(int argc, char *argv[])
 		case 'U':
 			usb_dev = optarg;
 			break;
+		case 'P':
+			pcie_dev = optarg;
+			break;
 		case 'o':
 			if (num_extra_opts >= EXTRA_OPT_MAX) {
 				fprintf(stderr, "Too many -o\n");
@@ -1362,7 +1665,5 @@ int main(int argc, char *argv[])
 	printf("Using QEMU binary %s\n", qemu_binary);
 	printf("Using kernel image %s\n", kernel_image);
 
-	start_qemu();
-
-	return EXIT_SUCCESS;
+	return start_qemu();
 }
-- 
2.54.0

