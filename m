Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/17] Bluetooth: Move address type conversion to outside hci_connect_le
Date: Tue, 25 Feb 2014 18:01:33 -0300
Message-Id: <1393362104-12175-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch moves address type conversion (L2CAP address type to HCI
address type) to outside hci_connect_le. This way, we avoid back and
forth address type conversion in a comming patch.

So hci_connect_le() now expects 'dst_type' parameter in HCI address
type convention.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_conn.c   |  6 ------
 net/bluetooth/l2cap_core.c | 12 ++++++++++--
 net/bluetooth/mgmt.c       | 16 +++++++++++++---
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7fbcc7d..ccf4a4f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -656,12 +656,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn)
 		return ERR_PTR(-EBUSY);
 
-	/* Convert from L2CAP channel address type to HCI address type */
-	if (dst_type == BDADDR_LE_PUBLIC)
-		dst_type = ADDR_LE_DEV_PUBLIC;
-	else
-		dst_type = ADDR_LE_DEV_RANDOM;
-
 	/* When given an identity address with existing identity
 	 * resolving key, the connection needs to be established
 	 * to a resolvable random address.
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 308945e..9ce386a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7108,11 +7108,19 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	if (bdaddr_type_is_le(dst_type))
+	if (bdaddr_type_is_le(dst_type)) {
+		/* Convert from L2CAP channel address type to HCI address type
+		 */
+		if (dst_type == BDADDR_LE_PUBLIC)
+			dst_type = ADDR_LE_DEV_PUBLIC;
+		else
+			dst_type = ADDR_LE_DEV_RANDOM;
+
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
 				      auth_type);
-	else
+	} else {
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
+	}
 
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9fc7c1d..bad23d5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2815,12 +2815,22 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	else
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 
-	if (cp->addr.type == BDADDR_BREDR)
+	if (cp->addr.type == BDADDR_BREDR) {
 		conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
 				       auth_type);
-	else
-		conn = hci_connect_le(hdev, &cp->addr.bdaddr, cp->addr.type,
+	} else {
+		u8 addr_type;
+
+		/* Convert from L2CAP channel address type to HCI address type
+		 */
+		if (cp->addr.type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
+
+		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
 				      sec_level, auth_type);
+	}
 
 	if (IS_ERR(conn)) {
 		int status;
-- 
1.8.5.4

