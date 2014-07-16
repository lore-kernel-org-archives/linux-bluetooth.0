Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Add a role parameter to hci_conn_add()
Date: Wed, 16 Jul 2014 11:56:07 +0300
Message-Id: <1405500969-17578-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to be able to track slave vs master LE connections in
hci_conn_hash, and to be able to do that we need to know the role of the
connection by the time hci_conn_add_has() is called. This means in
practice the hci_conn_add() call that creates the hci_conn_object.

This patch adds a new role parameter to hci_conn_add() function to give
the object its initial role value, and updates the callers to pass the
appropriate role to it. Since the function now takes care of
initializing both conn->role and conn->out values we can remove some
other unnecessary assignments.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/amp.c              |  4 ++--
 net/bluetooth/hci_conn.c         | 17 +++++++++--------
 net/bluetooth/hci_event.c        | 17 ++++++-----------
 4 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index abe5083becd3..3de000fbecdc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -695,7 +695,8 @@ void hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
-struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
+struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+			      u8 role);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
diff --git a/net/bluetooth/amp.c b/net/bluetooth/amp.c
index bb39509b3f06..e60603a8969f 100644
--- a/net/bluetooth/amp.c
+++ b/net/bluetooth/amp.c
@@ -113,8 +113,9 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 {
 	bdaddr_t *dst = &mgr->l2cap_conn->hcon->dst;
 	struct hci_conn *hcon;
+	u8 role = out ? HCI_ROLE_MASTER : HCI_ROLE_SLAVE;
 
-	hcon = hci_conn_add(hdev, AMP_LINK, dst);
+	hcon = hci_conn_add(hdev, AMP_LINK, dst, role);
 	if (!hcon)
 		return NULL;
 
@@ -125,7 +126,6 @@ struct hci_conn *phylink_add(struct hci_dev *hdev, struct amp_mgr *mgr,
 	hcon->handle = __next_handle(mgr);
 	hcon->remote_id = remote_id;
 	hcon->amp_mgr = amp_mgr_get(mgr);
-	hcon->out = out;
 
 	return hcon;
 }
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6edd55340157..ad5f0b819e90 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -421,7 +421,8 @@ static void le_conn_timeout(struct work_struct *work)
 	hci_le_create_connection_cancel(conn);
 }
 
-struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
+struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+			      u8 role)
 {
 	struct hci_conn *conn;
 
@@ -435,6 +436,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	bacpy(&conn->src, &hdev->bdaddr);
 	conn->hdev  = hdev;
 	conn->type  = type;
+	conn->role  = role;
 	conn->mode  = HCI_CM_ACTIVE;
 	conn->state = BT_OPEN;
 	conn->auth_type = HCI_AT_GENERAL_BONDING;
@@ -447,6 +449,9 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	set_bit(HCI_CONN_POWER_SAVE, &conn->flags);
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 
+	if (conn->role == HCI_ROLE_MASTER)
+		conn->out = true;
+
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
@@ -746,7 +751,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		dst_type = ADDR_LE_DEV_RANDOM;
 	}
 
-	conn = hci_conn_add(hdev, LE_LINK, dst);
+	conn = hci_conn_add(hdev, LE_LINK, dst, role);
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
@@ -769,8 +774,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 			    &enable);
 	}
 
-	conn->role = role;
-
 	/* If requested to connect as slave use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
 		/* If we're active scanning most controllers are unable
@@ -787,8 +790,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		goto create_conn;
 	}
 
-	conn->out  = true;
-
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
 	if (params) {
 		conn->le_conn_min_interval = params->conn_min_interval;
@@ -837,7 +838,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
-		acl = hci_conn_add(hdev, ACL_LINK, dst);
+		acl = hci_conn_add(hdev, ACL_LINK, dst, HCI_ROLE_MASTER);
 		if (!acl)
 			return ERR_PTR(-ENOMEM);
 	}
@@ -866,7 +867,7 @@ struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
-		sco = hci_conn_add(hdev, type, dst);
+		sco = hci_conn_add(hdev, type, dst, HCI_ROLE_MASTER);
 		if (!sco) {
 			hci_conn_drop(acl);
 			return ERR_PTR(-ENOMEM);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5f7fd410fb3b..c68b93e11686 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1414,11 +1414,9 @@ static void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		}
 	} else {
 		if (!conn) {
-			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
-			if (conn) {
-				conn->out  = true;
-				conn->role = HCI_ROLE_MASTER;
-			} else
+			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr,
+					    HCI_ROLE_MASTER);
+			if (!conn)
 				BT_ERR("No memory for new connection");
 		}
 	}
@@ -2156,7 +2154,8 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
 			&ev->bdaddr);
 	if (!conn) {
-		conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
+		conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr,
+				    HCI_ROLE_SLAVE);
 		if (!conn) {
 			BT_ERR("No memory for new connection");
 			hci_dev_unlock(hdev);
@@ -4100,7 +4099,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 	if (!conn) {
-		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr, ev->role);
 		if (!conn) {
 			BT_ERR("No memory for new connection");
 			goto unlock;
@@ -4108,10 +4107,6 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 		conn->dst_type = ev->bdaddr_type;
 
-		conn->role = ev->role;
-		if (conn->role == HCI_ROLE_MASTER)
-			conn->out = true;
-
 		/* If we didn't have a hci_conn object previously
 		 * but we're in master role this must be something
 		 * initiated using a white list. Since white list based
-- 
1.9.3

