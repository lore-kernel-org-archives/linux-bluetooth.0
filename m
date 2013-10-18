Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Create root debugfs directory during module init
Date: Thu, 17 Oct 2013 17:24:18 -0700
Message-Id: <1382055860-12572-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Create the root Bluetooth debugfs directory during module init
and remove it on module exit.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/af_bluetooth.c | 9 ++++++++-
 net/bluetooth/hci_sysfs.c    | 8 --------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index 1f1a111..f6a1671 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -25,6 +25,7 @@
 /* Bluetooth address family and sockets. */
 
 #include <linux/module.h>
+#include <linux/debugfs.h>
 #include <asm/ioctls.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -708,12 +709,17 @@ static struct net_proto_family bt_sock_family_ops = {
 	.create	= bt_sock_create,
 };
 
+struct dentry *bt_debugfs;
+EXPORT_SYMBOL_GPL(bt_debugfs);
+
 static int __init bt_init(void)
 {
 	int err;
 
 	BT_INFO("Core ver %s", VERSION);
 
+	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
+
 	err = bt_sysfs_init();
 	if (err < 0)
 		return err;
@@ -754,7 +760,6 @@ error:
 
 static void __exit bt_exit(void)
 {
-
 	sco_exit();
 
 	l2cap_exit();
@@ -764,6 +769,8 @@ static void __exit bt_exit(void)
 	sock_unregister(PF_BLUETOOTH);
 
 	bt_sysfs_cleanup();
+
+	debugfs_remove_recursive(bt_debugfs);
 }
 
 subsys_initcall(bt_init);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 0e71318..320a761 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -1,6 +1,5 @@
 /* Bluetooth HCI driver model support. */
 
-#include <linux/debugfs.h>
 #include <linux/module.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -8,9 +7,6 @@
 
 static struct class *bt_class;
 
-struct dentry *bt_debugfs;
-EXPORT_SYMBOL_GPL(bt_debugfs);
-
 static inline char *link_typetostr(int type)
 {
 	switch (type) {
@@ -426,8 +422,6 @@ void hci_del_sysfs(struct hci_dev *hdev)
 
 int __init bt_sysfs_init(void)
 {
-	bt_debugfs = debugfs_create_dir("bluetooth", NULL);
-
 	bt_class = class_create(THIS_MODULE, "bluetooth");
 
 	return PTR_ERR_OR_ZERO(bt_class);
@@ -436,6 +430,4 @@ int __init bt_sysfs_init(void)
 void bt_sysfs_cleanup(void)
 {
 	class_destroy(bt_class);
-
-	debugfs_remove_recursive(bt_debugfs);
 }
-- 
1.8.3.1

