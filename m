Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Add internal recv_event callback for event processing
Date: Mon, 12 Jan 2015 13:51:10 -0800
Message-Id: <1421099470-21771-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some new upcoming drivers need to process HCI events or take extra
actions based on them before handing the event to the Bluetooth core
for processing. The new recv_event callback allows exactly such an
internal behavior.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1ea63518d130..4a6495ab9726 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -309,6 +309,7 @@ struct btusb_data {
 	int isoc_altsetting;
 	int suspend_count;
 
+	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 };
 
@@ -374,7 +375,7 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 		if (bt_cb(skb)->expect == 0) {
 			/* Complete frame */
-			hci_recv_frame(data->hdev, skb);
+			data->recv_event(data->hdev, skb);
 			skb = NULL;
 		}
 	}
@@ -2048,6 +2049,7 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->isoc_anchor);
 	spin_lock_init(&data->rxlock);
 
+	data->recv_event = hci_recv_frame;
 	data->recv_bulk = btusb_recv_bulk;
 
 	hdev = hci_alloc_dev();
-- 
2.1.0

