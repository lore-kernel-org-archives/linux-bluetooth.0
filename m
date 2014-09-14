Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Use GFP_KERNEL in btusb_send_frame()
Date: Sun, 14 Sep 2014 08:49:34 +0300
Message-Id: <1410673774-10957-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All hdev->send() calls are these days done through a work queue. For the
btusb driver this means the btusb_send_frame() function. Because of this
we can safely use GFP_KERNEL for all memory allocations in this code
path.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/btusb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index a79d657c0845..d696e68f326a 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -769,11 +769,11 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
-		urb = usb_alloc_urb(0, GFP_ATOMIC);
+		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb)
 			return -ENOMEM;
 
-		dr = kmalloc(sizeof(*dr), GFP_ATOMIC);
+		dr = kmalloc(sizeof(*dr), GFP_KERNEL);
 		if (!dr) {
 			usb_free_urb(urb);
 			return -ENOMEM;
@@ -797,7 +797,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		if (!data->bulk_tx_ep)
 			return -ENODEV;
 
-		urb = usb_alloc_urb(0, GFP_ATOMIC);
+		urb = usb_alloc_urb(0, GFP_KERNEL);
 		if (!urb)
 			return -ENOMEM;
 
@@ -814,7 +814,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 		if (!data->isoc_tx_ep || hci_conn_num(hdev, SCO_LINK) < 1)
 			return -ENODEV;
 
-		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_ATOMIC);
+		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
 		if (!urb)
 			return -ENOMEM;
 
@@ -848,7 +848,7 @@ static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 skip_waking:
 	usb_anchor_urb(urb, &data->tx_anchor);
 
-	err = usb_submit_urb(urb, GFP_ATOMIC);
+	err = usb_submit_urb(urb, GFP_KERNEL);
 	if (err < 0) {
 		if (err != -EPERM && err != -ENODEV)
 			BT_ERR("%s urb %p submission failed (%d)",
-- 
1.9.3

