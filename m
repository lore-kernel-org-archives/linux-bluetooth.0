Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 3/5] Bluetooth: 6LoWPAN: Create a kernel module
Date: Mon,  2 Jun 2014 18:00:25 +0300
Message-Id: <1401721227-28439-4-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1401721227-28439-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1401721227-28439-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of adding the 6LoWPAN functionality to Bluetooth module,
we create a separate kernel module for it.

Usage:

In the slave side do this:

$ modprobe bluetooth_6lowpan
$ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
$ hciconfig hci0 leadv

In the master side do this:

$ modprobe bluetooth_6lowpan
$ echo 62 > /sys/kernel/debug/bluetooth/6lowpan_psm
$ echo 'connect E0:06:E6:B7:2A:73 1' > \
                  /sys/kernel/debug/bluetooth/6lowpan_control

The 6LoWPAN functionality can be controlled by psm value. If it
is left to 0, then the module is disabled and all the 6LoWPAN
connections are dropped if there were any. In the above example,
the psm value is just an example and not a real value for
6LoWPAN service. The real psm value is yet to be defined in
Bluetooth specification.

The 6lowpan controlling interface is a temporary solution
until the specifications are ready.

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 net/bluetooth/6lowpan.c | 11 ++++++++++-
 net/bluetooth/Kconfig   |  6 +++---
 net/bluetooth/Makefile  |  4 +++-
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index d197bbe..debf003 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -14,6 +14,7 @@
 #include <linux/if_arp.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
+#include <linux/module.h>
 #include <linux/debugfs.h>
 
 #include <net/ipv6.h>
@@ -1231,7 +1232,7 @@ static int __init bt_6lowpan_init(void)
 	return register_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
 
-void bt_6lowpan_cleanup(void)
+static void __exit bt_6lowpan_cleanup(void)
 {
 	cleanup_6lowpan();
 
@@ -1239,3 +1240,11 @@ void bt_6lowpan_cleanup(void)
 
 	unregister_netdevice_notifier(&bt_6lowpan_dev_notifier);
 }
+
+module_init(bt_6lowpan_init);
+module_exit(bt_6lowpan_cleanup);
+
+MODULE_AUTHOR("Jukka Rissanen <jukka.rissanen@linux.intel.com>");
+MODULE_DESCRIPTION("Bluetooth 6LoWPAN");
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 06ec144..f5afaa2 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -6,7 +6,6 @@ menuconfig BT
 	tristate "Bluetooth subsystem support"
 	depends on NET && !S390
 	depends on RFKILL || !RFKILL
-	select 6LOWPAN_IPHC if BT_6LOWPAN
 	select CRC16
 	select CRYPTO
 	select CRYPTO_BLKCIPHER
@@ -41,10 +40,11 @@ menuconfig BT
 	  more information, see <http://www.bluez.org/>.
 
 config BT_6LOWPAN
-	bool "Bluetooth 6LoWPAN support"
+	tristate "Bluetooth 6LoWPAN support"
 	depends on BT && IPV6
+	select 6LOWPAN_IPHC if BT_6LOWPAN
 	help
-	  IPv6 compression over Bluetooth.
+	  IPv6 compression over Bluetooth Low Energy.
 
 source "net/bluetooth/rfcomm/Kconfig"
 
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index ca51246..886e9aa 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -7,10 +7,12 @@ obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
 obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
+obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
+
+bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
 	a2mp.o amp.o
-bluetooth-$(CONFIG_BT_6LOWPAN) += 6lowpan.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
-- 
1.8.3.1

