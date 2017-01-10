Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Wen-chien Jesse Sung <jesse.sung@canonical.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: Add a delay for module reset
Date: Tue, 10 Jan 2017 11:46:28 +0800
Message-Id: <1484019988-10644-1-git-send-email-jesse.sung@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some btbcm devices require more time to complete its reset process.
They won't reply any hci command until reset is done.

[ 17.218554] Bluetooth: hci0 command 0x1001 tx timeout
[ 25.214999] Bluetooth: hci0: BCM: Reading local version info failed (-110)

Signed-off-by: Wen-chien Jesse Sung <jesse.sung@canonical.com>
---
 drivers/bluetooth/btbcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index fdb4482..195763f 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -177,6 +177,8 @@ static int btbcm_reset(struct hci_dev *hdev)
 		return err;
 	}
 	kfree_skb(skb);
+	/* 100 msec delay for module to complete reset process */
+	msleep(100);
 
 	return 0;
 }
-- 
2.7.4

