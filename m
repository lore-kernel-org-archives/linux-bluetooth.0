Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/6] Bluetooth: Add skeleton for self-test module
Date: Mon, 22 Dec 2014 20:14:54 +0200
Message-Id: <1419272094-32152-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1419270792-29086-4-git-send-email-johan.hedberg@gmail.com>
References: <1419270792-29086-4-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a basic skeleton for a new self-test module. The module
will be used to implement various self-tests for the bluetooth
subsystem. The first user will be SMP, for which it is of particular
importance that this is as a separate module to avoid loading priority
conflicts with the crypto subsystem and the rest of the Bluetooth
subsystem.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Use tristate instead of bool in Kconfig, depend on BT_LE and improve
description.

 net/bluetooth/Kconfig    |  8 ++++++++
 net/bluetooth/Makefile   | 15 +++++++++------
 net/bluetooth/selftest.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 6 deletions(-)
 create mode 100644 net/bluetooth/selftest.c

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 29bcafc41adf..bdb30c7ac5d8 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -64,4 +64,12 @@ config BT_6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
 
+config BT_SELFTEST
+	tristate "Run self-tests on boot"
+	depends on BT_LE && DEBUG_KERNEL
+	help
+	  Self-tests for Bluetooth subsystem. Currently limited to SMP. This would
+	  only be of interest to developers hacking on code that's covered by the
+	  self-tests.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 364cff1ad4b1..9765a68925b3 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -2,15 +2,18 @@
 # Makefile for the Linux Bluetooth subsystem.
 #
 
-obj-$(CONFIG_BT)	+= bluetooth.o
-obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
-obj-$(CONFIG_BT_BNEP)	+= bnep/
-obj-$(CONFIG_BT_CMTP)	+= cmtp/
-obj-$(CONFIG_BT_HIDP)	+= hidp/
-obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
+obj-$(CONFIG_BT)		+= bluetooth.o
+obj-$(CONFIG_BT_RFCOMM)		+= rfcomm/
+obj-$(CONFIG_BT_BNEP)		+= bnep/
+obj-$(CONFIG_BT_CMTP)		+= cmtp/
+obj-$(CONFIG_BT_HIDP)		+= hidp/
+obj-$(CONFIG_BT_6LOWPAN)	+= bluetooth_6lowpan.o
+obj-$(CONFIG_BT_SELFTEST)	+= bluetooth_selftest.o
 
 bluetooth_6lowpan-y := 6lowpan.o
 
+bluetooth_selftest-y := selftest.o
+
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
 	a2mp.o amp.o ecc.o hci_request.o hci_debugfs.o
diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
new file mode 100644
index 000000000000..394b05427ad1
--- /dev/null
+++ b/net/bluetooth/selftest.c
@@ -0,0 +1,50 @@
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
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "smp.h"
+
+#define VERSION "0.1"
+
+static int __init selftest_init(void)
+{
+	BT_INFO("Bluetooth self-tests version %s", VERSION);
+
+	return 0;
+}
+
+static void __exit selftest_exit(void)
+{
+}
+
+module_init(selftest_init);
+module_exit(selftest_exit);
+
+MODULE_AUTHOR("Johan Hedberg <johan.hedberg@intel.com>");
+MODULE_DESCRIPTION("Bluetooth self-tests version " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
-- 
2.1.0

