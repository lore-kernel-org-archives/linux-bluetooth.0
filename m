Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9 v4] Bluetooth: Simplify UUID removal code
Date: Sun, 27 Jan 2013 00:31:30 +0200
Message-Id: <1359239495-3444-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
References: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The UUID removal code can be simplified by using
list_for_each_entry_safe instead of list_for_each_safe.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8de6d57..1e906d8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1372,7 +1372,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_remove_uuid *cp = data;
 	struct pending_cmd *cmd;
-	struct list_head *p, *n;
+	struct bt_uuid *match, *tmp;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	int err, found;
 
@@ -1400,9 +1400,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	found = 0;
 
-	list_for_each_safe(p, n, &hdev->uuids) {
-		struct bt_uuid *match = list_entry(p, struct bt_uuid, list);
-
+	list_for_each_entry_safe(match, tmp, &hdev->uuids, list) {
 		if (memcmp(match->uuid, cp->uuid, 16) != 0)
 			continue;
 
-- 
1.7.10.4

