Return-Path: <vaibhavmurkute88@gmail.com>
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Subject: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly braces
Date: Mon, 14 May 2018 14:38:47 -0700
Message-Id: <1526333927-21222-1-git-send-email-vaibhavmurkute88@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

checkpatch.pl shows a warning for these unnecessary curly braces.
so just removed those curly braces.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461..a0e9398 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -204,9 +204,8 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		return 0;
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver))
 		bt_dev_err(hdev, "Event length mismatch for version info");
-	}
 
 	kfree_skb(skb);
 	return 0;
-- 
2.7.4
