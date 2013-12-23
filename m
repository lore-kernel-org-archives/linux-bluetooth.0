Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Set HCI_QUIRK_RESET_ON_CLOSE for Socket SDIO cards
Date: Mon, 23 Dec 2013 06:52:32 -0800
Message-Id: <1387810352-48383-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Socket Bluetooth SDIO cards are branded versions of Toshiba SD-BT2
and they do not support sending HCI_Reset as first command. To make
this card work the HCI_QUIRK_RESET_ON_CLOSE quirk needs to be set
before registering the controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btsdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index b61440aaee65..1f6815825e61 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -333,6 +333,9 @@ static int btsdio_probe(struct sdio_func *func,
 	hdev->flush    = btsdio_flush;
 	hdev->send     = btsdio_send_frame;
 
+	if (func->vendor == 0x0104 && func->device == 0x00c5)
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
+
 	err = hci_register_dev(hdev);
 	if (err < 0) {
 		hci_free_dev(hdev);
-- 
1.8.4.2

