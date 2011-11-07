Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Define HCI reasons instead of magic number
Date: Mon,  7 Nov 2011 14:20:25 +0200
Message-Id: <1320668425-11251-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Use HCI error reasons instead of magic numbers.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    7 +++++++
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    2 +-
 net/bluetooth/hci_event.c        |    4 ++--
 net/bluetooth/l2cap_core.c       |    8 ++++----
 5 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c5fcd13..139ce2a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -264,6 +264,13 @@ enum {
 #define HCI_LK_SMP_IRK			0x82
 #define HCI_LK_SMP_CSRK			0x83
 
+/* ---- HCI Error Codes ---- */
+#define HCI_ERROR_AUTH_FAILURE		0x05
+#define HCI_ERROR_REJ_BAD_ADDR		0x0f
+#define HCI_ERROR_REMOTE_USER_TERM	0x13
+#define HCI_ERROR_LOCAL_HOST_TERM	0x16
+#define HCI_ERROR_PAIRING_NOT_ALLOWED	0x18
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f97792c..006a769 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -730,7 +730,7 @@ static inline void hci_proto_connect_cfm(struct hci_conn *conn, __u8 status)
 static inline int hci_proto_disconn_ind(struct hci_conn *conn)
 {
 	register struct hci_proto *hp;
-	int reason = 0x13;
+	int reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	hp = hci_proto[HCI_PROTO_L2CAP];
 	if (hp && hp->disconn_ind)
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e545376..ac94367 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -820,7 +820,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 
 		c->state = BT_CLOSED;
 
-		hci_proto_disconn_cfm(c, 0x16);
+		hci_proto_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
 		hci_conn_del(c);
 	}
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d8fa657..aa3340ec 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1557,7 +1557,7 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 		struct hci_cp_reject_conn_req cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x0f;
+		cp.reason = HCI_ERROR_REJ_BAD_ADDR;
 		hci_send_cmd(hdev, HCI_OP_REJECT_CONN_REQ, sizeof(cp), &cp);
 	}
 }
@@ -2644,7 +2644,7 @@ static inline void hci_io_capa_request_evt(struct hci_dev *hdev, struct sk_buff
 		struct hci_cp_io_capability_neg_reply cp;
 
 		bacpy(&cp.bdaddr, &ev->bdaddr);
-		cp.reason = 0x18; /* Pairing not allowed */
+		cp.reason = HCI_ERROR_PAIRING_NOT_ALLOWED;
 
 		hci_send_cmd(hdev, HCI_OP_IO_CAPABILITY_NEG_REPLY,
 							sizeof(cp), &cp);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 20149ff..e8a6837 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -313,7 +313,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			chan->psm, chan->dcid);
 
-	conn->disc_reason = 0x13;
+	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = conn;
 
@@ -1082,7 +1082,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 		setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
-	conn->disc_reason = 0x13;
+	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	return conn;
 }
@@ -2559,7 +2559,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	/* Check if the ACL is secure enough (if not SDP) */
 	if (psm != cpu_to_le16(0x0001) &&
 				!hci_conn_check_link_mode(conn->hcon)) {
-		conn->disc_reason = 0x05;
+		conn->disc_reason = HCI_ERROR_AUTH_FAILURE;
 		result = L2CAP_CR_SEC_BLOCK;
 		goto response;
 	}
@@ -4435,7 +4435,7 @@ static int l2cap_disconn_ind(struct hci_conn *hcon)
 	BT_DBG("hcon %p", hcon);
 
 	if ((hcon->type != ACL_LINK && hcon->type != LE_LINK) || !conn)
-		return 0x13;
+		return HCI_ERROR_REMOTE_USER_TERM;
 
 	return conn->disc_reason;
 }
-- 
1.7.4.1

