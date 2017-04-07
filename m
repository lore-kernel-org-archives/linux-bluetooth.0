Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 07/16] Bluetooth: hci_ldisc: Add protocol check to hci_uart_dequeue()
Date: Fri, 7 Apr 2017 18:04:29 +0100
Message-ID: <1491584678-27228-8-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Before attempting to dequeue a Data Link protocol encapsulated message,
check that the Data Link protocol is still bound to the HCI UART driver.
This makes the code consistent with the usage of the other proto
function pointers.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_dequeue()
and return NULL if the Data Link protocol is not bound.

This is needed for robustness as there is a scheduling race condition.
hci_uart_write_work() is scheduled to run via work queue hu->write_work
from hci_uart_tx_wakeup(). Therefore, there is a delay between
scheduling hci_uart_write_work() to run and hci_uart_dequeue() running
whereby the Data Link protocol layer could become unbound during the
scheduling delay. In this case, without the check, the call to the
unbound Data Link protocol layer dequeue function can crash.

It is noted that hci_uart_tty_close() has a
"cancel_work_sync(&hu->write_work)" statement but this only reduces
the window of the race condition because it is possible for a new
work-item to be added to work queue hu->write_work after the call to
cancel_work_sync(). For example, Data Link layer retransmissions can
be added to the work queue after the cancel_work_sync() has finished.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index da9acc7..1d09964 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -113,10 +113,12 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 {
 	struct sk_buff *skb = hu->tx_skb;
 
-	if (!skb)
-		skb = hu->proto->dequeue(hu);
-	else
+	if (!skb) {
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+			skb = hu->proto->dequeue(hu);
+	} else {
 		hu->tx_skb = NULL;
+	}
 
 	return skb;
 }
-- 
2.7.4
