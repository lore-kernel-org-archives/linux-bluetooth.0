Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btusb: Add internal callback for USB bulk rx data
Date: Mon,  3 Nov 2014 05:16:07 +0100
Message-Id: <1414988168-51327-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some vendors require special handling of the rx data from the USB
bulk endpoints. For that case provide an internal callback that
can overwrite it with a custom receive function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c85426d6e33d..cd634f3b76d3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -299,6 +299,8 @@ struct btusb_data {
 	unsigned int sco_num;
 	int isoc_altsetting;
 	int suspend_count;
+
+	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
 };
 
 static inline void btusb_free_frags(struct btusb_data *data)
@@ -590,7 +592,7 @@ static void btusb_bulk_complete(struct urb *urb)
 	if (urb->status == 0) {
 		hdev->stat.byte_rx += urb->actual_length;
 
-		if (btusb_recv_bulk(data, urb->transfer_buffer,
+		if (data->recv_bulk(data, urb->transfer_buffer,
 				    urb->actual_length) < 0) {
 			BT_ERR("%s corrupted ACL packet", hdev->name);
 			hdev->stat.err_rx++;
@@ -2012,6 +2014,8 @@ static int btusb_probe(struct usb_interface *intf,
 	init_usb_anchor(&data->isoc_anchor);
 	spin_lock_init(&data->rxlock);
 
+	data->recv_bulk = btusb_recv_bulk;
+
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
1.9.3

