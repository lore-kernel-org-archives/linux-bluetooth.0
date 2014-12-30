Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/2] Bluetooth: Add support for self testing framework
Date: Mon, 29 Dec 2014 20:48:35 -0800
Message-Id: <1419914916-27051-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This add support for the Bluetooth self testing framework that allows
running certain test cases of sample data to ensure correctness of its
basic functionality.

With this patch only the basic framework will be added. It contains
the build magic that allows running this at module loading time or
at late_initcall stage when built into the kernel image.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Kconfig        | 13 ++++++++++
 net/bluetooth/Makefile       |  2 ++
 net/bluetooth/af_bluetooth.c |  6 +++++
 net/bluetooth/selftest.c     | 62 ++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/selftest.h     | 45 ++++++++++++++++++++++++++++++++
 5 files changed, 128 insertions(+)
 create mode 100644 net/bluetooth/selftest.c
 create mode 100644 net/bluetooth/selftest.h

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 29bcafc41adf..3296841531c9 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -64,4 +64,17 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
+config BT_SELFTEST
+	bool "Bluetooth self testing support"
+	depends on BT && DEBUG_KERNEL
+	help
+	  Run self tests when initializing the Bluetooth subsystem.  This
+	  is a developer option and can cause significant delay when booting
+	  the system.
+
+	  When the Bluetooth subsystem is built as module, then the test
+	  cases are run first thing at module load time.  When the Bluetooth
+	  subsystem is compiled into the kernel image, then the test cases
+	  are run late in the initcall hierarchy.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 364cff1ad4b1..8e96e3072266 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -15,4 +15,6 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
 	a2mp.o amp.o ecc.o hci_request.o hci_debugfs.o
 
+bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
+
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 012e3b03589d..ce22e0cfa923 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -31,6 +31,8 @@
 #include <net/bluetooth/bluetooth.h>
 #include <linux/proc_fs.h>
 
+#include "selftest.h"
+
 #define VERSION "2.20"
 
 /* Bluetooth sockets */
@@ -716,6 +718,10 @@ static int __init bt_init(void)
 
 	BT_INFO("Core ver %s", VERSION);
 
+	err = bt_selftest();
+	if (err < 0)
+		return err;
+
 	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
 
 	err = bt_sysfs_init();
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
new file mode 100644
index 000000000000..00cac4a5e229
--- /dev/null
+++ b/net/bluetooth/selftest.c
@@ -0,0 +1,62 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+
+   Copyright (C) 2014 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#include <net/bluetooth/bluetooth.h>
+
+#include "selftest.h"
+
+static int __init run_selftest(void)
+{
+	BT_INFO("Starting self testing");
+
+	BT_INFO("Finished self testing");
+
+	return 0;
+}
+
+#if IS_MODULE(CONFIG_BT)
+
+/* This is run when CONFIG_BT_SELFTEST=y and CONFIG_BT=m and is just a
+ * wrapper to allow running this at module init.
+ *
+ * If CONFIG_BT_SELFTEST=n, then this code is not compiled at all.
+ */
+int __init bt_selftest(void)
+{
+	return run_selftest();
+}
+
+#else
+
+/* This is run when CONFIG_BT_SELFTEST=y and CONFIG_BT=y and is run
+ * via late_initcall() as last item in the initialization sequence.
+ *
+ * If CONFIG_BT_SELFTEST=n, then this code is not compiled at all.
+ */
+static int __init bt_selftest_init(void)
+{
+	return run_selftest();
+}
+late_initcall(bt_selftest_init);
+
+#endif
diff --git a/net/bluetooth/selftest.h b/net/bluetooth/selftest.h
new file mode 100644
index 000000000000..2aa0a346a913
--- /dev/null
+++ b/net/bluetooth/selftest.h
@@ -0,0 +1,45 @@
+/*
+   BlueZ - Bluetooth protocol stack for Linux
+   Copyright (C) 2014 Intel Corporation
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License version 2 as
+   published by the Free Software Foundation;
+
+   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
+   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT OF THIRD PARTY RIGHTS.
+   IN NO EVENT SHALL THE COPYRIGHT HOLDER(S) AND AUTHOR(S) BE LIABLE FOR ANY
+   CLAIM, OR ANY SPECIAL INDIRECT OR CONSEQUENTIAL DAMAGES, OR ANY DAMAGES
+   WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+   ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+   OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+
+   ALL LIABILITY, INCLUDING LIABILITY FOR INFRINGEMENT OF ANY PATENTS,
+   COPYRIGHTS, TRADEMARKS OR OTHER RIGHTS, RELATING TO USE OF THIS
+   SOFTWARE IS DISCLAIMED.
+*/
+
+#if IS_ENABLED(CONFIG_BT_SELFTEST) && IS_MODULE(CONFIG_BT)
+
+/* When CONFIG_BT_SELFTEST=y and the CONFIG_BT=m, then the self testing
+ * is run at module loading time.
+ */
+int bt_selftest(void);
+
+#else
+
+/* When CONFIG_BT_SELFTEST=y and CONFIG_BT=y, then the self testing
+ * is run via late_initcall() to make sure that subsys_initcall() of
+ * the Bluetooth subsystem and device_initcall() of the Crypto subsystem
+ * do not clash.
+ *
+ * When CONFIG_BT_SELFTEST=n, then this turns into an empty call that
+ * has no impact.
+ */
+static inline int bt_selftest(void)
+{
+	return 0;
+}
+
+#endif
-- 
2.1.0

