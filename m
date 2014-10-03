Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Include ADV_IND report in Device Connected event
Date: Fri,  3 Oct 2014 12:10:26 +0000
Message-Id: <1412338226-7351-3-git-send-email-fons@spotify.com>
In-Reply-To: <1412338226-7351-1-git-send-email-fons@spotify.com>
References: <1412338226-7351-1-git-send-email-fons@spotify.com>
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
 include/net/bluetooth/hci_core.h |  5 ++++-
 net/bluetooth/hci_event.c        | 42 ++++++++++++++++++++++++++--------------
 net/bluetooth/l2cap_core.c       |  2 +-
 net/bluetooth/mgmt.c             | 26 ++++++++++++++++++-------
 4 files changed, 52 insertions(+), 23 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f1407fe..1d8d734 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -398,6 +398,8 @@ struct hci_conn {
 	__u16		le_conn_interval;
 	__u16		le_conn_latency;
 	__u16		le_supv_timeout;
+	__u8		le_adv_data[HCI_MAX_AD_LENGTH];
+	__u8		le_adv_len;
 	__s8		rssi;
 	__s8		tx_power;
 	__s8		max_tx_power;
@@ -1311,7 +1313,8 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
-			   u32 flags, u8 *name, u8 name_len);
+			   u32 flags, u8 *name, u8 name_len,
+			   u8 *adv, u8 adv_len);
 void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      u8 link_type, u8 addr_type, u8 reason,
 			      bool mgmt_connected);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6ee7de2..c6f61f8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1577,7 +1577,7 @@ static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
 	struct inquiry_entry *e;
 
 	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, 0, name, name_len);
+		mgmt_device_connected(hdev, conn, 0, name, name_len, NULL, 0);
 
 	if (discov->state == DISCOVERY_STOPPED)
 		return;
@@ -2535,7 +2535,7 @@ static void hci_remote_features_evt(struct hci_dev *hdev,
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
 	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0, NULL, 0);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3431,7 +3431,7 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
 	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0, NULL, 0);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -4209,7 +4209,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	}
 
 	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
-		mgmt_device_connected(hdev, conn, 0, NULL, 0);
+		mgmt_device_connected(hdev, conn, 0, NULL, 0,
+				      conn->le_adv_data,
+				      conn->le_adv_len);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
@@ -4263,25 +4265,26 @@ static void hci_le_conn_update_complete_evt(struct hci_dev *hdev,
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
@@ -4289,7 +4292,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 					   addr, addr_type);
 	if (!params)
-		return;
+		return NULL;
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_DIRECT:
@@ -4298,7 +4301,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 * incoming connections from slave devices.
 		 */
 		if (adv_type != LE_ADV_DIRECT_IND)
-			return;
+			return NULL;
 		break;
 	case HCI_AUTO_CONN_ALWAYS:
 		/* Devices advertising with ADV_IND or ADV_DIRECT_IND
@@ -4309,7 +4312,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 */
 		break;
 	default:
-		return;
+		return NULL;
 	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
@@ -4322,7 +4325,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		 * count consistent once the connection is established.
 		 */
 		params->conn = hci_conn_get(conn);
-		return;
+		return conn;
 	}
 
 	switch (PTR_ERR(conn)) {
@@ -4335,7 +4338,10 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 		break;
 	default:
 		BT_DBG("Failed to connect: err %ld", PTR_ERR(conn));
+		return NULL;
 	}
+
+	return conn;
 }
 
 static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
@@ -4343,6 +4349,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 {
 	struct discovery_state *d = &hdev->discovery;
 	struct smp_irk *irk;
+	struct hci_conn *conn;
 	bool match;
 	u32 flags;
 
@@ -4354,7 +4361,14 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	}
 
 	/* Check if we have been requested to connect to this device */
-	check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+	conn = check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
+	if (conn && type == LE_ADV_IND) {
+		/* Store report for later inclusion by
+		 * mgmt_device_connected
+		 */
+		memcpy(conn->le_adv_data, data, len);
+		conn->le_adv_len = len;
+	}
 
 	/* Passive scanning shouldn't trigger any device found events,
 	 * except for devices marked as CONN_REPORT for which we do send
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 2ff5591..98be19b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3873,7 +3873,7 @@ static int l2cap_connect_req(struct l2cap_conn *conn,
 	hci_dev_lock(hdev);
 	if (test_bit(HCI_MGMT, &hdev->dev_flags) &&
 	    !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &hcon->flags))
-		mgmt_device_connected(hdev, hcon, 0, NULL, 0);
+		mgmt_device_connected(hdev, hcon, 0, NULL, 0, NULL, 0);
 	hci_dev_unlock(hdev);
 
 	l2cap_connect(conn, cmd, data, L2CAP_CONN_RSP, 0);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fc275dc..b97cb9e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6172,7 +6172,8 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 }
 
 void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
-			   u32 flags, u8 *name, u8 name_len)
+			   u32 flags, u8 *name, u8 name_len,
+			   u8 *adv, u8 adv_len)
 {
 	char buf[512];
 	struct mgmt_ev_device_connected *ev = (void *) buf;
@@ -6183,13 +6184,24 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 
 	ev->flags = __cpu_to_le32(flags);
 
-	if (name_len > 0)
-		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
-					  name, name_len);
+	/* We must ensure that the EIR Data fields are ordered and
+	 * unique. Keep it simple for now and avoid the problem by not
+	 * adding any BR/EDR data to the LE adv.
+	 */
+	if (adv) {
+		memcpy(&ev->eir[eir_len], adv, adv_len);
+		eir_len = adv_len;
+	} else {
+		if (name_len > 0)
+			eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
+						  name, name_len);
 
-	if (conn->dev_class && memcmp(conn->dev_class, "\0\0\0", 3) != 0)
-		eir_len = eir_append_data(ev->eir, eir_len,
-					  EIR_CLASS_OF_DEV, conn->dev_class, 3);
+		if (conn->dev_class &&
+		    memcmp(conn->dev_class, "\0\0\0", 3) != 0)
+			eir_len = eir_append_data(ev->eir, eir_len,
+						  EIR_CLASS_OF_DEV,
+						  conn->dev_class, 3);
+	}
 
 	ev->eir_len = cpu_to_le16(eir_len);
 
-- 
1.9.1

