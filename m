Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Pass desired connection role to hci_connect_le()
Date: Mon,  7 Jul 2014 15:02:28 +0300
Message-Id: <1404734548-3380-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com>
References: <1404734548-3380-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If we have both LE scanning and advertising simultaneously enabled we
need a way to tell hci_connect_le() in which role to initiate a
connection. This patch adds a new parameter to the function to give it
the necessary information. For auto-connect and mgmt_pair_device we
always use master role, whereas for L2CAP users (in practice sockets) we
use slave role whenever HCI_ADVERTISING is set and master role
otherwise.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 3 ++-
 net/bluetooth/hci_conn.c         | 6 ++++--
 net/bluetooth/hci_event.c        | 3 ++-
 net/bluetooth/l2cap_core.c       | 6 +++++-
 net/bluetooth/mgmt.c             | 3 ++-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8752ac674db1..5701d15779dd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -704,7 +704,8 @@ void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u16 conn_timeout);
+				u8 dst_type, u8 sec_level, u16 conn_timeout,
+				bool master);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9323044f01cd..16fd55da9c1d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -700,7 +700,8 @@ static void hci_req_directed_advertising(struct hci_request *req,
 }
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u16 conn_timeout)
+				u8 dst_type, u8 sec_level, u16 conn_timeout,
+				bool master)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -760,7 +761,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags)) {
+	/* If requested to connect as slave use directed advertising */
+	if (!master) {
 		hci_req_directed_advertising(&req, conn);
 		goto create_conn;
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad39d9ad6fbc..a6816498b0b9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4253,8 +4253,9 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		return;
 
 connect:
+	/* Request connection in master = true role */
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT);
+			      HCI_LE_AUTOCONN_TIMEOUT, true);
 	if (!IS_ERR(conn))
 		return;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3daab4588522..bf379a379fa0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7124,6 +7124,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	chan->dcid = cid;
 
 	if (bdaddr_type_is_le(dst_type)) {
+		bool master;
+
 		/* Convert from L2CAP channel address type to HCI address type
 		 */
 		if (dst_type == BDADDR_LE_PUBLIC)
@@ -7131,8 +7133,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			dst_type = ADDR_LE_DEV_RANDOM;
 
+		master = !test_bit(HCI_ADVERTISING, &hdev->dev_flags);
+
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT);
+				      HCI_LE_CONN_TIMEOUT, master);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e7047de1ba11..b391e2fef4b6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3117,8 +3117,9 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 */
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
+		/* Request a connection with master = true role */
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, HCI_LE_CONN_TIMEOUT);
+				      sec_level, HCI_LE_CONN_TIMEOUT, true);
 	}
 
 	if (IS_ERR(conn)) {
-- 
1.9.3

