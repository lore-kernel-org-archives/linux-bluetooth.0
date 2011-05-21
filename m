Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 08/11] Bluetooth: Add 'dst_type' param to hci_conn_add()
Date: Fri, 20 May 2011 21:10:42 -0300
Message-Id: <1305936645-15007-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
References: <1305936645-15007-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The address type must be considered to create LE struct hci_conn
objects. For non-LE this parameter is ignored.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_conn.c         |   12 ++++++++----
 net/bluetooth/hci_event.c        |   11 +++++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 539eb85..486224d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -425,7 +425,8 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
-struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
+struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+								__u8 dst_type);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3163330..84ad32b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -282,7 +282,8 @@ static void hci_conn_auto_accept(unsigned long arg)
 	hci_dev_unlock(hdev);
 }
 
-struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
+struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
+								__u8 dst_type)
 {
 	struct hci_conn *conn;
 
@@ -319,6 +320,9 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	case ESCO_LINK:
 		conn->pkt_type = hdev->esco_type & ~EDR_ESCO_MASK;
 		break;
+	case LE_LINK:
+		conn->dst_type = dst_type;
+		break;
 	}
 
 	skb_queue_head_init(&conn->data_q);
@@ -450,7 +454,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
 			return ERR_PTR(-EBUSY);
-		le = hci_conn_add(hdev, LE_LINK, dst);
+		le = hci_conn_add(hdev, LE_LINK, dst, 0);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 		if (le->state == BT_OPEN)
@@ -463,7 +467,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	acl = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
 	if (!acl) {
-		acl = hci_conn_add(hdev, ACL_LINK, dst);
+		acl = hci_conn_add(hdev, ACL_LINK, dst, 0);
 		if (!acl)
 			return NULL;
 	}
@@ -482,7 +486,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 
 	sco = hci_conn_hash_lookup_ba(hdev, type, dst);
 	if (!sco) {
-		sco = hci_conn_add(hdev, type, dst);
+		sco = hci_conn_add(hdev, type, dst, 0);
 		if (!sco) {
 			hci_conn_put(acl);
 			return NULL;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8d6dc1e..2710332 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -913,7 +913,7 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		}
 	} else {
 		if (!conn) {
-			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
+			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr, 0);
 			if (conn) {
 				conn->out = 1;
 				conn->link_mode |= HCI_LM_MASTER;
@@ -1236,7 +1236,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 		}
 	} else {
 		if (!conn) {
-			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
+			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr,
+						cp->peer_addr_type);
 			if (conn)
 				conn->out = 1;
 			else
@@ -1400,7 +1401,8 @@ static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *sk
 
 		conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 		if (!conn) {
-			conn = hci_conn_add(hdev, ev->link_type, &ev->bdaddr);
+			conn = hci_conn_add(hdev, ev->link_type,
+							&ev->bdaddr, 0);
 			if (!conn) {
 				BT_ERR("No memory for new connection");
 				hci_dev_unlock(hdev);
@@ -2684,7 +2686,8 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
 	if (!conn) {
-		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr,
+							ev->bdaddr_type);
 		if (!conn) {
 			BT_ERR("No memory for new connection");
 			hci_dev_unlock(hdev);
-- 
1.7.4.1

