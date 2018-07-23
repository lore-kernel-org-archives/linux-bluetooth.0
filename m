Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] bluetooth: hci_intel: Replace GFP_ATOMIC with GFP_KERNEL in inject_cmd_complete()
Date: Mon, 23 Jul 2018 11:53:21 +0800
Message-Id: <20180723035321.8270-1-baijiaju1990@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

inject_cmd_complete() is only called by intel_dequeue(), 
which is never called in atomic context.

inject_cmd_complete() calls bt_skb_alloc() with GFP_ATOMIC, 
which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.
I also manually check the kernel code before reporting it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 7c166e3b308b..46ace321bf60 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -458,7 +458,7 @@ static int inject_cmd_complete(struct hci_dev *hdev, __u16 opcode)
 	struct hci_event_hdr *hdr;
 	struct hci_ev_cmd_complete *evt;
 
-	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_ATOMIC);
+	skb = bt_skb_alloc(sizeof(*hdr) + sizeof(*evt) + 1, GFP_KERNEL);
 	if (!skb)
 		return -ENOMEM;
 
-- 
2.17.0
