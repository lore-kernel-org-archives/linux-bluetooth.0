Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] NetLink patches.
From: Alok <alokbarsode@gmail.com>
To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1224737318.9386.167.camel@californication>
References: <1224255091.6175.18.camel@greatbear>
	 <1224737318.9386.167.camel@californication>
Content-Type: multipart/mixed; boundary="=-a0nTVP+QqV9Grhc1bGKZ"
Date: Thu, 30 Oct 2008 18:40:13 +0530
Message-Id: <1225372213.6189.21.camel@greatbear>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-a0nTVP+QqV9Grhc1bGKZ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Marcel,

Attaching 2 patches for netlink support.

1. Adds net/bluetooth/netlink.c for netlink support with initialization
and exit functions.

2. Registers a generic netlink family "bluetooth".

Let me know if anything needs to be modified.

Thanks,
Alok.

--=-a0nTVP+QqV9Grhc1bGKZ
Content-Disposition: attachment; filename=0001-Adding-net-bluetooth-netlink.c-for-netlink-support.patch
Content-Type: application/mbox; name=0001-Adding-net-bluetooth-netlink.c-for-netlink-support.patch
Content-Transfer-Encoding: 7bit

>From c81a88be8536f0369aa4106d2722357c36734a20 Mon Sep 17 00:00:00 2001
From: Alok Barsode <alok.barsode@azingo.com>
Date: Thu, 30 Oct 2008 16:50:15 +0530
Subject: [PATCH] Adding net/bluetooth/netlink.c for netlink support.

Signed-off-by: Alok Barsode <alok.barsode@azingo.com>
---
 include/net/bluetooth/bluetooth.h |    3 +++
 net/bluetooth/Makefile            |    2 +-
 net/bluetooth/af_bluetooth.c      |    6 ++++++
 net/bluetooth/netlink.c           |   24 ++++++++++++++++++++++++
 4 files changed, 34 insertions(+), 1 deletions(-)
 create mode 100644 net/bluetooth/netlink.c

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 6f8418b..b02c7aa 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -178,4 +178,7 @@ extern void bt_sysfs_cleanup(void);
 
 extern struct class *bt_class;
 
+extern int nlbluetooth_init(void);
+extern void nlbluetooth_cleanup(void);
+
 #endif /* __BLUETOOTH_H */
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
index d1e433f..f014d48 100644
--- a/net/bluetooth/Makefile
+++ b/net/bluetooth/Makefile
@@ -10,4 +10,4 @@ obj-$(CONFIG_BT_BNEP)	+= bnep/
 obj-$(CONFIG_BT_CMTP)	+= cmtp/
 obj-$(CONFIG_BT_HIDP)	+= hidp/
 
-bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o
+bluetooth-objs := af_bluetooth.o hci_core.o hci_conn.o hci_event.o hci_sock.o hci_sysfs.o lib.o netlink.o
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 8907eff..b6487dc 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -436,6 +436,10 @@ static int __init bt_init(void)
 	if (err < 0)
 		return err;
 
+	err = nlbluetooth_init();
+	if (err < 0)
+		return err;
+
 	err = sock_register(&bt_sock_family_ops);
 	if (err < 0) {
 		bt_sysfs_cleanup();
@@ -456,6 +460,8 @@ static void __exit bt_exit(void)
 	sock_unregister(PF_BLUETOOTH);
 
 	bt_sysfs_cleanup();
+
+	nlbluetooth_cleanup();
 }
 
 subsys_initcall(bt_init);
diff --git a/net/bluetooth/netlink.c b/net/bluetooth/netlink.c
new file mode 100644
index 0000000..4606bbc
--- /dev/null
+++ b/net/bluetooth/netlink.c
@@ -0,0 +1,24 @@
+/*
+ * This is the netlink-based bluetooth interface.
+ *
+ * Copyright 2008 Alok Barsode <alok.barsode@azingo.com>
+ */
+
+#include <net/genetlink.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+/* initialisation/exit functions */
+
+int __init nlbluetooth_init(void)
+{
+	return 0;
+}
+
+void nlbluetooth_cleanup(void)
+{
+
+}
-- 
1.5.4.3


--=-a0nTVP+QqV9Grhc1bGKZ
Content-Disposition: attachment; filename=0002-Registering-general-netlink-family-bluetooth.patch
Content-Type: application/mbox; name=0002-Registering-general-netlink-family-bluetooth.patch
Content-Transfer-Encoding: 7bit

>From 7c32b72b7e3ba502069fe87754e424d4f7f297e9 Mon Sep 17 00:00:00 2001
From: Alok Barsode <alok.barsode@azingo.com>
Date: Mon, 27 Oct 2008 21:01:59 +0530
Subject: [PATCH] Registering general netlink family - bluetooth.

Signed-off-by: Alok Barsode <alok.barsode@azingo.com>
---
 net/bluetooth/netlink.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/netlink.c b/net/bluetooth/netlink.c
index 4606bbc..fafc6f2 100644
--- a/net/bluetooth/netlink.c
+++ b/net/bluetooth/netlink.c
@@ -11,14 +11,38 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 
+#define VERSION 1
+
+enum nlbluetooth_attr {
+	NLBLUETOOTH_ATTR_UNSPEC,
+	__NLBLUETOOTH_ATTR_MAX,
+};
+
+#define NLBLUETOOTH_ATTR_MAX ( __NLBLUETOOTH_ATTR_MAX - 1)
+
+/* family definition */
+static struct genl_family nlbluetooth_fam = {
+	.id = GENL_ID_GENERATE,
+	.hdrsize = 0,
+	.name = "bluetooth",
+	.version = VERSION,
+	.maxattr = NLBLUETOOTH_ATTR_MAX
+};
+
 /* initialisation/exit functions */
 
 int __init nlbluetooth_init(void)
 {
+	int err;
+
+	err = genl_register_family(&nlbluetooth_fam);
+	if (err)
+		return err;
+
 	return 0;
 }
 
 void nlbluetooth_cleanup(void)
 {
-
+	genl_unregister_family(&nlbluetooth_fam);
 }
-- 
1.5.4.3


--=-a0nTVP+QqV9Grhc1bGKZ--

