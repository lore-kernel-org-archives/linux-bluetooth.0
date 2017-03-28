Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 11/16] Bluetooth: hci_ldisc: hci_uart_tty_close() move hci_uart_close()
Date: Tue, 28 Mar 2017 18:50:24 +0100
Message-ID: <1490723429-28870-12-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

In hci_uart_tty_close() move hci_uart_close() to after the call to
hci_unregister_dev() to avoid the tty flush in hci_uart_close()
and clearance of HCI_RUNNING from corrupting the Data Link protocol
layer's communication stream.

In fact, perform hci_uart_close() at the of hci_uart_tty_close()
where the Data Link protocol layer has been closed so that no
more data can be written in the tty layer. This makes the flush
clear out any non-sent data from the tty layer although this
is probably unnecessary.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e7d1b8b..acb08c6 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -497,8 +497,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		return;
 
 	hdev = hu->hdev;
-	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
-		hci_uart_close(hdev);
 
 	cancel_work_sync(&hu->write_work);
 
@@ -520,6 +518,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	if (test_and_clear_bit(HCI_UART_REGISTERED, &hu->flags)) {
+		hci_uart_close(hdev);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
 	}
-- 
2.7.4
