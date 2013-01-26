Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9 v3] Bluetooth: Simplify UUIDs clearing code
Date: Sat, 26 Jan 2013 12:08:37 +0200
Message-Id: <1359194924-3151-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
References: <1359194924-3151-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code for clearing the UUIDs list can be simplified by using
list_for_each_entry_safe instead of list_for_each_safe.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e061b35..618ca1a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1183,14 +1183,10 @@ static void hci_discov_off(struct work_struct *work)
 
 int hci_uuids_clear(struct hci_dev *hdev)
 {
-	struct list_head *p, *n;
-
-	list_for_each_safe(p, n, &hdev->uuids) {
-		struct bt_uuid *uuid;
+	struct bt_uuid *uuid, *tmp;
 
-		uuid = list_entry(p, struct bt_uuid, list);
-
-		list_del(p);
+	list_for_each_entry_safe(uuid, tmp, &hdev->uuids, list) {
+		list_del(&uuid->list);
 		kfree(uuid);
 	}
 
-- 
1.7.10.4

