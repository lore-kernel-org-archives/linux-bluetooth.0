Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC05944F56E
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 07:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790754663; cv=none; b=ldMrPsb402x+FJ6n3IztPAxox4afGMy+Orv44hf1c3oxAFX3bdh6YQ+qTC4SIdJGXLUveqWY8tTWp3b49TC/ReQeFCENJF2YBpe3h+qDnWej1BJ8FJsNIimJObg9nI3MhJe+06tje1NDqQTE+Qs5uZ0AAQVTJqwqCeHIyB4HCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790754663; c=relaxed/simple;
	bh=mJaYEx1dWxdi10e0pGVbxPwSO0QR7DKGkK/gGl1PY1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K6CVWRbZT4vTGBEnknIk/djeOgLNfzSlOjyRtxdtJTTCx290/V5TmqhN3K5/M6nODAG/Xh6aqaUd1B7PbnMUPJlETDJwTX3nF4+NXf5bXPDDmbkgQ0DPyrc4k8sZZvH+xfzyMhQf80W/UHOHP1xaaOG1A7SE9GN0SW4IOV4mjho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LI5oqrYw; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LI5oqrYw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790754660; x=1822290660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mJaYEx1dWxdi10e0pGVbxPwSO0QR7DKGkK/gGl1PY1E=;
  b=LI5oqrYwlZfLkI4IsXaImo4gd73tfWFQehXturzs35dpaFgloUWK1BJo
   ftG6IYgMrn4qICJFLRIxCjFbSsgrS/aD7G5Kuke9iNHrP89FA1tACZMpl
   OfGzI/RZAxCnl24FIZgasTXPkQ8GbOi3yu4jT9oPjWPay8zdlIf2iYVa/
   ubozuv3YO4mfhppcmZZv/AEguLl2jx0YQlCwB62WpzJ2XAqyTliDCNrGy
   srM8PLUSZ22RSl6i9GisRoVwS6tF49ebBMdc6d4h9sVzIq0SpMLFABa4i
   B3D4RS5UPIVBTPJd/5XD/fyElLKSt13WcOqPZBPeME4n2Abg95BSm3bsj
   A==;
X-CSE-ConnectionGUID: LzW3N+WcTsK/JtIg+c+I9Q==
X-CSE-MsgGUID: gBnM2q/KTS2Hff0rOm8qng==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="90386170"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="90386170"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 00:51:00 -0700
X-CSE-ConnectionGUID: VJMBSN8iQbqkBAPzZFt5iA==
X-CSE-MsgGUID: NU3Wc2p/QMScDu7WasGEBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="274816299"
Received: from weba0534.iind.intel.com ([10.66.226.131])
  by fmviesa010.fm.intel.com with ESMTP; 30 Sep 2026 00:50:58 -0700
From: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: kiran.k@intel.com,
	chethan.tumkur.narayan@intel.com,
	Sai Teja Aluvala <aluvala.sai.teja@intel.com>
Subject: [PATCH v1 1/1] emulator: add generic HW rfkill test tool
Date: Wed, 30 Sep 2026 13:12:39 +0530
Message-ID: <66971d6f85d714f2728b29fada7136d5a2fbb3c2.1790752800.git.aluvala.sai.teja@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790752800.git.aluvala.sai.teja@intel.com>
References: <cover.1790752800.git.aluvala.sai.teja@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add emulator/hci_rfkill, a standalone tool that drives the
force_hw_rfkill debugfs hook for an hciN device and verifies the
reported hardware-block state against /sys/class/rfkill. The hook
exercises the generic net/bluetooth rfkill path for any HCI transport;
it does not test the driver's hardware interrupt or register handling.

Support assert-only, deassert-only, and toggle modes. Validate the
hciN argument before using it in filesystem paths. In toggle mode,
if asserting the block was written successfully but subsequent
verification fails, still attempt a verified unblock while preserving
the failure result. Do not attempt an unblock when the assert write
itself fails.

The optional -r/--restore mode snapshots the adapter's up/down state
via HCIGETDEVINFO and restores it via HCIDEVUP/HCIDEVDOWN, following
the raw HCI control-socket approach used by tools/hciconfig.c.

Usage: hci_rfkill [-e|-d|-t] [-r] hciN

Signed-off-by: Sai Teja Aluvala <aluvala.sai.teja@intel.com>
---
 Makefile.tools        |   3 +
 emulator/hci_rfkill.c | 478 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 481 insertions(+)
 create mode 100644 emulator/hci_rfkill.c

diff --git a/Makefile.tools b/Makefile.tools
index 2914bf1c0..4e5d0d976 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -85,6 +85,7 @@ endif
 
 if TESTING
 noinst_PROGRAMS += emulator/btvirt emulator/b1ee emulator/hfp \
+					emulator/hci_rfkill \
 					peripheral/btsensor tools/3dsp \
 					tools/mgmt-tester tools/gap-tester \
 					tools/l2cap-tester tools/sco-tester \
@@ -111,6 +112,8 @@ emulator_b1ee_LDADD = src/libshared-mainloop.la
 emulator_hfp_SOURCES = emulator/hfp.c
 emulator_hfp_LDADD = src/libshared-mainloop.la
 
+emulator_hci_rfkill_SOURCES = emulator/hci_rfkill.c
+
 peripheral_btsensor_SOURCES = peripheral/main.c \
 				peripheral/efivars.h peripheral/efivars.c \
 				peripheral/attach.h peripheral/attach.c \
diff --git a/emulator/hci_rfkill.c b/emulator/hci_rfkill.c
new file mode 100644
index 000000000..f5ef5e3bb
--- /dev/null
+++ b/emulator/hci_rfkill.c
@@ -0,0 +1,478 @@
+// SPDX-License-Identifier: LGPL-2.1-or-later
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2026  Intel Corporation
+ *
+ */
+
+/*
+ * hci_rfkill - generic HW rfkill stack test driver.
+ *
+ * Applies to any hci_dev with rfkill registered, regardless of vendor or
+ * transport (USB, UART, PCIe, virtual, etc.). Many transport drivers (e.g.
+ * btintel_pcie) are bound to real hardware and have no userspace-attachable
+ * transport to emulate the way emulator/vhci.c does for /dev/vhci. Instead,
+ * net/bluetooth's hci_debugfs.c exposes a generic debugfs test hook
+ * ("force_hw_rfkill" under /sys/kernel/debug/bluetooth/hciN/) that calls
+ * hci_rfkill_set_hw_state() directly. That is the exact same entry point
+ * any driver's real HW rfkill interrupt path (e.g. btintel_pcie's
+ * MSIX/doorbell flow, or another vendor's equivalent) calls into, so
+ * writing this hook exercises the full net/bluetooth rfkill core
+ * notification chain (hci_rfkill_set_block() -> HCI_RFKILLED flag ->
+ * device power on/off) without needing the driver to assert its real HW
+ * rfkill line. This tool writes that hook to simulate the HW rfkill line
+ * toggling and reads back both the debugfs state and the corresponding
+ * /sys/class/rfkill hard-block state to confirm the hci_dev (and rfkill
+ * core) picked up the change.
+ *
+ * Note: this only covers the net/bluetooth stack side of the flow. The
+ * driver-side interrupt/doorbell/register-read logic that decides when to
+ * call hci_rfkill_set_hw_state() in the first place is vendor/transport
+ * specific and is not exercised by this tool; that still requires real
+ * hardware or a transport-level (e.g. PCIe) emulation to test.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <string.h>
+#include <ctype.h>
+#include <getopt.h>
+#include <dirent.h>
+#include <limits.h>
+#include <stdarg.h>
+#include <sys/socket.h>
+#include <sys/ioctl.h>
+
+#include "bluetooth/bluetooth.h"
+#include "bluetooth/hci.h"
+
+#define DEBUGFS_PATH "/sys/kernel/debug/bluetooth"
+#define RFKILL_CLASS_PATH "/sys/class/rfkill"
+
+static bool verbose;
+
+static void print_verbose(const char *format, ...)
+{
+	va_list ap;
+
+	if (!verbose)
+		return;
+
+	va_start(ap, format);
+	vprintf(format, ap);
+	va_end(ap);
+}
+
+static int debugfs_hw_rfkill_write(const char *hci_name, bool enable)
+{
+	char path[128];
+	int fd, err;
+	char val = enable ? 'Y' : 'N';
+
+	snprintf(path, sizeof(path), DEBUGFS_PATH "/%s/force_hw_rfkill",
+							hci_name);
+
+	fd = open(path, O_WRONLY);
+	if (fd < 0) {
+		err = -errno;
+		fprintf(stderr, "Failed to open %s: %s\n", path,
+							strerror(errno));
+		return err;
+	}
+
+	if (write(fd, &val, sizeof(val)) != sizeof(val)) {
+		err = -errno;
+		fprintf(stderr, "Failed to write %s: %s\n", path,
+							strerror(errno));
+		close(fd);
+		return err;
+	}
+
+	close(fd);
+
+	return 0;
+}
+
+static int debugfs_hw_rfkill_read(const char *hci_name, bool *enable)
+{
+	char path[128];
+	char buf[8];
+	int fd, err;
+	ssize_t len;
+
+	snprintf(path, sizeof(path), DEBUGFS_PATH "/%s/force_hw_rfkill",
+							hci_name);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		err = -errno;
+		fprintf(stderr, "Failed to open %s: %s\n", path,
+							strerror(errno));
+		return err;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	len = read(fd, buf, sizeof(buf) - 1);
+	close(fd);
+
+	if (len < 1)
+		return -EIO;
+
+	*enable = (buf[0] == 'Y');
+
+	return 0;
+}
+
+/* Locate the /sys/class/rfkill/rfkillN entry whose "name" matches the given
+ * hci device name (e.g. "hci0") and read back its hard-block state.
+ */
+static int rfkill_class_hard_read(const char *hci_name, bool *blocked)
+{
+	DIR *dir;
+	struct dirent *entry;
+	int ret = -ENOENT;
+	int val;
+
+	dir = opendir(RFKILL_CLASS_PATH);
+	if (!dir)
+		return -errno;
+
+	while ((entry = readdir(dir)) != NULL) {
+		char path[PATH_MAX];
+		char name[64];
+		FILE *f;
+
+		if (strncmp(entry->d_name, "rfkill", 6))
+			continue;
+
+		snprintf(path, sizeof(path), RFKILL_CLASS_PATH "/%s/name",
+							entry->d_name);
+
+		f = fopen(path, "r");
+		if (!f)
+			continue;
+
+		memset(name, 0, sizeof(name));
+		if (!fgets(name, sizeof(name), f)) {
+			fclose(f);
+			continue;
+		}
+		fclose(f);
+
+		name[strcspn(name, "\n")] = '\0';
+
+		if (strcmp(name, hci_name))
+			continue;
+
+		snprintf(path, sizeof(path), RFKILL_CLASS_PATH "/%s/hard",
+							entry->d_name);
+
+		f = fopen(path, "r");
+		if (!f) {
+			ret = -errno;
+			break;
+		}
+
+		if (fscanf(f, "%d", &val) == 1) {
+			*blocked = (val != 0);
+			ret = 0;
+		} else {
+			ret = -EIO;
+		}
+		fclose(f);
+		break;
+	}
+
+	closedir(dir);
+
+	return ret;
+}
+
+/* Parse the numeric device id out of an "hciN" name without requiring the
+ * device to be up (unlike lib/bluetooth's hci_devid(), which internally
+ * calls hci_devba() and fails with ENETDOWN on a down/blocked device --
+ * exactly the state this tool may have just put the adapter into).
+ */
+static int hci_name_to_id(const char *hci_name)
+{
+	const char *p;
+	char *end;
+	unsigned long id;
+
+	if (strncmp(hci_name, "hci", 3))
+		return -1;
+
+	p = hci_name + 3;
+	if (!*p)
+		return -1;
+
+	while (*p) {
+		if (!isdigit((unsigned char)*p))
+			return -1;
+		p++;
+	}
+
+	errno = 0;
+	id = strtoul(hci_name + 3, &end, 10);
+	if (errno == ERANGE || *end || id > USHRT_MAX)
+		return -1;
+
+	return id;
+}
+
+/* Query whether the given hci device currently has HCI_UP set, using the
+ * same raw HCI control socket + ioctl approach as tools/hciconfig.c.
+ */
+static int hci_dev_is_up(int hdev_id, bool *up)
+{
+	struct hci_dev_info di;
+	int ctl, err;
+
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (ctl < 0)
+		return -errno;
+
+	memset(&di, 0, sizeof(di));
+	di.dev_id = hdev_id;
+
+	if (ioctl(ctl, HCIGETDEVINFO, (void *) &di) < 0) {
+		err = -errno;
+		close(ctl);
+		return err;
+	}
+
+	close(ctl);
+
+	*up = !!(di.flags & (1U << HCI_UP));
+
+	return 0;
+}
+
+/* Bring the given hci device up or down via HCIDEVUP/HCIDEVDOWN, mirroring
+ * tools/hciconfig.c's cmd_up()/cmd_down(). Used to restore the adapter to
+ * its pre-test state, since unblocking HW rfkill does not automatically
+ * reopen the device (that is normally done by bluetoothd reacting to the
+ * rfkill unblock event via mgmt).
+ */
+static int hci_dev_set_up(int hdev_id, bool up)
+{
+	int ctl, err;
+
+	ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
+	if (ctl < 0)
+		return -errno;
+
+	if (ioctl(ctl, up ? HCIDEVUP : HCIDEVDOWN, hdev_id) < 0) {
+		err = -errno;
+		close(ctl);
+		/* HCIDEVUP returns EALREADY if the device is already up
+		 * (mirrors tools/hciconfig.c's cmd_up()); HCIDEVDOWN has
+		 * no such case.
+		 */
+		return (up && err == -EALREADY) ? 0 : err;
+	}
+
+	close(ctl);
+
+	return 0;
+}
+
+static int run_test(const char *hci_name, bool enable, bool *write_succeeded)
+{
+	bool val;
+	int err;
+
+	*write_succeeded = false;
+	printf("Setting HW rfkill %s on %s\n", enable ? "ON" : "OFF",
+								hci_name);
+
+	err = debugfs_hw_rfkill_write(hci_name, enable);
+	if (err)
+		return err;
+	*write_succeeded = true;
+
+	err = debugfs_hw_rfkill_read(hci_name, &val);
+	if (err) {
+		fprintf(stderr, "Failed to read back debugfs state: %s\n",
+							strerror(-err));
+		return err;
+	}
+
+	if (val != enable) {
+		fprintf(stderr, "debugfs force_hw_rfkill mismatch: wrote %d, "
+					"read %d\n", enable, val);
+		return -EIO;
+	}
+
+	print_verbose("debugfs force_hw_rfkill now reports: %s\n",
+						val ? "Y" : "N");
+
+	err = rfkill_class_hard_read(hci_name, &val);
+	if (err) {
+		fprintf(stderr, "Failed to read rfkill class state for %s: "
+					"%s\n", hci_name, strerror(-err));
+		return err;
+	}
+
+	print_verbose("rfkill class hard-block state: %s\n",
+						val ? "blocked" : "unblocked");
+
+	if (val != enable) {
+		fprintf(stderr, "rfkill class state mismatch: expected "
+					"%s, got %s\n",
+					enable ? "blocked" : "unblocked",
+					val ? "blocked" : "unblocked");
+		return -EIO;
+	}
+
+	printf("OK: hci_dev and rfkill class agree HW rfkill is %s\n",
+						enable ? "ON" : "OFF");
+
+	return 0;
+}
+
+static void usage(void)
+{
+	printf("hci_rfkill - generic HW rfkill stack test driver\n"
+		"Usage:\n");
+	printf("\thci_rfkill [options] <hciN>\n");
+	printf("options:\n"
+		"\t-t, --toggle       Toggle HW rfkill on then off "
+							"(default)\n"
+		"\t-e, --enable       Only assert HW rfkill (block)\n"
+		"\t-d, --disable      Only de-assert HW rfkill (unblock)\n"
+		"\t-r, --restore      Restore the adapter to its pre-test\n"
+		"\t                   up/down state afterwards (unblocking\n"
+		"\t                   HW rfkill does not reopen the device\n"
+		"\t                   on its own; that is normally done by\n"
+		"\t                   bluetoothd reacting to the rfkill\n"
+		"\t                   event via mgmt). Note: combined with\n"
+		"\t                   -e, restoring an adapter that was up\n"
+		"\t                   will fail with ERFKILL, since it is\n"
+		"\t                   left HW-blocked on purpose\n"
+		"\t-v, --verbose      Show verbose output\n"
+		"\t-h, --help         Show help options\n");
+}
+
+static const struct option main_options[] = {
+	{ "toggle",	no_argument,	NULL, 't' },
+	{ "enable",	no_argument,	NULL, 'e' },
+	{ "disable",	no_argument,	NULL, 'd' },
+	{ "restore",	no_argument,	NULL, 'r' },
+	{ "verbose",	no_argument,	NULL, 'v' },
+	{ "help",	no_argument,	NULL, 'h' },
+	{ }
+};
+
+int main(int argc, char *argv[])
+{
+	const char *hci_name;
+	int mode = 't';
+	bool restore = false;
+	int opt;
+	int hdev_id = -1;
+	bool was_up = false;
+	bool have_pre_state = false;
+	bool write_succeeded;
+	int ret = EXIT_SUCCESS;
+	int err;
+
+	while ((opt = getopt_long(argc, argv, "tedrvh",
+						main_options, NULL)) != -1) {
+		switch (opt) {
+		case 't':
+		case 'e':
+		case 'd':
+			mode = opt;
+			break;
+		case 'r':
+			restore = true;
+			break;
+		case 'v':
+			verbose = true;
+			break;
+		case 'h':
+			usage();
+			return EXIT_SUCCESS;
+		default:
+			usage();
+			return EXIT_FAILURE;
+		}
+	}
+
+	argc -= optind;
+	argv += optind;
+
+	if (argc < 1) {
+		usage();
+		return EXIT_FAILURE;
+	}
+
+	hci_name = argv[0];
+
+	hdev_id = hci_name_to_id(hci_name);
+	if (hdev_id < 0) {
+		fprintf(stderr, "Invalid hci device name %s\n", hci_name);
+		return EXIT_FAILURE;
+	}
+
+	if (restore) {
+		err = hci_dev_is_up(hdev_id, &was_up);
+		if (err) {
+			fprintf(stderr, "Failed to query %s up state: %s\n",
+						hci_name, strerror(-err));
+			return EXIT_FAILURE;
+		}
+
+		have_pre_state = true;
+		print_verbose("%s pre-test state: %s\n", hci_name,
+						was_up ? "up" : "down");
+	}
+
+	switch (mode) {
+	case 'e':
+		if (run_test(hci_name, true, &write_succeeded))
+			ret = EXIT_FAILURE;
+		break;
+	case 'd':
+		if (run_test(hci_name, false, &write_succeeded))
+			ret = EXIT_FAILURE;
+		break;
+	case 't':
+	default:
+		err = run_test(hci_name, true, &write_succeeded);
+		if (err)
+			ret = EXIT_FAILURE;
+		if (write_succeeded) {
+			if (run_test(hci_name, false, &write_succeeded))
+				ret = EXIT_FAILURE;
+		}
+		break;
+	}
+
+	if (restore && have_pre_state) {
+		err = hci_dev_set_up(hdev_id, was_up);
+		if (err) {
+			fprintf(stderr, "Failed to restore %s to its "
+					"pre-test %s state: %s\n", hci_name,
+					was_up ? "up" : "down",
+					strerror(-err));
+			ret = EXIT_FAILURE;
+		} else {
+			print_verbose("%s restored to pre-test state: %s\n",
+					hci_name, was_up ? "up" : "down");
+		}
+	}
+
+	return ret;
+}
-- 
2.53.0

