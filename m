Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add a convenience function to check for SSP enabled
Date: Thu, 19 Jan 2012 11:42:53 +0200
Message-Id: <1326966173-20105-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
References: <1326966173-20105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's a very common test to see if both the local and the remote device
have SSP enabled. By creating a simple function to test this we can
shorten many if-statements in the code.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    7 +++++++
 net/bluetooth/hci_conn.c         |    8 ++------
 net/bluetooth/hci_event.c        |   12 ++++--------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 94ba869..25f449f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -411,6 +411,13 @@ enum {
 	HCI_CONN_REMOTE_OOB,
 };
 
+static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	return (test_bit(HCI_SSP_ENABLED, &hdev->flags) &&
+				test_bit(HCI_CONN_SSP_ENABLED, &conn->flags));
+}
+
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6ec259e..eae7a53 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -608,9 +608,7 @@ int hci_conn_check_link_mode(struct hci_conn *conn)
 {
 	BT_DBG("conn %p", conn);
 
-	if (test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) &&
-			test_bit(HCI_SSP_ENABLED, &conn->hdev->dev_flags) &&
-			!(conn->link_mode & HCI_LM_ENCRYPT))
+	if (hci_conn_ssp_enabled(conn) && !(conn->link_mode & HCI_LM_ENCRYPT))
 		return 0;
 
 	return 1;
@@ -672,9 +670,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	/* For non 2.1 devices and low security level we don't need the link
 	   key. */
-	if (sec_level == BT_SECURITY_LOW &&
-			(!test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) ||
-			!test_bit(HCI_SSP_ENABLED, &conn->hdev->dev_flags)))
+	if (sec_level == BT_SECURITY_LOW && !hci_conn_ssp_enabled(conn))
 		return 1;
 
 	/* For other security levels we need the link key. */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3163d18..b24c663 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1270,8 +1270,7 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 
 	/* Only request authentication for SSP connections or non-SSP
 	 * devices with sec_level HIGH or if MITM protection is requested */
-	if (!(test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
-			test_bit(HCI_CONN_SSP_ENABLED, &conn->flags)) &&
+	if (!hci_conn_ssp_enabled(conn) &&
 				conn->pending_sec_level != BT_SECURITY_HIGH &&
 				!(conn->auth_type & 0x01))
 		return 0;
@@ -1845,9 +1844,8 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 		goto unlock;
 
 	if (!ev->status) {
-		if (!(test_bit(HCI_CONN_SSP_ENABLED, &conn->flags) &&
-				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags)) &&
-				test_bit(HCI_CONN_REAUTH_PEND,	&conn->flags)) {
+		if (!hci_conn_ssp_enabled(conn) &&
+				test_bit(HCI_CONN_REAUTH_PEND, &conn->flags)) {
 			BT_INFO("re-auth of legacy device is not possible.");
 		} else {
 			conn->link_mode |= HCI_LM_AUTH;
@@ -1861,9 +1859,7 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 	clear_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 
 	if (conn->state == BT_CONFIG) {
-		if (!ev->status &&
-				test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
-				test_bit(HCI_CONN_SSP_ENABLED, &conn->flags)) {
+		if (!ev->status && hci_conn_ssp_enabled(conn)) {
 			struct hci_cp_set_conn_encrypt cp;
 			cp.handle  = ev->handle;
 			cp.encrypt = 0x01;
-- 
1.7.8.3

