Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH 2/3] Bluetooth: Create a unified authentication request function
Date: Wed, 10 Nov 2010 17:11:52 +0200
Message-Id: <1289401913-22982-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
References: <1289401913-22982-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds a single function that's responsible for requesting
authentication for outgoing connections. This is preparation for the
next patch which will add automated name requests and thereby move the
authentication requests to a different location.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_event.c |   58 ++++++++++++++++++++++++++++++++++-----------
 1 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8430276..45569f2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -677,6 +677,33 @@ static void hci_cs_set_conn_encrypt(struct hci_dev *hdev, __u8 status)
 	hci_dev_unlock(hdev);
 }
 
+static int request_outgoing_auth(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct hci_cp_auth_requested cp;
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (!conn)
+		return 0;
+
+	if (conn->state != BT_CONFIG || !conn->out)
+		return 0;
+
+	if (conn->sec_level == BT_SECURITY_SDP)
+		return 0;
+
+	/* Only request authentication for SSP connections or non-SSP
+	 * devices with sec_level HIGH */
+	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
+					conn->sec_level != BT_SECURITY_HIGH)
+		return 0;
+
+	cp.handle = __cpu_to_le16(conn->handle);
+	hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
+
+	return 1;
+}
+
 static void hci_cs_remote_name_req(struct hci_dev *hdev, __u8 status)
 {
 	BT_DBG("%s status 0x%x", hdev->name, status);
@@ -1156,6 +1183,7 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 {
 	struct hci_ev_remote_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	int auth_requested;
 
 	BT_DBG("%s status %d", hdev->name, ev->status);
 
@@ -1177,12 +1205,15 @@ static inline void hci_remote_features_evt(struct hci_dev *hdev, struct sk_buff
 		cp.page = 0x01;
 		hci_send_cmd(hdev, HCI_OP_READ_REMOTE_EXT_FEATURES,
 							sizeof(cp), &cp);
-	} else if (!ev->status && conn->out &&
-			conn->sec_level == BT_SECURITY_HIGH) {
-		struct hci_cp_auth_requested cp;
-		cp.handle = ev->handle;
-		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED, sizeof(cp), &cp);
-	} else {
+		goto unlock;
+	}
+
+	if (!ev->status)
+		auth_requested = request_outgoing_auth(hdev, &conn->dst);
+	else
+		auth_requested = 0;
+
+	if (!auth_requested) {
 		conn->state = BT_CONNECTED;
 		hci_proto_connect_cfm(conn, ev->status);
 		hci_conn_put(conn);
@@ -1640,6 +1671,7 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 {
 	struct hci_ev_remote_ext_features *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	int auth_requested;
 
 	BT_DBG("%s", hdev->name);
 
@@ -1661,14 +1693,12 @@ static inline void hci_remote_ext_features_evt(struct hci_dev *hdev, struct sk_b
 	if (conn->state != BT_CONFIG)
 		goto unlock;
 
-	if (!ev->status && hdev->ssp_mode > 0 &&
-			conn->ssp_mode > 0 && conn->out &&
-			conn->sec_level != BT_SECURITY_SDP) {
-		struct hci_cp_auth_requested cp;
-		cp.handle = ev->handle;
-		hci_send_cmd(hdev, HCI_OP_AUTH_REQUESTED,
-				sizeof(cp), &cp);
-	} else {
+	if (!ev->status)
+		auth_requested = request_outgoing_auth(hdev, &conn->dst);
+	else
+		auth_requested = 0;
+
+	if (!auth_requested) {
 		conn->state = BT_CONNECTED;
 		hci_proto_connect_cfm(conn, ev->status);
 		hci_conn_put(conn);
-- 
1.7.2.3

