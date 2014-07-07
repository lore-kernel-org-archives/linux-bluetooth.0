Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove auth_type parameter from hci_connect_le()
Date: Mon,  7 Jul 2014 15:02:27 +0300
Message-Id: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The auth_type value which gets assigned to hci_conn->auth_type is
something that's only used for BR/EDR connections and is of no value for
LE connections. It makes therefore little sense to pass it to the
hci_connect_le() function. This patch removes the parameter from the
function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 +--
 net/bluetooth/hci_conn.c         | 5 +----
 net/bluetooth/hci_event.c        | 2 +-
 net/bluetooth/l2cap_core.c       | 6 ++----
 net/bluetooth/mgmt.c             | 3 +--
 5 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 06039aae3010..8752ac674db1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -704,8 +704,7 @@ void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u8 auth_type,
-				u16 conn_timeout);
+				u8 dst_type, u8 sec_level, u16 conn_timeout);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index faa032fcdaee..9323044f01cd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -700,8 +700,7 @@ static void hci_req_directed_advertising(struct hci_request *req,
 }
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u8 auth_type,
-				u16 conn_timeout)
+				u8 dst_type, u8 sec_level, u16 conn_timeout)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -721,7 +720,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 	if (conn) {
 		conn->pending_sec_level = sec_level;
-		conn->auth_type = auth_type;
 		goto done;
 	}
 
@@ -758,7 +756,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->pending_sec_level = sec_level;
-	conn->auth_type = auth_type;
 	conn->conn_timeout = conn_timeout;
 
 	hci_req_init(&req, hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 84f4659f136e..ad39d9ad6fbc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4254,7 +4254,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 
 connect:
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_AT_NO_BONDING, HCI_LE_AUTOCONN_TIMEOUT);
+			      HCI_LE_AUTOCONN_TIMEOUT);
 	if (!IS_ERR(conn))
 		return;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a219276d9f92..3daab4588522 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7048,7 +7048,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
-	__u8 auth_type;
 	int err;
 
 	BT_DBG("%pMR -> %pMR (type %u) psm 0x%2.2x", &chan->src, dst,
@@ -7124,8 +7123,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->psm = psm;
 	chan->dcid = cid;
 
-	auth_type = l2cap_get_auth_type(chan);
-
 	if (bdaddr_type_is_le(dst_type)) {
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
@@ -7135,8 +7132,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			dst_type = ADDR_LE_DEV_RANDOM;
 
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      auth_type, HCI_LE_CONN_TIMEOUT);
+				      HCI_LE_CONN_TIMEOUT);
 	} else {
+		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ef675acbcfce..e7047de1ba11 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3118,8 +3118,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, auth_type,
-				      HCI_LE_CONN_TIMEOUT);
+				      sec_level, HCI_LE_CONN_TIMEOUT);
 	}
 
 	if (IS_ERR(conn)) {
-- 
1.9.3

