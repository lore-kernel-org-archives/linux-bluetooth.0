Return-Path: <vaibhavmurkute88@gmail.com>
From: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vaibhav Murkute <vaibhavmurkute88@gmail.com>
Subject: [PATCH] drivers: bluetooth: hci_serdev: Removed unnecessary curly braces
Date: Fri, 11 May 2018 15:12:32 -0700
Message-Id: <1526076752-5871-1-git-send-email-vaibhavmurkute88@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

checkpatch.pl shows a warning for these unnecessary curly braces.
so just removed those curly braces.

Signed-off-by: Vaibhav Murkute <vaibhavmurkute88@gmail.com>
---
 drivers/bluetooth/hci_serdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index e0e6461..137c314 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -204,9 +204,9 @@ static int hci_uart_setup(struct hci_dev *hdev)
 		return 0;
 	}
 
-	if (skb->len != sizeof(*ver)) {
+	if (skb->len != sizeof(*ver))
 		bt_dev_err(hdev, "Event length mismatch for version info");
-	}
+
 
 	kfree_skb(skb);
 	return 0;
-- 
2.7.4
