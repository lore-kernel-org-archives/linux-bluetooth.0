Return-Path: <ian@mnementh.co.uk>
From: Ian Molton <ian@mnementh.co.uk>
To: linux-bluetooth@vger.kernel.org
Cc: sebastian.reichel@collabora.co.uk,
	marcel@holtmann.org,
	ohad@bencohen.org
Subject: [PATCH 1/4] bluetooth: Introduce hci_uart_unregister_device()
Date: Sat,  8 Jul 2017 17:12:25 +0100
Message-Id: <20170708161228.24324-1-ian@mnementh.co.uk>
List-ID: <linux-bluetooth.vger.kernel.org>

Several drivers have the same (and incorrect) code in their
_remove() handler.

Coalesce this into a shared function.

Signed-off-by: Ian Molton <ian@mnementh.co.uk>
---
 drivers/bluetooth/hci_serdev.c | 12 ++++++++++++
 drivers/bluetooth/hci_uart.h   |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index aea930101dd2..abc70b5e5647 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -354,3 +354,15 @@ int hci_uart_register_device(struct hci_uart *hu,
 	return err;
 }
 EXPORT_SYMBOL_GPL(hci_uart_register_device);
+
+void hci_uart_unregister_device(struct hci_uart *hu) {
+	struct hci_dev *hdev = hu->hdev;
+
+	hci_unregister_dev(hdev);
+	hci_free_dev(hdev);
+
+	cancel_work_sync(&hu->write_work);
+
+	hu->proto->close(hu);
+}
+EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index c6e9e1cf63f8..d9cd95d81149 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -112,6 +112,7 @@ struct hci_uart {
 int hci_uart_register_proto(const struct hci_uart_proto *p);
 int hci_uart_unregister_proto(const struct hci_uart_proto *p);
 int hci_uart_register_device(struct hci_uart *hu, const struct hci_uart_proto *p);
+void hci_uart_unregister_device(struct hci_uart *hu);
 
 int hci_uart_tx_wakeup(struct hci_uart *hu);
 int hci_uart_init_ready(struct hci_uart *hu);
-- 
2.11.0
