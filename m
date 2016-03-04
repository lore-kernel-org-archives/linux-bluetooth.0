Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Patrik Flykt <patrik.flykt@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/5] bluetooth: Merge Bluetooth 6lowpan functionality to bluetooth module
Date: Fri,  4 Mar 2016 13:40:40 +0200
Message-Id: <1457091644-21536-2-git-send-email-patrik.flykt@linux.intel.com>
In-Reply-To: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
References: <1457091644-21536-1-git-send-email-patrik.flykt@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bluetooth_6lowpan.ko module functionality is compiled into the
bluetooth module and a new header file 6lowpan.h is created. Kconfig
and Makefile are updated accordingly. 6lowpan init and exit functions
are called from the bluetooth module.

Signed-off-by: Patrik Flykt <patrik.flykt@linux.intel.com>
---
 net/bluetooth/6lowpan.c      | 12 ++----------
 net/bluetooth/Kconfig        |  2 +-
 net/bluetooth/Makefile       |  4 +---
 net/bluetooth/af_bluetooth.c | 11 +++++++++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 8a4cc2f..b675448 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1387,7 +1387,7 @@ static struct notifier_block bt_6lowpan_dev_notifier = {
 	.notifier_call = device_event,
 };
 
-static int __init bt_6lowpan_init(void)
+int bt_6lowpan_init(void)
 {
 	lowpan_enable_debugfs = debugfs_create_file("6lowpan_enable", 0644,
 						    bt_debugfs, NULL,
@@ -1399,7 +1399,7 @@ static int __init bt_6lowpan_init(void)
 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
 
-static void __exit bt_6lowpan_exit(void)
+void bt_6lowpan_exit(void)
 {
 	debugfs_remove(lowpan_enable_debugfs);
 	debugfs_remove(lowpan_control_debugfs);
@@ -1413,11 +1413,3 @@ static void __exit bt_6lowpan_exit(void)
 
 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
-
-module_init(bt_6lowpan_init);
-module_exit(bt_6lowpan_exit);
-
-MODULE_AUTHOR("Jukka Rissanen <jukka.rissanen@linux.intel.com>");
-MODULE_DESCRIPTION("Bluetooth 6LoWPAN");
-MODULE_VERSION(VERSION);
-MODULE_LICENSE("GPL");
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 06c31b9..5f29659 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -64,7 +64,7 @@ config BT_LE
 	default y
 
 config BT_6LOWPAN
-	tristate "Bluetooth 6LoWPAN support"
+	bool "Bluetooth 6LoWPAN support"
 	depends on BT_LE && 6LOWPAN
 	help
 	  IPv6 compression over Bluetooth Low Energy.
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index b3ff12e..57b02ba 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -7,9 +7,6 @@ obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
 obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
-obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
-
-bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
@@ -18,6 +15,7 @@ bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 bluetooth-$(CONFIG_BT_BREDR) += sco.o
 bluetooth-$(CONFIG_BT_HS) += a2mp.o amp.o
 bluetooth-$(CONFIG_BT_LEDS) += leds.o
+bluetooth-$(CONFIG_BT_6LOWPAN) += 6lowpan.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 955eda9..571a324 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -29,6 +29,7 @@
 #include <asm/ioctls.h>
 
 #include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/6lowpan.h>
 #include <linux/proc_fs.h>
 
 #include "selftest.h"
@@ -747,8 +748,16 @@ static int __init bt_init(void)
 		goto sock_err;
 	}
 
+	err = bt_6lowpan_init();
+	if (err < 0) {
+		sco_exit();
+		l2cap_exit();
+		goto sock_err;
+	}
+
 	err = mgmt_init();
 	if (err < 0) {
+		bt_6lowpan_exit();
 		sco_exit();
 		l2cap_exit();
 		goto sock_err;
@@ -770,6 +779,8 @@ static void __exit bt_exit(void)
 {
 	mgmt_exit();
 
+	bt_6lowpan_exit();
+
 	sco_exit();
 
 	l2cap_exit();
-- 
2.1.4

