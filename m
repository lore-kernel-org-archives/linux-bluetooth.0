Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Add address type to device blacklist table
Date: Thu, 17 Oct 2013 17:24:13 -0700
Message-Id: <1382055860-12572-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The device blacklist is not taking care of the address type. Actually
store the address type in the list entries and also use them when
looking up addresses in the table.

This is actually a serious bug. When adding a LE public address to
the blacklist, then it would be blocking a device on BR/EDR. And this
is not the expected behavior.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  3 ++-
 net/bluetooth/hci_core.c         | 21 +++++++++++----------
 net/bluetooth/hci_event.c        |  2 +-
 3 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 07c2da4..c6becda 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -81,6 +81,7 @@ struct hci_conn_hash {
 struct bdaddr_list {
 	struct list_head list;
 	bdaddr_t bdaddr;
+	u8 bdaddr_type;
 };
 
 struct bt_uuid {
@@ -732,7 +733,7 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg);
 int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
-					 bdaddr_t *bdaddr);
+					 bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b7c4ada..2376c30 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2158,13 +2158,15 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
-struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
+struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
+					 bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *b;
 
-	list_for_each_entry(b, &hdev->blacklist, list)
-		if (bacmp(bdaddr, &b->bdaddr) == 0)
+	list_for_each_entry(b, &hdev->blacklist, list) {
+		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
 			return b;
+	}
 
 	return NULL;
 }
@@ -2174,9 +2176,7 @@ int hci_blacklist_clear(struct hci_dev *hdev)
 	struct list_head *p, *n;
 
 	list_for_each_safe(p, n, &hdev->blacklist) {
-		struct bdaddr_list *b;
-
-		b = list_entry(p, struct bdaddr_list, list);
+		struct bdaddr_list *b = list_entry(p, struct bdaddr_list, list);
 
 		list_del(p);
 		kfree(b);
@@ -2189,10 +2189,10 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
-	if (bacmp(bdaddr, BDADDR_ANY) == 0)
+	if (!bacmp(bdaddr, BDADDR_ANY))
 		return -EBADF;
 
-	if (hci_blacklist_lookup(hdev, bdaddr))
+	if (hci_blacklist_lookup(hdev, bdaddr, type))
 		return -EEXIST;
 
 	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
@@ -2200,6 +2200,7 @@ int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 		return -ENOMEM;
 
 	bacpy(&entry->bdaddr, bdaddr);
+	entry->bdaddr_type = type;
 
 	list_add(&entry->list, &hdev->blacklist);
 
@@ -2210,10 +2211,10 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	struct bdaddr_list *entry;
 
-	if (bacmp(bdaddr, BDADDR_ANY) == 0)
+	if (!bacmp(bdaddr, BDADDR_ANY))
 		return hci_blacklist_clear(hdev);
 
-	entry = hci_blacklist_lookup(hdev, bdaddr);
+	entry = hci_blacklist_lookup(hdev, bdaddr, type);
 	if (!entry)
 		return -ENOENT;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c3b193..e43de98 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1692,7 +1692,7 @@ static void hci_conn_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				      &flags);
 
 	if ((mask & HCI_LM_ACCEPT) &&
-	    !hci_blacklist_lookup(hdev, &ev->bdaddr)) {
+	    !hci_blacklist_lookup(hdev, &ev->bdaddr, BDADDR_BREDR)) {
 		/* Connection accepted */
 		struct inquiry_entry *ie;
 		struct hci_conn *conn;
-- 
1.8.3.1

