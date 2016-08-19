Return-Path: <boris.brezillon@free-electrons.com>
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jason.abele@gmail.com,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 1/4] Bluetooth: hci_ldisc: fix a race in the hdev closing path
Date: Fri, 19 Aug 2016 09:38:44 +0200
Message-Id: <1471592327-14133-2-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

hci_uart_tty_close() is cancelling any pending write work, but some
hci_uart_proto implementations might re-schedule this work after its
cancellation (by calling hci_uart_tx_wakeup()).

Make sure the write work is not re-scheduled in our back while we're
closing the device.

We also cancel any pending init work and prevent the active one (if
any) from registering the hdev if the line discipline is being closed.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/bluetooth/hci_ldisc.c | 15 ++++++++++++++-
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dda97398c59a..de7f7f1f995c 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -130,7 +130,9 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
 
 	BT_DBG("");
 
-	schedule_work(&hu->write_work);
+	/* Don't schedule the work if the device is being closed. */
+	if (!test_bit(HCI_UART_CLOSING, &hu->flags))
+		schedule_work(&hu->write_work);
 
 	return 0;
 }
@@ -180,6 +182,11 @@ static void hci_uart_init_work(struct work_struct *work)
 	if (!test_and_clear_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags))
 		return;
 
+	if (test_bit(HCI_UART_CLOSING, &hu->flags)) {
+		BT_DBG("HCI device is being closed, don't register it.");
+		return;
+	}
+
 	err = hci_register_dev(hu->hdev);
 	if (err < 0) {
 		BT_ERR("Can't register HCI device");
@@ -490,7 +497,13 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 	if (hdev)
 		hci_uart_close(hdev);
 
+	/*
+	 * Set the closing bit to make sure nobody re-schedules the write work
+	 * in our back.
+	 */
+	set_bit(HCI_UART_CLOSING, &hu->flags);
 	cancel_work_sync(&hu->write_work);
+	cancel_work_sync(&hu->init_ready);
 
 	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		if (hdev) {
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 839bad1d8152..c092ad6607e1 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -96,6 +96,7 @@ struct hci_uart {
 #define HCI_UART_PROTO_SET	0
 #define HCI_UART_REGISTERED	1
 #define HCI_UART_PROTO_READY	2
+#define HCI_UART_CLOSING	3
 
 /* TX states  */
 #define HCI_UART_SENDING	1
-- 
2.7.4
