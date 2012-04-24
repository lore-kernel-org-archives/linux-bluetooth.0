Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix coding style in the code
Date: Tue, 24 Apr 2012 01:09:25 -0300
Message-Id: <1335240565-5582-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

New code added to the Bluetooth subsystem need to be complaint with the
new syle rules.

Signed-off-by: Gustavo Padovan <gustavo@padovan.org>
---
 net/bluetooth/hci_core.c   |    2 +-
 net/bluetooth/hci_event.c  |    2 +-
 net/bluetooth/l2cap_core.c |   12 +++++++-----
 net/bluetooth/mgmt.c       |   12 ++++++------
 4 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3b97ad3..0d9ed01 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1194,7 +1194,7 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 }
 
 static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
-						u8 key_type, u8 old_key_type)
+			       u8 key_type, u8 old_key_type)
 {
 	/* Legacy key */
 	if (key_type < 0x03)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8a13f90..fb23c47 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -208,7 +208,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 
 	/* Reset all non-persistent flags */
 	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PENDING_CLASS) |
-							BIT(HCI_PERIODIC_INQ));
+			     BIT(HCI_PERIODIC_INQ));
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
 }
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9b23db5..9d6c650 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1099,7 +1099,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
  * Returns closest match, locked.
  */
 static struct l2cap_chan *l2cap_global_chan_by_scid(int state, u16 cid,
-						bdaddr_t *src, bdaddr_t *dst)
+					            bdaddr_t *src,
+						    bdaddr_t *dst)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -1146,7 +1147,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	/* Check if we have socket listening on cid */
 	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
-							conn->src, conn->dst);
+					  conn->src, conn->dst);
 	if (!pchan)
 		return;
 
@@ -1355,8 +1356,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
  * Returns closest match.
  */
 static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm,
-							bdaddr_t *src,
-							bdaddr_t *dst)
+						   bdaddr_t *src,
+						   bdaddr_t *dst)
 {
 	struct l2cap_chan *c, *c1 = NULL;
 
@@ -4684,7 +4685,8 @@ drop:
 	return 0;
 }
 
-static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
+static inline int l2cap_att_channel(struct l2cap_conn *conn, u16 cid,
+		                    struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6bbb52c..1606514 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2425,17 +2425,16 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 							NAME_PENDING);
 		if (!e) {
 			mgmt_pending_remove(cmd);
-			err = cmd_complete(sk, hdev->id,
-						MGMT_OP_STOP_DISCOVERY, 0,
-						&mgmt_cp->type,
-						sizeof(mgmt_cp->type));
+			err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
+					   0, &mgmt_cp->type,
+					   sizeof(mgmt_cp->type));
 			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 			goto unlock;
 		}
 
 		bacpy(&cp.bdaddr, &e->data.bdaddr);
 		err = hci_send_cmd(hdev, HCI_OP_REMOTE_NAME_REQ_CANCEL,
-					sizeof(cp), &cp);
+				   sizeof(cp), &cp);
 
 		break;
 
@@ -2959,7 +2958,8 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 	return 0;
 }
 
-int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, bool persistent)
+int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
+		      bool persistent)
 {
 	struct mgmt_ev_new_link_key ev;
 
-- 
1.7.10

