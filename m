Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose white list size information in debugfs
Date: Fri, 18 Oct 2013 15:23:46 -0700
Message-Id: <1382135026-48008-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Knowing the white list size information is important for
debugging. So export it via debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ee946cb..8710d1f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1116,9 +1116,12 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &sniff_max_interval_fops);
 	}
 
-	if (lmp_le_capable(hdev))
+	if (lmp_le_capable(hdev)) {
+		debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
+				  &hdev->le_white_list_size);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				   hdev, &static_address_fops);
+	}
 
 	return 0;
 }
-- 
1.8.3.1

