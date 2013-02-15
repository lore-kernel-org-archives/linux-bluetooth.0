Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 4/8] Bluetooth: Add hci_conn helpers
Date: Fri, 15 Feb 2013 20:27:04 -0300
Message-Id: <1360970828-24004-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
References: <1360970828-24004-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds two helper functions for looking up hci_conn objects
according to its LE state. hci_conn_has_le_pending helper returns
a pending connection (hci_conn in HCI_CONN_LE_SCAN state) if any.
hci_conn_hash_lookup_le_state helper performs a lookup for hci_conn
objects in a given LE state.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  3 +++
 net/bluetooth/hci_conn.c         | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c704737..c797717 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -612,6 +612,9 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 void hci_conn_set_le_state(struct hci_conn *conn, int state);
+struct hci_conn *hci_conn_has_le_pending(struct hci_dev *hdev, bdaddr_t *addr,
+					 __u8 type);
+struct hci_conn *hci_conn_hash_lookup_le_state(struct hci_dev *hdev, int state);
 
 void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d54c2a0..b1a162f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1053,3 +1053,50 @@ void hci_conn_set_le_state(struct hci_conn *conn, int state)
 
 	atomic_set(&conn->le_state, state);
 }
+
+struct hci_conn *hci_conn_has_le_pending(struct hci_dev *hdev, bdaddr_t *addr,
+					 __u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+	if (!conn)
+		return NULL;
+
+	if (conn->state != BT_CONNECT)
+		return NULL;
+
+	if (conn->dst_type != type)
+		return NULL;
+
+	if (atomic_read(&conn->le_state) != HCI_CONN_LE_SCAN)
+		return NULL;
+
+	return conn;
+}
+
+struct hci_conn *hci_conn_hash_lookup_le_state(struct hci_dev *hdev, int state)
+{
+	struct hci_conn_hash *conn_hash = &hdev->conn_hash;
+	struct hci_conn *conn, *ret = NULL;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &conn_hash->list, list) {
+		if (conn->type != LE_LINK)
+			continue;
+
+		if (conn->state != BT_CONNECT)
+			continue;
+
+		if (atomic_read(&conn->le_state) != state)
+			continue;
+
+		ret = conn;
+		break;
+	}
+
+	rcu_read_unlock();
+
+	return ret;
+}
-- 
1.8.1.2

