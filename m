Return-Path: <cyrus@holtmann.org>
From: "balaji" <balaji@balaji-laptop>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, Vikram Kandukuri <vkandukuri@atheros.com>
Subject: [PATCH] Increased frame size to maximize throughput
Date: Fri, 15 May 2009 23:35:13 +0530
Message-Id: <1242410713-7144-1-git-send-email-vkandukuri@atheros.com>
In-Reply-To: <>
References: <>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch increases the receive buf size to
HCI_MAX_FRAME_SIZE which improves the rx
throughput considerably.

Signed-off-by: Vikram Kandukuri <vkandukuri@atheros.com>
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
1.5.4.3
