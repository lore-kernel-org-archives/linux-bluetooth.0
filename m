Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 1/2] Bluetooth: Don't call shutdown when leaving user channel
Date: Thu, 21 May 2015 16:46:40 +0200
Message-Id: <1432219601-3663-1-git-send-email-loic.poulain@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Don't interfere with the user channel exclusive access.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 476709b..5120fea 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1557,7 +1557,8 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 {
 	BT_DBG("%s %p", hdev->name, hdev);
 
-	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
+	if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
+	    !hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Execute vendor specific shutdown routine */
 		if (hdev->shutdown)
 			hdev->shutdown(hdev);
-- 
1.9.1
