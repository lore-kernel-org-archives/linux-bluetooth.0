Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth:bt3c_cs: Comparison to NULL re-written
Date: Fri, 25 Sep 2015 09:02:18 +0000
Message-ID: <20150925090212.GA5341@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

NOT NULL comparison modified to be readable, reported
by checkpatch.

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/bt3c_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 772a277..b8f4b63 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -233,7 +233,7 @@ static void bt3c_receive(struct bt3c_info *info)
 		info->hdev->stat.byte_rx++;
=20
 		/* Allocate packet */
-		if (info->rx_skb =3D=3D NULL) {
+		if (!info->rx_skb) {
 			info->rx_state =3D RECV_WAIT_PACKET_TYPE;
 			info->rx_count =3D 0;
 			info->rx_skb =3D bt_skb_alloc(HCI_MAX_FRAME_SIZE, GFP_ATOMIC);
--=20
1.9.1
