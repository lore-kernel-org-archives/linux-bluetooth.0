Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add timeout for LE connection attempts
Date: Fri, 28 Feb 2014 17:28:46 +0200
Message-Id: <1393601326-7188-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

LE connection attempts do not have a controller side timeout in the same
way as BR/EDR has (in form of the page timeout). Since we always do
scanning before initiating connections the attempts are always expected
to succeed in some reasonable time.

This patch adds a timer which forces a cancellation of the connection
attempt within 20 seconds if it has not been successful by then. This
way we e.g. ensure that mgmt_pair_device times out eventually and gives
an error response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_conn.c         | 20 ++++++++++++++++++++
 net/bluetooth/hci_event.c        |  2 ++
 4 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0740fee39c73..086d3f83faee 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -183,6 +183,7 @@ enum {
 #define HCI_ACL_TX_TIMEOUT	msecs_to_jiffies(45000)	/* 45 seconds */
 #define HCI_AUTO_OFF_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
 #define HCI_POWER_OFF_TIMEOUT	msecs_to_jiffies(5000)	/* 5 seconds */
+#define HCI_LE_CONN_TIMEOUT	msecs_to_jiffies(20000)	/* 20 seconds */
 
 /* HCI data types */
 #define HCI_COMMAND_PKT		0x01
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index edf194679b7d..dbb788e4f265 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -375,6 +375,7 @@ struct hci_conn {
 	struct delayed_work disc_work;
 	struct delayed_work auto_accept_work;
 	struct delayed_work idle_work;
+	struct delayed_work le_conn_timeout;
 
 	struct device	dev;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 818330c1b2a2..3e3d4a4260c5 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -363,6 +363,16 @@ static void hci_conn_auto_accept(struct work_struct *work)
 		     &conn->dst);
 }
 
+static void le_conn_timeout(struct work_struct *work)
+{
+	struct hci_conn *conn = container_of(work, struct hci_conn,
+					     le_conn_timeout.work);
+
+	BT_DBG("");
+
+	hci_le_create_connection_cancel(conn);
+}
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
@@ -410,6 +420,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
 	INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
+	INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -442,6 +453,8 @@ int hci_conn_del(struct hci_conn *conn)
 		/* Unacked frames */
 		hdev->acl_cnt += conn->sent;
 	} else if (conn->type == LE_LINK) {
+		cancel_delayed_work_sync(&conn->le_conn_timeout);
+
 		if (hdev->le_pkts)
 			hdev->le_cnt += conn->sent;
 		else
@@ -590,6 +603,13 @@ static void hci_req_add_le_create_conn(struct hci_request *req,
 	hci_req_add(req, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
 
 	conn->state = BT_CONNECT;
+
+	/* We don't want the connection attempt to stick around
+	 * indefinitely since LE doesn't have a page timeout concept
+	 * like BR/EDR.
+	 */
+	queue_delayed_work(conn->hdev->workqueue, &conn->le_conn_timeout,
+			   HCI_LE_CONN_TIMEOUT);
 }
 
 static void stop_scan_complete(struct hci_dev *hdev, u8 status)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3ae8ae1a029c..4698dfd8042f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3794,6 +3794,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			conn->init_addr_type = ev->bdaddr_type;
 			bacpy(&conn->init_addr, &ev->bdaddr);
 		}
+	} else {
+		cancel_delayed_work(&conn->le_conn_timeout);
 	}
 
 	/* Ensure that the hci_conn contains the identity address type
-- 
1.8.5.3

