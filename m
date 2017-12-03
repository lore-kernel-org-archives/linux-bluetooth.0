Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bluetooth: serdev: hci_ll: Wait for CTS instead of using msleep
Date: Sat,  2 Dec 2017 20:43:55 -0600
Message-Id: <1512269035-21710-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

When a TI Bluetooth chip is reset, it takes about 100ms for the RTS line of
the chip to deassert. For my use case with a TI CC2560A chip, this delay
was not long enough and caused the local UART to never transmit at all (TI
AM1808 SoC UART2).

We can wait for the CTS signal using serdev_device_wait_for_cts() instead
of trying to guess using msleep().

Also changed the comment to be more informative while we are touching this
code.

Signed-off-by: David Lechner <david@lechnology.com>
---
 drivers/bluetooth/hci_ll.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 1f6b933..b295cf8 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -674,11 +674,15 @@ static int ll_setup(struct hci_uart *hu)
 	serdev_device_set_flow_control(serdev, true);
 
 	do {
-		/* Configure BT_EN to HIGH state */
+		/* Reset the Bluetooth device */
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 		msleep(5);
 		gpiod_set_value_cansleep(lldev->enable_gpio, 1);
-		msleep(100);
+		err = serdev_device_wait_for_cts(serdev, true, 200);
+		if (err) {
+			bt_dev_err(hu->hdev, "Failed to get CTS");
+			return err;
+		}
 
 		err = download_firmware(lldev);
 		if (!err)
-- 
2.7.4
