Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Bluetooth: Rename hdev->inq_cache to hdev->discovery
Date: Thu,  5 Jan 2012 17:16:20 +0200
Message-Id: <1325776582-10314-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This struct is used for not just inquiry caching but also for general
device discovery state tracking so it's better to rename it to something
more appropriate.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   16 ++++++++--------
 net/bluetooth/hci_core.c         |   12 ++++++------
 net/bluetooth/hci_sysfs.c        |    2 +-
 net/bluetooth/mgmt.c             |    2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 236f7f0..5a566fd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -56,7 +56,7 @@ struct inquiry_entry {
 	struct inquiry_data	data;
 };
 
-struct inquiry_cache {
+struct discovery_state {
 	struct list_head all;		/* All devices found during inquiry */
 	struct list_head unknown;	/* Name state not known */
 	struct list_head resolve;	/* Name needs to be resolved */
@@ -226,7 +226,7 @@ struct hci_dev {
 
 	struct list_head	mgmt_pending;
 
-	struct inquiry_cache	inq_cache;
+	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
 	struct list_head	blacklist;
 
@@ -357,21 +357,21 @@ extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
 #define INQUIRY_ENTRY_AGE_MAX   (HZ*60)   /* 60 seconds */
 
-static inline void inquiry_cache_init(struct hci_dev *hdev)
+static inline void discovery_init(struct hci_dev *hdev)
 {
-	INIT_LIST_HEAD(&hdev->inq_cache.all);
-	INIT_LIST_HEAD(&hdev->inq_cache.unknown);
-	INIT_LIST_HEAD(&hdev->inq_cache.resolve);
+	INIT_LIST_HEAD(&hdev->discovery.all);
+	INIT_LIST_HEAD(&hdev->discovery.unknown);
+	INIT_LIST_HEAD(&hdev->discovery.resolve);
 }
 
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
 {
-	return list_empty(&hdev->inq_cache.all);
+	return list_empty(&hdev->discovery.all);
 }
 
 static inline long inquiry_cache_age(struct hci_dev *hdev)
 {
-	struct inquiry_cache *c = &hdev->inq_cache;
+	struct discovery_state *c = &hdev->discovery;
 	return jiffies - c->timestamp;
 }
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5c0a1e7..82829c1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -357,7 +357,7 @@ struct hci_dev *hci_dev_get(int index)
 /* ---- Inquiry support ---- */
 static void inquiry_cache_flush(struct hci_dev *hdev)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *p, *n;
 
 	list_for_each_entry_safe(p, n, &cache->all, all) {
@@ -371,7 +371,7 @@ static void inquiry_cache_flush(struct hci_dev *hdev)
 
 struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
 	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
@@ -387,7 +387,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 							bdaddr_t *bdaddr)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
 	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
@@ -403,7 +403,7 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *ie;
 
 	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
@@ -445,7 +445,7 @@ update:
 
 static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_info *info = (struct inquiry_info *) buf;
 	struct inquiry_entry *e;
 	int copied = 0;
@@ -1546,7 +1546,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	init_waitqueue_head(&hdev->req_wait_q);
 	mutex_init(&hdev->req_lock);
 
-	inquiry_cache_init(hdev);
+	discovery_init(hdev);
 
 	hci_conn_hash_init(hdev);
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 3600d78..74b49e3 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -383,7 +383,7 @@ static struct device_type bt_host = {
 static int inquiry_cache_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
-	struct inquiry_cache *cache = &hdev->inq_cache;
+	struct discovery_state *cache = &hdev->discovery;
 	struct inquiry_entry *e;
 
 	hci_dev_lock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3977511..894f11b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2000,7 +2000,7 @@ static int confirm_name(struct sock *sk, u16 index, unsigned char *data,
 		list_del(&e->list);
 	} else {
 		e->name_state = NAME_NEEDED;
-		list_move(&e->list, &hdev->inq_cache.resolve);
+		list_move(&e->list, &hdev->discovery.resolve);
 	}
 
 	err = 0;
-- 
1.7.7.3

