Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ll: Use skb_put_u8 instead of struct hcill_cmd
Date: Tue, 20 Mar 2018 09:31:04 +0100
Message-Id: <20180320083104.9243-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct hcill_cmd to create an skb with a single u8 is pointless. So
just use skb_put_u8 instead.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ll.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 2f30dcad96bd..7c55a9f77808 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -82,10 +82,6 @@ enum hcill_states_e {
 	HCILL_AWAKE_TO_ASLEEP
 };
 
-struct hcill_cmd {
-	u8 cmd;
-} __packed;
-
 struct ll_device {
 	struct hci_uart hu;
 	struct serdev_device *serdev;
@@ -113,7 +109,6 @@ static int send_hcill_cmd(u8 cmd, struct hci_uart *hu)
 	int err = 0;
 	struct sk_buff *skb = NULL;
 	struct ll_struct *ll = hu->priv;
-	struct hcill_cmd *hcill_packet;
 
 	BT_DBG("hu %p cmd 0x%x", hu, cmd);
 
@@ -126,8 +121,7 @@ static int send_hcill_cmd(u8 cmd, struct hci_uart *hu)
 	}
 
 	/* prepare packet */
-	hcill_packet = skb_put(skb, 1);
-	hcill_packet->cmd = cmd;
+	skb_put_u8(skb, cmd);
 
 	/* send packet */
 	skb_queue_tail(&ll->txq, skb);
-- 
2.14.3

