Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: Don't store debug keys if flag for them is not set
Date: Tue, 24 Jun 2014 13:15:51 +0300
Message-Id: <1403604953-19539-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of waiting for a disconnection to occur to remove a debug key
simply never store it in the list to begin with. This means we can also
remove the debug keys check when looking up keys in
hci_link_key_request_evt().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_event.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b0fdeec2f2ca..c92c5a020fe7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3066,12 +3066,6 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	BT_DBG("%s found key type %u for %pMR", hdev->name, key->type,
 	       &ev->bdaddr);
 
-	if (!test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags) &&
-	    key->type == HCI_LK_DEBUG_COMBINATION) {
-		BT_DBG("%s ignoring debug key", hdev->name);
-		goto not_found;
-	}
-
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
 		if ((key->type == HCI_LK_UNAUTH_COMBINATION_P192 ||
@@ -3141,8 +3135,18 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	mgmt_new_link_key(hdev, key, persistent);
 
-	if (conn)
+	/* Keep debug keys around only if the HCI_KEEP_DEBUG_KEYS flag
+	 * is set. If it's not set simply remove the key from the kernel
+	 * list (we've still notified user space about it but with
+	 * store_hint being 0).
+	 */
+	if (key->type == HCI_LK_DEBUG_COMBINATION &&
+	    !test_bit(HCI_KEEP_DEBUG_KEYS, &hdev->dev_flags)) {
+		list_del(&key->list);
+		kfree(key);
+	} else if (conn) {
 		conn->flush_key = !persistent;
+	}
 
 unlock:
 	hci_dev_unlock(hdev);
-- 
1.9.3

