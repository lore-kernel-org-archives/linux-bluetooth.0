Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: btusb: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
Date: Mon, 23 Jul 2018 11:38:51 +0800
Message-Id: <20180723033851.8141-1-baijiaju1990@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

inject_cmd_complete() is only called by btusb_send_frame_intel(), 
which is set to hdev->send, and hdev->send() is never 
called in atomic context.

inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c8c8b0b8d333..1586c54a01f1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1870,7 +1870,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	struct hci_event_hdr *hdr;
 	struct hci_ev_cmd_complete *evt;
 
-	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-- 
2.17.0

