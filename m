Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Fix specifying role for LE connections
Date: Wed, 11 Nov 2015 14:44:57 +0200
Message-Id: <1447245899-30783-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
References: <1447245899-30783-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_connect_le_scan() is (as the name implies) a master/central
role API, so it makes no sense in passing a role parameter to it. At
the same time this patch also fixes the direct advertising support for
LE L2CAP sockets where we now call the more appropriate hci_le_connect()
API if slave/peripheral role is desired.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         |  4 ++--
 net/bluetooth/l2cap_core.c       | 15 +++++++--------
 net/bluetooth/mgmt.c             |  3 +--
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 609f4a03899c..55ce209157b1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -877,7 +877,7 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u8 dst_type, u8 sec_level,
-				     u16 conn_timeout, u8 role);
+				     u16 conn_timeout);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1ed1e153b3fa..673c2254935b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -988,7 +988,7 @@ static int hci_explicit_conn_params_set(struct hci_dev *hdev,
 /* This function requires the caller holds hdev->lock */
 struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 				     u8 dst_type, u8 sec_level,
-				     u16 conn_timeout, u8 role)
+				     u16 conn_timeout)
 {
 	struct hci_conn *conn;
 
@@ -1018,7 +1018,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 
 	BT_DBG("requesting refresh of dst_addr");
 
-	conn = hci_conn_add(hdev, LE_LINK, dst, role);
+	conn = hci_conn_add(hdev, LE_LINK, dst, HCI_ROLE_MASTER);
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c65ee200c29..ffb7b26e02bc 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7099,8 +7099,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->dcid = cid;
 
 	if (bdaddr_type_is_le(dst_type)) {
-		u8 role;
-
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
 		if (dst_type == BDADDR_LE_PUBLIC)
@@ -7109,14 +7107,15 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			dst_type = ADDR_LE_DEV_RANDOM;
 
 		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
-			role = HCI_ROLE_SLAVE;
+			hcon = hci_connect_le(hdev, dst, dst_type,
+					      chan->sec_level,
+					      HCI_LE_CONN_TIMEOUT,
+					      HCI_ROLE_SLAVE);
 		else
-			role = HCI_ROLE_MASTER;
+			hcon = hci_connect_le_scan(hdev, dst, dst_type,
+						   chan->sec_level,
+						   HCI_LE_CONN_TIMEOUT);
 
-		hcon = hci_connect_le_scan(hdev, dst, dst_type,
-					   chan->sec_level,
-					   HCI_LE_CONN_TIMEOUT,
-					   role);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e4ad0457547a..eca203e891d2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3518,8 +3518,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		conn = hci_connect_le_scan(hdev, &cp->addr.bdaddr,
 					   addr_type, sec_level,
-					   HCI_LE_CONN_TIMEOUT,
-					   HCI_ROLE_MASTER);
+					   HCI_LE_CONN_TIMEOUT);
 	}
 
 	if (IS_ERR(conn)) {
-- 
2.5.0

