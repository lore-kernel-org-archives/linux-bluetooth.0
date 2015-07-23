Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:hci_ldisc: Cleaned up coding style warnings
Date: Thu, 23 Jul 2015 11:08:52 +0000
Message-ID: <20150723110845.GA6242@ubuntu>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Fix for Cleanpatch warning:
Space prohibited between function name and open parenthesis '('

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_ldisc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index 177dd69..f190f98 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -770,7 +770,7 @@ static int __init hci_uart_init(void)
=20
 	/* Register the tty discipline */
=20
-	memset(&hci_uart_ldisc, 0, sizeof (hci_uart_ldisc));
+	memset(&hci_uart_ldisc, 0, sizeof(hci_uart_ldisc));
 	hci_uart_ldisc.magic		=3D TTY_LDISC_MAGIC;
 	hci_uart_ldisc.name		=3D "n_hci";
 	hci_uart_ldisc.open		=3D hci_uart_tty_open;
--=20
1.7.0.4
