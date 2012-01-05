Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Fix persistency of the HCI_MGMT flag
Date: Thu,  5 Jan 2012 17:16:14 +0200
Message-Id: <1325776582-10314-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
References: <1325776582-10314-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The HCI_MGMT flag needs to remain set even after closing an HCI device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 6d38d80..52edc11 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -670,8 +670,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	mgmt_powered(hdev, 0);
 	hci_dev_unlock(hdev);
 
-	/* Clear flags */
-	hdev->flags = 0;
+	/* Clear flags, except persistent ones like HCI_MGMT */
+	hdev->flags &= BIT(HCI_MGMT);
 
 	hci_req_unlock(hdev);
 
-- 
1.7.7.3

