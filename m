Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] Bluetooth: Rename link_to_mgmt to link_to_bdaddr
Date: Tue, 24 Apr 2012 21:02:50 -0300
Message-Id: <1335312176-21306-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
References: <1335312176-21306-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Since address type macros are not only related to Management
Interface anymore, it makes sense to rename the helper function
link_to_mgmt to link_to_bdaddr.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a9c7330..40c7514 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1625,7 +1625,7 @@ failed:
 	return err;
 }
 
-static u8 link_to_mgmt(u8 link_type, u8 addr_type)
+static u8 link_to_bdaddr(u8 link_type, u8 addr_type)
 {
 	switch (link_type) {
 	case LE_LINK:
@@ -1693,7 +1693,7 @@ static int get_connections(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (!test_bit(HCI_CONN_MGMT_CONNECTED, &c->flags))
 			continue;
 		bacpy(&rp->addr[i].bdaddr, &c->dst);
-		rp->addr[i].type = link_to_mgmt(c->type, c->dst_type);
+		rp->addr[i].type = link_to_bdaddr(c->type, c->dst_type);
 		if (c->type == SCO_LINK || c->type == ESCO_LINK)
 			continue;
 		i++;
@@ -1860,7 +1860,7 @@ static void pairing_complete(struct pending_cmd *cmd, u8 status)
 	struct hci_conn *conn = cmd->user_data;
 
 	bacpy(&rp.addr.bdaddr, &conn->dst);
-	rp.addr.type = link_to_mgmt(conn->type, conn->dst_type);
+	rp.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
 
 	cmd_complete(cmd->sk, cmd->index, MGMT_OP_PAIR_DEVICE, status,
 		     &rp, sizeof(rp));
@@ -2983,7 +2983,7 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 
 	ev.store_hint = persistent;
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
-	ev.key.addr.type = link_to_mgmt(LE_LINK, key->bdaddr_type);
+	ev.key.addr.type = link_to_bdaddr(LE_LINK, key->bdaddr_type);
 	ev.key.authenticated = key->authenticated;
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
@@ -3007,7 +3007,7 @@ int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	u16 eir_len = 0;
 
 	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_mgmt(link_type, addr_type);
+	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 
 	ev->flags = __cpu_to_le32(flags);
 
@@ -3070,7 +3070,7 @@ int mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	mgmt_pending_foreach(MGMT_OP_DISCONNECT, hdev, disconnect_rsp, &sk);
 
 	bacpy(&ev.bdaddr, bdaddr);
-	ev.type = link_to_mgmt(link_type, addr_type);
+	ev.type = link_to_bdaddr(link_type, addr_type);
 
 	err = mgmt_event(MGMT_EV_DEVICE_DISCONNECTED, hdev, &ev, sizeof(ev),
 			 sk);
@@ -3096,7 +3096,7 @@ int mgmt_disconnect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = link_to_mgmt(link_type, addr_type);
+	rp.addr.type = link_to_bdaddr(link_type, addr_type);
 
 	err = cmd_complete(cmd->sk, cmd->index, MGMT_OP_DISCONNECT,
 			   mgmt_status(status), &rp, sizeof(rp));
@@ -3114,7 +3114,7 @@ int mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	struct mgmt_ev_connect_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(link_type, addr_type);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_CONNECT_FAILED, hdev, &ev, sizeof(ev), NULL);
@@ -3185,7 +3185,7 @@ int mgmt_user_confirm_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	BT_DBG("%s", hdev->name);
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(link_type, addr_type);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.confirm_hint = confirm_hint;
 	ev.value = value;
 
@@ -3201,7 +3201,7 @@ int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	BT_DBG("%s", hdev->name);
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(link_type, addr_type);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 
 	return mgmt_event(MGMT_EV_USER_PASSKEY_REQUEST, hdev, &ev, sizeof(ev),
 			  NULL);
@@ -3220,7 +3220,7 @@ static int user_pairing_resp_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		return -ENOENT;
 
 	bacpy(&rp.addr.bdaddr, bdaddr);
-	rp.addr.type = link_to_mgmt(link_type, addr_type);
+	rp.addr.type = link_to_bdaddr(link_type, addr_type);
 	err = cmd_complete(cmd->sk, hdev->id, opcode, mgmt_status(status),
 			   &rp, sizeof(rp));
 
@@ -3263,7 +3263,7 @@ int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	struct mgmt_ev_auth_failed ev;
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
-	ev.addr.type = link_to_mgmt(link_type, addr_type);
+	ev.addr.type = link_to_bdaddr(link_type, addr_type);
 	ev.status = mgmt_status(status);
 
 	return mgmt_event(MGMT_EV_AUTH_FAILED, hdev, &ev, sizeof(ev), NULL);
@@ -3530,7 +3530,7 @@ int mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	memset(buf, 0, sizeof(buf));
 
 	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_mgmt(link_type, addr_type);
+	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 	if (cfm_name)
 		ev->flags[0] |= MGMT_DEV_FOUND_CONFIRM_NAME;
@@ -3563,7 +3563,7 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	memset(buf, 0, sizeof(buf));
 
 	bacpy(&ev->addr.bdaddr, bdaddr);
-	ev->addr.type = link_to_mgmt(link_type, addr_type);
+	ev->addr.type = link_to_bdaddr(link_type, addr_type);
 	ev->rssi = rssi;
 
 	eir_len = eir_append_data(ev->eir, 0, EIR_NAME_COMPLETE, name,
-- 
1.7.10

