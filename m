Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Sort to-be-resolved devices by RSSI during discovery
Date: Mon,  9 Jan 2012 13:46:05 +0200
Message-Id: <1326109565-32631-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
References: <1326109565-32631-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes sure that devices with stronger signal (RSSI closer to
0) are sorted first in the resolve list and will therefore get their
names resolved first during device discovery. Since it's more likely
that the device the user is trying to discover has a strong signal due
to its proximity this ensures that the user gets the "device found"
event for it more quickly.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_core.c         |   28 +++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 25a6c3f..1f73a63 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -399,6 +399,8 @@ struct inquiry_entry *hci_inquiry_cache_lookup_unknown(struct hci_dev *hdev,
 struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 							bdaddr_t *bdaddr,
 							int state);
+void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
+						struct inquiry_entry *ie);
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f86571d..05788cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -457,6 +457,25 @@ struct inquiry_entry *hci_inquiry_cache_lookup_resolve(struct hci_dev *hdev,
 	return NULL;
 }
 
+void hci_inquiry_cache_update_resolve(struct hci_dev *hdev,
+						struct inquiry_entry *ie)
+{
+	struct discovery_state *cache = &hdev->discovery;
+	struct list_head *pos = &cache->resolve;
+	struct inquiry_entry *p;
+
+	list_del(&ie->list);
+
+	list_for_each_entry(p, &cache->resolve, list) {
+		if (p->name_state != NAME_PENDING &&
+				abs(p->data.rssi) >= abs(ie->data.rssi))
+			break;
+		pos = &p->list;
+	}
+
+	list_add(&ie->list, pos);
+}
+
 bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 							bool name_known)
 {
@@ -466,8 +485,15 @@ bool hci_inquiry_cache_update(struct hci_dev *hdev, struct inquiry_data *data,
 	BT_DBG("cache %p, %s", cache, batostr(&data->bdaddr));
 
 	ie = hci_inquiry_cache_lookup(hdev, &data->bdaddr);
-	if (ie)
+	if (ie) {
+		if (ie->name_state == NAME_NEEDED &&
+						data->rssi != ie->data.rssi) {
+			ie->data.rssi = data->rssi;
+			hci_inquiry_cache_update_resolve(hdev, ie);
+		}
+
 		goto update;
+	}
 
 	/* Entry not in the cache. Add new one. */
 	ie = kzalloc(sizeof(struct inquiry_entry), GFP_ATOMIC);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3de1e90..2dae2e8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2043,7 +2043,7 @@ static int confirm_name(struct sock *sk, u16 index, unsigned char *data,
 		list_del(&e->list);
 	} else {
 		e->name_state = NAME_NEEDED;
-		list_move(&e->list, &hdev->discovery.resolve);
+		hci_inquiry_cache_update_resolve(hdev, e);
 	}
 
 	err = 0;
-- 
1.7.8.2

