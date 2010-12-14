Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Introduce a new HCI_CLOSE flag for hci_dev_close()
Date: Tue, 14 Dec 2010 14:04:03 +0200
Message-Id: <1292328244-5335-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1292328244-5335-1-git-send-email-johan.hedberg@gmail.com>
References: <1292328244-5335-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

To be able to handle the intialization state differently from the
closing state (e.g. different sets of HCI commands are sent in them) a
distinct state flag should be used when closing a device.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci.h |    1 +
 net/bluetooth/hci_core.c    |   10 ++++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 29a7a8c..517a652 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -68,6 +68,7 @@ enum {
 	HCI_UP,
 	HCI_INIT,
 	HCI_RUNNING,
+	HCI_CLOSE,
 
 	HCI_PSCAN,
 	HCI_ISCAN,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1a4ec97..6374054 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -581,10 +581,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
-		set_bit(HCI_INIT, &hdev->flags);
+		set_bit(HCI_CLOSE, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
 					msecs_to_jiffies(250));
-		clear_bit(HCI_INIT, &hdev->flags);
+		clear_bit(HCI_CLOSE, &hdev->flags);
 	}
 
 	/* Kill cmd task */
@@ -1029,7 +1029,8 @@ int hci_recv_frame(struct sk_buff *skb)
 {
 	struct hci_dev *hdev = (struct hci_dev *) skb->dev;
 	if (!hdev || (!test_bit(HCI_UP, &hdev->flags)
-				&& !test_bit(HCI_INIT, &hdev->flags))) {
+				&& !test_bit(HCI_INIT, &hdev->flags)
+				&& !test_bit(HCI_CLOSE, &hdev->flags))) {
 		kfree_skb(skb);
 		return -ENXIO;
 	}
@@ -1695,7 +1696,8 @@ static void hci_rx_task(unsigned long arg)
 			continue;
 		}
 
-		if (test_bit(HCI_INIT, &hdev->flags)) {
+		if (test_bit(HCI_INIT, &hdev->flags) ||
+					test_bit(HCI_CLOSE, &hdev->flags)) {
 			/* Don't process data packets in this states. */
 			switch (bt_cb(skb)->pkt_type) {
 			case HCI_ACLDATA_PKT:
-- 
1.7.2.3

