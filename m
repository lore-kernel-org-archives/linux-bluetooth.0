Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add support for creating HCI UART based AMP controllers
Date: Fri, 24 Feb 2012 17:09:38 +0100
Message-Id: <1330099778-9107-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In reality this might never be used for real hardware, but it is a nice
feature for emulating AMP controllers within a virtual machine.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c |    5 +++++
 drivers/bluetooth/hci_uart.h  |    1 +
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index cdc3594..fd5adb4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -396,6 +396,11 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
 
+	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
+		hdev->dev_type = HCI_AMP;
+	else
+		hdev->dev_type = HCI_BREDR;
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 54c8983..6cf6ab22 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -46,6 +46,7 @@
 
 #define HCI_UART_RAW_DEVICE	0
 #define HCI_UART_RESET_ON_INIT	1
+#define HCI_UART_CREATE_AMP	2
 
 struct hci_uart;
 
-- 
1.7.7.6

