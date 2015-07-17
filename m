Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 3/4] Bluetooth: Fix connection to already paired device.
Date: Fri, 17 Jul 2015 22:51:08 +0200
Message-Id: <1437166269-14588-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1437166269-14588-1-git-send-email-jpawlowski@google.com>
References: <1437166269-14588-1-git-send-email-jpawlowski@google.com>
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

pend_le_sock_conn field was added to hci_dev struct. It is list of all
devices that we try to connect to. When the connection is succesully
estabilished, or after timeout params will be removed from this list or
deleted, i.e. if params structure is not used for autoconnect.

HCI_AUTO_CONN_JUST_ONCE value was added to hci_conn_params. It is used to
mark hci_conn_params that are to be used to connect to device only once,
and be removed after sending connect request.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  13 ++++
 net/bluetooth/hci_conn.c         | 147 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_core.c         |  30 ++++++++
 net/bluetooth/hci_event.c        |  70 +++++++++++++------
 net/bluetooth/hci_request.c      |  32 ++++++++-
 5 files changed, 259 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2a6b091..c9b1011 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -357,6 +357,7 @@ struct hci_dev {
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
+	struct list_head	pend_le_sock_conn;
 
 	struct hci_dev_stats	stat;
 
@@ -497,6 +498,7 @@ struct hci_chan {
 struct hci_conn_params {
 	struct list_head list;
 	struct list_head action;
+	struct list_head sock_action;
 
 	bdaddr_t addr;
 	u8 addr_type;
@@ -512,6 +514,7 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_DIRECT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
+		HCI_AUTO_CONN_SOCK,
 	} auto_connect;
 
 	struct hci_conn *conn;
@@ -823,6 +826,10 @@ void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
+struct hci_conn *hci_add_to_sock_conn_whitelist(struct hci_dev *hdev,
+				bdaddr_t *dst, u8 dst_type, u8 sec_level,
+				u16 conn_timeout, u8 role);
+void hci_remove_from_sock_conn_whitelist(struct hci_conn *conn);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role);
@@ -898,6 +905,10 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 			} else {
 				timeo = 0;
 			}
+
+			if (conn->state == BT_OPEN)
+				hci_remove_from_sock_conn_whitelist(conn);
+
 			break;
 
 		case AMP_LINK:
@@ -988,6 +999,8 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
+struct hci_conn_params *hci_pend_le_sock_action_lookup(struct list_head *list,
+						  bdaddr_t *addr, u8 addr_type);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..58c8c95 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -723,12 +723,133 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
+/* This function requires the caller holds hdev->lock */
+void hci_remove_from_sock_conn_whitelist(struct hci_conn *conn)
+{
+	struct hci_request req;
+	struct hci_conn_params *params = hci_pend_le_sock_action_lookup(
+						&conn->hdev->pend_le_sock_conn,
+						&conn->dst, conn->dst_type);
+	if (!params)
+		return;
+
+	/* The connection attempt was doing scan for new RPA, and is still
+	 * stuck in scan phase. If params are not associated with any other
+	 * autoconnect action, remove them completely. If they are, just unmark
+	 * them as awaiting for connection, by clearing sock_action field.
+	 */
+	if (params->auto_connect == HCI_AUTO_CONN_SOCK)
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+	else
+		list_del_init(&params->sock_action);
+
+	/* if connection didn't really happened, remove hash. */
+	if (conn->state == BT_OPEN)
+		hci_conn_hash_del(conn->hdev, conn);
+
+	hci_req_init(&req, conn->hdev);
+	__hci_update_background_scan(&req);
+	hci_req_run(&req, NULL);
+}
+
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
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
+/* This function requires the caller holds hdev->lock */
+int hci_onetime_conn_params_set(struct hci_request *req, bdaddr_t *addr,
+				u8 addr_type)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn_params *params;
+	bool is_new;
+
+	if (is_connected(hdev, addr, addr_type))
+		return -EISCONN;
+
+	is_new = false;
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (params)
+		is_new = true;
+
+	params = hci_conn_params_add(hdev, addr, addr_type);
+	if (!params)
+		return -EIO;
+
+	/* if we created new params, mark them to be used just once to connect
+	 */
+	if (is_new)
+		params->auto_connect = HCI_AUTO_CONN_SOCK;
+
+	list_del_init(&params->sock_action);
+	list_add(&params->sock_action, &hdev->pend_le_sock_conn);
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
+	struct hci_conn *conn;
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
+	conn = hci_conn_add(hdev, LE_LINK, dst, role);
+	if (!conn)
+		return ERR_PTR(-ENOMEM);
+
+	BT_DBG("requesting refresh of dst_addr.");
+	hci_req_init(&req, hdev);
+
+	if (hci_onetime_conn_params_set(&req, dst, dst_type) < 0)
+		return ERR_PTR(-EBUSY);
+
+	err = hci_req_run(&req, NULL);
+	if (err)
+		return ERR_PTR(err);
+
+	conn->dst_type = dst_type;
+	conn->sec_level = BT_SECURITY_LOW;
+	conn->pending_sec_level = sec_level;
+	conn->conn_timeout = conn_timeout;
+
+	hci_conn_hold(conn);
+	return conn;
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
@@ -751,9 +872,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -767,10 +894,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -782,7 +905,13 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
 
@@ -855,7 +984,9 @@ create_conn:
 	}
 
 done:
-	hci_conn_hold(conn);
+	if (!conn_unfinished)
+		hci_conn_hold(conn);
+
 	return conn;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc43b64..d2a8d85 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2848,6 +2848,22 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 }
 
 /* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_pend_le_sock_action_lookup(struct list_head *list,
+						       bdaddr_t *addr,
+						       u8 addr_type)
+{
+	struct hci_conn_params *param;
+
+	list_for_each_entry(param, list, sock_action) {
+		if (bacmp(&param->addr, addr) == 0 &&
+		    param->addr_type == addr_type)
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
@@ -2868,6 +2884,7 @@ struct hci_conn_params *hci_conn_params_add(struct hci_dev *hdev,
 
 	list_add(&params->list, &hdev->le_conn_params);
 	INIT_LIST_HEAD(&params->action);
+	INIT_LIST_HEAD(&params->sock_action);
 
 	params->conn_min_interval = hdev->le_conn_min_interval;
 	params->conn_max_interval = hdev->le_conn_max_interval;
@@ -2888,6 +2905,7 @@ static void hci_conn_params_free(struct hci_conn_params *params)
 	}
 
 	list_del(&params->action);
+	list_del(&params->sock_action);
 	list_del(&params->list);
 	kfree(params);
 }
@@ -2916,6 +2934,17 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
 		if (params->auto_connect != HCI_AUTO_CONN_DISABLED)
 			continue;
+
+		/* If trying to estabilish one time connection to disabled
+		 * device, leave the params, but mark them as just once.
+		 */
+		if (hci_pend_le_sock_action_lookup(&hdev->pend_le_sock_conn,
+						   &params->addr,
+						   params->addr_type)) {
+			params->auto_connect = HCI_AUTO_CONN_SOCK;
+			continue;
+		}
+
 		list_del(&params->list);
 		kfree(params);
 	}
@@ -3187,6 +3216,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->pend_le_conns);
 	INIT_LIST_HEAD(&hdev->pend_le_reports);
+	INIT_LIST_HEAD(&hdev->pend_le_sock_conn);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..4e754ed 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4715,6 +4715,7 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
+	bool only_connect;
 
 	/* If the event is not connectable don't proceed further */
 	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
@@ -4731,44 +4732,67 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 		return NULL;
 
 	/* If we're not connectable only connect devices that we have in
-	 * our pend_le_conns list.
+	 * our pend_le_conns or pend_le_sock_conn list.
 	 */
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 					   addr, addr_type);
-	if (!params)
-		return NULL;
 
-	switch (params->auto_connect) {
-	case HCI_AUTO_CONN_DIRECT:
-		/* Only devices advertising with ADV_DIRECT_IND are
-		 * triggering a connection attempt. This is allowing
-		 * incoming connections from slave devices.
-		 */
-		if (adv_type != LE_ADV_DIRECT_IND)
+	only_connect = false;
+	if (!params) {
+		params = hci_pend_le_sock_action_lookup(
+						      &hdev->pend_le_sock_conn,
+						      addr, addr_type);
+		if (!params)
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
+
+		only_connect = true;
+	}
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
+			return NULL;
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
+			list_del_init(&params->sock_action);
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
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d6025d6..8a988de 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -180,7 +180,10 @@ static u8 update_white_list(struct hci_request *req)
 		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
 					      &b->bdaddr, b->bdaddr_type) ||
 		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					      &b->bdaddr, b->bdaddr_type)) {
+					      &b->bdaddr, b->bdaddr_type) ||
+		    hci_pend_le_sock_action_lookup(&hdev->pend_le_sock_conn,
+						   &b->bdaddr,
+						   b->bdaddr_type)) {
 			white_list_entries++;
 			continue;
 		}
@@ -246,6 +249,30 @@ static u8 update_white_list(struct hci_request *req)
 		add_to_white_list(req, params);
 	}
 
+	/* After adding all new pending connections, and pending reports walk
+	 * through the list of connection requests and also add these to the
+	 * white list if there is still space.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_sock_conn, sock_action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (white_list_entries >= hdev->le_white_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		if (hci_find_irk_by_addr(hdev, &params->addr,
+					 params->addr_type)) {
+			/* White list can not be used with RPAs */
+			return 0x00;
+		}
+
+		white_list_entries++;
+		add_to_white_list(req, params);
+	}
+
 	/* Select filter policy to use white list */
 	return 0x01;
 }
@@ -507,7 +534,8 @@ void __hci_update_background_scan(struct hci_request *req)
 	hci_discovery_filter_clear(hdev);
 
 	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports)) {
+	    list_empty(&hdev->pend_le_reports) &&
+	    list_empty(&hdev->pend_le_sock_conn)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
 		 * scanning.
-- 
2.1.4

