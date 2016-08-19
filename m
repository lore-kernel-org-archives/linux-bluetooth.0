Return-Path: <boris.brezillon@free-electrons.com>
From: Boris Brezillon <boris.brezillon@free-electrons.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	jason.abele@gmail.com,
	Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH 4/4] Bluetooth: hci_ldisc: make sure we don't loose HCI_UART_TX_WAKEUP events
Date: Fri, 19 Aug 2016 09:38:47 +0200
Message-Id: <1471592327-14133-5-git-send-email-boris.brezillon@free-electrons.com>
In-Reply-To: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1471592327-14133-1-git-send-email-boris.brezillon@free-electrons.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The HCI_UART_TX_WAKEUP flag checking is racy and some HCI_UART_TX_WAKEUP
events can be lost.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/bluetooth/hci_ldisc.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 27f73294edcb..ee7b25f1c6ce 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -172,6 +172,17 @@ restart:
 		goto restart;
 
 	clear_bit(HCI_UART_SENDING, &hu->tx_state);
+
+	/*
+	 * One last check to make sure hci_uart_tx_wakeup() did not set
+	 * HCI_UART_TX_WAKEUP while we where clearing HCI_UART_SENDING.
+	 * The work might have been scheduled by someone else in the
+	 * meantime, in this case we return directly.
+	 */
+	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
+	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
+		goto restart;
+
 }
 
 static void hci_uart_init_work(struct work_struct *work)
-- 
2.7.4
