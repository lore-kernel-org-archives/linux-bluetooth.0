Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 1/6] Bluetooth: add HCI_LE_CONNECTING hci_dev flags
Date: Wed, 29 Jul 2015 11:21:49 +0200
Message-Id: <1438161714-4521-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds HCI_LE_CONNECTING flag to hci_dev flags, that will be set
when connect attempt is pending. It also uses this flag instead of conn
hash lookup where appropriate to check wether connect is in progress.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h | 1 +
 net/bluetooth/hci_conn.c    | 3 +--
 net/bluetooth/hci_event.c   | 4 ++++
 net/bluetooth/hci_request.c | 6 ++----
 net/bluetooth/mgmt.c        | 2 +-
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 7ca6690..4772ff8 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -240,6 +240,7 @@ enum {
 	HCI_DUT_MODE,
 	HCI_FORCE_BREDR_SMP,
 	HCI_FORCE_STATIC_ADDR,
+	HCI_LE_CONNECTING,
 
 	__HCI_NUM_FLAGS,
 };
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 2c48bf0..1ba8240 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -759,8 +759,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	/* Since the controller supports only one LE connection attempt at a
 	 * time, we return -EBUSY if there is any connection attempt running.
 	 */
-	conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
-	if (conn)
+	if (hci_dev_test_flag(hdev, HCI_LE_CONNECTING))
 		return ERR_PTR(-EBUSY);
 
 	/* When given an identity address with existing identity
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 32363c2..18fccf8 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2005,6 +2005,8 @@ static void hci_cs_le_create_conn(struct hci_dev *hdev, u8 status)
 
 	hci_dev_lock(hdev);
 
+	hci_dev_set_flag(hdev, HCI_LE_CONNECTING);
+
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->peer_addr);
 	if (!conn)
 		goto unlock;
@@ -4535,6 +4537,8 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_dev_lock(hdev);
 
+	hci_dev_clear_flag(hdev, HCI_LE_CONNECTING);
+
 	/* All controllers implicitly stop advertising in the event of a
 	 * connection, so ensure that the state bit is cleared.
 	 */
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index d6025d6..daebb75 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -317,7 +317,7 @@ static void set_random_addr(struct hci_request *req, bdaddr_t *rpa)
 	 * address be updated at the next cycle.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+	    hci_dev_test_flag(hdev, HCI_LE_CONNECTING)) {
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
+		if (hci_dev_test_flag(hdev, HCI_LE_CONNECTING))
 			return;
 
 		/* If controller is currently scanning, we stop it to ensure we
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7ab1915..c35d671 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4210,7 +4210,7 @@ static bool trigger_le_scan(struct hci_request *req, u16 interval, u8 *status)
 		/* Don't let discovery abort an outgoing connection attempt
 		 * that's using directed advertising.
 		 */
-		if (hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_CONNECTING)) {
 			*status = MGMT_STATUS_REJECTED;
 			return false;
 		}
-- 
2.1.4

