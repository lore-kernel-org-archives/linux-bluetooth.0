Return-Path: <cyrus@holtmann.org>
Date: Thu, 2 Jul 2009 14:31:59 +0530
From: Vikram Kandukuri <vkandukuri@atheros.com>
To: <marcel@holtmann.org>
CC: <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: Improve the throughput by increasing the frame
	size
Message-ID: <20090702090147.GA9790@atheros-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

Subject: [PATCH] Bluetooth: Improve the throughput by increasing the frame size

This patch increases the receive buffer size to HCI_MAX_FRAME_SIZE
which improves the Rx throughput considerably.

Tested against BRM/Atheros/CSR USB Dongles with PAN profile using
iperf and chariot. This gave significant (around 40%) increase
in performance (increased from 0.8 to 1.5 Mb/s in Sheld room)

Signed-off-by: Vikram Kandukuri <vikram.kandukuri@atheros.com>
---
 drivers/bluetooth/btusb.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e70c57e..124db8c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -301,7 +301,7 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	struct urb *urb;
 	unsigned char *buf;
 	unsigned int pipe;
-	int err, size;
+	int err, size = HCI_MAX_FRAME_SIZE;
 
 	BT_DBG("%s", hdev->name);
 
@@ -312,8 +312,6 @@ static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
 	if (!urb)
 		return -ENOMEM;
 
-	size = le16_to_cpu(data->bulk_rx_ep->wMaxPacketSize);
-
 	buf = kmalloc(size, mem_flags);
 	if (!buf) {
 		usb_free_urb(urb);
-- 
1.6.0.4
