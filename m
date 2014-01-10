Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 04/15] Bluetooth: Add definitions for new link key types
Date: Fri, 10 Jan 2014 02:07:19 -0800
Message-Id: <1389348450-23303-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With the introduction of Secure Connections, the list of link key types
got extended by P-256 versions of authenticated and unauthenticated
link keys.

To avoid any confusion the previous authenticated and unauthenticated
link key types got ammended with a P912 postfix. And the two new keys
have a P256 postfix now. Existing code using the previous definitions
has been adjusted.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h | 6 ++++--
 net/bluetooth/hci_conn.c    | 4 ++--
 net/bluetooth/hci_event.c   | 2 +-
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e4e94bfc5232..8d888bc432c6 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -331,9 +331,11 @@ enum {
 #define HCI_LK_LOCAL_UNIT		0x01
 #define HCI_LK_REMOTE_UNIT		0x02
 #define HCI_LK_DEBUG_COMBINATION	0x03
-#define HCI_LK_UNAUTH_COMBINATION	0x04
-#define HCI_LK_AUTH_COMBINATION		0x05
+#define HCI_LK_UNAUTH_COMBINATION_P192	0x04
+#define HCI_LK_AUTH_COMBINATION_P192	0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
+#define HCI_LK_UNAUTH_COMBINATION_P256	0x07
+#define HCI_LK_AUTH_COMBINATION_P256	0x08
 /* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
 #define HCI_SMP_STK			0x80
 #define HCI_SMP_STK_SLAVE		0x81
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ba5366c320da..251f22e32fbf 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -802,12 +802,12 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	/* An authenticated combination key has sufficient security for any
 	   security level. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION)
+	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P192)
 		goto encrypt;
 
 	/* An unauthenticated combination key has sufficient security for
 	   security level 1 and 2. */
-	if (conn->key_type == HCI_LK_UNAUTH_COMBINATION &&
+	if (conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 &&
 	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
 		goto encrypt;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfcce448957b..defa1252b534 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2633,7 +2633,7 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
-		if (key->type == HCI_LK_UNAUTH_COMBINATION &&
+		if (key->type == HCI_LK_UNAUTH_COMBINATION_P192 &&
 		    conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
 			BT_DBG("%s ignoring unauthenticated key", hdev->name);
 			goto not_found;
-- 
1.8.4.2

