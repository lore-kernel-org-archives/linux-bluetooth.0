Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1 2/2] Bluetooth: Fix connection to already paired device.
Date: Wed, 24 Jun 2015 16:34:10 -0700
Message-Id: <1435188850-14969-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
References: <1435188850-14969-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently, when trying to connect to already paired device that just
rotated its RPA MAC address, old address would be used and connection
would fail. In order to fix that, kernel must scan and receive
advertisement with fresh RPA before connecting.

This patch changes connection procedure behaviour for all devices.
Instead of just sending HCI_OP_LE_CREATE_CONN to controller, "connect"
will add device to kernel whitelist and start scan. If advertisement is
received, it'll be compared against whitelist and then trigger connection
if it matches. That fixes mentioned reconnect issue for  already paired
devices. It also make whole connection procedure more robust. We can try
to connect to multiple devices at same time now, even though controller
allow only one.

pend_le_conn_reqs field was added to hci_dev struct. It is list of all
devices that we try to connect to. When the connection is succesully
estabilished, or after timeout params will be removed from this list or
deleted, i.e. if params structure is not used for autoconnect.

HCI_AUTO_CONN_JUST_ONCE value was added to hci_conn_params. It is used to
mark hci_conn_params that are to be used to connect to device only once,
and be removed after sending connect request.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h |  11 ++++
 net/bluetooth/hci_conn.c         | 139 ++++++++++++++++++++++++++++++++++++---
 net/bluetooth/hci_core.c         |  30 +++++++++
 net/bluetooth/hci_event.c        |  70 +++++++++++++-------
 net/bluetooth/hci_request.c      |  32 ++++++++-
 net/bluetooth/l2cap_core.c       |   5 +-
 net/bluetooth/mgmt.c             |   7 +-
 7 files changed, 255 insertions(+), 39 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 3bd618d..95d78ad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -357,6 +357,7 @@ struct hci_dev {
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 	struct list_head	pend_le_reports;
+	struct list_head	pend_le_conn_reqs;
 
 	struct hci_dev_stats	stat;
 
@@ -497,6 +498,7 @@ struct hci_chan {
 struct hci_conn_params {
 	struct list_head list;
 	struct list_head action;
+	struct list_head conn_action;
 
 	bdaddr_t addr;
 	u8 addr_type;
@@ -512,6 +514,7 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_DIRECT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
+		HCI_AUTO_CONN_JUST_ONCE,
 	} auto_connect;
 
 	struct hci_conn *conn;
@@ -823,6 +826,10 @@ void hci_chan_del(struct hci_chan *chan);
 void hci_chan_list_flush(struct hci_conn *conn);
 struct hci_chan *hci_chan_lookup_handle(struct hci_dev *hdev, __u16 handle);
 
+struct hci_conn *hci_add_to_connect_whitelist(struct hci_dev *hdev,
+				bdaddr_t *dst, u8 dst_type, u8 sec_level,
+				u16 conn_timeout, u8 role);
+void hci_remove_from_conect_whitelist(struct hci_conn *conn);
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, u8 sec_level, u16 conn_timeout,
 				u8 role);
@@ -909,6 +916,8 @@ static inline void hci_conn_drop(struct hci_conn *conn)
 			break;
 		}
 
+		hci_remove_from_conect_whitelist(conn);
+
 		cancel_delayed_work(&conn->disc_work);
 		queue_delayed_work(conn->hdev->workqueue,
 				   &conn->disc_work, timeo);
@@ -988,6 +997,8 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 						  bdaddr_t *addr,
 						  u8 addr_type);
+struct hci_conn_params *hci_pend_le_conn_action_lookup(struct list_head *list,
+						  bdaddr_t *addr, u8 addr_type);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..d86b64f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -723,16 +723,130 @@ static void hci_req_directed_advertising(struct hci_request *req,
 	conn->state = BT_CONNECT;
 }
 
+void hci_remove_from_conect_whitelist(struct hci_conn *conn)
+{
+	struct hci_conn_params *params = hci_pend_le_conn_action_lookup(
+						&conn->hdev->pend_le_conn_reqs,
+						&conn->dst, conn->dst_type);
+	if (!params)
+		return;
+
+	/* The connection attempt was doing scan for new RPA, and is still
+	 * stuck in scan phase. If params are not associated with any other
+	 * autoconnect action, remove them completely. If they are, just unmark
+	 * them as awaiting for connection, by clearing conn_action field.
+	 */
+	if (params->auto_connect == HCI_AUTO_CONN_JUST_ONCE)
+		hci_conn_params_del(conn->hdev, &conn->dst, conn->dst_type);
+	else
+		list_del_init(&params->conn_action);
+
+	/* if connection didn't really happened, remove hash. */
+	if (conn->state == BT_OPEN)
+		hci_conn_hash_del(conn->hdev, conn);
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
+		params->auto_connect = HCI_AUTO_CONN_JUST_ONCE;
+
+	list_del_init(&params->conn_action);
+	list_add(&params->conn_action, &hdev->pend_le_conn_reqs);
+	__hci_update_background_scan(req);
+
+	BT_INFO("addr %pMR (type %u) auto_connect %u", addr, addr_type,
+		params->auto_connect);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+struct hci_conn *hci_add_to_connect_whitelist(struct hci_dev *hdev,
+					      bdaddr_t *dst, u8 dst_type,
+					      u8 sec_level, u16 conn_timeout,
+					      u8 role) {
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
-
 	/* Let's make sure that le is enabled.*/
 	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
 		if (lmp_le_capable(hdev))
@@ -740,7 +854,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 
 		return ERR_PTR(-EOPNOTSUPP);
 	}
-
 	/* Some devices send ATT messages as soon as the physical link is
 	 * established. To be able to handle these ATT messages, the user-
 	 * space first establishes the connection and then starts the pairing
@@ -751,9 +864,15 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -767,10 +886,6 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
@@ -782,7 +897,13 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bc43b64..4b21085 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2848,6 +2848,22 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 }
 
 /* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_pend_le_conn_action_lookup(struct list_head *list,
+						       bdaddr_t *addr,
+						       u8 addr_type)
+{
+	struct hci_conn_params *param;
+
+	list_for_each_entry(param, list, conn_action) {
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
+	INIT_LIST_HEAD(&params->conn_action);
 
 	params->conn_min_interval = hdev->le_conn_min_interval;
 	params->conn_max_interval = hdev->le_conn_max_interval;
@@ -2888,6 +2905,7 @@ static void hci_conn_params_free(struct hci_conn_params *params)
 	}
 
 	list_del(&params->action);
+	list_del(&params->conn_action);
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
+		if (hci_pend_le_conn_action_lookup(&hdev->pend_le_conn_reqs,
+						   &params->addr,
+						   params->addr_type)) {
+			params->auto_connect = HCI_AUTO_CONN_JUST_ONCE;
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
+	INIT_LIST_HEAD(&hdev->pend_le_conn_reqs);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 	INIT_LIST_HEAD(&hdev->adv_instances);
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..9c2bf60 100644
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
+	 * our pend_le_conns or pend_le_conn_reqs list.
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
+		params = hci_pend_le_conn_action_lookup(
+						      &hdev->pend_le_conn_reqs,
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
+			list_del_init(&params->conn_action);
+
+			/* Params were needed only to refresh the RPA.*/
+			if (params->auto_connect == HCI_AUTO_CONN_JUST_ONCE)
+				hci_conn_params_del(hdev, addr, addr_type);
+		} else {
+			params->conn = hci_conn_get(conn);
+		}
+
 		return conn;
 	}
 
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d6025d6..e8616be 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -180,7 +180,10 @@ static u8 update_white_list(struct hci_request *req)
 		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
 					      &b->bdaddr, b->bdaddr_type) ||
 		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					      &b->bdaddr, b->bdaddr_type)) {
+					      &b->bdaddr, b->bdaddr_type) ||
+		    hci_pend_le_conn_action_lookup(&hdev->pend_le_conn_reqs,
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
+	list_for_each_entry(params, &hdev->pend_le_conn_reqs, conn_action) {
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
+	    list_empty(&hdev->pend_le_conn_reqs)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
 		 * scanning.
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 51594fb..3219654 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -7113,8 +7113,9 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		else
 			role = HCI_ROLE_MASTER;
 
-		hcon = hci_connect_le(hdev, dst, dst_type, chan->sec_level,
-				      HCI_LE_CONN_TIMEOUT, role);
+		hcon = hci_add_to_connect_whitelist(hdev, dst, dst_type,
+						    chan->sec_level,
+						    HCI_LE_CONN_TIMEOUT, role);
 	} else {
 		u8 auth_type = l2cap_get_auth_type(chan);
 		hcon = hci_connect_acl(hdev, dst, chan->sec_level, auth_type);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a7d1b33..e300b05 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3564,9 +3564,10 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 		 */
 		hci_conn_params_add(hdev, &cp->addr.bdaddr, addr_type);
 
-		conn = hci_connect_le(hdev, &cp->addr.bdaddr, addr_type,
-				      sec_level, HCI_LE_CONN_TIMEOUT,
-				      HCI_ROLE_MASTER);
+		conn = hci_add_to_connect_whitelist(hdev, &cp->addr.bdaddr,
+						    addr_type, sec_level,
+						    HCI_LE_CONN_TIMEOUT,
+						    HCI_ROLE_MASTER);
 	}
 
 	if (IS_ERR(conn)) {
-- 
2.4.3.573.g4eafbef

