Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/7] Bluetooth: Refactor connection request handling
Date: Wed,  9 Jul 2014 11:43:10 +0300
Message-Id: <1404895392-12588-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
References: <1404895392-12588-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The conditions for accepting an incoming connections are already
non-trivial and will become more so once a white list is added. This
patch breaks up the checks for when to reject the request by creating a
helper function for it.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 112 +++++++++++++++++++++++++---------------------
 1 file changed, 60 insertions(+), 52 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 381c631423f1..6d1d5b3e9cd4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2121,10 +2121,21 @@ unlock:
 	hci_conn_check_pending(hdev);
 }
 
+static void hci_reject_conn(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct hci_cp_reject_conn_req cp;
+
+	bacpy(&cp.bdaddr, bdaddr);
+	cp.reason = HCI_ERROR_REJ_BAD_ADDR;
+	hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp);
+}
+
 static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_request *ev = (void *) skb->data;
 	int mask = hdev->link_mode;
+	struct inquiry_entry *ie;
+	struct hci_conn *conn;
 	__u8 flags = 0;
 
 	BT_DBG("%s bdaddr %pMR type 0x%x", hdev->name, &ev->bdaddr,
@@ -2133,74 +2144,71 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	mask |= hci_proto_connect_ind(hdev, &ev->bdaddr, ev->link_type,
 				      &flags);
 
-	if ((mask & HCI_LM_ACCEPT) &&
-	    !hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
+	if (!(mask & HCI_LM_ACCEPT)) {
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
+
+	if (!hci_bdaddr_list_lookup(&hdev->blacklist, &ev->bdaddr,
 				    BDADDR_BREDR)) {
-		/* Connection accepted */
-		struct inquiry_entry *ie;
-		struct hci_conn *conn;
+		hci_reject_conn(hdev, &ev->bdaddr);
+		return;
+	}
 
-		hci_dev_lock(hdev);
+	/* Connection accepted */
 
-		ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
-		if (ie)
-			memcpy(ie->data.dev_class, ev->dev_class, 3);
+	hci_dev_lock(hdev);
 
-		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
-					       &ev->bdaddr);
+	ie = hci_inquiry_cache_lookup(hdev, &ev->bdaddr);
+	if (ie)
+		memcpy(ie->data.dev_class, ev->dev_class, 3);
+
+	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type,
+			&ev->bdaddr);
+	if (!conn) {
+		conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
-			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
-			if (!conn) {
-				BT_ERR("No memory for new connection");
-				hci_dev_unlock(hdev);
-				return;
-			}
+			BT_ERR("No memory for new connection");
+			hci_dev_unlock(hdev);
+			return;
 		}
+	}
 
-		memcpy(conn->dev_class, ev->dev_class, 3);
+	memcpy(conn->dev_class, ev->dev_class, 3);
 
-		hci_dev_unlock(hdev);
+	hci_dev_unlock(hdev);
 
-		if (ev->link_type == ACL_LINK ||
-		    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
-			struct hci_cp_accept_conn_req cp;
-			conn->state = BT_CONNECT;
+	if (ev->link_type == ACL_LINK ||
+	    (!(flags & HCI_PROTO_DEFER) && !lmp_esco_capable(hdev))) {
+		struct hci_cp_accept_conn_req cp;
+		conn->state = BT_CONNECT;
 
-			bacpy(&cp.bdaddr, &ev->bdaddr);
+		bacpy(&cp.bdaddr, &ev->bdaddr);
 
-			if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
-				cp.role = 0x00; /* Become master */
-			else
-				cp.role = 0x01; /* Remain slave */
+		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
+			cp.role = 0x00; /* Become master */
+		else
+			cp.role = 0x01; /* Remain slave */
 
-			hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp),
-				     &cp);
-		} else if (!(flags & HCI_PROTO_DEFER)) {
-			struct hci_cp_accept_sync_conn_req cp;
-			conn->state = BT_CONNECT;
+		hci_send_cmd(hdev, HCI_OP_ACCEPT_CONN_REQ, sizeof(cp), &cp);
+	} else if (!(flags & HCI_PROTO_DEFER)) {
+		struct hci_cp_accept_sync_conn_req cp;
+		conn->state = BT_CONNECT;
 
-			bacpy(&cp.bdaddr, &ev->bdaddr);
-			cp.pkt_type = cpu_to_le16(conn->pkt_type);
+		bacpy(&cp.bdaddr, &ev->bdaddr);
+		cp.pkt_type = cpu_to_le16(conn->pkt_type);
 
-			cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
-			cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
-			cp.max_latency    = cpu_to_le16(0xffff);
-			cp.content_format = cpu_to_le16(hdev->voice_setting);
-			cp.retrans_effort = 0xff;
+		cp.tx_bandwidth   = cpu_to_le32(0x00001f40);
+		cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
+		cp.max_latency    = cpu_to_le16(0xffff);
+		cp.content_format = cpu_to_le16(hdev->voice_setting);
+		cp.retrans_effort = 0xff;
 
-			hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ,
-				     sizeof(cp), &cp);
-		} else {
-			conn->state = BT_CONNECT2;
-			hci_proto_connect_cfm(conn, 0);
-		}
+		hci_send_cmd(hdev, HCI_OP_ACCEPT_SYNC_CONN_REQ, sizeof(cp),
+			     &cp);
 	} else {
-		/* Connection rejected */
-		struct hci_cp_reject_conn_req cp;
-
-		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = HCI_ERROR_REJ_BAD_ADDR;
-		hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp);
+		conn->state = BT_CONNECT2;
+		hci_proto_connect_cfm(conn, 0);
 	}
 }
 
-- 
1.9.3

