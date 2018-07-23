Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: bpa10x: Replace GFP_ATOMIC with GFP_KERNEL in bpa10x_send_frame()
Date: Mon, 23 Jul 2018 11:24:02 +0800
Message-Id: <20180723032402.7676-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

bpa10x_send_frame() is only set to hdev->send, and hdev->send() is never 
called in atomic context.

bpa10x_send_frame() calls usb_alloc_urb(), kmalloc() and usb_submit_urb() 
with GFP_ATOMIC, which is not necessary. 
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/bpa10x.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index c6f7cc57db14..d1c2adf08576 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -289,7 +289,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb->dev = (void *) hdev;
 
-	urb = usb_alloc_urb(0, GFP_ATOMIC);
+	urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!urb)
 		return -ENOMEM;
 
@@ -298,7 +298,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (hci_skb_pkt_type(skb)) {
 	case HCI_COMMAND_PKT:
-		dr = kmalloc(sizeof(*dr), GFP_ATOMIC);
+		dr = kmalloc(sizeof(*dr), GFP_KERNEL);
 		if (!dr) {
 			usb_free_urb(urb);
 			return -ENOMEM;
@@ -343,7 +343,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	usb_anchor_urb(urb, &data->tx_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, GFP_KERNEL);
 	if (err < 0) {
 		bt_dev_err(hdev, "urb %p submission failed", urb);
 		kfree(urb->setup_packet);
-- 
2.17.0
