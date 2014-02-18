Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Look up RPA for connection requests with Identity Address
Date: Tue, 18 Feb 2014 21:41:36 +0200
Message-Id: <1392752497-8696-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
References: <1392752497-8696-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to check whether there's a matching IRK and RPA when we're
requested to connect to a remote LE device based on its Identity
Address. This patch updates the hci_connect_le function to do an extra
call to hci_find_irk_by_addr and uses the RPA if it's cached. This is
particularly important once we start exposing the Identity Address to
user space instead of the RPA in events such as Device Connected and
Device Found.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 67972928a623..40ec37355d6f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -588,6 +588,7 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
+	struct smp_irk *irk;
 	int err;
 
 	if (test_bit(HCI_ADVERTISING, &hdev->flags))
@@ -616,15 +617,23 @@ static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn)
 		return ERR_PTR(-EBUSY);
 
+	/* Convert from L2CAP channel address type to HCI address type */
+	if (dst_type == BDADDR_LE_PUBLIC)
+		dst_type = ADDR_LE_DEV_PUBLIC;
+	else
+		dst_type = ADDR_LE_DEV_RANDOM;
+
+	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
+	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
+		dst = &irk->rpa;
+		dst_type = ADDR_LE_DEV_RANDOM;
+	}
+
 	conn = hci_conn_add(hdev, LE_LINK, dst);
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
-	if (dst_type == BDADDR_LE_PUBLIC)
-		conn->dst_type = ADDR_LE_DEV_PUBLIC;
-	else
-		conn->dst_type = ADDR_LE_DEV_RANDOM;
-
+	conn->dst_type = dst_type;
 	conn->src_type = hdev->own_addr_type;
 
 	conn->state = BT_CONNECT;
-- 
1.8.5.3

