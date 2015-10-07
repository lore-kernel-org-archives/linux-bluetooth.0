Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Buetooth: Add support for vendor specific diagnostic channel
Date: Wed,  7 Oct 2015 16:38:35 +0200
Message-Id: <1444228715-28972-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce hci_recv_diag function for HCI drivers to allow sending vendor
specific diagnostic messages into the Bluetooth core stack. The messages
are not processed, but they are forwarded to the monitor channel and can
be retrieved by user space diagnostic tools.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/hci_mon.h  |  1 +
 net/bluetooth/hci_core.c         | 15 +++++++++++++++
 net/bluetooth/hci_sock.c         |  3 +++
 5 files changed, 21 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e7f938cac7c6..cf75c4391945 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -262,6 +262,7 @@ enum {
 #define HCI_ACLDATA_PKT		0x02
 #define HCI_SCODATA_PKT		0x03
 #define HCI_EVENT_PKT		0x04
+#define HCI_DIAG_PKT		0xf0
 #define HCI_VENDOR_PKT		0xff
 
 /* HCI packet types */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 61dc786358be..d473b67a2c65 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1066,6 +1066,7 @@ int hci_remove_adv_instance(struct hci_dev *hdev, u8 instance);
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
 int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb);
+int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 
 void hci_init_sysfs(struct hci_dev *hdev);
 void hci_conn_init_sysfs(struct hci_conn *conn);
diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 842bb754a078..2b67567cf28d 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -42,6 +42,7 @@ struct hci_mon_hdr {
 #define HCI_MON_OPEN_INDEX	8
 #define HCI_MON_CLOSE_INDEX	9
 #define HCI_MON_INDEX_INFO	10
+#define HCI_MON_VENDOR_DIAG	11
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 40a67017bd32..8193845a9b60 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3493,6 +3493,21 @@ int hci_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 }
 EXPORT_SYMBOL(hci_recv_frame);
 
+/* Receive diagnostic message from HCI drivers */
+int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Time stamp */
+	__net_timestamp(skb);
+
+	/* Mark as diagnostic packet and send to monitor */
+	bt_cb(skb)->pkt_type = HCI_DIAG_PKT;
+	hci_send_to_monitor(hdev, skb);
+
+	kfree_skb(skb);
+	return 0;
+}
+EXPORT_SYMBOL(hci_recv_diag);
+
 /* ---- Interface to upper protocols ---- */
 
 int hci_register_cb(struct hci_cb *cb)
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 9bf30db89d89..9a100c1fd7b5 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -279,6 +279,9 @@ void hci_send_to_monitor(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			opcode = cpu_to_le16(HCI_MON_SCO_TX_PKT);
 		break;
+	case HCI_DIAG_PKT:
+		opcode = cpu_to_le16(HCI_MON_VENDOR_DIAG);
+		break;
 	default:
 		return;
 	}
-- 
2.4.3

