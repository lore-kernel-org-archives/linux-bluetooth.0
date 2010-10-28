Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH v2] Bluetooth: Automate remote name requests
Date: Thu, 28 Oct 2010 12:20:24 -0400
Message-Id: <1288282824-30736-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

In Bluetooth there are no automatic updates of remote device names when
they get changed on the remote side. Instead, it is a good idea to do a
manual name request when a new connection gets created (for whatever
reason) since at this point it is very cheap (no costly baseband
connection creation needed just for the sake of the name request).

So far userspace has been responsible for this extra name request but
tighter control is needed in order not to flood Bluetooth controllers
with two many commands during connection creation. It has been shown
that some controllers simply fail to function correctly if they get too
many (almost) simultaneous commands during connection creation. The
simplest way to acheive better control of these commands is to move
their sending completely to the kernel side.

This patch inserts name requests into the sequence of events that the
kernel performs during connection creation. It does this after the
remote features have been successfully requested and before any pending
authentication requests are performed. The code will work sub-optimally
with userspace versions that still do the name requesting themselves (it
shouldn't break anything though) so it is recommended to combine this
with a userspace software version that doesn't have automated name
requests.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
v2 makes sure that the name request gets always sent instead of just
doing it for cases when we're also going to request authentication.

 net/bluetooth/hci_event.c |  151 ++++++++++++++++++++++++++++++++-------------
 1 files changed, 107 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 84093b0..6e770e8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -677,9 +677,51 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static void request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct hci_cp_auth_requested cp;
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (!conn)
+		return;
+
+	if (conn->state != BT_CONFIG || !conn->out)
+		return;
+
+	if (conn->sec_level == BT_SECURITY_SDP)
+		return;
+
+	/* Only request authentication for SSP connections or non-SSP
+	 * devices with sec_level HIGH */
+	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
+					conn->sec_level != BT_SECURITY_HIGH)
+		return;
+
+	cp.handle = __cpu_to_le16(conn->handle);
+	hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
+}
+
 static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 {
+	struct hci_cp_remote_name_req *cp;
+
 	BT_DBG("%s status 0x%x", hdev->name, status);
+
+	/* If successful wait for the name req complete event before
+	 * checking for the need to do authentication */
+	if (!status)
+		return;
+
+	cp = hci_sent_cmd_data(hdev, HCI_OP_REMOTE_NAME_REQ);
+	if (!cp)
+		return;
+
+	hci_dev_lock(hdev);
+
+	request_outgoing_auth(hdev, &cp->bdaddr);
+
+	hci_dev_unlock(hdev);
 }
 
 static void hci_cs_read_remote_features(struct hci_dev *hdev, __u8 status)
@@ -1090,9 +1132,17 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	struct hci_ev_remote_name *ev = (void *) skb->data;
+
 	BT_DBG("%s", hdev->name);
 
 	hci_conn_check_pending(hdev);
+
+	hci_dev_lock(hdev);
+
+	request_outgoing_auth(hdev, &ev->bdaddr);
+
+	hci_dev_unlock(hdev);
 }
 
 static inline void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1162,33 +1212,39 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-		if (!ev->status)
-			memcpy(conn->features, ev->features, 8);
+	if (!conn)
+		goto unlock;
 
-		if (conn->state == BT_CONFIG) {
-			if (!ev->status && lmp_ssp_capable(hdev) &&
-						lmp_ssp_capable(conn)) {
-				struct hci_cp_read_remote_ext_features cp;
-				cp.handle = ev->handle;
-				cp.page = 0x01;
-				hci_send_cmd(hdev,
-					HCI_OP_READ_REMOTE_EXT_FEATURES,
-							sizeof(cp), &cp);
-			} else if (!ev->status && conn->out &&
-					conn->sec_level == BT_SECURITY_HIGH) {
-				struct hci_cp_auth_requested cp;
-				cp.handle = ev->handle;
-				hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
+	if (!ev->status)
+		memcpy(conn->features, ev->features, 8);
+
+	if (conn->state != BT_CONFIG)
+		goto unlock;
+
+	if (!ev->status && lmp_ssp_capable(hdev) && lmp_ssp_capable(conn)) {
+		struct hci_cp_read_remote_ext_features cp;
+		cp.handle = ev->handle;
+		cp.page = 0x01;
+		hci_send_cmd(hdev, HCI_OP_READ_REMOTE_EXT_FEATURES,
 							sizeof(cp), &cp);
-			} else {
-				conn->state = BT_CONNECTED;
-				hci_proto_connect_cfm(conn, ev->status);
-				hci_conn_put(conn);
-			}
-		}
+		goto unlock;
+	}
+
+	if (!ev->status) {
+		struct hci_cp_remote_name_req cp;
+		memset(&cp, 0, sizeof(cp));
+		bacpy(&cp.bdaddr, &conn->dst);
+		cp.pscan_rep_mode = 0x02;
+		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
+	}
+
+	if (!conn->out || conn->sec_level != BT_SECURITY_HIGH) {
+		conn->state = BT_CONNECTED;
+		hci_proto_connect_cfm(conn, ev->status);
+		hci_conn_put(conn);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -1646,32 +1702,39 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
-	if (conn) {
-		if (!ev->status && ev->page == 0x01) {
-			struct inquiry_entry *ie;
+	if (!conn)
+		goto unlock;
 
-			if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst)))
-				ie->data.ssp_mode = (ev->features[0] & 0x01);
+	if (!ev->status && ev->page == 0x01) {
+		struct inquiry_entry *ie;
 
-			conn->ssp_mode = (ev->features[0] & 0x01);
-		}
+		if ((ie = hci_inquiry_cache_lookup(hdev, &conn->dst)))
+			ie->data.ssp_mode = (ev->features[0] & 0x01);
 
-		if (conn->state == BT_CONFIG) {
-			if (!ev->status && hdev->ssp_mode > 0 &&
-					conn->ssp_mode > 0 && conn->out &&
-					conn->sec_level != BT_SECURITY_SDP) {
-				struct hci_cp_auth_requested cp;
-				cp.handle = ev->handle;
-				hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
-							sizeof(cp), &cp);
-			} else {
-				conn->state = BT_CONNECTED;
-				hci_proto_connect_cfm(conn, ev->status);
-				hci_conn_put(conn);
-			}
-		}
+		conn->ssp_mode = (ev->features[0] & 0x01);
 	}
 
+	if (conn->state != BT_CONFIG)
+		goto unlock;
+
+	if (!ev->status) {
+		struct hci_cp_remote_name_req cp;
+		memset(&cp, 0, sizeof(cp));
+		bacpy(&cp.bdaddr, &conn->dst);
+		cp.pscan_rep_mode = 0x02;
+		hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ, sizeof(cp), &cp);
+	}
+
+	/* If legacy pairing, or an incoming connection, or SDP security
+	 * consider ourself connected */
+	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) || !conn->out ||
+					conn->sec_level == BT_SECURITY_SDP) {
+		conn->state = BT_CONNECTED;
+		hci_proto_connect_cfm(conn, ev->status);
+		hci_conn_put(conn);
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
 }
 
-- 
1.7.1

