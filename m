Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Allow HCI UART reset parameter via flags ioctl
Date: Fri, 24 Feb 2012 17:12:24 +0100
Message-Id: <1330099944-9371-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The flags ioctl for HCI UART drivers already allows setting of certain
Bluetooth core quirks. The reset parameter fits right in here. So allow
this as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c |   11 +++--------
 drivers/bluetooth/hci_uart.h  |    1 +
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c2d637a..cdc3594 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -48,8 +48,6 @@
 
 #define VERSION "2.2"
 
-static bool reset = 0;
-
 static struct hci_uart_proto *hup[HCI_UART_MAX_PROTO];
 
 int hci_uart_register_proto(struct hci_uart_proto *p)
@@ -392,12 +390,12 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->send  = hci_uart_send_frame;
 	hdev->parent = hu->tty->dev;
 
-	if (!reset)
-		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
-
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
+	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
+		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
@@ -584,9 +582,6 @@ static void __exit hci_uart_exit(void)
 module_init(hci_uart_init);
 module_exit(hci_uart_exit);
 
-module_param(reset, bool, 0644);
-MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
-
 MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth HCI UART driver ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 99fb352..54c8983 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -45,6 +45,7 @@
 #define HCI_UART_ATH3K	5
 
 #define HCI_UART_RAW_DEVICE	0
+#define HCI_UART_RESET_ON_INIT	1
 
 struct hci_uart;
 
-- 
1.7.7.6

