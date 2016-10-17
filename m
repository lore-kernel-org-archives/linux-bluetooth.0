Return-Path: <pkarthik@intrinsyc.com>
From: Prasanna Karthik <pkarthik@intrinsyc.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] HCI_BCSP: Use setup_timer Kernel API instead of init_timer
Date: Mon, 17 Oct 2016 18:31:08 +0000
Message-ID: <20161017183114.GA28622@prasanna-ubuntu.itc.intrinsyc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Replace init_timer function with setup_timer reported by coccinelle

Signed-off-by: Prasanna Karthik <pkarthik@intrinsyc.com>
---
 drivers/bluetooth/hci_bcsp.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index a2c921f..910ec96 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -733,9 +733,7 @@ static int bcsp_open(struct hci_uart *hu)
 	skb_queue_head_init(&bcsp->rel);
 	skb_queue_head_init(&bcsp->unrel);
=20
-	init_timer(&bcsp->tbcsp);
-	bcsp->tbcsp.function =3D bcsp_timed_event;
-	bcsp->tbcsp.data     =3D (u_long)hu;
+	setup_timer(&bcsp->tbcsp, bcsp_timed_event, (u_long)hu);
=20
 	bcsp->rx_state =3D BCSP_W4_PKT_DELIMITER;
=20
--=20
1.9.1
