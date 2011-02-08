Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Merge L2CAP and SCO modules into bluetooth.ko
Date: Tue,  8 Feb 2011 16:50:59 -0200
Message-Id: <1297191061-8246-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Actually doesn't make sense have these modules built separately.
The L2CAP layer is needed by almost all Bluetooth protocols and profiles.
There isn't any real use case without having L2CAP loaded.
SCO is only essential for Audio transfers, but it is so small that we can
have it loaded always in bluetooth.ko without problems.
If you really doesn't want it you can disable SCO in the kernel config.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/bluetooth.h |   28 ++++++++++++++++++++++++++++
 net/bluetooth/Kconfig             |   10 ++--------
 net/bluetooth/Makefile            |    5 ++---
 net/bluetooth/af_bluetooth.c      |   30 +++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_core.c        |   13 ++-----------
 net/bluetooth/sco.c               |   13 ++-----------
 6 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ed7d775..4375043 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -205,4 +205,32 @@ extern void bt_sysfs_cleanup(void);
 
 extern struct dentry *bt_debugfs;
 
+#ifdef CONFIG_BT_L2CAP
+int l2cap_init(void);
+void l2cap_exit(void);
+#else
+static inline int l2cap_init(void)
+{
+	return 0;
+}
+
+static inline void l2cap_exit(void)
+{
+}
+#endif
+
+#ifdef CONFIG_BT_SCO
+int sco_init(void);
+void sco_exit(void);
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
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
index e45eae6..c6f9c2f 100644
--- a/net/bluetooth/Kconfig
+++ b/net/bluetooth/Kconfig
@@ -32,7 +32,7 @@ menuconfig BT
 	  more information, see <http://www.bluez.org/>.
 
 config BT_L2CAP
-	tristate "L2CAP protocol support"
+	bool "L2CAP protocol support"
 	depends on BT
 	select CRC16
 	help
@@ -40,19 +40,13 @@ config BT_L2CAP
 	  connection oriented and connection-less data transport.  L2CAP
 	  support is required for most Bluetooth applications.
 
-	  Say Y here to compile L2CAP support into the kernel or say M to
-	  compile it as module (l2cap).
-
 config BT_SCO
-	tristate "SCO links support"
+	bool "SCO links support"
 	depends on BT
 	help
 	  SCO link provides voice transport over Bluetooth.  SCO support is
 	  required for voice applications like Headset and Audio.
 
-	  Say Y here to compile SCO support into the kernel or say M to
-	  compile it as module (sco).
-
 source "net/bluetooth/rfcomm/Kconfig"
 
 source "net/bluetooth/bnep/Kconfig"
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index 339b429..f04fe9a 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -3,12 +3,11 @@
 #
 
 obj-$(CONFIG_BT)	+= bluetooth.o
-obj-$(CONFIG_BT_L2CAP)	+= l2cap.o
-obj-$(CONFIG_BT_SCO)	+= sco.o
 obj-$(CONFIG_BT_RFCOMM)	+= rfcomm/
 obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
 bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o hci_sock.o hci_sysfs.o lib.o
-l2cap-y := l2cap_core.o l2cap_sock.o
+bluetooth-$(CONFIG_BT_L2CAP)	+= l2cap_core.o l2cap_sock.o
+bluetooth-$(CONFIG_BT_SCO)	+= sco.o
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 2abfe2f..d1413d4 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -545,13 +545,41 @@ static int __init bt_init(void)
 
 	BT_INFO("HCI device and connection manager initialized");
 
-	hci_sock_init();
+	err = hci_sock_init();
+	if (err < 0)
+		goto error;
+
+	err = l2cap_init();
+	if (err < 0) {
+		hci_sock_cleanup();
+		goto sock_err;
+	}
+
+	err = sco_init();
+	if (err < 0) {
+		l2cap_exit();
+		goto sock_err;
+	}
 
 	return 0;
+
+sock_err:
+	hci_sock_cleanup();
+
+error:
+	sock_unregister(PF_BLUETOOTH);
+	bt_sysfs_cleanup();
+
+	return err;
 }
 
 static void __exit bt_exit(void)
 {
+
+	sco_exit();
+
+	l2cap_exit();
+
 	hci_sock_cleanup();
 
 	sock_unregister(PF_BLUETOOTH);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ba7f9da..518d940 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3806,7 +3806,7 @@ static struct hci_proto l2cap_hci_proto = {
 	.recv_acldata	= l2cap_recv_acldata
 };
 
-static int __init l2cap_init(void)
+int __init l2cap_init(void)
 {
 	int err;
 
@@ -3845,7 +3845,7 @@ error:
 	return err;
 }
 
-static void __exit l2cap_exit(void)
+void l2cap_exit(void)
 {
 	debugfs_remove(l2cap_debugfs);
 
@@ -3866,14 +3866,5 @@ void l2cap_load(void)
 }
 EXPORT_SYMBOL(l2cap_load);
 
-module_init(l2cap_init);
-module_exit(l2cap_exit);
-
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
-
-MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-MODULE_DESCRIPTION("Bluetooth L2CAP ver " VERSION);
-MODULE_VERSION(VERSION);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("bt-proto-0");
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 960c6d1..db40a35 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1023,7 +1023,7 @@ static struct hci_proto sco_hci_proto = {
 	.recv_scodata	= sco_recv_scodata
 };
 
-static int __init sco_init(void)
+int __init sco_init(void)
 {
 	int err;
 
@@ -1061,7 +1061,7 @@ error:
 	return err;
 }
 
-static void __exit sco_exit(void)
+void __exit sco_exit(void)
 {
 	debugfs_remove(sco_debugfs);
 
@@ -1074,14 +1074,5 @@ static void __exit sco_exit(void)
 	proto_unregister(&sco_proto);
 }
 
-module_init(sco_init);
-module_exit(sco_exit);
-
 module_param(disable_esco, bool, 0644);
 MODULE_PARM_DESC(disable_esco, "Disable eSCO connection creation");
-
-MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-MODULE_DESCRIPTION("Bluetooth SCO ver " VERSION);
-MODULE_VERSION(VERSION);
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("bt-proto-2");
-- 
1.7.4

