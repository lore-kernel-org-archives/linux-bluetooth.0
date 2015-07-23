Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:hci_h5: Cleaned up coding style warnings
Date: Thu, 23 Jul 2015 11:22:56 +0000
Message-ID: <20150723112248.GA6546@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Cleanedup "Unnecessary space before function pointer arguments" warning
reported by Checkpatch

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_h5.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 3455cec..b35b238 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -75,7 +75,7 @@ struct h5 {
 	size_t			rx_pending;	/* Expecting more bytes */
 	u8			rx_ack;		/* Last ack number received */
=20
-	int			(*rx_func) (struct hci_uart *hu, u8 c);
+	int			(*rx_func)(struct hci_uart *hu, u8 c);
=20
 	struct timer_list	timer;		/* Retransmission timer */
=20
--=20
1.7.0.4
