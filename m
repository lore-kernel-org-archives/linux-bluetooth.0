Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Johan Hedberg <johan.hedberg@nokia.com>
Subject: [PATCH] Bluetooth: Don't clear the blacklist when closing the HCI device
Date: Thu,  9 Sep 2010 10:32:39 +0300
Message-Id: <1284017559-13510-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

Clearing the blacklist in hci_dev_do_close() would mean that user space
needs to do extra work to re-block devices after a DEVDOWN-DEVUP cycle.
This patch removes the clearing of the blacklist in this case and
thereby saves user space from the extra work.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/hci_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c52f091..bc2a052 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -562,7 +562,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hci_dev_lock_bh(hdev);
 	inquiry_cache_flush(hdev);
 	hci_conn_hash_flush(hdev);
-	hci_blacklist_clear(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	hci_notify(hdev, HCI_DEV_DOWN);
-- 
1.7.0.4

