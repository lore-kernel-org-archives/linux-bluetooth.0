Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 08/26] Bluetooth: Clear non-persistent flags when closing HCI device
Date: Wed, 13 Mar 2013 11:11:59 -0700
Message-Id: <1363198337-3896-9-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When hci_dev_do_close() is called we should make sure to clear all
non-persistent flags in hci->dev_flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 02070dc..37ee261 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1139,6 +1139,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Clear flags */
 	hdev->flags = 0;
+	hdev->dev_flags &= HCI_PERSISTENT_MASK;
 
 	/* Controller radio is available but is currently powered down */
 	hdev->amp_status = 0;
-- 
1.7.10.4

