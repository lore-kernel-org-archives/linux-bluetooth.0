Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add support for external configuration with UART driver
Date: Fri, 11 Jul 2014 07:12:58 +0200
Message-Id: <1405055578-30621-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The quirk for enabling external configuration with UART needs to be
provided via the HCI UART flags. Add a new flag for it and declare
it as valid.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 6 +++++-
 drivers/bluetooth/hci_uart.h  | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index a49ee1b42439..401a3be57cda 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -431,6 +431,9 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
+	if (test_bit(HCI_UART_EXT_CONFIG, &hu->hdev_flags))
+		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
+
 	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
@@ -482,7 +485,8 @@ static int hci_uart_set_flags(struct hci_uart *hu, unsigned long flags)
 	unsigned long valid_flags = BIT(HCI_UART_RAW_DEVICE) |
 				    BIT(HCI_UART_RESET_ON_INIT) |
 				    BIT(HCI_UART_CREATE_AMP) |
-				    BIT(HCI_UART_INIT_PENDING);
+				    BIT(HCI_UART_INIT_PENDING) |
+				    BIT(HCI_UART_EXT_CONFIG);
 
 	if ((flags & ~valid_flags))
 		return -EINVAL;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 12df101ca942..247488edcbf9 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -48,6 +48,7 @@
 #define HCI_UART_RESET_ON_INIT	1
 #define HCI_UART_CREATE_AMP	2
 #define HCI_UART_INIT_PENDING	3
+#define HCI_UART_EXT_CONFIG	4
 
 struct hci_uart;
 
-- 
1.9.3

