Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 10/16] Bluetooth: hci_ldisc: Tidy-up HCI_UART_REGISTERED in hci_uart_tty_close()
Date: Fri, 7 Apr 2017 18:04:32 +0100
Message-ID: <1491584678-27228-11-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

The code in hci_uart_tty_close is over complex in handling flag
HCI_UART_REGISTERED as it is unnecessary to check that hdev is NULL.
This is because hdev is only valid when HCI_UART_REGISTERED is in
the set state.

Therefore, remove all "if (hdev)" checks and instead check for flag
HCI_UART_REGISTERED being in the set state.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 65bfc0f..4a32fd2 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -520,20 +520,17 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		return;
 
 	hdev = hu->hdev;
-	if (hdev)
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags))
 		hci_uart_close(hdev);
 
 	cancel_work_sync(&hu->write_work);
 
-	if (hdev) {
-		if (test_bit(HCI_UART_REGISTERED, &hu->flags)) {
-			/* Note hci_unregister_dev() may try to send a
-			 * HCI RESET command. If the transmission fails then
-			 * hci_unregister_dev() waits HCI_CMD_TIMEOUT
-			 * (2) seconds for the timeout to occur.
-			 */
-			hci_unregister_dev(hdev);
-		}
+	if (test_bit(HCI_UART_REGISTERED, &hu->flags)) {
+		/* Note hci_unregister_dev() may try to send a HCI RESET
+		 * command. If the transmission fails then hci_unregister_dev()
+		 * waits HCI_CMD_TIMEOUT (2) seconds for the timeout to occur.
+		 */
+		hci_unregister_dev(hdev);
 	}
 
 	if (test_bit(HCI_UART_PROTO_READY, &hu->flags)) {
-- 
2.7.4
