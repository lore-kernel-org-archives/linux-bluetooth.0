Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: Fix connection to already paired device.
Date: Tue,  9 Jun 2015 13:38:07 -0700
Message-Id: <1433882287-14503-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch changes connection procedure behaviour for devices that
have IRK. Instead of directly calling "connect" with last known RPA,
it'll add device to kernel whitelist and start scan. If advertisement
is received, it'll be compared against whitelist and then trigger
connection if it matches.

auto_connect_for_connect field was added to hci_conn_params struct.
If it's set, params are marked for autoconnect because someone tried to
given address. When the connection is succesully estabilished, or after
timeout this params will be deleted, and device is removed from
autoconnect whitelist.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h | 27 +++++++++++++++++-
 net/bluetooth/hci_conn.c         | 61 +++++++++++++++++++++++++++-------------
 net/bluetooth/hci_event.c        | 16 +++++++++--
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/mgmt.c             | 22 +++++++++++----
 5 files changed, 98 insertions(+), 30 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3fbb793..bedc6be 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -504,6 +504,8 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_LINK_LOSS,
 	} auto_connect;
 
+	bool auto_connect_for_connect;
+
 	struct hci_conn *conn;
 };
 
@@ -820,7 +822,7 @@ struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role);
+				u8 role, bool fresh_dst_addr);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type);
 struct hci_conn *hci_connect_sco(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -875,12 +877,21 @@ static inline void hci_conn_hold(struct hci_conn *conn)
 	cancel_delayed_work(&conn->disc_work);
 }
 
+
+struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
+					       bdaddr_t *addr, u8 addr_type);
+void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+
+
 static inline void hci_conn_drop(struct hci_conn *conn)
 {
 	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
 
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		unsigned long timeo;
+		struct hci_conn_params *params =
+				hci_conn_params_lookup(conn->hdev, &conn->dst,
+								conn->dst_type);
 
 		switch (conn->type) {
 		case ACL_LINK:
@@ -904,6 +915,16 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 			break;
 		}
 
+		/* If the connection attempt was doing scan for new RPA, and is
+		 * still stuck in scann phase, then stop the scan.
+		 */
+		if (params && params->auto_connect_for_connect &&
+						conn->state == BT_OPEN) {
+			hci_conn_params_del(conn->hdev, &conn->dst,
+								conn->dst_type);
+			hci_conn_hash_del(conn->hdev, conn);
+		}
+
 		cancel_delayed_work(&conn->disc_work);
 		queue_delayed_work(conn->hdev->workqueue,
 				   &conn->disc_work, timeo);
@@ -976,6 +997,10 @@ struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type);
+
+struct hci_request;
+int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+			       u8 addr_type, u8 auto_connect, bool for_connect);
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..e670c91 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -612,21 +612,17 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 		hci_conn_put(params->conn);
 		params->conn = NULL;
 	}
-
 	conn->state = BT_CLOSED;
 
 	mgmt_connect_failed(hdev, &conn->dst, conn->type, conn->dst_type,
 			    status);
 
 	hci_connect_cfm(conn, status);
-
 	hci_conn_del(conn);
-
 	/* Since we may have temporarily stopped the background scanning in
 	 * favor of connection establishment, we should restart it.
 	 */
 	hci_update_background_scan(hdev);
-
 	/* Re-enable advertising in case this was a failed connection
 	 * attempt as a peripheral.
 	 */
@@ -725,14 +721,13 @@ static void hci_req_directed_advertising(struct hci_request *req,
 
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role)
+				u8 role, bool fresh_dst_addr)
 {
 	struct hci_conn_params *params;
-	struct hci_conn *conn;
+	struct hci_conn *conn, *conn_unfinished;
 	struct smp_irk *irk;
 	struct hci_request req;
 	int err;
-
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
@@ -740,7 +735,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 		return ERR_PTR(-EOPNOTSUPP);
 	}
-
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
@@ -751,9 +745,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	 * and return the object found.
 	 */
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	conn_unfinished = NULL;
 	if (conn) {
 		conn->pending_sec_level = sec_level;
-		goto done;
+		if (conn->state == BT_OPEN) {
+			BT_DBG("will coninue unfinished conn %pMR", dst);
+			conn_unfinished = conn;
+		} else {
+			goto done;
+		}
 	}
 
 	/* Since the controller supports only one LE connection attempt at a
@@ -765,24 +765,44 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 	/* When given an identity address with existing identity
 	 * resolving key, the connection needs to be established
-	 * to a resolvable random address.
+	 * to a Resolvable Private Address (RPA).
 	 *
-	 * This uses the cached random resolvable address from
-	 * a previous scan. When no cached address is available,
-	 * try connecting to the identity address instead.
+	 * If RPA is not fresh, start scan and try to find current
+	 * value before trying to connect. If advertisement with new
+	 * RPA is received, this method will be called again and
+	 * connection estabilishment will continue.
 	 *
-	 * Storing the resolvable random address is required here
-	 * to handle connection failures. The address will later
-	 * be resolved back into the original identity address
-	 * from the connect request.
+	 * Storing the RPA is required here to handle connection
+	 * failures. The address will later be resolved back into
+	 * the original identity address from the connect request.
 	 */
 	irk = hci_find_irk_by_addr(hdev, dst, dst_type);
-	if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
+	if (irk && !fresh_dst_addr) {
+		struct hci_request req;
+
+		BT_DBG("Requesting refresh of dst_addr.");
+		hci_req_init(&req, hdev);
+
+		if (hci_conn_params_set(&req, dst, dst_type,
+					HCI_AUTO_CONN_ALWAYS, true) < 0) {
+			return ERR_PTR(-EBUSY);
+		}
+
+		err = hci_req_run(&req, NULL);
+		if (err)
+			return ERR_PTR(err);
+	} else if (irk && bacmp(&irk->rpa, BDADDR_ANY)) {
 		dst = &irk->rpa;
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
 
@@ -791,6 +811,9 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 
+	if (irk && !fresh_dst_addr)
+		goto done;
+
 	hci_req_init(&req, hdev);
 
 	/* Disable advertising if we're active. For master role
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index fcbfa41..1300d4a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4674,15 +4674,25 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
-			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
+			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER, true);
 	if (!IS_ERR(conn)) {
-		/* Store the pointer since we don't really have any
+		/* If auto_connect_for_connect is set, conn is already
+		 * owned by socket that tried to connect, if no then
+		 * store the pointer since we don't really have any
 		 * other owner of the object besides the params that
 		 * triggered it. This way we can abort the connection if
 		 * the parameters get removed and keep the reference
 		 * count consistent once the connection is established.
 		 */
-		params->conn = hci_conn_get(conn);
+
+		if (params->auto_connect_for_connect) {
+			BT_DBG("removing %pMR params", addr);
+			/* Params were needed only to refresh the RPA.*/
+			hci_conn_params_del(hdev, addr, addr_type);
+		} else {
+			params->conn = hci_conn_get(conn);
+		}
+
 		return conn;
 	}
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 07bd316..3f2b2b2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7118,7 +7118,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 			role = HCI_ROLE_MASTER;
 
 		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT, role);
+				      HCI_LE_CONN_TIMEOUT, role, false);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a6f21f8..ff3e531 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3438,7 +3438,7 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
 				      sec_level, HCI_LE_CONN_TIMEOUT,
-				      HCI_ROLE_MASTER);
+				      HCI_ROLE_MASTER, false);
 	}
 
 	if (IS_ERR(conn)) {
@@ -5939,16 +5939,26 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
-			       u8 addr_type, u8 auto_connect)
+int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+			u8 addr_type, u8 auto_connect, bool for_connect)
 {
 	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *params;
+	bool is_new;
+
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (params)
+		is_new = true;
 
 	params = hci_conn_params_add(hdev, addr, addr_type);
 	if (!params)
 		return -EIO;
 
+	if (for_connect && (params->auto_connect_for_connect || is_new))
+		params->auto_connect_for_connect = true;
+	else
+		params->auto_connect_for_connect = false;
+
 	if (params->auto_connect == auto_connect)
 		return 0;
 
@@ -5974,8 +5984,8 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 
 	params->auto_connect = auto_connect;
 
-	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
-	       auto_connect);
+	BT_DBG("addr %pMR (type %u) auto_connect %u for_connect %d", addr,
+	       addr_type, auto_connect, params->auto_connect_for_connect);
 
 	return 0;
 }
@@ -6080,7 +6090,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	 * they will be created and configured with defaults.
 	 */
 	if (hci_conn_params_set(&req, &cp->addr.bdaddr, addr_type,
-				auto_conn) < 0) {
+				auto_conn, false) < 0) {
 		err = cmd->cmd_complete(cmd, MGMT_STATUS_FAILED);
 		mgmt_pending_remove(cmd);
 		goto unlock;
-- 
2.2.0.rc0.207.ga3a616c

