Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/2] Bluetooth: Correct version check in hci_setup
Date: Thu, 24 Nov 2011 14:36:29 +0200
Message-Id: <1322138190-21593-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Check for hci_ver instead of lmp_ver

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_event.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index dfe6fbc..7da7ef6 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -562,7 +562,7 @@ static void hci_setup(struct hci_dev *hdev)
 {
 	hci_setup_event_mask(hdev);
 
-	if (hdev->lmp_ver > 1)
+	if (hdev->hci_ver > 1)
 		hci_send_cmd(hdev, HCI_OP_READ_LOCAL_COMMANDS, 0, NULL);
 
 	if (hdev->features[6] & LMP_SIMPLE_PAIR) {
-- 
1.7.4.1

