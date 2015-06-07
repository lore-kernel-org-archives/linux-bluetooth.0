Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btusb: Fix memory leak in Intel setup routine
Date: Sun,  7 Jun 2015 09:42:19 +0200
Message-Id: <1433662939-30065-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The SKB returned from the Intel specific version information command is
missing a kfree_skb.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
Cc: stable@vger.kernel.org
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c956250176b3..7f936db169f5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1616,6 +1616,8 @@ static int btusb_setup_intel(struct hci_dev *hdev)
 	}
 	fw_ptr = fw->data;
 
+	kfree_skb(skb);
+
 	/* This Intel specific command enables the manufacturer mode of the
 	 * controller.
 	 *
-- 
2.4.2

