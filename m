Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org,
	gustavo@padovan.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_ldisc: Add setup callback
Date: Wed, 25 Mar 2015 15:19:30 +0100
Message-Id: <1427293170-3658-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Some Bluetooth controllers require initialization before
being used (vendor config, firmware download).
Add possibility for a HCI UART proto to implement this
early init via the setup callback.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
 drivers/bluetooth/hci_uart.h  |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index dc487b5..48a0c25 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -261,6 +261,16 @@ static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	return 0;
 }
 
+static int hci_uart_setup(struct hci_dev *hdev)
+{
+	struct hci_uart *hu = hci_get_drvdata(hdev);
+
+	if (hu->proto->setup)
+		return hu->proto->setup(hu);
+
+	return 0;
+}
+
 /* ------ LDISC part ------ */
 /* hci_uart_tty_open
  *
@@ -426,6 +436,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 	hdev->close = hci_uart_close;
 	hdev->flush = hci_uart_flush;
 	hdev->send  = hci_uart_send_frame;
+	hdev->setup = hci_uart_setup;
 	SET_HCIDEV_DEV(hdev, hu->tty->dev);
 
 	if (test_bit(HCI_UART_RAW_DEVICE, &hu->hdev_flags))
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 247488e..074ed29 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -59,6 +59,7 @@ struct hci_uart_proto {
 	int (*flush)(struct hci_uart *hu);
 	int (*recv)(struct hci_uart *hu, void *data, int len);
 	int (*enqueue)(struct hci_uart *hu, struct sk_buff *skb);
+	int (*setup)(struct hci_uart *hu);
 	struct sk_buff *(*dequeue)(struct hci_uart *hu);
 };
 
-- 
1.9.1
