Return-Path: <cyrus@holtmann.org>
Date: Fri, 30 Jul 2010 21:54:49 -0700 (PDT)
Message-Id: <20100730.215449.226772568.davem@davemloft.net>
To: linux-bluetooth@vger.kernel.org
CC: marcel@holtmann.org
Subject: [PATCH] bluetooth: Use list_head for hci blacklist head.
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>


The bdaddr in the list root is completely unused and just
taking up space.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8b28962..4568b93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -132,7 +132,7 @@ struct hci_dev {
 
 	struct inquiry_cache	inq_cache;
 	struct hci_conn_hash	conn_hash;
-	struct bdaddr_list	blacklist;
+	struct list_head	blacklist;
 
 	struct hci_dev_stats	stat;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8303f1c..c52f091 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -924,7 +924,7 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	hci_conn_hash_init(hdev);
 
-	INIT_LIST_HEAD(&hdev->blacklist.list);
+	INIT_LIST_HEAD(&hdev->blacklist);
 
 	memset(&hdev->stat, 0, sizeof(struct hci_dev_stats));
 
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 4f170a5..83acd16 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -168,9 +168,8 @@ static int hci_sock_release(struct socket *sock)
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct list_head *p;
-	struct bdaddr_list *blacklist = &hdev->blacklist;
 
-	list_for_each(p, &blacklist->list) {
+	list_for_each(p, &hdev->blacklist) {
 		struct bdaddr_list *b;
 
 		b = list_entry(p, struct bdaddr_list, list);
@@ -202,7 +201,7 @@ static int hci_blacklist_add(struct hci_dev *hdev, void __user *arg)
 
 	bacpy(&entry->bdaddr, &bdaddr);
 
-	list_add(&entry->list, &hdev->blacklist.list);
+	list_add(&entry->list, &hdev->blacklist);
 
 	return 0;
 }
@@ -210,9 +209,8 @@ static int hci_blacklist_add(struct hci_dev *hdev, void __user *arg)
 int hci_blacklist_clear(struct hci_dev *hdev)
 {
 	struct list_head *p, *n;
-	struct bdaddr_list *blacklist = &hdev->blacklist;
 
-	list_for_each_safe(p, n, &blacklist->list) {
+	list_for_each_safe(p, n, &hdev->blacklist) {
 		struct bdaddr_list *b;
 
 		b = list_entry(p, struct bdaddr_list, list);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index ce44c47..8fb967b 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -439,12 +439,11 @@ static const struct file_operations inquiry_cache_fops = {
 static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
-	struct bdaddr_list *blacklist = &hdev->blacklist;
 	struct list_head *l;
 
 	hci_dev_lock_bh(hdev);
 
-	list_for_each(l, &blacklist->list) {
+	list_for_each(l, &hdev->blacklist) {
 		struct bdaddr_list *b;
 		bdaddr_t bdaddr;
 
