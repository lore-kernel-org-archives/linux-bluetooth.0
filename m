Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/10] Bluetooth: Fix controller list for AMP discover response
Date: Sat,  5 Oct 2013 11:47:40 -0700
Message-Id: <1380998869-64411-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The AMP discover response should list exactly one BR/EDR controller
and ignore all other BR/EDR controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/a2mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 17f33a6..eb0f05e 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -92,7 +92,7 @@ static void __a2mp_add_cl(struct amp_mgr *mgr, struct a2mp_cl *cl, u8 num_ctrl)
 
 	list_for_each_entry(hdev, &hci_dev_list, list) {
 		/* Iterate through AMP controllers */
-		if (hdev->id == HCI_BREDR_ID)
+		if (hdev->dev_type != HCI_AMP)
 			continue;
 
 		/* Starting from second entry */
-- 
1.8.3.1

