Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] bluetooth: Fix possible NULL dereference
Date: Wed,  3 Dec 2014 09:46:05 +0200
Message-Id: <1417592765-24836-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

conn might be NULL and would be dereferenced in conn_set_key()
---
 net/bluetooth/hci_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bd0a801..95f8057 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3312,7 +3312,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Update connection information since adding the key will have
 	 * fixed up the type in the case of changed combination keys.
 	 */
-	if (ev->key_type == HCI_LK_CHANGED_COMBINATION)
+	if (conn && ev->key_type == HCI_LK_CHANGED_COMBINATION)
 		conn_set_key(conn, key->type, key->pin_len);
 
 	mgmt_new_link_key(hdev, key, persistent);
-- 
1.9.1

