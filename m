Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: bfusb: Set the HCI_QUIRK_BROKEN_LOCAL_COMMANDS quirk
Date: Fri, 26 Dec 2014 04:42:32 +0100
Message-Id: <1419565354-49553-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AVM BlueFritz! 1.0 USB dongles do not support the HCI command for
reading the local supported commands. So set this quirk to let the
core know about it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index b2e7e94a6771..fcfb72e9e0ee 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -696,6 +696,8 @@ static int bfusb_probe(struct usb_interface *intf, const struct usb_device_id *i
 	hdev->flush = bfusb_flush;
 	hdev->send  = bfusb_send_frame;
 
+	set_bit(HCI_QUIRK_BROKEN_LOCAL_COMMANDS, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
-- 
2.1.0

