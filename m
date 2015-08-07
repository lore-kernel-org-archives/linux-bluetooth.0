Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v10 2/6] Bluetooth: add hci_lookup_le_connect
Date: Fri,  7 Aug 2015 20:22:52 +0200
Message-Id: <1438971776-10903-2-git-send-email-jpawlowski@google.com>
In-Reply-To: <1438971776-10903-1-git-send-email-jpawlowski@google.com>
References: <1438971776-10903-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds hci_lookup_le_connect method, that will be used to check
wether outgoing le connection attempt is in progress.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
 net/bluetooth/hci_conn.c         |  5 ++---
 net/bluetooth/hci_event.c        |  4 ++--
 net/bluetooth/hci_request.c      |  6 ++----
 net/bluetooth/mgmt.c             |  2 +-
 5 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c8d2b5a..f0a9fc1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -811,6 +811,26 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == LE_LINK && c->state == BT_CONNECT &&
+		    !test_bit(HCI_CONN_SCANNING, &c->flags)) {
+			rcu_read_unlock();
+			return c;
+		}
+	}
+
+	rcu_read_unlock();
+
+	return NULL;
+}
+
 int hci_disconnect(struct hci_conn *conn, __u8 reason);
 bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..0b4d919 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -645,7 +645,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 
 	hci_dev_lock(hdev);
 
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	conn = hci_lookup_le_connect(hdev);
 	if (!conn)
 		goto done;
 
@@ -759,8 +759,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	/* Since the controller supports only one LE connection attempt at a
 	 * time, we return -EBUSY if there is any connection attempt running.
 	 */
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (conn)
+	if (hci_lookup_le_connect(hdev))
 		return ERR_PTR(-EBUSY);
 
 	/* When given an identity address with existing identity
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 218d7df..128c5b7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1059,7 +1059,7 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 
 		hci_dev_set_flag(hdev, HCI_LE_ADV);
 
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+		conn = hci_lookup_le_connect(hdev);
 		if (conn)
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
@@ -4447,7 +4447,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	 */
 	hci_dev_clear_flag(hdev, HCI_LE_ADV);
 
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
+	conn = hci_lookup_le_connect(hdev);
 	if (!conn) {
 		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr, ev->role);
 		if (!conn) {
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d6025d6..b736922 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -317,7 +317,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	 * address be updated at the next cycle.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+	    hci_lookup_le_connect(hdev)) {
 		BT_DBG("Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return;
@@ -479,7 +479,6 @@ void hci_update_page_scan(struct hci_dev *hdev)
 void __hci_update_background_scan(struct hci_request *req)
 {
 	struct hci_dev *hdev = req->hdev;
-	struct hci_conn *conn;
 
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
@@ -529,8 +528,7 @@ void __hci_update_background_scan(struct hci_request *req)
 		 * since some controllers are not able to scan and connect at
 		 * the same time.
 		 */
-		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-		if (conn)
+		if (hci_lookup_le_connect(hdev))
 			return;
 
 		/* If controller is currently scanning, we stop it to ensure we
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ab1915..35418bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4210,7 +4210,7 @@ static bool trigger_le_scan(struct hci_request *req, u16 interval, u8 *status)
 		/* Don't let discovery abort an outgoing connection attempt
 		 * that's using directed advertising.
 		 */
-		if (hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+		if (hci_lookup_le_connect(hdev)) {
 			*status = MGMT_STATUS_REJECTED;
 			return false;
 		}
-- 
2.1.4

