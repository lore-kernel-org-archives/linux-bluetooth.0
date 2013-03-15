Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 08/26] Bluetooth: Clear non-persistent flags when closing HCI device
Date: Fri, 15 Mar 2013 17:06:58 -0500
Message-Id: <1363385236-25704-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When hci_dev_do_close() is called we should make sure to clear all
non-persistent flags in hci->dev_flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 02070dc..059bbae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1139,6 +1139,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Clear flags */
 	hdev->flags = 0;
+	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
 	/* Controller radio is available but is currently powered down */
 	hdev->amp_status = 0;
-- 
1.7.10.4

