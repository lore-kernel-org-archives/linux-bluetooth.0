Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: add support for Integrated System Solution devices
Date: Sun, 19 Apr 2009 16:35:47 -0300
Message-Id: <1240169747-15998-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Just add the device id to btusb. I tested with obexd and hcitool info
<baddr> and it works. But there is an issue yet, l2ping disconnects after
10 seconds.

Signed-off-by: Gustavo F. Padovan <gustavo@las.ic.unicamp.br>
---
 drivers/bluetooth/btusb.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index e70c57e..9df83a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -131,6 +131,9 @@ static struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x08fd, 0x0001), .driver_info = BTUSB_DIGIANSWER },
 	{ USB_DEVICE(0x08fd, 0x0002), .driver_info = BTUSB_IGNORE },
 
+	/* Integrated System Solution devices */
+	{ USB_DEVICE(0x1131, 0x1004), .driver_info = BTUSB_WRONG_SCO_MTU },
+
 	/* CSR BlueCore Bluetooth Sniffer */
 	{ USB_DEVICE(0x0a12, 0x0002), .driver_info = BTUSB_SNIFFER },
 
-- 
1.6.0.6

