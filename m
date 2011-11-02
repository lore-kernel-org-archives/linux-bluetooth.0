Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Define HCI reasons instead of magic number
Date: Wed,  2 Nov 2011 10:12:14 +0200
Message-Id: <1320221534-13765-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use HCI error reasons instead of magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    8 ++++++++
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    2 +-
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/l2cap_core.c       |    8 ++++----
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c5fcd13..b9b0ca9 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -288,6 +288,10 @@ struct hci_cp_create_conn {
 	__u8     role_switch;
 } __packed;
 
+#define HCI_REASON_DISC_AUTH_FAILURE	0x05
+#define HCI_REASON_DISC_REMOTE_USER	0x13
+#define HCI_REASON_DISC_LOCAL_HOST	0x16
+
 #define HCI_OP_DISCONNECT		0x0406
 struct hci_cp_disconnect {
 	__le16   handle;
@@ -311,6 +315,8 @@ struct hci_cp_accept_conn_req {
 	__u8     role;
 } __packed;
 
+#define HCI_REASON_REJ_BAD_ADDR		0x0f
+
 #define HCI_OP_REJECT_CONN_REQ		0x040a
 struct hci_cp_reject_conn_req {
 	bdaddr_t bdaddr;
@@ -458,6 +464,8 @@ struct hci_cp_remote_oob_data_neg_reply {
 	bdaddr_t bdaddr;
 } __packed;
 
+#define HCI_REASON_PAIRING_NOT_ALLOWED	0x18
+
 #define HCI_OP_IO_CAPABILITY_NEG_REPLY	0x0434
 struct hci_cp_io_capability_neg_reply {
 	bdaddr_t bdaddr;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a9db9a..804493c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -689,7 +689,7 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 {
 	register struct hci_proto *hp;
-	int reason = 0x13;
+	int reason = HCI_REASON_DISC_REMOTE_USER;
 
 	hp = hci_proto[HCI_PROTO_L2CAP];
 	if (hp && hp->disconn_ind)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6e98ff3..d68f9ca 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -816,7 +816,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 
 		c->state = BT_CLOSED;
 
-		hci_proto_disconn_cfm(c, 0x16);
+		hci_proto_disconn_cfm(c, HCI_REASON_DISC_LOCAL_HOST);
 		hci_conn_del(c);
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d8fa657..5951577 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1557,7 +1557,7 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 		struct hci_cp_reject_conn_req cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x0f;
+		cp.reason = HCI_REASON_REJ_BAD_ADDR;
 		hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp);
 	}
 }
@@ -2644,7 +2644,7 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		struct hci_cp_io_capability_neg_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x18; /* Pairing not allowed */
+		cp.reason = HCI_REASON_PAIRING_NOT_ALLOWED;
 
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_NEG_REPLY,
 							sizeof(cp), &cp);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index af3e8c5..ec0bf74 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -311,7 +311,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
 
-	conn->disc_reason = 0x13;
+	conn->disc_reason = HCI_REASON_DISC_REMOTE_USER;
 
 	chan->conn = conn;
 
@@ -1059,7 +1059,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 		setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
-	conn->disc_reason = 0x13;
+	conn->disc_reason = HCI_REASON_DISC_REMOTE_USER;
 
 	return conn;
 }
@@ -2530,7 +2530,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
-		conn->disc_reason = 0x05;
+		conn->disc_reason = HCI_REASON_DISC_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
 	}
@@ -4217,7 +4217,7 @@ static int l2cap_disconn_ind(struct hci_conn *hcon)
 	BT_DBG("hcon %p", hcon);
 
 	if ((hcon->type != ACL_LINK && hcon->type != LE_LINK) || !conn)
-		return 0x13;
+		return HCI_REASON_DISC_REMOTE_USER;
 
 	return conn->disc_reason;
 }
-- 
1.7.4.1

