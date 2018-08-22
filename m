Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: mka@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1 2/2] Bluetooth: hci_serdev: Add protocol check in hci_uart_dequeue().
Date: Wed, 22 Aug 2018 17:34:12 +0530
Message-Id: <20180822120412.20285-3-bgodavar@codeaurora.org>
In-Reply-To: <20180822120412.20285-1-bgodavar@codeaurora.org>
References: <20180822120412.20285-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This will help to check the status of protocol while dequeuing an
skb packet. In some instaces we will end up kernel crash,
where proto close is called and we trying to dequeue an packet.

[  500.142902] [<ffffff80080f9ce4>] do_raw_spin_lock+0x1c/0xe0
[  500.148643] [<ffffff80088f1c7c>] _raw_spin_lock_irqsave+0x38/0x48
[  500.154917] [<ffffff8008780ce8>] skb_dequeue+0x28/0x84
[  500.160209] [<ffffff8000ad6f48>] 0xffffff8000ad6f48
[  500.165230] [<ffffff8000ad6610>] 0xffffff8000ad6610
[  500.170257] [<ffffff80080c7ce8>] process_one_work+0x238/0x3e4
[  500.176174] [<ffffff80080c8330>] worker_thread+0x2bc/0x3d4
[  500.181821] [<ffffff80080cdabc>] kthread+0x138/0x140
[  500.186945] [<ffffff80080844e0>] ret_from_fork+0x10/0x18

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/hci_serdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index 46e20444ba19..a541e6ee085e 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -57,9 +57,10 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
 {
 	struct sk_buff *skb = hu->tx_skb;
 
-	if (!skb)
-		skb = hu->proto->dequeue(hu);
-	else
+	if (!skb) {
+		if (test_bit(HCI_UART_PROTO_READY, &hu->flags))
+			skb = hu->proto->dequeue(hu);
+	} else
 		hu->tx_skb = NULL;
 
 	return skb;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
