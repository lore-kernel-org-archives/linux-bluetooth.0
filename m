Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 13/16] Bluetooth: hci_ldisc: hci_uart_tty_close() free hu->tx_skb
Date: Tue, 28 Mar 2017 18:50:26 +0100
Message-ID: <1490723429-28870-14-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

There is a race condition for accessing hu->tx_skb between
hci_uart_flush() and hci_uart_dequeue() which runs in
hci_uart_write_work() from the work queue hu->write_work. This race
condition exists because there is no locking between these 2 threads
to protect hu->tx_skb. Consequently a call to hci_uart_flush() might
be able to free hu->tx_skb whilst hci_uart_write_work() is using
hu->tx_skb which is undesirable as a crash could occur.

Performing any flushing in the transmission path between the Data Link
protocol layer and the UART port may corrupt the data. So freeing
hu->tx_skb or not freeing hu->tx_skb makes little difference to having
intact data or corrupted data. So it is OK not to free hu->tx_skb.

Instead, move the freeing of hu->tx_skb to the end of
hci_uart_tty_close() from hci_uart_flush(). This eliminates the race
condition because the Data Link protocol layer is in the unbound state
and ensures hu->tx_skb is freed before hu is freed. Also use a temporary
pointer to allow hu->tx_skb to be set to NULL before freeing hu->tx_skb.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 61e03dd4..ad2dec5 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -229,10 +229,6 @@ static int hci_uart_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %p tty %p", hdev, tty);
 
-	if (hu->tx_skb) {
-		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
-	}
-
 	/* Flush any pending characters in the driver and discipline. */
 	tty_ldisc_flush(tty);
 	tty_driver_flush_buffer(tty);
@@ -490,6 +486,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = tty->disc_data;
 	struct hci_dev *hdev;
+	struct sk_buff *temp_skb;
 
 	BT_DBG("tty %p", tty);
 
@@ -522,6 +519,12 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		hci_free_dev(hdev);
 	}
 
+	if (hu->tx_skb) {
+		temp_skb = hu->tx_skb;
+		hu->tx_skb = NULL;
+		kfree_skb(temp_skb);
+	}
+
 	kfree(hu);
 }
 
-- 
2.7.4
