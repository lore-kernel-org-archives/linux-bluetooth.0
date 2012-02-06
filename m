Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix device reset
Date: Mon,  6 Feb 2012 15:59:03 +0200
Message-Id: <1328536743-8343-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/hci_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e77cc79..3f30714 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -822,7 +822,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
-				test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
+			!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
 					msecs_to_jiffies(250));
-- 
1.7.8.3

