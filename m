Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/15] Bluetooth: Convert hdev->out to a bool type
Date: Wed, 18 Jan 2012 20:51:54 +0200
Message-Id: <1326912717-6347-13-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
References: <1326912717-6347-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hdev->out variable is essentially a boolean so the type 'bool' makes
more sense than u8.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_conn.c         |    8 ++++----
 net/bluetooth/hci_event.c        |    4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4440e49..40efe33 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -281,7 +281,7 @@ struct hci_conn {
 	__u16		state;
 	__u8		mode;
 	__u8		type;
-	__u8		out;
+	bool		out;
 	__u8		attempt;
 	__u8		dev_class[3];
 	__u8		features[8];
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c1fc6a9..4fb7b4f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -51,7 +51,7 @@ static void hci_le_connect(struct hci_conn *conn)
 	struct hci_cp_le_create_conn cp;
 
 	conn->state = BT_CONNECT;
-	conn->out = 1;
+	conn->out = true;
 	conn->link_mode |= HCI_LM_MASTER;
 	conn->sec_level = BT_SECURITY_LOW;
 
@@ -83,7 +83,7 @@ void hci_acl_connect(struct hci_conn *conn)
 	BT_DBG("%p", conn);
 
 	conn->state = BT_CONNECT;
-	conn->out = 1;
+	conn->out = true;
 
 	conn->link_mode = HCI_LM_MASTER;
 
@@ -152,7 +152,7 @@ void hci_add_sco(struct hci_conn *conn, __u16 handle)
 	BT_DBG("%p", conn);
 
 	conn->state = BT_CONNECT;
-	conn->out = 1;
+	conn->out = true;
 
 	conn->attempt++;
 
@@ -170,7 +170,7 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 	BT_DBG("%p", conn);
 
 	conn->state = BT_CONNECT;
-	conn->out = 1;
+	conn->out = true;
 
 	conn->attempt++;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 21ab6e7..f49f64f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1160,7 +1160,7 @@ static inline void hci_cs_create_conn(struct hci_dev *hdev, __u8 status)
 		if (!conn) {
 			conn = hci_conn_add(hdev, ACL_LINK, &cp->bdaddr);
 			if (conn) {
-				conn->out = 1;
+				conn->out = true;
 				conn->link_mode |= HCI_LM_MASTER;
 			} else
 				BT_ERR("No memory for new connection");
@@ -1532,7 +1532,7 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, __u8 status)
 			conn = hci_conn_add(hdev, LE_LINK, &cp->peer_addr);
 			if (conn) {
 				conn->dst_type = cp->peer_addr_type;
-				conn->out = 1;
+				conn->out = true;
 			} else {
 				BT_ERR("No memory for new connection");
 			}
-- 
1.7.8.3

