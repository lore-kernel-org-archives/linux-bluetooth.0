Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bfusb: Replace GFP_ATOMIC with GFP_KERNEL in bfusb_send_frame()
Date: Mon, 23 Jul 2018 11:09:00 +0800
Message-Id: <20180723030900.7305-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

bfusb_send_frame() is only set to hdev->send, and hdev->send() is never
called in atomic context.

bfusb_send_frame() calls bt_skb_alloc() with GFP_ATOMIC, which is not
necessary. GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bfusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index ab090a313a5f..0588639b899a 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -490,7 +490,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	count = skb->len;
 
 	/* Max HCI frame size seems to be 1511 + 1 */
-	nskb = bt_skb_alloc(count + 32, GFP_ATOMIC);
+	nskb = bt_skb_alloc(count + 32, GFP_KERNEL);
 	if (!nskb) {
 		BT_ERR("Can't allocate memory for new packet");
 		return -ENOMEM;
-- 
2.17.0
