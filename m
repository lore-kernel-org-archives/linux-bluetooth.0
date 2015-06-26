Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ldisc: backport changes
Date: Fri, 26 Jun 2015 20:13:34 +0200
Message-Id: <1435342414-21061-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The references to tty->termios in hci_ldisc were not backports
compatible. Introducing #define statements to make this file compile
against earlier kernel versions.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 177dd69..14d08b1 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -24,6 +24,7 @@
  */
 
 #include <linux/module.h>
+#include <linux/version.h>
 
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -277,7 +278,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 
 	if (enable) {
 		/* Disable hardware flow control */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
 		ktermios = tty->termios;
+#else
+		ktermios = *tty->termios;
+#endif
 		ktermios.c_cflag &= ~CRTSCTS;
 		status = tty_set_termios(tty, &ktermios);
 		BT_DBG("Disabling hardware flow control: %s",
@@ -311,7 +316,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
 		BT_DBG("Setting RTS: %s", status ? "failed" : "success");
 
 		/* Re-enable hardware flow control */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
 		ktermios = tty->termios;
+#else
+		ktermios = *tty->termios;
+#endif
 		ktermios.c_cflag |= CRTSCTS;
 		status = tty_set_termios(tty, &ktermios);
 		BT_DBG("Enabling hardware flow control: %s",
@@ -332,7 +341,11 @@ void hci_uart_init_tty(struct hci_uart *hu)
 	struct ktermios ktermios;
 
 	/* Bring the UART into a known 8 bits no parity hw fc state */
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
 	ktermios = tty->termios;
+#else
+	ktermios = *tty->termios;
+#endif
 	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
 			      INLCR | IGNCR | ICRNL | IXON);
 	ktermios.c_oflag &= ~OPOST;
@@ -350,7 +363,11 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	struct tty_struct *tty = hu->tty;
 	struct ktermios ktermios;
 
+#if (LINUX_VERSION_CODE >= KERNEL_VERSION(3,7,0))
 	ktermios = tty->termios;
+#else
+	ktermios = *tty->termios;
+#endif
 	ktermios.c_cflag &= ~CBAUD;
 	tty_termios_encode_baud_rate(&ktermios, speed, speed);
 
@@ -358,7 +375,7 @@ void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 	tty_set_termios(tty, &ktermios);
 
 	BT_DBG("%s: New tty speeds: %d/%d", hu->hdev->name,
-	       tty->termios.c_ispeed, tty->termios.c_ospeed);
+	       ktermios.c_ispeed, ktermios.c_ospeed);
 }
 
 static int hci_uart_setup(struct hci_dev *hdev)
-- 
1.9.1

