Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Restrict valid packet types via  HCI_CHANNEL_RAW
Date: Fri,  9 Oct 2015 14:09:22 +0200
Message-Id: <1444392563-12977-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When using the HCI_CHANNEL_RAW, restrict the packet types to valid ones
from the Bluetooth specification.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_sock.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index bad86dfe134f..1f4665a124f6 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -170,6 +170,11 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 			continue;
 
 		if (hci_pi(sk)->channel == HCI_CHANNEL_RAW) {
+			if (bt_cb(skb)->pkt_type != HCI_COMMAND_PKT &&
+			    bt_cb(skb)->pkt_type != HCI_EVENT_PKT &&
+			    bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+			    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT)
+				continue;
 			if (is_filtered_packet(sk, skb))
 				continue;
 		} else if (hci_pi(sk)->channel == HCI_CHANNEL_USER) {
@@ -1247,6 +1252,12 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 			goto drop;
 		}
 
+		if (bt_cb(skb)->pkt_type != HCI_ACLDATA_PKT &&
+		    bt_cb(skb)->pkt_type != HCI_SCODATA_PKT) {
+			err = -EINVAL;
+			goto drop;
+		}
+
 		skb_queue_tail(&hdev->raw_q, skb);
 		queue_work(hdev->workqueue, &hdev->tx_work);
 	}
-- 
2.4.3

