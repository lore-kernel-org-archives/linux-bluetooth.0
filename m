Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add support setup stage internal notification event
Date: Tue, 20 Oct 2015 01:36:12 +0200
Message-Id: <1445297773-44411-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before the vendor specific setup stage is triggered call back into the
core to trigger an internal notification event. That event is used to
send an index update to the monitor interface. With that specific event
it is possible to update userspace with manufacturer information before
any HCI command has been executed. This is useful for early stage
debugging of vendor specific initialization sequences.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  4 ++++
 net/bluetooth/hci_sock.c         | 33 +++++++++++++++++++++++++--------
 4 files changed, 31 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b59971c5cb71..0205b80cc90b 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -46,6 +46,7 @@
 #define HCI_DEV_RESUME			6
 #define HCI_DEV_OPEN			7
 #define HCI_DEV_CLOSE			8
+#define HCI_DEV_SETUP			9
 
 /* HCI notify events */
 #define HCI_NOTIFY_CONN_ADD		1
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 989c72aabc45..57ed9b20719c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -200,6 +200,7 @@ struct hci_dev {
 	__u16		id;
 	__u8		bus;
 	__u8		dev_type;
+	__u16		dev_manufacturer;
 	bdaddr_t	bdaddr;
 	bdaddr_t	setup_addr;
 	bdaddr_t	public_addr;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f33268004195..d31ee34f5d6a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1461,6 +1461,8 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 	set_bit(HCI_INIT, &hdev->flags);
 
 	if (hci_dev_test_flag(hdev, HCI_SETUP)) {
+		hci_sock_dev_event(hdev, HCI_DEV_SETUP);
+
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
@@ -3250,6 +3252,8 @@ struct hci_dev *hci_alloc_dev(void)
 	if (!hdev)
 		return NULL;
 
+	hdev->dev_manufacturer = 0xffff;	/* Set to internal use */
+
 	hdev->pkt_type  = (HCI_DM1 | HCI_DH1 | HCI_HV1);
 	hdev->esco_type = (ESCO_HV1);
 	hdev->link_mode = (HCI_LM_ACCEPT);
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 0172ac54671a..e93e093cd983 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -363,6 +363,21 @@ static struct sk_buff *create_monitor_event(struct hci_dev *hdev, int event)
 		opcode = cpu_to_le16(HCI_MON_CLOSE_INDEX);
 		break;
 
+	case HCI_DEV_SETUP:
+		if (hdev->dev_manufacturer == 0xffff)
+			return NULL;
+
+		skb = bt_skb_alloc(HCI_MON_INDEX_INFO_SIZE, GFP_ATOMIC);
+		if (!skb)
+			return NULL;
+
+		ii = (void *)skb_put(skb, HCI_MON_INDEX_INFO_SIZE);
+		bacpy(&ii->bdaddr, &hdev->bdaddr);
+		ii->manufacturer = cpu_to_le16(hdev->dev_manufacturer);
+
+		opcode = cpu_to_le16(HCI_MON_INDEX_INFO);
+		break;
+
 	default:
 		return NULL;
 	}
@@ -403,15 +418,17 @@ static void send_monitor_replay(struct sock *sk)
 		if (sock_queue_rcv_skb(sk, skb))
 			kfree_skb(skb);
 
-		if (!test_bit(HCI_UP, &hdev->flags))
-			continue;
-
-		skb = create_monitor_event(hdev, HCI_DEV_UP);
-		if (!skb)
-			continue;
+		if (test_bit(HCI_UP, &hdev->flags))
+			skb = create_monitor_event(hdev, HCI_DEV_UP);
+		else if (hci_dev_test_flag(hdev, HCI_SETUP))
+			skb = create_monitor_event(hdev, HCI_DEV_SETUP);
+		else
+			skb = NULL;
 
-		if (sock_queue_rcv_skb(sk, skb))
-			kfree_skb(skb);
+		if (skb) {
+			if (sock_queue_rcv_skb(sk, skb))
+				kfree_skb(skb);
+		}
 	}
 
 	read_unlock(&hci_dev_list_lock);
-- 
2.4.3

