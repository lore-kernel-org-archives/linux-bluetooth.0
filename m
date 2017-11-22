Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: btqcomsmd: Fix skb double free corruption
Date: Wed, 22 Nov 2017 15:03:17 +0100
Message-Id: <1511359397-25523-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

In case of hci send frame failure, skb is still owned
by the caller (hci_core) and then should not be freed.

This fixes crash on dragonboard-410c when sending SCO
packet. skb is freed by both btqcomsmd and hci_core.

Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/btqcomsmd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 663bed6..2c9a5fc 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -88,7 +88,8 @@ static int btqcomsmd_send(struct hci_dev *hdev, struct sk_buff *skb)
 		break;
 	}
 
-	kfree_skb(skb);
+	if (!ret)
+		kfree_skb(skb);
 
 	return ret;
 }
-- 
2.7.4
