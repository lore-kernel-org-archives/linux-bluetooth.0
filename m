Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/3] Bluetooth: Add dst_type parameter to hci_connect
Date: Tue, 27 Mar 2012 20:59:35 -0300
Message-Id: <1332892776-12060-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
References: <1332892776-12060-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the dst_type parameter to hci_connect. This way, we
use the address type information from upper layer instead of searching
it on the advertising cache.

The dst_type parameter is ignored for BR/EDR connection establishment.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   12 ++++--------
 net/bluetooth/l2cap_core.c       |    4 ++--
 net/bluetooth/mgmt.c             |    8 ++++----
 net/bluetooth/sco.c              |    3 ++-
 5 files changed, 13 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fa2c778..178eaa1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -574,7 +574,7 @@ int hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-						__u8 sec_level, __u8 auth_type);
+				__u8 dst_type, __u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 947172b..4f24d3f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -514,7 +514,8 @@ EXPORT_SYMBOL(hci_get_route);
 
 /* Create SCO, ACL or LE connection.
  * Device _must_ be locked */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type)
+struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
+				__u8 dst_type, __u8 sec_level, __u8 auth_type)
 {
 	struct hci_conn *acl;
 	struct hci_conn *sco;
@@ -523,21 +524,16 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
 	if (type == LE_LINK) {
-		struct adv_entry *entry;
-
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
 			return ERR_PTR(-EBUSY);
 
-		entry = hci_find_adv_entry(hdev, dst);
-		if (!entry)
-			return ERR_PTR(-EHOSTUNREACH);
-
 		le = hci_conn_add(hdev, LE_LINK, dst);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 
-		le->dst_type = entry->bdaddr_type;
+		le->dst_type = (dst_type == MGMT_ADDR_LE_RANDOM) ?
+				ADDR_LE_DEV_RANDOM : ADDR_LE_DEV_PUBLIC;
 
 		hci_le_connect(le);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 3caff27..91b02de 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1216,10 +1216,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	auth_type = l2cap_get_auth_type(chan);
 
 	if (chan->dcid == L2CAP_CID_LE_DATA)
-		hcon = hci_connect(hdev, LE_LINK, dst,
+		hcon = hci_connect(hdev, LE_LINK, dst, MGMT_ADDR_LE_RANDOM,
 					chan->sec_level, auth_type);
 	else
-		hcon = hci_connect(hdev, ACL_LINK, dst,
+		hcon = hci_connect(hdev, ACL_LINK, dst, MGMT_ADDR_BREDR,
 					chan->sec_level, auth_type);
 
 	if (IS_ERR(hcon)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5a56e0c..7fae5e3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1911,11 +1911,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 
 	if (cp->addr.type == MGMT_ADDR_BREDR)
-		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr, sec_level,
-				   auth_type);
+		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
+					cp->addr.type, sec_level, auth_type);
 	else
-		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr, sec_level,
-				   auth_type);
+		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
+					cp->addr.type, sec_level, auth_type);
 
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 8bf26d1..a48de4c 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -196,7 +196,8 @@ static int sco_connect(struct sock *sk)
 	else
 		type = SCO_LINK;
 
-	hcon = hci_connect(hdev, type, dst, BT_SECURITY_LOW, HCI_AT_NO_BONDING);
+	hcon = hci_connect(hdev, type, dst, MGMT_ADDR_BREDR, BT_SECURITY_LOW,
+				HCI_AT_NO_BONDING);
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
 		goto done;
-- 
1.7.9.4

