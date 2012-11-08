Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix memory leak when removing a UUID
Date: Thu,  8 Nov 2012 10:25:26 +0100
Message-Id: <1352366726-4308-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When removing a UUID from the list in the remove_uuid() function we must
also kfree the entry in addition to removing it from the list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ad1054f..142764a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1379,6 +1379,7 @@ static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 
 		list_del(&match->list);
+		kfree(match);
 		found++;
 	}
 
-- 
1.7.10.4

