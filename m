Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH 3/3] Bluetooth: Make hci_send_to_sock usable for management control sockets
Date: Wed, 24 Nov 2010 15:39:35 +0100
Message-Id: <1290609575-28435-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
References: <1290609575-28435-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

In order to send data to management control sockets the function should:

  - skip checks intended for raw HCI data and stack internal events
  - make sure RAW HCI data or stack internal events don't go to
    management control sockets

In order to accomplish this the patch adds a new member to the bluetooth
skb private data to flag skb's that are destined for management control
sockets.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/bluetooth.h |    1 +
 net/bluetooth/hci_sock.c          |   10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index d81ea79..0c5e725 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -144,6 +144,7 @@ struct bt_skb_cb {
 	__u8 tx_seq;
 	__u8 retries;
 	__u8 sar;
+	unsigned short channel;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 730a4e8..ab449b2 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -104,6 +104,12 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 		if (skb->sk == sk)
 			continue;
 
+		if (bt_cb(skb)->channel != hci_pi(sk)->channel)
+			continue;
+
+		if (bt_cb(skb)->channel == HCI_CHANNEL_CONTROL)
+			goto clone;
+
 		/* Apply filter */
 		flt = &hci_pi(sk)->filter;
 
@@ -127,11 +133,13 @@ void hci_send_to_sock(struct hci_dev *hdev, struct sk_buff *skb)
 				continue;
 		}
 
+clone:
 		if (!(nskb = skb_clone(skb, GFP_ATOMIC)))
 			continue;
 
 		/* Put type byte before the data */
-		memcpy(skb_push(nskb, 1), &bt_cb(nskb)->pkt_type, 1);
+		if (bt_cb(skb)->channel == HCI_CHANNEL_RAW)
+			memcpy(skb_push(nskb, 1), &bt_cb(nskb)->pkt_type, 1);
 
 		if (sock_queue_rcv_skb(sk, nskb))
 			kfree_skb(nskb);
-- 
1.7.2.3

