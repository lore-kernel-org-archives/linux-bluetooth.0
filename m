Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add support for sending system notes to monitor channel
Date: Sat,  7 Nov 2015 13:56:56 +0100
Message-Id: <1446901017-114430-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The monitor channel can be used to send generic system notes as text
strings for debugging purposes. This adds the system note monitor code
and uses it for including kernel and subsystem version into traces.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  2 ++
 include/net/bluetooth/hci_mon.h   |  1 +
 net/bluetooth/af_bluetooth.c      |  8 +++-----
 net/bluetooth/hci_sock.c          | 29 +++++++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 8d38f411009c..bfd1590821d6 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -29,6 +29,8 @@
 #include <net/sock.h>
 #include <linux/seq_file.h>
 
+#define BT_SUBSYS_VERSION "2.21"
+
 #ifndef AF_BLUETOOTH
 #define AF_BLUETOOTH	31
 #define PF_BLUETOOTH	AF_BLUETOOTH
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 2b67567cf28d..c91bb23eb29e 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -43,6 +43,7 @@ struct hci_mon_hdr {
 #define HCI_MON_CLOSE_INDEX	9
 #define HCI_MON_INDEX_INFO	10
 #define HCI_MON_VENDOR_DIAG	11
+#define HCI_MON_SYSTEM_NOTE	12
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
index a3bffd1ec2b4..34c53d5862f6 100644
--- a/net/bluetooth/af_bluetooth.c
+++ b/net/bluetooth/af_bluetooth.c
@@ -33,8 +33,6 @@
 
 #include "selftest.h"
 
-#define VERSION "2.21"
-
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
 static const struct net_proto_family *bt_proto[BT_MAX_PROTO];
@@ -715,7 +713,7 @@ static int __init bt_init(void)
 
 	sock_skb_cb_check_size(sizeof(struct bt_skb_cb));
 
-	BT_INFO("Core ver %s", VERSION);
+	BT_INFO("Core ver %s", BT_SUBSYS_VERSION);
 
 	err = bt_selftest();
 	if (err < 0)
@@ -789,7 +787,7 @@ subsys_initcall(bt_init);
 module_exit(bt_exit);
 
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
-MODULE_DESCRIPTION("Bluetooth Core ver " VERSION);
-MODULE_VERSION(VERSION);
+MODULE_DESCRIPTION("Bluetooth Core ver " BT_SUBSYS_VERSION);
+MODULE_VERSION(BT_SUBSYS_VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NETPROTO(PF_BLUETOOTH);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 18a41eae295c..c976f9da96c0 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -26,6 +26,8 @@
 
 #include <linux/export.h>
 #include <asm/unaligned.h>
+#include <generated/compile.h>
+#include <generated/utsrelease.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -383,6 +385,29 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 	return skb;
 }
 
+static void send_monitor_note(struct sock *sk, const char *text)
+{
+	size_t len = strlen(text);
+	struct hci_mon_hdr *hdr;
+	struct sk_buff *skb;
+
+	skb = bt_skb_alloc(len + 1, GFP_ATOMIC);
+	if (!skb)
+		return;
+
+	strcpy(skb_put(skb, len + 1), text);
+
+	__net_timestamp(skb);
+
+	hdr = (void *)skb_push(skb, HCI_MON_HDR_SIZE);
+	hdr->opcode = HCI_MON_SYSTEM_NOTE;
+	hdr->index = cpu_to_le16(HCI_DEV_NONE);
+	hdr->len = cpu_to_le16(skb->len - HCI_MON_HDR_SIZE);
+
+	if (sock_queue_rcv_skb(sk, skb))
+		kfree_skb(skb);
+}
+
 static void send_monitor_replay(struct sock *sk)
 {
 	struct hci_dev *hdev;
@@ -872,6 +897,10 @@ static int hci_sock_bind(struct socket *sock, struct sockaddr *addr,
 		 */
 		hci_sock_set_flag(sk, HCI_SOCK_TRUSTED);
 
+		send_monitor_note(sk, "Linux version " UTS_RELEASE
+				      " (" UTS_MACHINE ")");
+		send_monitor_note(sk, "Bluetooth subsystem version "
+				      BT_SUBSYS_VERSION);
 		send_monitor_replay(sk);
 
 		atomic_inc(&monitor_promisc);
-- 
2.5.0

