Return-Path: <robherring2@gmail.com>
From: Rob Herring <robh@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: hci_uart: remove unused hci_uart_init_tty
Date: Wed, 18 Jan 2017 11:29:01 -0600
Message-Id: <20170118172901.20546-1-robh@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

There are no users of hci_uart_init_tty, so remove it.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
---
 drivers/bluetooth/hci_ldisc.c | 19 -------------------
 drivers/bluetooth/hci_uart.h  |  1 -
 2 files changed, 20 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9497c469efd2..de20a438a78a 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -318,25 +318,6 @@ void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 	hu->oper_speed = oper_speed;
 }
 
-void hci_uart_init_tty(struct hci_uart *hu)
-{
-	struct tty_struct *tty = hu->tty;
-	struct ktermios ktermios;
-
-	/* Bring the UART into a known 8 bits no parity hw fc state */
-	ktermios = tty->termios;
-	ktermios.c_iflag &= ~(IGNBRK | BRKINT | PARMRK | ISTRIP |
-			      INLCR | IGNCR | ICRNL | IXON);
-	ktermios.c_oflag &= ~OPOST;
-	ktermios.c_lflag &= ~(ECHO | ECHONL | ICANON | ISIG | IEXTEN);
-	ktermios.c_cflag &= ~(CSIZE | PARENB);
-	ktermios.c_cflag |= CS8;
-	ktermios.c_cflag |= CRTSCTS;
-
-	/* tty_set_termios() return not checked as it is always 0 */
-	tty_set_termios(tty, &ktermios);
-}
-
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed)
 {
 	struct tty_struct *tty = hu->tty;
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 070139513e65..cb7f4b4aeca0 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -107,7 +107,6 @@ int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
-void hci_uart_init_tty(struct hci_uart *hu);
 void hci_uart_set_baudrate(struct hci_uart *hu, unsigned int speed);
 void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
-- 
2.10.1
