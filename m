Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/7] Bluetooth: Use numbers for subsystem version string
Date: Tue, 30 Aug 2016 05:00:35 +0200
Message-Id: <1472526040-21804-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of keeping a version string around, use version and revision
numbers and then stringify them for use as module parameter.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  3 ++-
 net/bluetooth/af_bluetooth.c      | 10 +++++++---
 net/bluetooth/hci_sock.c          |  4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 69b5174168b7..d705bcf40710 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -29,7 +29,8 @@
 #include <net/sock.h>
 #include <linux/seq_file.h>
 
-#define BT_SUBSYS_VERSION "2.21"
+#define BT_SUBSYS_VERSION	2
+#define BT_SUBSYS_REVISION	21
 
 #ifndef AF_BLUETOOTH
 #define AF_BLUETOOTH	31
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index b8a5caf2bf52..59a763225f1a 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -26,6 +26,7 @@
 
 #include <linux/module.h>
 #include <linux/debugfs.h>
+#include <linux/stringify.h>
 #include <asm/ioctls.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -713,13 +714,16 @@ static struct net_proto_family bt_sock_family_ops = {
 struct dentry *bt_debugfs;
 EXPORT_SYMBOL_GPL(bt_debugfs);
 
+#define VERSION __stringify(BT_SUBSYS_VERSION) "." \
+		__stringify(BT_SUBSYS_REVISION)
+
 static int __init bt_init(void)
 {
 	int err;
 
 	sock_skb_cb_check_size(sizeof(struct bt_skb_cb));
 
-	BT_INFO("Core ver %s", BT_SUBSYS_VERSION);
+	BT_INFO("Core ver %s", VERSION);
 
 	err = bt_selftest();
 	if (err < 0)
@@ -797,7 +801,7 @@ subsys_initcall(bt_init);
 module_exit(bt_exit);
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-MODULE_DESCRIPTION("Bluetooth Core ver " BT_SUBSYS_VERSION);
-MODULE_VERSION(BT_SUBSYS_VERSION);
+MODULE_DESCRIPTION("Bluetooth Core ver " VERSION);
+MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_BLUETOOTH);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 933de46886b3..fc3ccfe2a5c9 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -1117,8 +1117,8 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		send_monitor_note(sk, "Linux version %s (%s)",
 				  init_utsname()->release,
 				  init_utsname()->machine);
-		send_monitor_note(sk, "Bluetooth subsystem version %s",
-				  BT_SUBSYS_VERSION);
+		send_monitor_note(sk, "Bluetooth subsystem version %u.%u",
+				  BT_SUBSYS_VERSION, BT_SUBSYS_REVISION);
 		send_monitor_replay(sk);
 		send_monitor_control_replay(sk);
 
-- 
2.7.4

