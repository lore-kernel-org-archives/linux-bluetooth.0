Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Prefer sizeof(*ptr) when allocating memory
Date: Mon, 21 Jul 2014 10:50:06 +0300
Message-Id: <1405929006-21537-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's safer practice to use sizeof(*ptr) instead of sizeof(ptr_type) when
allocating memory in case the type changes. This also fixes the
following style of warnings from static analyzers:

CHECK: Prefer kzalloc(sizeof(*ie)...) over kzalloc(sizeof(struct inquiry_entry)...)
+	ie = kzalloc(sizeof(struct inquiry_entry), GFP_KERNEL);

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c   | 4 ++--
 net/bluetooth/hci_core.c   | 6 +++---
 net/bluetooth/l2cap_core.c | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 1ac9f7f52acd..b50dabb3f86a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -428,7 +428,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
 
 	BT_DBG("%s dst %pMR", hdev->name, dst);
 
-	conn = kzalloc(sizeof(struct hci_conn), GFP_KERNEL);
+	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn)
 		return NULL;
 
@@ -1282,7 +1282,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 
 	BT_DBG("%s hcon %p", hdev->name, conn);
 
-	chan = kzalloc(sizeof(struct hci_chan), GFP_KERNEL);
+	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
 	if (!chan)
 		return NULL;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f82a6cf1aaa8..cfcb6055ced8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2088,7 +2088,7 @@ u32 hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	}
 
 	/* Entry not in the cache. Add new one. */
-	ie = kzalloc(sizeof(struct inquiry_entry), GFP_KERNEL);
+	ie = kzalloc(sizeof(*ie), GFP_KERNEL);
 	if (!ie) {
 		flags |= MGMT_DEV_FOUND_CONFIRM_NAME;
 		goto done;
@@ -3492,7 +3492,7 @@ int hci_bdaddr_list_add(struct list_head *list, bdaddr_t *bdaddr, u8 type)
 	if (hci_bdaddr_list_lookup(list, bdaddr, type))
 		return -EEXIST;
 
-	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
 	if (!entry)
 		return -ENOMEM;
 
@@ -3897,7 +3897,7 @@ struct hci_dev *hci_alloc_dev(void)
 {
 	struct hci_dev *hdev;
 
-	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
+	hdev = kzalloc(sizeof(*hdev), GFP_KERNEL);
 	if (!hdev)
 		return NULL;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f3fb61c9f96f..46547b920f88 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6985,7 +6985,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon)
 	if (!hchan)
 		return NULL;
 
-	conn = kzalloc(sizeof(struct l2cap_conn), GFP_KERNEL);
+	conn = kzalloc(sizeof(*conn), GFP_KERNEL);
 	if (!conn) {
 		hci_chan_del(hchan);
 		return NULL;
-- 
1.9.3

