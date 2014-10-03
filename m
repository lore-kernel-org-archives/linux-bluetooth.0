Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Include ADV_IND report in Device Connected event
Date: Fri,  3 Oct 2014 08:34:53 +0000
Message-Id: <1412325293-6651-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There are scenarios when autoconnecting to a device after the
reception of an ADV_IND report (action 0x02), in which userland
might want to examine the report's contents.

For instance, the Service Data might have changed and it would be
useful to know ahead of time before starting any GATT procedures.
Also, the ADV_IND may contain Manufacturer Specific data which would
be lost if not propagated to userland. In fact, this patch results
from the need to rebond with a device lacking persistent storage which
notifies about losing its LTK in ADV_IND reports.

This patch appends the ADV_IND report which triggered the
autoconnection to the EIR Data in the Device Connected event.

Signed-off-by: Alfonso Acosta <fons@spotify.com>
---
 include/net/bluetooth/hci_core.h |  4 ++-
 net/bluetooth/hci_event.c        | 64 +++++++++++++++++++++++++++++-----------
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/mgmt.c             |  5 +++-
 4 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 37ff1ae..618c82d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -398,6 +398,8 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u8		le_pend_adv_data[HCI_MAX_AD_LENGTH];
+	__u8		le_pend_adv_len;
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
@@ -1312,7 +1314,7 @@ void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			   u8 *dev_class);
+			   u8 *dev_class, u8 *adv, u8 adv_len);
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b0a2a6..9a58d03 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1576,9 +1576,13 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
-	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00, 0, name,
-				      name_len, conn->dev_class);
+				      name_len, conn->dev_class,
+				      conn->le_pend_adv_data,
+				      conn->le_pend_adv_len);
+		conn->le_pend_adv_len = 0;
+	}
 
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
@@ -2535,10 +2539,14 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, &conn->dst, conn->type,
 				      conn->dst_type, 0, NULL, 0,
-				      conn->dev_class);
+				      conn->dev_class,
+				      conn->le_pend_adv_data,
+				      conn->le_pend_adv_len);
+		conn->le_pend_adv_len = 0;
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3433,10 +3441,14 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, &conn->dst, conn->type,
 				      conn->dst_type, 0, NULL, 0,
-				      conn->dev_class);
+				      conn->dev_class,
+				      conn->le_pend_adv_data,
+				      conn->le_pend_adv_len);
+		conn->le_pend_adv_len = 0;
+	}
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -4213,9 +4225,13 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		goto unlock;
 	}
 
-	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_connected(hdev, &conn->dst, conn->type,
-				      conn->dst_type, 0, NULL, 0, NULL);
+				      conn->dst_type, 0, NULL, 0, NULL,
+				      conn->le_pend_adv_data,
+				      conn->le_pend_adv_len);
+		conn->le_pend_adv_len = 0;
+	}
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
@@ -4269,25 +4285,26 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
 }
 
 /* This function requires the caller holds hdev->lock */
-static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
-				  u8 addr_type, u8 adv_type)
+static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
+					      bdaddr_t *addr,
+					      u8 addr_type, u8 adv_type)
 {
 	struct hci_conn *conn;
 	struct hci_conn_params *params;
 
 	/* If the event is not connectable don't proceed further */
 	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
-		return;
+		return NULL;
 
 	/* Ignore if the device is blocked */
 	if (hci_bdaddr_list_lookup(&hdev->blacklist, addr, addr_type))
-		return;
+		return NULL;
 
 	/* Most controller will fail if we try to create new connections
 	 * while we have an existing one in slave role.
 	 */
 	if (hdev->conn_hash.le_num_slave > 0)
-		return;
+		return NULL;
 
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
@@ -4295,7 +4312,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 					   addr, addr_type);
 	if (!params)
-		return;
+		return NULL;
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_DIRECT:
@@ -4304,7 +4321,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 * incoming connections from slave devices.
 		 */
 		if (adv_type != LE_ADV_DIRECT_IND)
-			return;
+			return NULL;
 		break;
 	case HCI_AUTO_CONN_ALWAYS:
 		/* Devices advertising with ADV_IND or ADV_DIRECT_IND
@@ -4315,7 +4332,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 */
 		break;
 	default:
-		return;
+		return NULL;
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
@@ -4328,7 +4345,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 * count consistent once the connection is established.
 		 */
 		params->conn = hci_conn_get(conn);
-		return;
+		return conn;
 	}
 
 	switch (PTR_ERR(conn)) {
@@ -4341,7 +4358,10 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		break;
 	default:
 		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
+		return NULL;
 	}
+
+	return conn;
 }
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
@@ -4351,6 +4371,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	struct smp_irk *irk;
 	bool match;
 	u32 flags;
+	struct hci_conn *conn;
 
 	/* Check if we need to convert to identity address */
 	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
@@ -4360,7 +4381,14 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	}
 
 	/* Check if we have been requested to connect to this device */
-	check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+	if (conn && type == LE_ADV_IND) {
+		/* Store report for later inclusion by
+		 * mgmt_device_connected
+		 */
+		memcpy(conn->le_pend_adv_data, data, len);
+		conn->le_pend_adv_len = len;
+	}
 
 	/* Passive scanning shouldn't trigger any device found events,
 	 * except for devices marked as CONN_REPORT for which we do send
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b6f9777..079834c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3875,7 +3875,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
 		mgmt_device_connected(hdev, &hcon->dst, hcon->type,
 				      hcon->dst_type, 0, NULL, 0,
-				      hcon->dev_class);
+				      hcon->dev_class, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index efb71b0..6f533fbb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6173,7 +6173,7 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 
 void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			   u8 addr_type, u32 flags, u8 *name, u8 name_len,
-			   u8 *dev_class)
+			   u8 *dev_class, u8 *adv, u8 adv_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_connected *ev = (void *) buf;
@@ -6192,6 +6192,9 @@ void mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		eir_len = eir_append_data(ev->eir, eir_len,
 					  EIR_CLASS_OF_DEV, dev_class, 3);
 
+	memcpy(&ev->eir[eir_len], adv, adv_len);
+	eir_len += adv_len;
+
 	ev->eir_len = cpu_to_le16(eir_len);
 
 	mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
-- 
1.9.1

