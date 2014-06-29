Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Update background scanning from hci_conn_params_clear
Date: Sun, 29 Jun 2014 13:41:51 +0200
Message-Id: <1404042111-60574-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When calling hci_conn_params_clear function, it should update the
background scanning properly and not require a separate call to
update it.

For the case when the function is used during unregister of a
controller, an extra safe guard is but in place.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8b206d0942aa..c566b57610c9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -959,7 +959,6 @@ static ssize_t le_auto_conn_write(struct file *file, const char __user *data,
 	} else if (memcmp(buf, "clr", 3) == 0) {
 		hci_dev_lock(hdev);
 		hci_conn_params_clear(hdev);
-		hci_update_background_scan(hdev);
 		hci_dev_unlock(hdev);
 	} else {
 		err = -EINVAL;
@@ -3483,6 +3482,8 @@ void hci_pend_le_conns_clear(struct hci_dev *hdev)
 	}
 
 	BT_DBG("All LE pending connections cleared");
+
+	hci_update_background_scan(hdev);
 }
 
 /* This function requires the caller holds hdev->lock */
@@ -5293,6 +5294,9 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	struct hci_conn *conn;
 	int err;
 
+	if (test_bit(HCI_UNREGISTER, &hdev->dev_flags))
+		return;
+
 	hci_req_init(&req, hdev);
 
 	if (list_empty(&hdev->pend_le_conns)) {
-- 
1.9.3

