Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [RFC 7/8] Bluetooth: Introduce helpers for le conn status and complete
Date: Wed, 20 Dec 2017 11:44:36 +0530
Message-Id: <1513750477-8438-7-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1513750477-8438-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1513750477-8438-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is done so that the helpers can be used for extended conn
implementation which will be done in subsequent patch.

Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
---
 net/bluetooth/hci_event.c | 111 +++++++++++++++++++++++++++-------------------
 1 file changed, 66 insertions(+), 45 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f6d475e..5256e84 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1997,55 +1997,63 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	hci_dev_unlock(hdev);
 }
 
-static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
+static void cs_le_create_conn(struct hci_dev *hdev, bdaddr_t *peer_addr,
+			      u8 peer_addr_type, u8 own_address_type,
+			      u8 filter_policy)
 {
-	struct hci_cp_le_create_conn *cp;
 	struct hci_conn *conn;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, status);
-
-	/* All connection failure handling is taken care of by the
-	 * hci_le_conn_failed function which is triggered by the HCI
-	 * request completion callbacks used for connecting.
-	 */
-	if (status)
-		return;
-
-	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CONN);
-	if (!cp)
-		return;
-
-	hci_dev_lock(hdev);
-
-	conn = hci_conn_hash_lookup_le(hdev, &cp->peer_addr,
-				       cp->peer_addr_type);
+	conn = hci_conn_hash_lookup_le(hdev, peer_addr,
+				       peer_addr_type);
 	if (!conn)
-		goto unlock;
+		return;
 
 	/* Store the initiator and responder address information which
 	 * is needed for SMP. These values will not change during the
 	 * lifetime of the connection.
 	 */
-	conn->init_addr_type = cp->own_address_type;
-	if (cp->own_address_type == ADDR_LE_DEV_RANDOM)
+	conn->init_addr_type = own_address_type;
+	if (own_address_type == ADDR_LE_DEV_RANDOM)
 		bacpy(&conn->init_addr, &hdev->random_addr);
 	else
 		bacpy(&conn->init_addr, &hdev->bdaddr);
 
-	conn->resp_addr_type = cp->peer_addr_type;
-	bacpy(&conn->resp_addr, &cp->peer_addr);
+	conn->resp_addr_type = peer_addr_type;
+	bacpy(&conn->resp_addr, peer_addr);
 
 	/* We don't want the connection attempt to stick around
 	 * indefinitely since LE doesn't have a page timeout concept
 	 * like BR/EDR. Set a timer for any connection that doesn't use
 	 * the white list for connecting.
 	 */
-	if (cp->filter_policy == HCI_LE_USE_PEER_ADDR)
+	if (filter_policy == HCI_LE_USE_PEER_ADDR)
 		queue_delayed_work(conn->hdev->workqueue,
 				   &conn->le_conn_timeout,
 				   conn->conn_timeout);
+}
+
+static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
+{
+	struct hci_cp_le_create_conn *cp;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, status);
+
+	/* All connection failure handling is taken care of by the
+	 * hci_le_conn_failed function which is triggered by the HCI
+	 * request completion callbacks used for connecting.
+	 */
+	if (status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_CREATE_CONN);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	cs_le_create_conn(hdev, &cp->peer_addr, cp->peer_addr_type,
+			  cp->own_address_type, cp->filter_policy);
 
-unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -4572,16 +4580,16 @@ static void hci_disconn_phylink_complete_evt(struct hci_dev *hdev,
 }
 #endif
 
-static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
+				 bdaddr_t *bdaddr, u8 bdaddr_type, u8 role,
+				 u16 handle, u16 interval, u16 latency,
+				 u16 supervision_timeout)
 {
-	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
 	struct hci_conn_params *params;
 	struct hci_conn *conn;
 	struct smp_irk *irk;
 	u8 addr_type;
 
-	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
-
 	hci_dev_lock(hdev);
 
 	/* All controllers implicitly stop advertising in the event of a
@@ -4591,13 +4599,13 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_lookup_le_connect(hdev);
 	if (!conn) {
-		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr, ev->role);
+		conn = hci_conn_add(hdev, LE_LINK, bdaddr, role);
 		if (!conn) {
 			bt_dev_err(hdev, "no memory for new connection");
 			goto unlock;
 		}
 
-		conn->dst_type = ev->bdaddr_type;
+		conn->dst_type = bdaddr_type;
 
 		/* If we didn't have a hci_conn object previously
 		 * but we're in master role this must be something
@@ -4608,8 +4616,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		 * initiator address based on the HCI_PRIVACY flag.
 		 */
 		if (conn->out) {
-			conn->resp_addr_type = ev->bdaddr_type;
-			bacpy(&conn->resp_addr, &ev->bdaddr);
+			conn->resp_addr_type = bdaddr_type;
+			bacpy(&conn->resp_addr, bdaddr);
 			if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
 				conn->init_addr_type = ADDR_LE_DEV_RANDOM;
 				bacpy(&conn->init_addr, &hdev->rpa);
@@ -4633,8 +4641,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		else
 			bacpy(&conn->resp_addr, &hdev->bdaddr);
 
-		conn->init_addr_type = ev->bdaddr_type;
-		bacpy(&conn->init_addr, &ev->bdaddr);
+		conn->init_addr_type = bdaddr_type;
+		bacpy(&conn->init_addr, bdaddr);
 
 		/* For incoming connections, set the default minimum
 		 * and maximum connection interval. They will be used
@@ -4660,8 +4668,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		conn->dst_type = irk->addr_type;
 	}
 
-	if (ev->status) {
-		hci_le_conn_failed(conn, ev->status);
+	if (status) {
+		hci_le_conn_failed(conn, status);
 		goto unlock;
 	}
 
@@ -4680,17 +4688,17 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		mgmt_device_connected(hdev, conn, 0, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
-	conn->handle = __le16_to_cpu(ev->handle);
+	conn->handle = handle;
 	conn->state = BT_CONFIG;
 
-	conn->le_conn_interval = le16_to_cpu(ev->interval);
-	conn->le_conn_latency = le16_to_cpu(ev->latency);
-	conn->le_supv_timeout = le16_to_cpu(ev->supervision_timeout);
+	conn->le_conn_interval = interval;
+	conn->le_conn_latency = latency;
+	conn->le_supv_timeout = supervision_timeout;
 
 	hci_debugfs_create_conn(conn);
 	hci_conn_add_sysfs(conn);
 
-	if (!ev->status) {
+	if (!status) {
 		/* The remote features procedure is defined for master
 		 * role only. So only in case of an initiated connection
 		 * request the remote features.
@@ -4712,10 +4720,10 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			hci_conn_hold(conn);
 		} else {
 			conn->state = BT_CONNECTED;
-			hci_connect_cfm(conn, ev->status);
+			hci_connect_cfm(conn, status);
 		}
 	} else {
-		hci_connect_cfm(conn, ev->status);
+		hci_connect_cfm(conn, status);
 	}
 
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
@@ -4734,6 +4742,19 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_unlock(hdev);
 }
 
+static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
+
+	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
+
+	le_conn_complete_evt(hdev, ev->status, &ev->bdaddr, ev->bdaddr_type,
+			     ev->role, le16_to_cpu(ev->handle),
+			     le16_to_cpu(ev->interval),
+			     le16_to_cpu(ev->latency),
+			     le16_to_cpu(ev->supervision_timeout));
+}
+
 static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 					    struct sk_buff *skb)
 {
-- 
2.7.4

