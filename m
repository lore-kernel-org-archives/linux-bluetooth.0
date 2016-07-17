Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: bpa10x: Add support for hci_set_fw_info
Date: Sun, 17 Jul 2016 19:55:17 +0200
Message-Id: <1468778117-62931-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Digianswer sniffer devices allow for reading a firmware specific
information string. If it is available, then inform the Bluetooth core
about it via hci_set_fw_info. That exposes it via debugfs like this:

  # cat /sys/kernel/debug/bluetooth/hci0/firmware_info
  SNIF_102,BB930,02/01/18,10:37:56

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bpa10x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index fd6b53e9bbf2..a9932fe57d92 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -274,6 +274,8 @@ static int bpa10x_setup(struct hci_dev *hdev)
 
 	BT_INFO("%s: %s", hdev->name, (char *)(skb->data + 1));
 
+	hci_set_fw_info(hdev, "%s", skb->data + 1);
+
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.7.4

