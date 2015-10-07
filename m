Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Send index information updates to monitor channel
Date: Wed,  7 Oct 2015 15:32:13 +0200
Message-Id: <1444224733-20368-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth public device address might change during controller setup
and it makes it a lot simpler for monitoring tools if they just get told
what the new address is. In addition include the manufacturer / company
information of the controller. That allows for easy vendor specific HCI
command and event handling.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_mon.h |  7 +++++++
 net/bluetooth/hci_sock.c        | 25 ++++++++++++++++++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_mon.h b/include/net/bluetooth/hci_mon.h
index 37e4283d1d68..842bb754a078 100644
--- a/include/net/bluetooth/hci_mon.h
+++ b/include/net/bluetooth/hci_mon.h
@@ -41,6 +41,7 @@ struct hci_mon_hdr {
 #define HCI_MON_SCO_RX_PKT	7
 #define HCI_MON_OPEN_INDEX	8
 #define HCI_MON_CLOSE_INDEX	9
+#define HCI_MON_INDEX_INFO	10
 
 struct hci_mon_new_index {
 	__u8		type;
@@ -50,4 +51,10 @@ struct hci_mon_new_index {
 } __packed;
 #define HCI_MON_NEW_INDEX_SIZE 16
 
+struct hci_mon_index_info {
+	bdaddr_t	bdaddr;
+	__le16		manufacturer;
+} __packed;
+#define HCI_MON_INDEX_INFO_SIZE 8
+
 #endif /* __HCI_MON_H */
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 64ebe84989d1..9bf30db89d89 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -303,6 +303,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 {
 	struct hci_mon_hdr *hdr;
 	struct hci_mon_new_index *ni;
+	struct hci_mon_index_info *ii;
 	struct sk_buff *skb;
 	__le16 opcode;
 
@@ -312,7 +313,7 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		if (!skb)
 			return NULL;
 
-		ni = (void *) skb_put(skb, HCI_MON_NEW_INDEX_SIZE);
+		ni = (void *)skb_put(skb, HCI_MON_NEW_INDEX_SIZE);
 		ni->type = hdev->dev_type;
 		ni->bus = hdev->bus;
 		bacpy(&ni->bdaddr, &hdev->bdaddr);
@@ -329,6 +330,18 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		opcode = cpu_to_le16(HCI_MON_DEL_INDEX);
 		break;
 
+	case HCI_DEV_UP:
+		skb = bt_skb_alloc(HCI_MON_INDEX_INFO_SIZE, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		ii = (void *)skb_put(skb, HCI_MON_INDEX_INFO_SIZE);
+		bacpy(&ii->bdaddr, &hdev->bdaddr);
+		ii->manufacturer = cpu_to_le16(hdev->manufacturer);
+
+		opcode = cpu_to_le16(HCI_MON_INDEX_INFO);
+		break;
+
 	case HCI_DEV_OPEN:
 		skb = bt_skb_alloc(0, GFP_ATOMIC);
 		if (!skb)
@@ -384,6 +397,16 @@ static void send_monitor_replay(struct sock *sk)
 
 		if (sock_queue_rcv_skb(sk, skb))
 			kfree_skb(skb);
+
+		if (!test_bit(HCI_UP, &hdev->flags))
+			continue;
+
+		skb = create_monitor_event(hdev, HCI_DEV_UP);
+		if (!skb)
+			continue;
+
+		if (sock_queue_rcv_skb(sk, skb))
+			kfree_skb(skb);
 	}
 
 	read_unlock(&hci_dev_list_lock);
-- 
2.4.3

