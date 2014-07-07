Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't try background scanning if LE is not enabled
Date: Mon,  7 Jul 2014 15:19:50 +0300
Message-Id: <1404735590-4378-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For adapters that do not support LE and ones where LE hasn't been
enabled we shouldn't be trying to initiate background scanning. This
patch adds an extra check to the hci_update_background_scan() to ensure
that we bail out if HCI_LE_ENABLED is not set.

Since we do allow user space to feed the kernel with LE connection
parameters even when LE is not enabled we now need to also call
hci_update_background_scan() as soon as LE gets enabled so that scanning
gets started if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++++
 net/bluetooth/mgmt.c     | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6790dc8cff99..f1c5a077e558 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5403,6 +5403,10 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	    test_bit(HCI_UNREGISTER, &hdev->dev_flags))
 		return;
 
+	/* No point in doing scanning if LE support hasn't been enabled */
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return;
+
 	/* If discovery is active don't interfere with it */
 	if (hdev->discovery.state != DISCOVERY_STOPPED)
 		return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b391e2fef4b6..9cc7108f4c45 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2152,6 +2152,8 @@ static void le_enable_complete(struct hci_dev *hdev, u8 status)
 		update_scan_rsp_data(&req);
 		hci_req_run(&req, NULL);
 
+		hci_update_background_scan(hdev);
+
 		hci_dev_unlock(hdev);
 	}
 }
-- 
1.9.3

