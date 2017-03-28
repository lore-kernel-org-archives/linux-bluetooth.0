Return-Path: <Dean_Jenkins@mentor.com>
From: Dean Jenkins <Dean_Jenkins@mentor.com>
To: Marcel Holtmann <marcel@holtmann.org>
CC: Dean Jenkins <Dean_Jenkins@mentor.com>, "Gustavo F . Padovan"
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>,
	<linux-bluetooth@vger.kernel.org>
Subject: [RFC V1 10/16] Bluetooth: hci_ldisc: hci_uart_tty_close() detach tty after last msg
Date: Tue, 28 Mar 2017 18:50:23 +0100
Message-ID: <1490723429-28870-11-git-send-email-Dean_Jenkins@mentor.com>
In-Reply-To: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
References: <1490723429-28870-1-git-send-email-Dean_Jenkins@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

hci_uart_tty_close() is detaching the tty prematurely which prevents
the Data Link protocol layer from using the tty serial port in the
call to hci_unregister_dev().

Consequently, when hci_unregister_dev() attempts to send a HCI RESET
command, the BCSP layer attempts to retransmit the message many times
and the command is timed-out after HCI_CMD_TIMEOUT (2) seconds.
Nothing was physically transmitted because the tty was detached too
early.

Therefore, move the detach statement "tty->disc_data = NULL" to after
hci_unregister_dev() so that the HCI RESET command maybe sent and
acknowledged.

Signed-off-by: Dean Jenkins <Dean_Jenkins@mentor.com>
---
 drivers/bluetooth/hci_ldisc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 2d5c6f0..e7d1b8b 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -493,9 +493,6 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 
 	BT_DBG("tty %p", tty);
 
-	/* Detach from the tty */
-	tty->disc_data = NULL;
-
 	if (!hu)
 		return;
 
@@ -517,6 +514,9 @@ static void hci_uart_tty_close(struct tty_struct *tty)
 		hu->proto->close(hu);
 	}
 
+	/* Detach from the tty */
+	tty->disc_data = NULL;
+
 	clear_bit(HCI_UART_PROTO_SET, &hu->flags);
 
 	if (test_and_clear_bit(HCI_UART_REGISTERED, &hu->flags)) {
-- 
2.7.4
