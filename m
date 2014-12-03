Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Simplify Link Key Notification event handling logic
Date: Wed,  3 Dec 2014 11:03:06 +0200
Message-Id: <1417597386-24060-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we get a Link Key Notification HCI event we should already have a
hci_conn object. This should have been created either in the Connection
Request event handler, the hci_connect_acl() function or the
hci_cs_create_conn() function (if the request was not sent by the
kernel).

Since the only case that we'd end up not having a hci_conn in the Link
Key Notification event handler would be essentially broken hardware it's
safe to simply bail out from the function if this happens.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index bd0a80120665..d76d4f821189 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3294,12 +3294,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
-	if (conn) {
-		hci_conn_hold(conn);
-		conn->disc_timeout = HCI_DISCONN_TIMEOUT;
-		hci_conn_drop(conn);
-		conn_set_key(conn, ev->key_type, conn->pin_length);
-	}
+	if (!conn)
+		goto unlock;
+
+	hci_conn_hold(conn);
+	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
+	hci_conn_drop(conn);
+
+	conn_set_key(conn, ev->key_type, conn->pin_length);
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
 		goto unlock;
@@ -3326,13 +3328,14 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags)) {
 		list_del_rcu(&key->list);
 		kfree_rcu(key, rcu);
-	} else if (conn) {
-		if (persistent)
-			clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
-		else
-			set_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+		goto unlock;
 	}
 
+	if (persistent)
+		clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+	else
+		set_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+
 unlock:
 	hci_dev_unlock(hdev);
 }
-- 
2.1.0

