Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: btmrvl_main: Replace GFP_ATOMIC with GFP_KERNEL in btmrvl_send_sync_cmd
Date: Fri, 26 Jan 2018 23:57:01 +0800
Message-Id: <1516982221-8524-1-git-send-email-baijiaju1990@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After checking all possible call chains to btmrvl_send_sync_cmd(), 
my tool finds that this function is never called in atomic context, 
namely never in an interrupt handler or holding a spinlock. 
And it calls wait_event_interruptible_timeout() after bt_skb_alloc(), 
so it indicates that btmrvl_send_sync_cmd() 
can call function which can sleep.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/btmrvl_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index b280d46..f6c694a 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -183,7 +183,7 @@ static int btmrvl_send_sync_cmd(struct btmrvl_private *priv, u16 opcode,
 		return -EFAULT;
 	}
 
-	skb = bt_skb_alloc(HCI_COMMAND_HDR_SIZE + len, GFP_ATOMIC);
+	skb = bt_skb_alloc(HCI_COMMAND_HDR_SIZE + len, GFP_KERNEL);
 	if (!skb) {
 		BT_ERR("No free skb");
 		return -ENOMEM;
-- 
1.7.9.5

