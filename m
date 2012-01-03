Return-Path: <cyrus@holtmann.org>
From: Daniel Wagner <wagi@monom.org>
To: linux-bluetooth@vger.kernel.org
Cc: Daniel Wagner <daniel.wagner@bmw-carit.de>
Subject: [PATCH] Bluetooth: Don't mark URB_ISO_ASAP urbs for non xfer isoc endpoints
Date: Tue,  3 Jan 2012 11:47:56 +0100
Message-Id: <1325587676-4540-1-git-send-email-wagi@monom.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

[ 2096.384084] btusb_send_frame:684: hci0
[ 2096.384087] usb 3-1: BOGUS urb flags, 2 --> 0
[ 2096.384091] Bluetooth: hci0 urb ffff8801b61d3a80 submission failed (22)

According the documentation in usb_submit_urb() URB_ISO_ASAP
flag is only allowed for endpoints of type USB_ENDPOINT_XFER_ISOC.

This reverts commit b8aabfc92249b239c425da7e4ca85b7e4855e984.
---
 drivers/bluetooth/btusb.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fbfba80..77b9f7b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -726,9 +726,6 @@ static int btusb_send_frame(struct sk_buff *skb)
 		usb_fill_bulk_urb(urb, data->udev, pipe,
 				skb->data, skb->len, btusb_tx_complete, skb);
 
-		if (skb->priority >= HCI_PRIO_MAX - 1)
-			urb->transfer_flags  = URB_ISO_ASAP;
-
 		hdev->stat.acl_tx++;
 		break;
 
-- 
1.7.8.110.g4cb5d1

