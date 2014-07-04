Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use list_del when freeing the list entry
Date: Fri,  4 Jul 2014 16:17:23 +0300
Message-Id: <1404479843-8770-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's wasteful to use list_del_init (which re-initializes the list_head)
if we're just about to free the element and never use it again.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f1672b15c0f3..90eabcae3ed2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5225,7 +5225,7 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		list_del_init(&params->action);
+		list_del(&params->action);
 		list_del(&params->list);
 		kfree(params);
 		hci_update_background_scan(hdev);
-- 
1.9.3

