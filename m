Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 3/4] Bluetooth: Extend hci_conn_check_pending()
Date: Tue,  9 Aug 2011 19:52:39 -0300
Message-Id: <1312930360-30860-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
References: <1312930360-30860-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a new parameter to the hci_conn_check_pending().
This function was modified to check for pending hci connections
according to the link type.

In case there is a pending LE connection, we should check if the
LE advertising of the destination device was cached. If so, we
create a connection, otherwise the connection attempt fails.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |   35 +++++++++++++++++++++++++++++++----
 net/bluetooth/hci_event.c        |   12 ++++++------
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8611e2e..6b3b632 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -450,7 +450,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status);
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst);
 int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
-void hci_conn_check_pending(struct hci_dev *hdev);
+void hci_conn_check_pending(struct hci_dev *hdev, u8 type);
 
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 						__u8 sec_level, __u8 auth_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fa6820e..cc36358 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -825,19 +825,46 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 }
 
 /* Check pending connect attempts */
-void hci_conn_check_pending(struct hci_dev *hdev)
+void hci_conn_check_pending(struct hci_dev *hdev, u8 type)
 {
 	struct hci_conn *conn;
+	struct adv_entry *entry;
 
 	BT_DBG("hdev %s", hdev->name);
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
-	if (conn)
-		hci_acl_connect(conn);
+	switch (type) {
+	case ACL_LINK:
+		conn = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
+		if (conn)
+			hci_acl_connect(conn);
+
+		break;
+	case LE_LINK:
+		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_OPEN);
+		if (!conn)
+			goto unlock;
+
+		entry = hci_find_adv_entry(hdev, &conn->dst);
+		if (!entry) {
+			u8 status = 0x04; /* mapped into EHOSTDOWN errno */
+			mgmt_connect_failed(hdev->id, &conn->dst, status);
+			hci_proto_connect_cfm(conn, status);
+			conn->state = BT_CLOSED;
+			hci_conn_del(conn);
+			goto unlock;
+		}
 
+		conn->dst_type = entry->bdaddr_type;
+		hci_le_connect(conn);
+
+		break;
+	}
+
+unlock:
 	hci_dev_unlock(hdev);
+
 }
 
 void hci_conn_hold_device(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9910f81..6bbf4d7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -64,7 +64,7 @@ static void hci_cc_inquiry_cancel(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY_CANCEL, status);
 
-	hci_conn_check_pending(hdev);
+	hci_conn_check_pending(hdev, ACL_LINK);
 
 	mgmt_discovering(hdev->id, 0);
 	mgmt_stop_discovery_complete(hdev->id);
@@ -79,7 +79,7 @@ static void hci_cc_exit_periodic_inq(struct hci_dev *hdev, struct sk_buff *skb)
 	if (status)
 		return;
 
-	hci_conn_check_pending(hdev);
+	hci_conn_check_pending(hdev, ACL_LINK);
 }
 
 static void hci_cc_remote_name_req_cancel(struct hci_dev *hdev, struct sk_buff *skb)
@@ -989,7 +989,7 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
 
 	if (status) {
 		hci_req_complete(hdev, HCI_OP_INQUIRY, status);
-		hci_conn_check_pending(hdev);
+		hci_conn_check_pending(hdev, ACL_LINK);
 
 		mgmt_start_discovery_failed(hdev->id, bt_to_errno(status));
 
@@ -1381,7 +1381,7 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	BT_DBG("%s status %d", hdev->name, status);
 
-	hci_conn_check_pending(hdev);
+	hci_conn_check_pending(hdev, ACL_LINK);
 
 	if (!test_bit(HCI_INQUIRY, &hdev->flags))
 		return;
@@ -1514,7 +1514,7 @@ static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 unlock:
 	hci_dev_unlock(hdev);
 
-	hci_conn_check_pending(hdev);
+	hci_conn_check_pending(hdev, ACL_LINK);
 }
 
 static inline void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
@@ -1693,7 +1693,7 @@ static inline void hci_remote_name_evt(struct hci_dev *hdev, struct sk_buff *skb
 
 	BT_DBG("%s", hdev->name);
 
-	hci_conn_check_pending(hdev);
+	hci_conn_check_pending(hdev, ACL_LINK);
 
 	hci_dev_lock(hdev);
 
-- 
1.7.5.2

