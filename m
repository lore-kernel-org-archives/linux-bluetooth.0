Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 1/4] Bluetooth: Use standard HCI cmd timeout for RESET
Date: Fri,  8 Jun 2012 11:12:43 +0300
Message-Id: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove magic and use standard HCI cmd timeout

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a2e15436c..e5a9a09 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -783,7 +783,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
-			      msecs_to_jiffies(250));
+			      msecs_to_jiffies(HCI_CMD_TIMEOUT));
 		clear_bit(HCI_INIT, &hdev->flags);
 	}
 
-- 
1.7.9.5

