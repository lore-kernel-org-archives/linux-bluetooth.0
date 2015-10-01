Return-Path: <cyrus@holtmann.org>
From: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>, "gustavo@padovan.org"
	<gustavo@padovan.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] bluetooth: bt3c_cs: clean up bt3c_cs driver code
Date: Thu, 1 Oct 2015 12:56:22 +0000
Message-ID: <20151001125557.GA4143@jci-VirtualBox>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasanna Karthik <mkarthi3@visteon.com>

Patch fixes the checkpatch warnings:
- use linux/io.h instead of asm/io.h
- NULL comparison could be re-written

Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
---
 drivers/bluetooth/bt3c_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index 772a277..5597eef 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -39,7 +39,7 @@
 #include <linux/serial.h>
 #include <linux/serial_reg.h>
 #include <linux/bitops.h>
-#include <asm/io.h>
+#include <linux/io.h>
=20
 #include <linux/device.h>
 #include <linux/firmware.h>
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
