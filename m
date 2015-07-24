Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 3/5] Bluetooth: advertisement handling in new connect procedure
Date: Fri, 24 Jul 2015 19:37:03 +0200
Message-Id: <1437759425-20109-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1437759425-20109-1-git-send-email-jpawlowski@google.com>
References: <1437759425-20109-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This path makes sure that after advertisement is received from device that
we try to connect to, it is properly handled in check_pending_le_conn and
trigger connect attempt.

It also modifies hci_le_connect to make sure that connect attempt will be
properly continued.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_conn.c  | 58 ++++++++++++++++++++++++++++++++++++++---------
 net/bluetooth/hci_event.c | 51 +++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c      |  6 +++++
 3 files changed, 82 insertions(+), 33 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 74b8d07..be15502 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -685,6 +685,7 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 
 	conn->state = BT_CONNECT;
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 }
 
 static void hci_req_directed_advertising(struct hci_request *req,
@@ -723,12 +724,32 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
+static inline struct hci_conn *find_not_scanning_conn(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == LE_LINK && c->state == BT_CONNECT &&
+		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role)
 {
 	struct hci_conn_params *params;
-	struct hci_conn *conn;
+	struct hci_conn *conn, *conn_unfinished;
 	struct smp_irk *irk;
 	struct hci_request req;
 	int err;
@@ -751,15 +772,22 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * and return the object found.
 	 */
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	conn_unfinished = NULL;
 	if (conn) {
-		conn->pending_sec_level = sec_level;
-		goto done;
+		if (conn->state == BT_CONNECT &&
+		    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+			BT_DBG("will coninue unfinished conn %pMR", dst);
+			conn_unfinished = conn;
+		} else {
+			conn->pending_sec_level = sec_level;
+			goto done;
+		}
 	}
 
 	/* Since the controller supports only one LE connection attempt at a
 	 * time, we return -EBUSY if there is any connection attempt running.
 	 */
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	conn = find_not_scanning_conn(hdev);
 	if (conn)
 		return ERR_PTR(-EBUSY);
 
@@ -767,10 +795,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * resolving key, the connection needs to be established
 	 * to a resolvable random address.
 	 *
-	 * This uses the cached random resolvable address from
-	 * a previous scan. When no cached address is available,
-	 * try connecting to the identity address instead.
-	 *
 	 * Storing the resolvable random address is required here
 	 * to handle connection failures. The address will later
 	 * be resolved back into the original identity address
@@ -782,15 +806,23 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		dst_type = ADDR_LE_DEV_RANDOM;
 	}
 
-	conn = hci_conn_add(hdev, LE_LINK, dst, role);
+	if (conn_unfinished) {
+		conn = conn_unfinished;
+		bacpy(&conn->dst, dst);
+	} else {
+		conn = hci_conn_add(hdev, LE_LINK, dst, role);
+	}
+
 	if (!conn)
 		return ERR_PTR(-ENOMEM);
 
 	conn->dst_type = dst_type;
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 
+	if (!conn_unfinished)
+		conn->pending_sec_level = sec_level;
+
 	hci_req_init(&req, hdev);
 
 	/* Disable advertising if we're active. For master role
@@ -855,7 +887,11 @@ create_conn:
 	}
 
 done:
-	hci_conn_hold(conn);
+	if (conn_unfinished)
+		hci_remove_from_explicit_connect(conn, true);
+	else
+		hci_conn_hold(conn);
+
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..09856aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4733,42 +4733,49 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					   addr, addr_type);
+	params = hci_pend_le_explicit_action_lookup(hdev, addr, addr_type);
+
 	if (!params)
 		return NULL;
 
-	switch (params->auto_connect) {
-	case HCI_AUTO_CONN_DIRECT:
-		/* Only devices advertising with ADV_DIRECT_IND are
-		 * triggering a connection attempt. This is allowing
-		 * incoming connections from slave devices.
-		 */
-		if (adv_type != LE_ADV_DIRECT_IND)
+	if (!params->explicit_connect) {
+		switch (params->auto_connect) {
+		case HCI_AUTO_CONN_DIRECT:
+			/* Only devices advertising with ADV_DIRECT_IND are
+			 * triggering a connection attempt. This is allowing
+			 * incoming connections from slave devices.
+			 */
+			if (adv_type != LE_ADV_DIRECT_IND)
+				return NULL;
+			break;
+		case HCI_AUTO_CONN_ALWAYS:
+			/* Devices advertising with ADV_IND or ADV_DIRECT_IND
+			 * are triggering a connection attempt. This means
+			 * that incoming connectioms from slave device are
+			 * accepted and also outgoing connections to slave
+			 * devices are established when found.
+			 */
+			break;
+		default:
 			return NULL;
-		break;
-	case HCI_AUTO_CONN_ALWAYS:
-		/* Devices advertising with ADV_IND or ADV_DIRECT_IND
-		 * are triggering a connection attempt. This means
-		 * that incoming connectioms from slave device are
-		 * accepted and also outgoing connections to slave
-		 * devices are established when found.
-		 */
-		break;
-	default:
-		return NULL;
+		}
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
 	if (!IS_ERR(conn)) {
-		/* Store the pointer since we don't really have any
+		/* If HCI_AUTO_CONN_EXPLICIT is set, conn is already owned
+		 * by higher layer that tried to connect, if no then
+		 * store the pointer since we don't really have any
 		 * other owner of the object besides the params that
 		 * triggered it. This way we can abort the connection if
 		 * the parameters get removed and keep the reference
 		 * count consistent once the connection is established.
 		 */
-		params->conn = hci_conn_get(conn);
+
+		if (!params->explicit_connect)
+			params->conn = hci_conn_get(conn);
+
 		return conn;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9a736b5..083bb81 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6107,6 +6107,12 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
+		/* If auto connect is being disabled when we're trying to
+		 * connect to device, keep connecting.
+		 */
+		if (params->explicit_connect)
+			list_add(&params->action, &hdev->pend_le_conns);
+
 		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-- 
2.1.4

