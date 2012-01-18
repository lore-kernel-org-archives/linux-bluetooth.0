Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/15] Bluetooth: Update device_connected and device_found events to latest API
Date: Wed, 18 Jan 2012 20:51:55 +0200
Message-Id: <1326912717-6347-14-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates mgmt_ev_device_connected and mgmt_ev_device found to
include an EIR-encoded remote name and class whenever possible. With
this addition the mgmt_ev_remote_name event becomes unnecessary and can
be removed. Since the connected event doesn't map to hci_conn_complete
anymore a HCI_CONN_MGMT_CONNECTED flag is added to track when mgmt has
been notified about a connection.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    7 ++-
 include/net/bluetooth/mgmt.h     |   17 ++++----
 net/bluetooth/hci_event.c        |   78 +++++++++++++++++++++++++++-----------
 net/bluetooth/mgmt.c             |   56 ++++++++++++++++++++-------
 4 files changed, 110 insertions(+), 48 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 40efe33..ab1a626 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -408,6 +408,7 @@ enum {
 	HCI_CONN_SSP_SUPPORT,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_MGMT_CONNECTED,
 };
 
 static inline bool hci_conn_ssp_support(struct hci_conn *conn)
@@ -939,7 +940,8 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 								u8 persistent);
 int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-								u8 addr_type);
+					u8 addr_type, u8 *name, u8 name_len,
+					u8 *dev_class);
 int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 						u8 link_type, u8 addr_type);
 int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
@@ -968,7 +970,8 @@ int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
 int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 					u8 addr_type, u8 *dev_class, s8 rssi,
 					u8 cfm_name, u8 *eir, u16 eir_len);
-int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name);
+int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+			u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index bdace52..6f37983 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -329,6 +329,11 @@ struct mgmt_ev_new_link_key {
 } __packed;
 
 #define MGMT_EV_DEVICE_CONNECTED	0x000A
+struct mgmt_ev_device_connected {
+	struct mgmt_addr_info addr;
+	__le16 eir_len;
+	__u8 eir[0];
+} __packed;
 
 #define MGMT_EV_DEVICE_DISCONNECTED	0x000B
 
@@ -371,20 +376,14 @@ struct mgmt_ev_device_found {
 	__u8 eir[0];
 } __packed;
 
-#define MGMT_EV_REMOTE_NAME		0x0012
-struct mgmt_ev_remote_name {
-	bdaddr_t bdaddr;
-	__u8 name[MGMT_MAX_NAME_LENGTH];
-} __packed;
-
-#define MGMT_EV_DISCOVERING		0x0013
+#define MGMT_EV_DISCOVERING		0x0012
 
-#define MGMT_EV_DEVICE_BLOCKED		0x0014
+#define MGMT_EV_DEVICE_BLOCKED		0x0013
 struct mgmt_ev_device_blocked {
 	bdaddr_t bdaddr;
 } __packed;
 
-#define MGMT_EV_DEVICE_UNBLOCKED	0x0015
+#define MGMT_EV_DEVICE_UNBLOCKED	0x0014
 struct mgmt_ev_device_unblocked {
 	bdaddr_t bdaddr;
 } __packed;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f49f64f..d469b99 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1292,11 +1292,36 @@ static inline int hci_resolve_name(struct hci_dev *hdev, struct inquiry_entry *e
 	return hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
 }
 
-static void hci_resolve_next_name(struct hci_dev *hdev, bdaddr_t *bdaddr)
+static bool hci_resolve_next_name(struct hci_dev *hdev)
 {
 	struct discovery_state *discov = &hdev->discovery;
 	struct inquiry_entry *e;
 
+	if (list_empty(&discov->resolve))
+		return false;
+
+	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
+	if (hci_resolve_name(hdev, e) == 0) {
+		e->name_state = NAME_PENDING;
+		return true;
+	}
+
+	return false;
+}
+
+static void hci_check_pending_name(struct hci_dev *hdev, struct hci_conn *conn,
+					bdaddr_t *bdaddr, u8 *name, u8 name_len)
+{
+	struct discovery_state *discov = &hdev->discovery;
+	struct inquiry_entry *e;
+
+	if (conn && !test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_connected(hdev, bdaddr, ACL_LINK, 0x00,
+					name, name_len, conn->dev_class);
+
+	if (discov->state == DISCOVERY_STOPPED)
+		return;
+
 	if (discov->state == DISCOVERY_STOPPING)
 		goto discov_complete;
 
@@ -1307,16 +1332,13 @@ static void hci_resolve_next_name(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	if (e) {
 		e->name_state = NAME_KNOWN;
 		list_del(&e->list);
+		if (name)
+			mgmt_remote_name(hdev, bdaddr, ACL_LINK, 0x00,
+					e->data.rssi, name, name_len);
 	}
 
-	if (list_empty(&discov->resolve))
-		goto discov_complete;
-
-	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_NEEDED);
-	if (hci_resolve_name(hdev, e) == 0) {
-		e->name_state = NAME_PENDING;
+	if (hci_resolve_next_name(hdev))
 		return;
-	}
 
 discov_complete:
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
@@ -1340,10 +1362,11 @@ static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 
 	hci_dev_lock(hdev);
 
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
+
 	if (test_bit(HCI_MGMT, &hdev->dev_flags))
-		hci_resolve_next_name(hdev, &cp->bdaddr);
+		hci_check_pending_name(hdev, conn, &cp->bdaddr, NULL, 0);
 
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->bdaddr);
 	if (!conn)
 		goto unlock;
 
@@ -1649,8 +1672,6 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 			conn->state = BT_CONFIG;
 			hci_conn_hold(conn);
 			conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-			mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
-							conn->dst_type);
 		} else
 			conn->state = BT_CONNECTED;
 
@@ -1791,7 +1812,8 @@ static inline void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	if (ev->status == 0)
 		conn->state = BT_CLOSED;
 
-	if (conn->type == ACL_LINK || conn->type == LE_LINK) {
+	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags) &&
+			(conn->type == ACL_LINK || conn->type == LE_LINK)) {
 		if (ev->status != 0)
 			mgmt_disconnect_failed(hdev, &conn->dst, ev->status);
 		else
@@ -1884,14 +1906,18 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	hci_dev_lock(hdev);
 
-	if (test_bit(HCI_MGMT, &hdev->dev_flags)) {
-		if (ev->status == 0)
-			mgmt_remote_name(hdev, &ev->bdaddr, ev->name);
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 
-		hci_resolve_next_name(hdev, &ev->bdaddr);
-	}
+	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
+		goto check_auth;
 
-	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
+	if (ev->status == 0)
+		hci_check_pending_name(hdev, conn, &ev->bdaddr, ev->name,
+					strnlen(ev->name, HCI_MAX_NAME_LENGTH));
+	else
+		hci_check_pending_name(hdev, conn, &ev->bdaddr, NULL, 0);
+
+check_auth:
 	if (!conn)
 		goto unlock;
 
@@ -2000,7 +2026,10 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	}
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_connected(hdev, &conn->dst, conn->type,
+						conn->dst_type, NULL, 0,
+						conn->dev_class);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -2770,7 +2799,10 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 		bacpy(&cp.bdaddr, &conn->dst);
 		cp.pscan_rep_mode = 0x02;
 		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
-	}
+	} else if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_connected(hdev, &conn->dst, conn->type,
+						conn->dst_type, NULL, 0,
+						conn->dev_class);
 
 	if (!hci_outgoing_auth_needed(hdev, conn)) {
 		conn->state = BT_CONNECTED;
@@ -3172,7 +3204,9 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 		goto unlock;
 	}
 
-	mgmt_device_connected(hdev, &ev->bdaddr, conn->type, conn->dst_type);
+	if (!test_and_set_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		mgmt_device_connected(hdev, &ev->bdaddr, conn->type,
+						conn->dst_type, NULL, 0, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->handle = __le16_to_cpu(ev->handle);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c851579..8d5f8b9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1244,7 +1244,6 @@ static int get_connections(struct sock *sk, u16 index)
 	struct mgmt_rp_get_connections *rp;
 	struct hci_dev *hdev;
 	struct hci_conn *c;
-	struct list_head *p;
 	size_t rp_len;
 	u16 count;
 	int i, err;
@@ -1259,8 +1258,9 @@ static int get_connections(struct sock *sk, u16 index)
 	hci_dev_lock(hdev);
 
 	count = 0;
-	list_for_each(p, &hdev->conn_hash.list) {
-		count++;
+	list_for_each_entry(c, &hdev->conn_hash.list, list) {
+		if (test_bit(HCI_CONN_MGMT_CONNECTED, &c->flags))
+			count++;
 	}
 
 	rp_len = sizeof(*rp) + (count * sizeof(struct mgmt_addr_info));
@@ -1274,6 +1274,8 @@ static int get_connections(struct sock *sk, u16 index)
 
 	i = 0;
 	list_for_each_entry(c, &hdev->conn_hash.list, list) {
+		if (!test_bit(HCI_CONN_MGMT_CONNECTED, &c->flags))
+			continue;
 		bacpy(&rp->addr[i].bdaddr, &c->dst);
 		rp->addr[i].type = link_to_mgmt(c->type, c->dst_type);
 		if (rp->addr[i].type == MGMT_ADDR_INVALID)
@@ -2465,15 +2467,28 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 }
 
 int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
-								u8 addr_type)
+					u8 addr_type, u8 *name, u8 name_len,
+					u8 *dev_class)
 {
-	struct mgmt_addr_info ev;
+	char buf[512];
+	struct mgmt_ev_device_connected *ev = (void *) buf;
+	u16 eir_len = 0;
 
-	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_mgmt(link_type, addr_type);
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_mgmt(link_type, addr_type);
 
-	return mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, &ev, sizeof(ev),
-									NULL);
+	if (name_len > 0)
+		eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE,
+								name, name_len);
+
+	if (dev_class && memcmp(dev_class, "\0\0\0", 3) != 0)
+		eir_len = eir_append_data(&ev->eir[eir_len], eir_len,
+					EIR_CLASS_OF_DEV, dev_class, 3);
+
+	put_unaligned_le16(eir_len, &ev->eir_len);
+
+	return mgmt_event(MGMT_EV_DEVICE_CONNECTED, hdev, buf,
+						sizeof(*ev) + eir_len, NULL);
 }
 
 static void disconnect_rsp(struct pending_cmd *cmd, void *data)
@@ -2813,16 +2828,27 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, ev, ev_size, NULL);
 }
 
-int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *name)
+int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
+				u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {
-	struct mgmt_ev_remote_name ev;
+	struct mgmt_ev_device_found *ev;
+	char buf[sizeof(*ev) + HCI_MAX_NAME_LENGTH + 2];
+	u16 eir_len;
 
-	memset(&ev, 0, sizeof(ev));
+	ev = (struct mgmt_ev_device_found *) buf;
 
-	bacpy(&ev.bdaddr, bdaddr);
-	memcpy(ev.name, name, HCI_MAX_NAME_LENGTH);
+	memset(buf, 0, sizeof(buf));
+
+	bacpy(&ev->addr.bdaddr, bdaddr);
+	ev->addr.type = link_to_mgmt(link_type, addr_type);
+	ev->rssi = rssi;
+
+	eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
+								name_len);
+
+	put_unaligned_le16(eir_len, &ev->eir_len);
 
-	return mgmt_event(MGMT_EV_REMOTE_NAME, hdev, &ev, sizeof(ev), NULL);
+	return mgmt_event(MGMT_EV_DEVICE_FOUND, hdev, &ev, sizeof(ev), NULL);
 }
 
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
-- 
1.7.8.3

