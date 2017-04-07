Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 15/16] Bluetooth: hci_ldisc: Simplify flushing
Date: Fri, 7 Apr 2017 18:04:37 +0100
Message-ID: <1491584678-27228-16-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The flushing due to the hci_uart_close() call probably corrupts the
data flow between the Data Link protocol layer and the UART port
(transmission direction). In any case, the flushing activity is
asynchronous to the state of the Data Link protocol layer so is
undesirable.

Modify hci_uart_close() to not perform any flushing because
hci_uart_flush() is explicitly called in hci_dev_do_close() which
is synchronous to the closure of the Data Link protocol layer so
it is OK. In other words, there is no point in flushing multiple
times with the Data Link protocol layer being in the bound state.

In hci_uart_tty_close() call hci_uart_flush() instead of
hci_uart_close() before freeing hdev. This final flush is after the
Data Link protocol layer has been unbound so ensures that the
transmission path is empty.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index fbf830a..ec9b96f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -256,8 +256,7 @@ static int hci_uart_close(struct hci_dev *hdev)
 {
 	BT_DBG("hdev %p", hdev);
 
-	hci_uart_flush(hdev);
-	hdev->flush = NULL;
+	/* Nothing to do for UART driver */
 	return 0;
 }
 
@@ -538,7 +537,7 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	if (test_and_clear_bit(HCI_UART_REGISTERED, &hu->flags)) {
-		hci_uart_close(hdev);
+		hci_uart_flush(hdev);
 		hu->hdev = NULL;
 		hci_free_dev(hdev);
 	}
-- 
2.7.4
