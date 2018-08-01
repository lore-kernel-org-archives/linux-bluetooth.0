Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Amit K Bag <amit.k.bag@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: ravishankar.srivatsa@intel.com, Amit K Bag <amit.k.bag@intel.com>
Subject: [PATCH] Bluetooth: btusb: Add HCI reset command on BT shutdown
Date: Wed,  1 Aug 2018 11:53:42 +0530
Message-Id: <1533104622-835-1-git-send-email-amit.k.bag@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of BT turn off from UI it is safe to add HCI reset command
which will maintain the controller state.

Signed-off-by: Amit K Bag <amit.k.bag@intel.com>
---
 drivers/bluetooth/btusb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 572fd75fbcf6..599ec9b12d3f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2369,6 +2369,18 @@ static int btusb_shutdown_intel(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	long ret;
 
+	/* In case of BT off from UI it is safe to do HCI reset.
+	 * This will maintain the controller state.
+	 */
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+        if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		BT_ERR("%s: BT controller  HCI reset failed (%ld)",
+		       hdev->name, ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
 	/* Some platforms have an issue with BT LED when the interface is
 	 * down or BT radio is turned off, which takes 5 seconds to BT LED
 	 * goes off. This command turns off the BT LED immediately.
-- 
2.7.4

