Return-Path: <cyrus@holtmann.org>
From: Arron Wang <arron.wang@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Arron Wang <arron.wang@intel.com>
Subject: [PATCH 1/2] Bluetooth: Add option to enable/disable SCO support
Date: Fri, 22 May 2015 13:56:04 +0800
Message-Id: <1432274165-23569-1-git-send-email-arron.wang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Embedded device may need flexible option to reduce the code size
and memory use

Signed-off-by: Arron Wang <arron.wang@intel.com>
---
 include/net/bluetooth/bluetooth.h |   11 +++++++++++
 include/net/bluetooth/hci_core.h  |   13 +++++++++++++
 net/bluetooth/Kconfig             |   10 +++++++++-
 net/bluetooth/Makefile            |    3 ++-
 4 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 7dba805..f085ff14 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -365,8 +365,19 @@ extern struct dentry *bt_debugfs;
 int l2cap_init(void);
 void l2cap_exit(void);
 
+#if IS_ENABLED(CONFIG_BT_SCO)
 int sco_init(void);
 void sco_exit(void);
+#else
+static inline int sco_init(void)
+{
+	return 0;
+}
+
+static inline void sco_exit(void)
+{
+}
+#endif
 
 int mgmt_init(void);
 void mgmt_exit(void);
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a056c2b..7c70034 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -532,8 +532,21 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int l2cap_disconn_ind(struct hci_conn *hcon);
 int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags);
 
+#if IS_ENABLED(CONFIG_BT_SCO)
 int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags);
 int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
+#else
+static inline int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr,
+				  __u8 *flags)
+{
+	return 0;
+}
+
+static inline int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
+{
+	return 0;
+}
+#endif
 
 /* ----- Inquiry cache ----- */
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index b8c794b..e7bca37 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -23,10 +23,10 @@ menuconfig BT
 	  Linux Bluetooth subsystem consist of several layers:
 	     Bluetooth Core
 		HCI device and connection manager, scheduler
-		SCO audio links
 		L2CAP (Logical Link Control and Adaptation Protocol)
 		SMP (Security Manager Protocol) on LE (Low Energy) links
 	     HCI Device drivers (Interface to the hardware)
+	     SCO Module (SCO audio links)
 	     RFCOMM Module (RFCOMM Protocol)  
 	     BNEP Module (Bluetooth Network Encapsulation Protocol)
 	     CMTP Module (CAPI Message Transport Protocol)
@@ -45,6 +45,14 @@ config BT_BREDR
 	depends on BT
 	default y
 
+config BT_SCO
+	bool "Bluetooth SCO support"
+	depends on BT_BREDR
+	default y
+	help
+	  SCO link provides voice transport over Bluetooth.  SCO support is
+	  required for voice applications like Headset and Audio.
+
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 9a8ea23..21fe57a 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -12,9 +12,10 @@ obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
 bluetooth_6lowpan-y := 6lowpan.o
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
-	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
+	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
 	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
 
+bluetooth-$(CONFIG_BT_SCO) += sco.o
 bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
 bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
 
-- 
1.7.9.5

