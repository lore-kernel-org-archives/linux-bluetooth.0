Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove unnecessary call to hci_update_background_scan
Date: Tue, 10 Nov 2015 09:38:40 +0200
Message-Id: <1447141121-27941-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The hci_conn_params_clear_all() function is only called from
hci_unregister_dev() at which point it's completely futile to try to
do any LE scanning updates. Simply remove this unnecessary function
call.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c270feaac8a1..704e75f989d0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3072,8 +3072,6 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list)
 		hci_conn_params_free(params);
 
-	hci_update_background_scan(hdev);
-
 	BT_DBG("All LE connection parameters were removed");
 }
 
-- 
2.5.0

