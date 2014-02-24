Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix canceling RPA expiry timer
Date: Mon, 24 Feb 2014 20:35:07 +0200
Message-Id: <1393266907-25867-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The RPA expiry timer is only initialized inside mgmt.c when we receive
the first command from user space. This action also involves setting the
HCI_MGMT flag for the first time so that flag acts as a good indicator
of whether the delayed work variable can be touched or not. This patch
fixes hci_dev_do_close to first check the flag.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4bb4f4e7bbbe..669c76ec659a 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2257,7 +2257,9 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		cancel_delayed_work(&hdev->service_cache);
 
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
-	cancel_delayed_work_sync(&hdev->rpa_expired);
+
+	if (test_bit(HCI_MGMT, &hdev->dev_flags))
+		cancel_delayed_work_sync(&hdev->rpa_expired);
 
 	hci_dev_lock(hdev);
 	hci_inquiry_cache_flush(hdev);
-- 
1.8.5.3

