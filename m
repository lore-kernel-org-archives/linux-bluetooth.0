Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 12/16] Bluetooth: hci_ldisc: hci_uart_tty_close() move cancel_work_sync()
Date: Tue, 28 Mar 2017 18:50:25 +0100
Message-ID: <1490723429-28870-13-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The current location of cancel_work_sync() in hci_uart_tty_close()
before the call to hci_unregister_dev(hdev) may momentarily interfere
with the execution of hci_uart_tty_close() by waiting for an active call
to hci_uart_write_work() to finish. However, its current location is
ineffective at preventing a race condition described next.

cancel_work_sync() is needed to try to prevent hci_uart_write_work() from
running whilst the Data Link protocol layer is being unbound (closed).
However, it is weak as a race condition exists between
hci_uart_write_work() being scheduled via hci_uart_tx_wakeup() and
closure of the Data Link protocol layer. In particular, the Data Link
protocol layer may have a retransmission timer which will independently
call hci_uart_tx_wakeup().

To minimise the race condition, cancel_work_sync() needs to be as close
as possible to the code that closes down the Data Link protocol layer.
Therefore, move the cancel_work_sync() statement to be just before
the code which unbinds (closes) the Data Link protocol layer.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index acb08c6..61e03dd4 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -498,8 +498,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	hdev = hu->hdev;
 
-	cancel_work_sync(&hu->write_work);
-
 	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 		/* Note hci_unregister_dev() may try to send a HCI RESET
 		 * command. If the transmission fails then hci_unregister_dev()
@@ -509,6 +507,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
+		cancel_work_sync(&hu->write_work);
 		hu->proto->close(hu);
 	}
 
-- 
2.7.4
