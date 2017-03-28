Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 07/16] Bluetooth: hci_ldisc: Add protocol check to hci_uart_tx_wakeup()
Date: Tue, 28 Mar 2017 18:50:20 +0100
Message-ID: <1490723429-28870-8-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Before attempting to schedule a work-item onto hu->write_work in
hci_uart_tx_wakeup(), check that the Data Link protocol layer is
still bound to the HCI UART driver.

Failure to perform this protocol check causes a race condition between
the work queue hu->write_work running hci_uart_write_work() and the
Data Link protocol layer being unbound (closed) in hci_uart_tty_close().

Note hci_uart_tty_close() does have a "cancel_work_sync(&hu->write_work)"
but it is ineffective because it cannot prevent work-items being added
to hu->write_work after cancel_work_sync() has run.

Therefore, add a check for HCI_UART_PROTO_READY into hci_uart_tx_wakeup()
which prevents scheduling of the work queue when HCI_UART_PROTO_READY
is in the clear state. However, note a small race condition remains
because the hci_uart_tx_wakeup() thread can run in parallel with the
hci_uart_tty_close() thread so it is possible that a schedule of
hu->write_work can occur when HCI_UART_PROTO_READY is cleared. A complete
solution needs locking of the threads which is implemented in a future
commit.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index c4b801b..a1bb4d64b9 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -125,15 +125,19 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 
 int hci_uart_tx_wakeup(struct hci_uart *hu)
 {
+	if (!test_bit(HCI_UART_PROTO_READY, &hu->flags))
+		goto no_schedule;
+
 	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
 		set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
-		return 0;
+		goto no_schedule;
 	}
 
 	BT_DBG("");
 
 	schedule_work(&hu->write_work);
 
+no_schedule:
 	return 0;
 }
 
-- 
2.7.4
