Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 05/16] Bluetooth: hci_ldisc: Separate flag handling in hci_uart_tty_close()
Date: Fri, 7 Apr 2017 18:04:27 +0100
Message-ID: <1491584678-27228-6-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The treatment of flags HCI_UART_REGISTERED and HCI_UART_PROTO_READY
in hci_uart_tty_close() was combined in multiple if statements. This
is over-complex and can be simplified.

The simplification is to separate the processing of the flags
HCI_UART_REGISTERED and HCI_UART_PROTO_READY in hci_uart_tty_close()
because registration of the HCI UART device is actually independent of
the binding of the Data Link protocol layer. The Data Link protocol
layer is bound before the HCI UART device is registered and therefore
unregister the HCI UART device before unbinding the Data Link protocol
layer. However, the software should not break if the Data Link protocol
somehow becomes unbound whilst the HCI UART device is still registered.

One of the reasons the software got over complex was because
hci_uart_send_frame() did not check the status of the
HCI_UART_PROTO_READY flag which meant that the hdev->workqueue could
operate on an unbound Data Link protocol layer. The complexity of the
logic prevented hci_uart_send_frame() from crashing.

The commit
"Bluetooth: Add protocol check to hci_uart_send_frame()"
for adding the HCI_UART_PROTO_READY flag check to hci_uart_send_frame()
is necessary to allow this simplification to work. Otherwise,
hci_uart_send_frame() can attempt to write to the unbound Data Link
protocol layer resulting in a crash.

Note hci_uart_write_work() races with hci_uart_tty_close() so it is
important that freeing of hdev is moved to the end of
hci_uart_tty_close() to reduce the risk of use after free of hdev.
For completeness set hu->hdev to NULL before freeing hdev so that
hu no longer references the freed hdev.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 9a96463..063ccaa 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -496,23 +496,27 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	cancel_work_sync(&hu->write_work);
 
-	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-		if (hdev) {
-			if (test_bit(HCI_UART_REGISTERED, &hu->flags)) {
-				/* Note hci_unregister_dev() may try to send
-				 * a HCI RESET command. If the transmission
-				 * fails then hci_unregister_dev() waits
-				 * HCI_CMD_TIMEOUT (2) seconds for the timeout
-				 * to occur.
-				 */
-				hci_unregister_dev(hdev);
-			}
-			hci_free_dev(hdev);
+	if (hdev) {
+		if (test_bit(HCI_UART_REGISTERED, &hu->flags)) {
+			/* Note hci_unregister_dev() may try to send a
+			 * HCI RESET command. If the transmission fails then
+			 * hci_unregister_dev() waits HCI_CMD_TIMEOUT
+			 * (2) seconds for the timeout to occur.
+			 */
+			hci_unregister_dev(hdev);
 		}
-		hu->proto->close(hu);
 	}
+
+	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags))
+		hu->proto->close(hu);
+
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
+	if (test_and_clear_bit(HCI_UART_REGISTERED, &hu->flags)) {
+		hu->hdev = NULL;
+		hci_free_dev(hdev);
+	}
+
 	kfree(hu);
 }
 
-- 
2.7.4
