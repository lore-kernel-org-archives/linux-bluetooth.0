Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Subject: [PATCH 4/5] Bluetooth: Correctly take hci_dev->dev refcount
Date: Thu, 29 Dec 2011 16:40:41 +0100
Message-Id: <1325173242-12264-5-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
References: <1325173242-12264-1-git-send-email-dh.herrmann@googlemail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_dev->dev device structure has an internal refcount. This refcount is
used to protect the whole hci_dev object. However, we currently do not use it.
Therefore, if someone calls hci_free_dev() we currently immediately destroy the
hci_dev object because we never took the device refcount.

This even happens if the hci_dev->refcnt is not 0. In fact, the hci_dev->refcnt
is totally useless in its current state. Therefore, we simply remove
hci_dev->refcnt and instead use hci_dev->dev refcnt.

This fixes all the symptoms and also correctly integrates the device structure
into out bluetooth bus system.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
---
 include/net/bluetooth/hci_core.h |    5 ++---
 net/bluetooth/hci_core.c         |    2 +-
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 13f7c06..8b17d07 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -113,7 +113,6 @@ struct adv_entry {
 struct hci_dev {
 	struct list_head list;
 	struct mutex	lock;
-	atomic_t	refcnt;
 
 	char		name[8];
 	unsigned long	flags;
@@ -565,7 +564,7 @@ static inline void hci_conn_put(struct hci_conn *conn)
 /* ----- HCI Devices ----- */
 static inline void __hci_dev_put(struct hci_dev *d)
 {
-	atomic_dec(&d->refcnt);
+	put_device(&d->dev);
 }
 
 /*
@@ -576,7 +575,7 @@ static inline void __hci_dev_put(struct hci_dev *d)
 
 static inline struct hci_dev *__hci_dev_hold(struct hci_dev *d)
 {
-	atomic_inc(&d->refcnt);
+	get_device(&d->dev);
 	return d;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0c7e2b2..4dbbfbc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1474,7 +1474,6 @@ int hci_register_dev(struct hci_dev *hdev)
 	hdev->id = id;
 	list_add_tail(&hdev->list, head);
 
-	atomic_set(&hdev->refcnt, 1);
 	mutex_init(&hdev->lock);
 
 	hdev->flags = 0;
@@ -1558,6 +1557,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	schedule_work(&hdev->power_on);
 
 	hci_notify(hdev, HCI_DEV_REG);
+	__hci_dev_hold(hdev);
 
 	return id;
 
-- 
1.7.8.1
