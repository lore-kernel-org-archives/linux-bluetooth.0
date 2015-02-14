Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Provide option to enable/disable debugfs information
Date: Sat, 14 Feb 2015 13:40:06 -0800
Message-Id: <1423950006-9119-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth controllers can export extensive information about
internal states via debugfs. This patch provides an option to
choose if these information are provided or not.

For backwards compatibility with existing kernel configuration,
this option defaults to yes.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/Kconfig       |  8 ++++++++
 net/bluetooth/Makefile      |  3 ++-
 net/bluetooth/hci_debugfs.h | 22 ++++++++++++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index 7de74635a110..b8c794b87523 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -91,4 +91,12 @@ config BT_SELFTEST_SMP
 	  Run test cases for SMP cryptographic functionality, including both
 	  legacy SMP as well as the Secure Connections features.
 
+config BT_DEBUGFS
+	bool "Export Bluetooth internals in debugfs"
+	depends on BT && DEBUG_FS
+	default y
+	help
+	  Provide extensive information about internal Bluetooth states
+	  in debugfs.
+
 source "drivers/bluetooth/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 8e96e3072266..5d608799717e 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -13,8 +13,9 @@ bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
 	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
-	a2mp.o amp.o ecc.o hci_request.o hci_debugfs.o
+	a2mp.o amp.o ecc.o hci_request.o
 
+bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
 subdir-ccflags-y += -D__CHECK_ENDIAN__
diff --git a/net/bluetooth/hci_debugfs.h b/net/bluetooth/hci_debugfs.h
index fb68efe083c5..4444dc8cedc2 100644
--- a/net/bluetooth/hci_debugfs.h
+++ b/net/bluetooth/hci_debugfs.h
@@ -20,7 +20,29 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#if IS_ENABLED(CONFIG_BT_DEBUGFS)
+
 void hci_debugfs_create_common(struct hci_dev *hdev);
 void hci_debugfs_create_bredr(struct hci_dev *hdev);
 void hci_debugfs_create_le(struct hci_dev *hdev);
 void hci_debugfs_create_conn(struct hci_conn *conn);
+
+#else
+
+static inline void hci_debugfs_create_common(struct hci_dev *hdev)
+{
+}
+
+static inline void hci_debugfs_create_bredr(struct hci_dev *hdev)
+{
+}
+
+static inline void hci_debugfs_create_le(struct hci_dev *hdev)
+{
+}
+
+static inline void hci_debugfs_create_conn(struct hci_conn *conn)
+{
+}
+
+#endif
-- 
2.1.0

