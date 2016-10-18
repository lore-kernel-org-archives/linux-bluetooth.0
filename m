Return-Path: <pkarthik@intrinsyc.com>
From: Prasanna Karthik <pkarthik@intrinsyc.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: hci_h5: Use setup_timer Kernel API instead of
 init_timer
Date: Tue, 18 Oct 2016 17:30:10 +0000
Message-ID: <20161018173018.GA27568@prasanna-ubuntu.itc.intrinsyc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Replace init_timer function with setup_timer reported by coccinelle

Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
---
 drivers/bluetooth/hci_h5.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index 0879d64..90d0456 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -204,9 +204,7 @@ static int h5_open(struct hci_uart *hu)
=20
 	h5_reset_rx(h5);
=20
-	init_timer(&h5->timer);
-	h5->timer.function =3D h5_timed_event;
-	h5->timer.data =3D (unsigned long)hu;
+	setup_timer(&h5->timer, h5_timed_event, (unsigned long)hu);
=20
 	h5->tx_win =3D H5_TX_WIN_MAX;
=20
--=20
1.9.1
