Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Rename hci_acl_disconn to hci_disconnect
Date: Wed,  8 Jun 2011 19:10:22 -0300
Message-Id: <1307571024-22442-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_disconnect() takes care of both ACL and LE connections

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    4 ++--
 net/bluetooth/hci_core.c         |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 818eadb..7be2280 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -421,7 +421,6 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 }
 
 void hci_acl_connect(struct hci_conn *conn);
-void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
@@ -432,6 +431,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8 sec_level, __u8 auth_type);
+void hci_disconnect(struct hci_conn *conn, __u8 reason);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 37f5a17..351c860 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -129,7 +129,7 @@ static void hci_acl_connect_cancel(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_CREATE_CONN_CANCEL, sizeof(cp), &cp);
 }
 
-void hci_acl_disconn(struct hci_conn *conn, __u8 reason)
+void hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cp_disconnect cp;
 
@@ -251,7 +251,7 @@ static void hci_conn_timeout(unsigned long arg)
 	case BT_CONFIG:
 	case BT_CONNECTED:
 		reason = hci_proto_disconn_ind(conn);
-		hci_acl_disconn(conn, reason);
+		hci_disconnect(conn, reason);
 		break;
 	default:
 		conn->state = BT_CLOSED;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e14e8a1..1076f46 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1945,7 +1945,7 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
 				hdev->name, batostr(&c->dst));
-			hci_acl_disconn(c, 0x13);
+			hci_disconnect(c, 0x13);
 		}
 	}
 }
-- 
1.7.5.1

