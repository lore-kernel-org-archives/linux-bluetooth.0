Return-Path: <yi2010.guo@samsung.com>
From: Guo Yi <yi2010.guo@samsung.com>
To: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
	davem@davemloft.net, Guo Yi <yi2010.guo@samsung.com>
Subject: [PATCH] Bluetooth: 6lowpan: Fix disconnect bug in 6lowpan
Date: Wed, 17 Jan 2018 11:47:28 +0800
Message-Id: <1516160848-471-1-git-send-email-yi2010.guo@samsung.com>
Content-Type: text/plain; charset="utf-8"
References: <CGME20180117034755epcas5p1437f6831b91eb594a1106f0960204b81@epcas5p1.samsung.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix the bluetooth 6lowpan disconnect fail bug.

The type of the same address type have different define value in HCI layer
and L2CAP layer.That makes disconnect fail due to wrong network type.User
will not be able to disconnect from console with the network type that used
in connect.

This patch add a var lookup_type, and covert the channel address type to
HCI address type. By these means, user can disconnect successfuly.

Signed-off-by: Guo Yi <yi2010.guo@samsung.com>
---
 net/bluetooth/6lowpan.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 795ddd8..332dddb 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -1104,11 +1104,18 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 	struct hci_dev *hdev;
 	bdaddr_t *src = BDADDR_ANY;
 	int n;
+	u8 lookup_type;
 
 	n = sscanf(buf, "%hhx:%hhx:%hhx:%hhx:%hhx:%hhx %hhu",
 		   &addr->b[5], &addr->b[4], &addr->b[3],
 		   &addr->b[2], &addr->b[1], &addr->b[0],
 		   addr_type);
+	/* Convert from L2CAP channel address type to HCI address type
+	 */
+	if (*addr_type == BDADDR_LE_PUBLIC)
+		lookup_type = ADDR_LE_DEV_PUBLIC;
+	else
+		lookup_type = ADDR_LE_DEV_RANDOM;
 
 	if (n < 7)
 		return -EINVAL;
@@ -1118,7 +1125,7 @@ static int get_l2cap_conn(char *buf, bdaddr_t *addr, u8 *addr_type,
 		return -ENOENT;
 
 	hci_dev_lock(hdev);
-	hcon = hci_conn_hash_lookup_le(hdev, addr, *addr_type);
+	hcon = hci_conn_hash_lookup_le(hdev, addr, lookup_type);
 	hci_dev_unlock(hdev);
 
 	if (!hcon)
-- 
2.7.4
