Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/18 v2] Bluetooth: Simplify hci_uart_tty_close logic
Date: Mon, 16 Jul 2012 16:12:10 +0300
Message-Id: <1342444339-1627-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
References: <1342444339-1627-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch cleans up and reduces indentation in the hci_uart_tty_close
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 drivers/bluetooth/hci_ldisc.c |   25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 142f49c..b6d1f20 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -286,28 +286,29 @@ static int hci_uart_tty_open(struct tty_struct *tty)
 static void hci_uart_tty_close(struct tty_struct *tty)
 {
 	struct hci_uart *hu = (void *)tty->disc_data;
+	struct hci_dev *hdev;
 
 	BT_DBG("tty %p", tty);
 
 	/* Detach from the tty */
 	tty->disc_data = NULL;
 
-	if (hu) {
-		struct hci_dev *hdev = hu->hdev;
+	if (!hu)
+		return;
 
-		if (hdev)
-			hci_uart_close(hdev);
+	hdev = hu->hdev;
+	if (hdev)
+		hci_uart_close(hdev);
 
-		if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
-			if (hdev) {
-				hci_unregister_dev(hdev);
-				hci_free_dev(hdev);
-			}
-			hu->proto->close(hu);
+	if (test_and_clear_bit(HCI_UART_PROTO_SET, &hu->flags)) {
+		if (hdev) {
+			hci_unregister_dev(hdev);
+			hci_free_dev(hdev);
 		}
-
-		kfree(hu);
+		hu->proto->close(hu);
 	}
+
+	kfree(hu);
 }
 
 /* hci_uart_tty_wakeup()
-- 
1.7.10.4

