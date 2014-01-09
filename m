Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: Add support for handling P-256 derived link keys
Date: Thu,  9 Jan 2014 12:56:25 -0800
Message-Id: <1389300990-20255-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Before being able to enable Secure Connections support, the core needs
to know on how to handle P-256 derived link keys. The difference between
authenticated and unauthenticated P-256 derived link keys is the same as
its P-192 counter parts.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_conn.c  | 6 ++++--
 net/bluetooth/hci_event.c | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 251f22e32fbf..cf96b3438a91 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -802,12 +802,14 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 	/* An authenticated combination key has sufficient security for any
 	   security level. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P192)
+	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
+	    conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
 		goto encrypt;
 
 	/* An unauthenticated combination key has sufficient security for
 	   security level 1 and 2. */
-	if (conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 &&
+	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
+	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
 	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
 		goto encrypt;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index defa1252b534..b3c5396e0c1b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2633,7 +2633,8 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
-		if (key->type == HCI_LK_UNAUTH_COMBINATION_P192 &&
+		if ((key->type == HCI_LK_UNAUTH_COMBINATION_P192 ||
+		     key->type == HCI_LK_UNAUTH_COMBINATION_P256) &&
 		    conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
 			BT_DBG("%s ignoring unauthenticated key", hdev->name);
 			goto not_found;
-- 
1.8.4.2

