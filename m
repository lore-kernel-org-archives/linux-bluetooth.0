Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 09/26] Bluetooth: Fix clearing flags on power off before notifying mgmt
Date: Wed, 13 Mar 2013 11:12:00 -0700
Message-Id: <1363198337-3896-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
References: <1363198337-3896-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering off the device the hdev->flags and hdev->dev_flags need to
be cleared before calling mgmt_powered(). If this is not done the
resulting events sent to user space may contain incorrect values.

Note that the HCI_AUTO_OFF flag accessed right after this is part of the
persistent flags, so it's unchanged by the hdev->dev_flags reset.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 37ee261..5436e02 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1130,6 +1130,10 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	 * and no tasks are scheduled. */
 	hdev->close(hdev);
 
+	/* Clear flags */
+	hdev->flags = 0;
+	hdev->dev_flags &= HCI_PERSISTENT_MASK;
+
 	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
 	    mgmt_valid_hdev(hdev)) {
 		hci_dev_lock(hdev);
@@ -1137,10 +1141,6 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 		hci_dev_unlock(hdev);
 	}
 
-	/* Clear flags */
-	hdev->flags = 0;
-	hdev->dev_flags &= HCI_PERSISTENT_MASK;
-
 	/* Controller radio is available but is currently powered down */
 	hdev->amp_status = 0;
 
-- 
1.7.10.4

