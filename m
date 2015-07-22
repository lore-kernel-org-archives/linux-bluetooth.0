Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 1/2] Bluetooth: Fix connection to already paired device.
Date: Wed, 22 Jul 2015 13:29:36 +0200
Message-Id: <1437564577-4207-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch adds infrastructure for future changes in connection
estabilishment procedure behaviour for all devices. Instead of just
sending HCI_OP_LE_CREATE_CONN to controller, "connect" will add device to
kernel whitelist and start scan. If advertisement is received, it'll be
compared against whitelist and then trigger connection if it matches.
That fixes mentioned reconnect issue for  already paired devices. It also
make whole connection procedure more robust. We can try to connect to
multiple devices at same time now, even though controller allow only one.

HCI_AUTO_CONN_JUST_ONCE value was added to hci_conn_params. It is used to
mark hci_conn_params that are to be used to connect to device only once,
and be removed after sending connect request.

New flag, HCI_CONN_SCANNING, is added to hci_conn flags. When it's set,
connect is scan phase. It gets cleared when advertisement is received, and
HCI_OP_LE_CREATE_CONN is sent.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  30 ++++++
 net/bluetooth/hci_conn.c         | 216 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_core.c         |  33 ++++++
 net/bluetooth/hci_event.c        |  62 +++++++----
 net/bluetooth/mgmt.c             |   6 ++
 5 files changed, 312 insertions(+), 35 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a6b091..b36e598 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -512,9 +512,11 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_DIRECT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
+		HCI_AUTO_CONN_SOCK,
 	} auto_connect;
 
 	struct hci_conn *conn;
+	bool is_sock_conn;
 };
 
 extern struct list_head hci_dev_list;
@@ -639,6 +641,7 @@ enum {
 	HCI_CONN_DROP,
 	HCI_CONN_PARAM_REMOVAL_PEND,
 	HCI_CONN_NEW_LINK_KEY,
+	HCI_CONN_SCANNING,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
@@ -808,6 +811,27 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_state_no_flag(
+			struct hci_dev *hdev, __u8 type, __u16 state, int flag)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->state == state &&
+		    !test_bit(flag, &c->flags)) {
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
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
@@ -823,6 +847,10 @@ void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
+struct hci_conn *hci_add_to_sock_conn_whitelist(struct hci_dev *hdev,
+				bdaddr_t *dst, u8 dst_type, u8 sec_level,
+				u16 conn_timeout, u8 role);
+void hci_remove_from_sock_conn_whitelist(struct hci_conn *conn);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role);
@@ -988,6 +1016,8 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
+struct hci_conn_params *hci_pend_le_sock_action_lookup(struct hci_dev *hdev,
+						  bdaddr_t *addr, u8 addr_type);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..113ff5c 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -340,8 +340,12 @@ static void hci_conn_timeout(struct work_struct *work)
 		if (conn->out) {
 			if (conn->type == ACL_LINK)
 				hci_acl_create_connection_cancel(conn);
-			else if (conn->type == LE_LINK)
-				hci_le_create_connection_cancel(conn);
+			else if (conn->type == LE_LINK) {
+				if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+					hci_remove_from_sock_conn_whitelist(conn);
+				else
+					hci_le_create_connection_cancel(conn);
+			}
 		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
 			hci_reject_sco(conn);
 		}
@@ -685,6 +689,7 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 
 	conn->state = BT_CONNECT;
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 }
 
 static void hci_req_directed_advertising(struct hci_request *req,
@@ -723,13 +728,114 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
-struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
-				u8 dst_type, u8 sec_level, u16 conn_timeout,
-				u8 role)
+/* This function requires the caller holds hdev->lock */
+void hci_remove_from_sock_conn_whitelist(struct hci_conn *conn)
+{
+	struct hci_request req;
+	struct hci_conn_params *params = hci_pend_le_sock_action_lookup(
+						conn->hdev, &conn->dst,
+						conn->dst_type);
+	if (!params)
+		return;
+
+	/* The connection attempt was doing scan for new RPA, and is still
+	 * stuck in scan phase. If params are not associated with any other
+	 * autoconnect action, remove them completely. If they are, just unmark
+	 * them as awaiting for connection, by clearing is_sock_conn field.
+	 */
+	if (params->auto_connect == HCI_AUTO_CONN_SOCK)
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+	else
+		params->is_sock_conn = false;
+
+	/* If we're still in scan phase, remove hash. */
+	if (conn->state == BT_CONNECT &&
+	    test_bit(HCI_CONN_SCANNING, &conn->flags))
+		hci_conn_hash_del(conn->hdev, conn);
+
+	hci_req_init(&req, conn->hdev);
+	__hci_update_background_scan(&req);
+	hci_req_run(&req, NULL);
+}
+
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 {
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
+static void add_to_whitelist_complete(struct hci_dev *hdev, u8 status,
+				      u16 opcode)
+{
+	struct hci_conn *conn;
+
+	if (status == 0)
+		return;
+
+	BT_ERR("Failed to add device to socket conn whitelist: status 0x%2.2x",
+	       status);
+
+	hci_dev_lock(hdev);
+
+	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	if (!conn)
+		goto done;
+
+	hci_le_conn_failed(conn, status);
+
+done:
+	hci_dev_unlock(hdev);
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_onetime_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+				u8 addr_type)
+{
+	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *params;
+
+	if (is_connected(hdev, addr, addr_type))
+		return -EISCONN;
+
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return -EIO;
+
+	/* If we created new params, or exiting params were marked as disabled,
+	 * mark them to be used just once to connect.
+	 */
+	if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
+		params->auto_connect = HCI_AUTO_CONN_SOCK;
+		list_del_init(&params->action);
+		list_add(&params->action, &hdev->pend_le_conns);
+	}
+
+	params->is_sock_conn = true;
+	__hci_update_background_scan(req);
+
+	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
+	       params->auto_connect);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+struct hci_conn *hci_add_to_sock_conn_whitelist(struct hci_dev *hdev,
+						bdaddr_t *dst, u8 dst_type,
+						u8 sec_level, u16 conn_timeout,
+						u8 role) {
 	struct hci_conn *conn;
-	struct smp_irk *irk;
 	struct hci_request req;
 	int err;
 
@@ -756,6 +862,8 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		goto done;
 	}
 
+	BT_DBG("requesting refresh of dst_addr.");
+
 	/* Since the controller supports only one LE connection attempt at a
 	 * time, we return -EBUSY if there is any connection attempt running.
 	 */
@@ -763,14 +871,86 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	if (conn)
 		return ERR_PTR(-EBUSY);
 
+	conn = hci_conn_add(hdev, LE_LINK, dst, role);
+	if (!conn)
+		return ERR_PTR(-ENOMEM);
+
+	hci_req_init(&req, hdev);
+
+	if (hci_onetime_conn_params_set(&req, dst, dst_type) < 0)
+		return ERR_PTR(-EBUSY);
+
+	conn->state = BT_CONNECT;
+	set_bit(HCI_CONN_SCANNING, &conn->flags);
+
+	err = hci_req_run(&req, add_to_whitelist_complete);
+	if (err && err != -ENODATA) {
+		hci_conn_del(conn);
+		return ERR_PTR(err);
+	}
+
+	conn->dst_type = dst_type;
+	conn->sec_level = BT_SECURITY_LOW;
+	conn->pending_sec_level = sec_level;
+	conn->conn_timeout = conn_timeout;
+
+done:
+	hci_conn_hold(conn);
+	return conn;
+}
+
+struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
+				u8 dst_type, u8 sec_level, u16 conn_timeout,
+				u8 role)
+{
+	struct hci_conn_params *params;
+	struct hci_conn *conn, *conn_unfinished;
+	struct smp_irk *irk;
+	struct hci_request req;
+	int err;
+
+	/* Let's make sure that le is enabled.*/
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
+		if (lmp_le_capable(hdev))
+			return ERR_PTR(-ECONNREFUSED);
+
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+
+	/* Some devices send ATT messages as soon as the physical link is
+	 * established. To be able to handle these ATT messages, the user-
+	 * space first establishes the connection and then starts the pairing
+	 * process.
+	 *
+	 * So if a hci_conn object already exists for the following connection
+	 * attempt, we simply update pending_sec_level and auth_type fields
+	 * and return the object found.
+	 */
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
+	conn_unfinished = NULL;
+	if (conn) {
+		if (conn->state == BT_CONNECT &&
+		    test_bit(HCI_CONN_SCANNING, &conn->flags)) {
+			BT_DBG("will coninue unfinished conn %pMR", dst);
+			conn_unfinished = conn;
+		} else {
+			conn->pending_sec_level = sec_level;
+			goto done;
+		}
+	}
+
+	/* Since the controller supports only one LE connection attempt at a
+	 * time, we return -EBUSY if there is any connection attempt running.
+	 */
+	conn = hci_conn_hash_lookup_state_no_flag(hdev, LE_LINK, BT_CONNECT,
+						  HCI_CONN_SCANNING);
+	if (conn)
+		return ERR_PTR(-EBUSY);
+
 	/* When given an identity address with existing identity
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
@@ -782,15 +962,23 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -855,7 +1043,9 @@ create_conn:
 	}
 
 done:
-	hci_conn_hold(conn);
+	if (!conn_unfinished)
+		hci_conn_hold(conn);
+
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc43b64..8f7902b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2848,6 +2848,30 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 }
 
 /* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_pend_le_sock_action_lookup(struct hci_dev *hdev,
+						       bdaddr_t *addr,
+						       u8 addr_type)
+{
+	struct hci_conn_params *param;
+
+	list_for_each_entry(param, &hdev->pend_le_conns, action) {
+		if (bacmp(&param->addr, addr) == 0 &&
+		    param->addr_type == addr_type &&
+		    param->is_sock_conn)
+			return param;
+	}
+
+	list_for_each_entry(param, &hdev->pend_le_reports, action) {
+		if (bacmp(&param->addr, addr) == 0 &&
+		    param->addr_type == addr_type &&
+		    param->is_sock_conn)
+			return param;
+	}
+
+	return NULL;
+}
+
+/* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 					    bdaddr_t *addr, u8 addr_type)
 {
@@ -2916,6 +2940,15 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
 		if (params->auto_connect != HCI_AUTO_CONN_DISABLED)
 			continue;
+
+		/* If trying to estabilish one time connection to disabled
+		 * device, leave the params, but mark them as just once.
+		 */
+		if (params->is_sock_conn) {
+			params->auto_connect = HCI_AUTO_CONN_SOCK;
+			continue;
+		}
+
 		list_del(&params->list);
 		kfree(params);
 	}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..faae24e 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4715,6 +4715,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
+	bool only_connect;
 
 	/* If the event is not connectable don't proceed further */
 	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
@@ -4733,42 +4734,59 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					   addr, addr_type);
+	params = hci_pend_le_sock_action_lookup(hdev, addr, addr_type);
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
+	only_connect = params->is_sock_conn &&
+		       (params->auto_connect == HCI_AUTO_CONN_SOCK);
+
+	if (!only_connect) {
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
+		/* If only_connect is set, conn is already
+		 * owned by socket that tried to connect, if no then
+		 * store the pointer since we don't really have any
 		 * other owner of the object besides the params that
 		 * triggered it. This way we can abort the connection if
 		 * the parameters get removed and keep the reference
 		 * count consistent once the connection is established.
 		 */
-		params->conn = hci_conn_get(conn);
+
+		if (only_connect) {
+			list_del_init(&params->action);
+
+			/* Params were needed only to refresh the RPA.*/
+			if (params->auto_connect == HCI_AUTO_CONN_SOCK)
+				hci_conn_params_del(hdev, addr, addr_type);
+		} else {
+			params->conn = hci_conn_get(conn);
+		}
+
 		return conn;
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ab1915..ce403ff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6107,6 +6107,12 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 	switch (auto_connect) {
 	case HCI_AUTO_CONN_DISABLED:
 	case HCI_AUTO_CONN_LINK_LOSS:
+		/* If auto connect is being disabled when we're trying to
+		 * connect to device, keep connecting.
+		 */
+		if (params->is_sock_conn)
+			list_add(&params->action, &hdev->pend_le_conns);
+
 		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-- 
2.1.4

