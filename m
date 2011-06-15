Return-Path: <cyrus@holtmann.org>
From: Antti Julku <antti.julku@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Antti Julku <antti.julku@nokia.com>
Subject: [PATCH 1/2] Bluetooth: Move blacklisting functions to hci_core
Date: Wed, 15 Jun 2011 12:01:14 +0300
Message-Id: <1308128475-11670-1-git-send-email-antti.julku@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move blacklisting functions to hci_core.c, so that they can
be used by both management interface and hci socket interface.

Signed-off-by: Antti Julku <antti.julku@nokia.com>
---
 include/net/bluetooth/hci_core.h |    2 +
 net/bluetooth/hci_core.c         |   79 ++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_sock.c         |   70 +++------------------------------
 3 files changed, 87 insertions(+), 64 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fe05946..26233d4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -529,6 +529,8 @@ int hci_inquiry(void __user *arg);
 
 struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_blacklist_clear(struct hci_dev *hdev);
+int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f62ca19..8f5bee1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1205,6 +1205,85 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 	return 0;
 }
 
+struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
+						bdaddr_t *bdaddr)
+{
+	struct list_head *p;
+
+	list_for_each(p, &hdev->blacklist) {
+		struct bdaddr_list *b;
+
+		b = list_entry(p, struct bdaddr_list, list);
+
+		if (bacmp(bdaddr, &b->bdaddr) == 0)
+			return b;
+	}
+
+	return NULL;
+}
+
+int hci_blacklist_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->blacklist) {
+		struct bdaddr_list *b;
+
+		b = list_entry(p, struct bdaddr_list, list);
+
+		list_del(p);
+		kfree(b);
+	}
+
+	return 0;
+}
+
+int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct bdaddr_list *entry;
+
+	hci_dev_lock(hdev);
+
+	if (bacmp(bdaddr, BDADDR_ANY) == 0)
+		return -EBADF;
+
+	if (hci_blacklist_lookup(hdev, bdaddr))
+		return -EEXIST;
+
+	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, bdaddr);
+
+	list_add(&entry->list, &hdev->blacklist);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct bdaddr_list *entry;
+
+	hci_dev_lock(hdev);
+
+	if (bacmp(bdaddr, BDADDR_ANY) == 0)
+		return hci_blacklist_clear(hdev);
+
+	entry = hci_blacklist_lookup(hdev, bdaddr);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
 static void hci_clear_adv_cache(unsigned long arg)
 {
 	struct hci_dev *hdev = (void *) arg;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 295e4a8..ff02cf5 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -180,82 +180,24 @@ static int hci_sock_release(struct socket *sock)
 	return 0;
 }
 
-struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
-{
-	struct list_head *p;
-
-	list_for_each(p, &hdev->blacklist) {
-		struct bdaddr_list *b;
-
-		b = list_entry(p, struct bdaddr_list, list);
-
-		if (bacmp(bdaddr, &b->bdaddr) == 0)
-			return b;
-	}
-
-	return NULL;
-}
-
-static int hci_blacklist_add(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_blacklist_add(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
-	struct bdaddr_list *entry;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	if (bacmp(&bdaddr, BDADDR_ANY) == 0)
-		return -EBADF;
-
-	if (hci_blacklist_lookup(hdev, &bdaddr))
-		return -EEXIST;
-
-	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
-	if (!entry)
-		return -ENOMEM;
-
-	bacpy(&entry->bdaddr, &bdaddr);
-
-	list_add(&entry->list, &hdev->blacklist);
-
-	return 0;
-}
-
-int hci_blacklist_clear(struct hci_dev *hdev)
-{
-	struct list_head *p, *n;
-
-	list_for_each_safe(p, n, &hdev->blacklist) {
-		struct bdaddr_list *b;
-
-		b = list_entry(p, struct bdaddr_list, list);
-
-		list_del(p);
-		kfree(b);
-	}
-
-	return 0;
+	return hci_blacklist_add(hdev, &bdaddr);
 }
 
-static int hci_blacklist_del(struct hci_dev *hdev, void __user *arg)
+static int hci_sock_blacklist_del(struct hci_dev *hdev, void __user *arg)
 {
 	bdaddr_t bdaddr;
-	struct bdaddr_list *entry;
 
 	if (copy_from_user(&bdaddr, arg, sizeof(bdaddr)))
 		return -EFAULT;
 
-	if (bacmp(&bdaddr, BDADDR_ANY) == 0)
-		return hci_blacklist_clear(hdev);
-
-	entry = hci_blacklist_lookup(hdev, &bdaddr);
-	if (!entry)
-		return -ENOENT;
-
-	list_del(&entry->list);
-	kfree(entry);
-
-	return 0;
+	return hci_blacklist_del(hdev, &bdaddr);
 }
 
 /* Ioctls that require bound socket */
@@ -290,12 +232,12 @@ static inline int hci_sock_bound_ioctl(struct sock *sk, unsigned int cmd, unsign
 	case HCIBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
-		return hci_blacklist_add(hdev, (void __user *) arg);
+		return hci_sock_blacklist_add(hdev, (void __user *) arg);
 
 	case HCIUNBLOCKADDR:
 		if (!capable(CAP_NET_ADMIN))
 			return -EACCES;
-		return hci_blacklist_del(hdev, (void __user *) arg);
+		return hci_sock_blacklist_del(hdev, (void __user *) arg);
 
 	default:
 		if (hdev->ioctl)
-- 
1.7.2.5

