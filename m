Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Bluetooth: Convert inquiry cache to use standard list types
Date: Thu,  5 Jan 2012 17:16:15 +0200
Message-Id: <1325776582-10314-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This makes it possible to use the convenience functions provided for
standard kernel list types and it also makes it easier to extend the use
of the cache for the management interface where e.g. name resolving
control will be needed.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   10 ++++------
 net/bluetooth/hci_core.c         |   31 +++++++++++++++++--------------
 net/bluetooth/hci_sysfs.c        |    2 +-
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ea9231f..91d1baf 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -44,14 +44,14 @@ struct inquiry_data {
 };
 
 struct inquiry_entry {
-	struct inquiry_entry	*next;
+	struct list_head	list;
 	__u32			timestamp;
 	struct inquiry_data	data;
 };
 
 struct inquiry_cache {
+	struct list_head	list;
 	__u32			timestamp;
-	struct inquiry_entry	*list;
 };
 
 struct hci_conn_hash {
@@ -350,14 +350,12 @@ extern int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
 
 static inline void inquiry_cache_init(struct hci_dev *hdev)
 {
-	struct inquiry_cache *c = &hdev->inq_cache;
-	c->list = NULL;
+	INIT_LIST_HEAD(&hdev->inq_cache.list);
 }
 
 static inline int inquiry_cache_empty(struct hci_dev *hdev)
 {
-	struct inquiry_cache *c = &hdev->inq_cache;
-	return c->list == NULL;
+	return list_empty(&hdev->inq_cache.list);
 }
 
 static inline long inquiry_cache_age(struct hci_dev *hdev)
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52edc11..39214e1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -357,15 +357,11 @@ struct hci_dev *hci_dev_get(int index)
 /* ---- Inquiry support ---- */
 static void inquiry_cache_flush(struct hci_dev *hdev)
 {
-	struct inquiry_cache *cache = &hdev->inq_cache;
-	struct inquiry_entry *next  = cache->list, *e;
-
-	BT_DBG("cache %p", cache);
+	struct inquiry_entry *p, *n;
 
-	cache->list = NULL;
-	while ((e = next)) {
-		next = e->next;
-		kfree(e);
+	list_for_each_entry_safe(p, n, &hdev->inq_cache.list, list) {
+		list_del(&p->list);
+		kfree(p);
 	}
 }
 
@@ -376,10 +372,12 @@ struct inquiry_entry *hci_inquiry_cache_lookup(struct hci_dev *hdev, bdaddr_t *b
 
 	BT_DBG("cache %p, %s", cache, batostr(bdaddr));
 
-	for (e = cache->list; e; e = e->next)
+	list_for_each_entry(e, &cache->list, list) {
 		if (!bacmp(&e->data.bdaddr, bdaddr))
-			break;
-	return e;
+			return e;
+	}
+
+	return NULL;
 }
 
 void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
@@ -396,8 +394,7 @@ void hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data)
 		if (!ie)
 			return;
 
-		ie->next = cache->list;
-		cache->list = ie;
+		list_add(&ie->list, &cache->list);
 	}
 
 	memcpy(&ie->data, data, sizeof(*data));
@@ -412,15 +409,21 @@ static int inquiry_cache_dump(struct hci_dev *hdev, int num, __u8 *buf)
 	struct inquiry_entry *e;
 	int copied = 0;
 
-	for (e = cache->list; e && copied < num; e = e->next, copied++) {
+	list_for_each_entry(e, &cache->list, list) {
 		struct inquiry_data *data = &e->data;
+
+		if (copied >= num)
+			break;
+
 		bacpy(&info->bdaddr, &data->bdaddr);
 		info->pscan_rep_mode	= data->pscan_rep_mode;
 		info->pscan_period_mode	= data->pscan_period_mode;
 		info->pscan_mode	= data->pscan_mode;
 		memcpy(info->dev_class, data->dev_class, 3);
 		info->clock_offset	= data->clock_offset;
+
 		info++;
+		copied++;
 	}
 
 	BT_DBG("cache %p, copied %d", cache, copied);
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 5210956..ed9ccee 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -388,7 +388,7 @@ static int inquiry_cache_show(struct seq_file *f, void *p)
 
 	hci_dev_lock(hdev);
 
-	for (e = cache->list; e; e = e->next) {
+	list_for_each_entry(e, &cache->list, list) {
 		struct inquiry_data *data = &e->data;
 		seq_printf(f, "%s %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
 			   batostr(&data->bdaddr),
-- 
1.7.7.3

