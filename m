Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/17] Bluetooth: Refactor HCI connection code
Date: Wed, 26 Feb 2014 20:21:44 -0300
Message-Id: <1393456916-22701-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
References: <1393456916-22701-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_connect() is a very simple and useless wrapper of hci_connect_acl
and hci_connect_le functions. Addtionally, all places where hci_connect
is called the link type value is passed explicitly. This way, we can
safely delete hci_connect, declare hci_connect_acl and hci_connect_le
in hci_core.h and call them directly.

No functionality is changed by this patch.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  6 ++++--
 net/bluetooth/hci_conn.c         | 24 ++++--------------------
 net/bluetooth/l2cap_core.c       |  7 +++----
 net/bluetooth/mgmt.c             |  8 ++++----
 4 files changed, 15 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4253bdf..20bdb2e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -641,8 +641,10 @@ void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type);
+struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
+				u8 dst_type, u8 sec_level, u8 auth_type);
+struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
+				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 				 __u16 setting);
 int hci_conn_check_link_mode(struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 296b8ee..5c392aa 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -624,8 +624,8 @@ static void stop_scan_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				    u8 dst_type, u8 sec_level, u8 auth_type)
+struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
+				u8 dst_type, u8 sec_level, u8 auth_type)
 {
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
@@ -729,8 +729,8 @@ done:
 	return conn;
 }
 
-static struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
-						u8 sec_level, u8 auth_type)
+struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
+				 u8 sec_level, u8 auth_type)
 {
 	struct hci_conn *acl;
 
@@ -799,22 +799,6 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	return sco;
 }
 
-/* Create SCO, ACL or LE connection. */
-struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
-			     __u8 dst_type, __u8 sec_level, __u8 auth_type)
-{
-	BT_DBG("%s dst %pMR type 0x%x", hdev->name, dst, type);
-
-	switch (type) {
-	case LE_LINK:
-		return hci_connect_le(hdev, dst, dst_type, sec_level, auth_type);
-	case ACL_LINK:
-		return hci_connect_acl(hdev, dst, sec_level, auth_type);
-	}
-
-	return ERR_PTR(-EINVAL);
-}
-
 /* Check link security requirement */
 int hci_conn_check_link_mode(struct hci_conn *conn)
 {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d8d9902..ab5e2bd 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7109,11 +7109,10 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 	auth_type = l2cap_get_auth_type(chan);
 
 	if (bdaddr_type_is_le(dst_type))
-		hcon = hci_connect(hdev, LE_LINK, dst, dst_type,
-				   chan->sec_level, auth_type);
+		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
+				      auth_type);
 	else
-		hcon = hci_connect(hdev, ACL_LINK, dst, dst_type,
-				   chan->sec_level, auth_type);
+		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
 
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index cfcaf97..9fc7c1d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2816,11 +2816,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		auth_type = HCI_AT_DEDICATED_BONDING_MITM;
 
 	if (cp->addr.type == BDADDR_BREDR)
-		conn = hci_connect(hdev, ACL_LINK, &cp->addr.bdaddr,
-				   cp->addr.type, sec_level, auth_type);
+		conn = hci_connect_acl(hdev, &cp->addr.bdaddr, sec_level,
+				       auth_type);
 	else
-		conn = hci_connect(hdev, LE_LINK, &cp->addr.bdaddr,
-				   cp->addr.type, sec_level, auth_type);
+		conn = hci_connect_le(hdev, &cp->addr.bdaddr, cp->addr.type,
+				      sec_level, auth_type);
 
 	if (IS_ERR(conn)) {
 		int status;
-- 
1.8.5.4

