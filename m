Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCHv2 1/2] Bluetooth: Don't call shutdown when leaving user channel
Date: Tue,  9 Jun 2015 11:46:30 +0200
Message-Id: <1433843190-4252-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Don't interfere with the user channel exclusive access.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 v2: Rebase on d24d81444f8 (HCI_UP test)
 net/bluetooth/hci_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f6c9909..573711c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1553,6 +1553,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	BT_DBG("%s %p", hdev->name, hdev);
 
 	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
 	    test_bit(HCI_UP, &hdev->flags)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
-- 
1.9.1
