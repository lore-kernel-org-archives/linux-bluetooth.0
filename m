Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Send transport open and close monitor events
Date: Sun,  4 Oct 2015 23:34:03 +0200
Message-Id: <1443994443-123453-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the core starts or shuts down the actual HCI transport, send a new
monitor event that indicates that this is happening. These new events
correspond to HCI_DEV_OPEN and HCI_DEV_CLOSE events.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_mon.h |  2 ++
 net/bluetooth/hci_sock.c        | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 77d1e5764185..37e4283d1d68 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -39,6 +39,8 @@ struct hci_mon_hdr {
 #define HCI_MON_ACL_RX_PKT	5
 #define HCI_MON_SCO_TX_PKT	6
 #define HCI_MON_SCO_RX_PKT	7
+#define HCI_MON_OPEN_INDEX	8
+#define HCI_MON_CLOSE_INDEX	9
 
 struct hci_mon_new_index {
 	__u8		type;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index d9ad68448173..64ebe84989d1 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -329,6 +329,22 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		opcode = cpu_to_le16(HCI_MON_DEL_INDEX);
 		break;
 
+	case HCI_DEV_OPEN:
+		skb = bt_skb_alloc(0, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		opcode = cpu_to_le16(HCI_MON_OPEN_INDEX);
+		break;
+
+	case HCI_DEV_CLOSE:
+		skb = bt_skb_alloc(0, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		opcode = cpu_to_le16(HCI_MON_CLOSE_INDEX);
+		break;
+
 	default:
 		return NULL;
 	}
@@ -358,6 +374,16 @@ static void send_monitor_replay(struct sock *sk)
 
 		if (sock_queue_rcv_skb(sk, skb))
 			kfree_skb(skb);
+
+		if (!test_bit(HCI_RUNNING, &hdev->flags))
+			continue;
+
+		skb = create_monitor_event(hdev, HCI_DEV_OPEN);
+		if (!skb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, skb))
+			kfree_skb(skb);
 	}
 
 	read_unlock(&hci_dev_list_lock);
-- 
2.4.3

