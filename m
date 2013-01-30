Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: Rename hci_acl_disconn
Date: Wed, 30 Jan 2013 11:50:56 -0300
Message-Id: <1359557457-10199-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
References: <1359557457-10199-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As hci_acl_disconn function basically sends the HCI Disconnect Command
and it is used to disconnect ACL, SCO and LE links, renaming it to
hci_disconnect is more suitable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_conn.c         | 4 ++--
 net/bluetooth/hci_core.c         | 2 +-
 net/bluetooth/hci_event.c        | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90cf75a..787d3b9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -574,7 +574,7 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
-void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
+void hci_disconnect(struct hci_conn *conn, __u8 reason);
 void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4925a02..b9f9016 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -117,7 +117,7 @@ static void hci_acl_create_connection_cancel(struct hci_conn *conn)
 	hci_send_cmd(conn->hdev, HCI_OP_CREATE_CONN_CANCEL, sizeof(cp), &cp);
 }
 
-void hci_acl_disconn(struct hci_conn *conn, __u8 reason)
+void hci_disconnect(struct hci_conn *conn, __u8 reason)
 {
 	struct hci_cp_disconnect cp;
 
@@ -253,7 +253,7 @@ static void hci_conn_disconnect(struct hci_conn *conn)
 		hci_amp_disconn(conn, reason);
 		break;
 	default:
-		hci_acl_disconn(conn, reason);
+		hci_disconnect(conn, reason);
 		break;
 	}
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 618ca1a..388c456 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2398,7 +2398,7 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %pMR",
 			       hdev->name, &c->dst);
-			hci_acl_disconn(c, HCI_ERROR_REMOTE_USER_TERM);
+			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
 		}
 	}
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d4fcba6..5c78480 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2399,7 +2399,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 		if (ev->status && conn->state == BT_CONNECTED) {
-			hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
+			hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 			hci_conn_put(conn);
 			goto unlock;
 		}
@@ -3472,7 +3472,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev,
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
 	if (ev->status && conn->state == BT_CONNECTED) {
-		hci_acl_disconn(conn, HCI_ERROR_AUTH_FAILURE);
+		hci_disconnect(conn, HCI_ERROR_AUTH_FAILURE);
 		hci_conn_put(conn);
 		goto unlock;
 	}
-- 
1.8.1.1

