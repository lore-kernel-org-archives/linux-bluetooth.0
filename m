Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [RFC 4/4] Bluetooth: Correctly take device refcounts
Date: Fri, 28 Oct 2011 15:00:04 +0200
Message-Id: <1319806804-12230-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_dev->dev internal ref-count is used by hci core to protect the
hci_dev structure. We need to make sure to take this refcount when
calling hci_dev_hold/put(), otherwise we might end up with a valid
reference but a freed hci_dev structure.

We also entirely remove the second hci_dev->refcnt reference counter as
it is not used for anything right now.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    5 ++---
 net/bluetooth/hci_core.c         |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e5dc220..7fa1ab8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -116,7 +116,6 @@ struct adv_entry {
 struct hci_dev {
 	struct list_head list;
 	spinlock_t	lock;
-	atomic_t	refcnt;
 
 	char		name[8];
 	unsigned long	flags;
@@ -491,7 +490,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void __hci_dev_put(struct hci_dev *d)
 {
-	atomic_dec(&d->refcnt);
+	put_device(&d->dev);
 }
 
 static inline void hci_dev_put(struct hci_dev *d)
@@ -501,7 +500,7 @@ static inline void hci_dev_put(struct hci_dev *d)
 
 static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
 {
-	atomic_inc(&d->refcnt);
+	get_device(&d->dev);
 	return d;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fb981bd..53e3585 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1468,7 +1468,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->id = id;
 	list_add(&hdev->list, head);
 
-	atomic_set(&hdev->refcnt, 1);
 	spin_lock_init(&hdev->lock);
 
 	hdev->flags = 0;
@@ -1552,6 +1551,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	queue_work(hdev->workqueue, &hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
+	__hci_dev_hold(hdev);
 
 	return id;
 
-- 
1.7.7.1
