Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 15/17] Bluetooth: Implement proper low-power support for Three-wire UART
Date: Wed, 27 Jun 2012 14:26:05 +0300
Message-Id: <1340796367-10321-16-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
References: <1340796367-10321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds on-demand wakeup request sending (and re-sendind) when
we are in low-power state. When the controller enters this state it will
send a sleep message after which the host is not allowed to send any
other packets until a wakeup request has been sent and the woken message
received as a response to it. The wakeup requests are re-sent
periodically until a woken message is received.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_h5.c |   37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 1e83118..630ed70 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -78,7 +78,11 @@ struct h5 {
 		H5_ACTIVE,
 	} state;
 
-	bool			sleeping;
+	enum {
+		H5_AWAKE,
+		H5_SLEEPING,
+		H5_WAKING_UP,
+	} sleep;
 };
 
 static void h5_reset_rx(struct h5 *h5);
@@ -108,6 +112,8 @@ static void h5_timed_event(unsigned long arg)
 	struct sk_buff *skb;
 	unsigned long flags;
 
+	BT_DBG("%s", hu->hdev->name);
+
 	if (h5->state == H5_UNINITIALIZED)
 		h5_link_control(hu, sync_req, sizeof(sync_req));
 
@@ -119,6 +125,11 @@ static void h5_timed_event(unsigned long arg)
 		goto wakeup;
 	}
 
+	if (h5->sleep != H5_AWAKE) {
+		h5->sleep = H5_SLEEPING;
+		goto wakeup;
+	}
+
 	BT_DBG("hu %p retransmitting %u pkts", hu, h5->unack.qlen);
 
 	spin_lock_irqsave_nested(&h5->unack.lock, flags, SINGLE_DEPTH_NESTING);
@@ -259,12 +270,15 @@ static void h5_handle_internal_rx(struct hci_uart *hu)
 		return;
 	} else if (memcmp(data, sleep_req, 2) == 0) {
 		BT_DBG("Peer went to sleep");
-		h5->sleeping = true;
-		h5_link_control(hu, wakeup_req, 2);
+		h5->sleep = H5_SLEEPING;
+		return;
 	} else if (memcmp(data, woken_req, 2) == 0) {
 		BT_DBG("Peer woke up");
-		h5->sleeping = false;
-		return;
+		h5->sleep = H5_AWAKE;
+	} else if (memcmp(data, wakeup_req, 2) == 0) {
+		BT_DBG("Peer requested wakeup");
+		h5_link_control(hu, woken_req, 2);
+		h5->sleep = H5_AWAKE;
 	} else {
 		BT_DBG("Link Control: 0x%02hhx 0x%02hhx", data[0], data[1]);
 		return;
@@ -622,6 +636,19 @@ static struct sk_buff *h5_dequeue(struct hci_uart *hu)
 	unsigned long flags;
 	struct sk_buff *skb, *nskb;
 
+	if (h5->sleep != H5_AWAKE) {
+		const unsigned char wakeup_req[] = { 0x05, 0xfa };
+
+		if (h5->sleep == H5_WAKING_UP)
+			return NULL;
+
+		h5->sleep = H5_WAKING_UP;
+		BT_DBG("Sending wakeup request");
+
+		mod_timer(&h5->timer, jiffies + HZ / 100);
+		return h5_prepare_pkt(hu, HCI_3WIRE_LINK_PKT, wakeup_req, 2);
+	}
+
 	if ((skb = skb_dequeue(&h5->unrel)) != NULL) {
 		nskb = h5_prepare_pkt(hu, bt_cb(skb)->pkt_type,
 				      skb->data, skb->len);
-- 
1.7.10.4

