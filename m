Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:hci_qca: Changed unsigned long to bool
Date: Mon, 28 Sep 2015 06:29:07 +0000
Message-ID: <20150928062901.GA5935@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

'retransmit' being set in HCI_IBS_TX_WAKING case,
using bool would be efficient.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/hci_qca.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 21f4ea4..3fdb17d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -347,7 +347,7 @@ static void hci_ibs_wake_retrans_timeout(unsigned long =
arg)
 	struct hci_uart *hu =3D (struct hci_uart *)arg;
 	struct qca_data *qca =3D hu->priv;
 	unsigned long flags, retrans_delay;
-	unsigned long retransmit =3D 0;
+	bool retransmit;
=20
 	BT_DBG("hu %p wake retransmit timeout in %d state",
 		hu, qca->tx_ibs_state);
@@ -358,7 +358,7 @@ static void hci_ibs_wake_retrans_timeout(unsigned long =
arg)
 	switch (qca->tx_ibs_state) {
 	case HCI_IBS_TX_WAKING:
 		/* No WAKE_ACK, retransmit WAKE */
-		retransmit =3D 1;
+		retransmit =3D true;
 		if (send_hci_ibs_cmd(HCI_IBS_WAKE_IND, hu) < 0) {
 			BT_ERR("Failed to acknowledge device wake up");
 			break;
--=20
1.9.1
