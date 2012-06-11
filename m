Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/5] Bluetooth: Fix not setting HCI_RESET flag for AMP
Date: Mon, 11 Jun 2012 11:13:10 +0300
Message-Id: <1339402390-32320-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339402390-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1339143166-6523-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1339402390-32320-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Move reset function to common initialization section fixing
not setting HCI_RESET flag for amp_init.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4f804ff..7a6ff57 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -188,12 +188,6 @@ static void bredr_init(struct hci_dev *hdev)
 
 	/* Mandatory initialization */
 
-	/* Reset */
-	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
-		set_bit(HCI_RESET, &hdev->flags);
-		hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
-	}
-
 	/* Read Local Supported Features */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_FEATURES, 0, NULL);
 
@@ -234,9 +228,6 @@ static void amp_init(struct hci_dev *hdev)
 {
 	hdev->flow_ctl_mode = HCI_FLOW_CTL_MODE_BLOCK_BASED;
 
-	/* Reset */
-	hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
-
 	/* Read Local Version */
 	hci_send_cmd(hdev, HCI_OP_READ_LOCAL_VERSION, 0, NULL);
 
@@ -262,6 +253,10 @@ static void hci_init_req(struct hci_dev *hdev, unsigned long opt)
 	}
 	skb_queue_purge(&hdev->driver_init);
 
+	/* Reset */
+	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks))
+		hci_reset_req(hdev, 0);
+
 	switch (hdev->dev_type) {
 	case HCI_BREDR:
 		bredr_init(hdev);
-- 
1.7.9.5

