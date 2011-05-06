Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 09/12] Bluetooth: Add hci_le_conn_add()
Date: Fri,  6 May 2011 14:05:18 -0300
Message-Id: <1304701521-26459-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
References: <1304701521-26459-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements a wrapper function to hci_conn_add() which
takes the address type as argument. This patch also replaces
hci_conn_add() calls by hci_le_conn_add() in LE related code.

hci_le_conn_add() was created to consider the destination address
type when creating a new LE hci_conn.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_conn.c         |   14 +++++++++++++-
 net/bluetooth/hci_event.c        |    5 +++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5e64d3f..6dd7cad 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -427,6 +427,8 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
+struct hci_conn *hci_le_conn_add(struct hci_dev *hdev, bdaddr_t *dst,
+							__u8 addr_type);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7f5ad8a..8896174 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -347,6 +347,18 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	return conn;
 }
 
+struct hci_conn *hci_le_conn_add(struct hci_dev *hdev, bdaddr_t *dst,
+							__u8 addr_type)
+{
+	struct hci_conn *conn = hci_conn_add(hdev, LE_LINK, dst);
+	if (!conn)
+		return NULL;
+
+	conn->dst_type = addr_type;
+
+	return conn;
+}
+
 int hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -450,7 +462,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
 		if (le)
 			return ERR_PTR(-EBUSY);
-		le = hci_conn_add(hdev, LE_LINK, dst);
+		le = hci_le_conn_add(hdev, dst, 0);
 		if (!le)
 			return ERR_PTR(-ENOMEM);
 		if (le->state == BT_OPEN)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a676757..8c0e3b4 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1231,7 +1231,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 		}
 	} else {
 		if (!conn) {
-			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
+			conn = hci_le_conn_add(hdev, &cp->peer_addr,
+						cp->peer_addr_type);
 			if (conn)
 				conn->out = 1;
 			else
@@ -2679,7 +2680,7 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
 	if (!conn) {
-		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+		conn = hci_le_conn_add(hdev, &ev->bdaddr, ev->bdaddr_type);
 		if (!conn) {
 			BT_ERR("No memory for new connection");
 			hci_dev_unlock(hdev);
-- 
1.7.1

