Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix SMP channel registration for unconfigured controllers
Date: Thu,  1 Jan 2015 02:05:16 -0800
Message-Id: <1420106716-13323-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the Bluetooth controllers requires an unconfigured state (for
example when the BD_ADDR is missing), then it is important to try
to register the SMP channels when the controller transitions to the
configured state.

This also fixes an issue with the debugfs entires that are not present
for controllers that start out as unconfigured.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 5ef5221c1813..6c12110b75a7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -931,10 +931,20 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	/* Only create debugfs entries during the initial setup
-	 * phase and not every time the controller gets powered on.
+	/* This function is only called when the controller is actually in
+	 * configured state. When the controller is marked as unconfigured,
+	 * this initialization procedure is not run.
+	 *
+	 * It means that it is possible that a controller runs through its
+	 * setup phase and then discovers missing settings. If that is the
+	 * case, then this function will not be called. It then will only
+	 * be called during the config phase.
+	 *
+	 * So only when in setup phase or config phase, create the debugfs
+	 * entries and register the SMP channels.
 	 */
-	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
+	if (!test_bit(HCI_SETUP, &hdev->dev_flags) &&
+	    !test_bit(HCI_CONFIG, &hdev->dev_flags))
 		return 0;
 
 	hci_debugfs_create_common(hdev);
-- 
2.1.0

