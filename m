Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_h4: Fix zero len data packet reception issue
Date: Mon, 24 Aug 2015 18:57:57 +0200
Message-Id: <1440435477-25188-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Packets with a variable len equal to zero were not received.
Since no more data expected (and input buffer entirely consumed), we
need to complete/forward the packet immediately instead of waiting for
more data.

Fix this by completing the packet on !dlen.
happening if two cases:
    - no variable data len
    - variable data len is zero.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_h4.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 57faddc..5bd8301 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -223,8 +223,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			switch ((&pkts[i])->lsize) {
 			case 0:
 				/* No variable data length */
-				(&pkts[i])->recv(hdev, skb);
-				skb = NULL;
+				dlen = 0;
 				break;
 			case 1:
 				/* Single octet variable length */
@@ -252,6 +251,12 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 				kfree_skb(skb);
 				return ERR_PTR(-EILSEQ);
 			}
+
+			if (!dlen) {
+				/* no more data, complete frame */
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
 		} else {
 			/* Complete frame */
 			(&pkts[i])->recv(hdev, skb);
-- 
1.9.1

