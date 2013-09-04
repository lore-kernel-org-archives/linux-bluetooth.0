Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use GFP_KERNEL when cloning SKB in a workqueue
Date: Tue,  3 Sep 2013 18:11:07 -0700
Message-Id: <1378257067-52933-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to use GFP_ATOMIC with skb_clone() when the code is
executed in a workqueue.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1b86c78..4dbb6cb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3537,7 +3537,7 @@ static void hci_cmd_work(struct work_struct *work)
 
 		kfree_skb(hdev->sent_cmd);
 
-		hdev->sent_cmd = skb_clone(skb, GFP_ATOMIC);
+		hdev->sent_cmd = skb_clone(skb, GFP_KERNEL);
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
-- 
1.8.3.1

