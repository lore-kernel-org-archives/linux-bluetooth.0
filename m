Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH] Bluetooth: hci_uart: Fix uninitialized alignment value
Date: Sat, 29 Jul 2017 19:32:31 +0200
Message-Id: <1501349551-4678-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Force alignment value to the default one (1 byte) if uninitialized.
This fixes hci_ll serdev driver (alignment = 0) and avoid any further
issues with upcoming drivers.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
 drivers/bluetooth/hci_h4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 4e328d7..3b82a87 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -172,7 +172,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const struct h4_recv_pkt *pkts, int pkts_count)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
-	u8 alignment = hu->alignment;
+	u8 alignment = hu->alignment ? hu->alignment : 1;
 
 	while (count) {
 		int i, len;
-- 
1.9.1
