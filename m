Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix using test_and_clear instead of test_and_set
Date: Thu, 10 Jul 2014 11:50:27 +0300
Message-Id: <1404982227-28321-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The code for updating the HCI_CONNECTABLE flag was incorrectly using
test_and_set_bit instead of test_and_clear_bit when HCI_CONNECTABLE is
to be cleared.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 84431b86af96..8f9df768f250 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2726,8 +2726,8 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 				changed = !test_and_set_bit(HCI_CONNECTABLE,
 							    &hdev->dev_flags);
 			else
-				changed = test_and_set_bit(HCI_CONNECTABLE,
-							   &hdev->dev_flags);
+				changed = test_and_clear_bit(HCI_CONNECTABLE,
+							     &hdev->dev_flags);
 
 			if (changed)
 				mgmt_new_settings(hdev);
-- 
1.9.3

