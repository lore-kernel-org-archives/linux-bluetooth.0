Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Clear pending connections from hci_conn_params_clear
Date: Sun, 29 Jun 2014 13:41:50 +0200
Message-Id: <1404042111-60574-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When hci_conn_params_clear is called, it is always followed by a
call to hci_pend_le_conns_clear. So instead of making this explicit
just make sure it is always called. This makes this function similar
on how hci_conn_params_add and hci_conn_params_del work.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ffee5f547506..8b206d0942aa 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -959,7 +959,6 @@ static ssize_t le_auto_conn_write(struct file *file, const char __user *data,
 	} else if (memcmp(buf, "clr", 3) == 0) {
 		hci_dev_lock(hdev);
 		hci_conn_params_clear(hdev);
-		hci_pend_le_conns_clear(hdev);
 		hci_update_background_scan(hdev);
 		hci_dev_unlock(hdev);
 	} else {
@@ -3561,6 +3560,8 @@ void hci_conn_params_clear(struct hci_dev *hdev)
 		kfree(params);
 	}
 
+	hci_pend_le_conns_clear(hdev);
+
 	BT_DBG("All LE connection parameters were removed");
 }
 
@@ -4006,7 +4007,6 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_remote_oob_data_clear(hdev);
 	hci_white_list_clear(hdev);
 	hci_conn_params_clear(hdev);
-	hci_pend_le_conns_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
-- 
1.9.3

