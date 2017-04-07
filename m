Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [PATCH V2 04/16] Bluetooth: hci_ldisc: Add HCI RESET comment to hci_unregister_dev() call
Date: Fri, 7 Apr 2017 18:04:26 +0100
Message-ID: <1491584678-27228-5-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1491584678-27228-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

This commit relates to the HCI UART quirk HCI_QUIRK_RESET_ON_CLOSE
which is enabled by default and can be disabled by setting hdev_flags
flag HCI_UART_RESET_ON_INIT via ioctl HCIUARTSETFLAGS from userland.

The implementation of HCI_QUIRK_RESET_ON_CLOSE is broken for the BCSP
Data Link protocol layer because it can be seen that
hci_unregister_dev() takes 2 seconds to run due to BCSP communications
failure. Suspect that sending of the HCI RESET command is broken
for the other Data Link protocols as well.

Therefore, add a comment to inform that the call to
hci_unregister_dev() in hci_uart_tty_close() may send a HCI RESET
command. This transmission needs the HCI UART driver to remain
operational including having the Data Link protocol being bound to
the HCI UART driver. If the transmission fails, then
hci_unregister_dev() waits HCI_CMD_TIMEOUT (2) seconds for the
timeout to occur which is undesirable.

The current software has a call to hci_unregister_dev(hdev) in
hci_uart_tty_close() which can cause an attempt at sending the
command HCI RESET to occur through the following callstack:

hci_uart_tty_close()
hci_unregister_dev()
hci_dev_do_close()
__hci_req_sync() to queue up command HCI RESET
which adds a work-item to the hdev->workqueue and waits 2 seconds
for a response

Subsequently
hdev->workqueue runs and processes the work-item by calling
hci_cmd_work()
hci_send_frame()
hci_uart_send_frame() to enqueue into the Data Link protocol layer

No protocol response comes so hci_unregister_dev() takes 2 seconds to
run!

In fact, this hidden transmission of the HCI RESET command is most
likely the root cause of why hci_uart_tty_close() crashed in the past
and was "fixed" with multiple workarounds in the past.

The underlying design flaw is that hci_uart_tty_close() is interfering
with various aspects of transmitting and receiving HCI messages
whilst hci_unregister_dev() is trying to use the Data Link protocol
to send the HCI RESET command. Consequently, the design flaw
causes the Data Link protocol to retransmit as no reply comes from
the Bluetooth Radio module over the UART link.

Over the many years of "fixes", this caused the logic in
hci_uart_tty_close() to become over-complex.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 1887ad4..9a96463 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -498,8 +498,15 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	if (test_and_clear_bit(HCI_UART_PROTO_READY, &hu->flags)) {
 		if (hdev) {
-			if (test_bit(HCI_UART_REGISTERED, &hu->flags))
+			if (test_bit(HCI_UART_REGISTERED, &hu->flags)) {
+				/* Note hci_unregister_dev() may try to send
+				 * a HCI RESET command. If the transmission
+				 * fails then hci_unregister_dev() waits
+				 * HCI_CMD_TIMEOUT (2) seconds for the timeout
+				 * to occur.
+				 */
 				hci_unregister_dev(hdev);
+			}
 			hci_free_dev(hdev);
 		}
 		hu->proto->close(hu);
-- 
2.7.4
