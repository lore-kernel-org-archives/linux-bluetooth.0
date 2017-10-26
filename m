Return-Path: <ronald@innovation.ch>
Date: Wed, 25 Oct 2017 22:15:19 -0700
From: =?iso-8859-1?B?PT9VVEYtOD9xP1JvbmFsZD0yMFRzY2hhbD1DMz1BNHI/PQ==?= <ronald@innovation.ch>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>, Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_ldisc: Fix another race when closing the tty.
Message-ID: <20171026051519.GA15958@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

The following race condition still existed:

         P1                                P2
  cancel_work_sync()
                                     hci_uart_tx_wakeup()
                                     hci_uart_write_work()
                                     hci_uart_dequeue()
  clear_bit(HCI_UART_PROTO_READY)
  hci_unregister_dev(hdev)
  hci_free_dev(hdev)
  hu->proto->close(hu)
  kfree(hu)
                                     access to hdev and hu

Cancelling the work after clearing the HCI_UART_PROTO_READY bit avoids
this as any hci_uart_tx_wakeup() issued after the flag is cleared will
detect that and not schedule further work.

Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Cc: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: Lukas Wunner <lukas@wunner.de>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Gustavo Padovan <gustavo@padovan.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
---
 drivers/bluetooth/hci_ldisc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 31def781a562..c823914b3a80 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -523,13 +523,13 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (hdev)
 		hci_uart_close(hdev);
 
-	cancel_work_sync(&hu->write_work);
-
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		percpu_down_write(&hu->proto_lock);
 		clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 		percpu_up_write(&hu->proto_lock);
 
+		cancel_work_sync(&hu->write_work);
+
 		if (hdev) {
 			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 				hci_unregister_dev(hdev);
-- 
2.13.6
