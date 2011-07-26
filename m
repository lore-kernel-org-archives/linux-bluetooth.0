Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Peter Hurley <peter@hurleysoftware.com>,
	Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] Don't use cmd_timer to timeout HCI reset command
Date: Tue, 26 Jul 2011 22:46:54 +0200
Message-Id: <1311713214-2414-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No command should be send before Command Complete event for HCI
reset is received. This fix regression introduced by commit
6bd32326cda(Bluetooth: Use proper timer for hci command timout)
for chips whose reset command takes longer to complete (e.g. CSR)
resulting in next command being send before HCI reset completed.

Signed-off-by: Szymon Janc <szymon@janc.net.pl>
---
 net/bluetooth/hci_core.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 908fcd3..3b39198 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1209,7 +1209,6 @@ static void hci_cmd_timer(unsigned long arg)
 
 	BT_ERR("%s command tx timeout", hdev->name);
 	atomic_set(&hdev->cmd_cnt, 1);
-	clear_bit(HCI_RESET, &hdev->flags);
 	tasklet_schedule(&hdev->cmd_task);
 }
 
@@ -2408,7 +2407,10 @@ static void hci_cmd_task(unsigned long arg)
 		if (hdev->sent_cmd) {
 			atomic_dec(&hdev->cmd_cnt);
 			hci_send_frame(skb);
-			mod_timer(&hdev->cmd_timer,
+			if (test_bit(HCI_RESET, &hdev->flags))
+				del_timer(&hdev->cmd_timer);
+			else
+				mod_timer(&hdev->cmd_timer,
 				  jiffies + msecs_to_jiffies(HCI_CMD_TIMEOUT));
 		} else {
 			skb_queue_head(&hdev->cmd_q, skb);
-- 
1.7.5.4


