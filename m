Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Don't register any SMP channel if LE is not supported
Date: Wed, 14 Jan 2015 15:43:10 -0800
Message-Id: <1421278991-4169-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When LE features are not supported, then do not bother registering any
kind of SMP channel.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3e4de935f667..08a9314f3ca7 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3066,6 +3066,12 @@ int smp_register(struct hci_dev *hdev)
 
 	BT_DBG("%s", hdev->name);
 
+	/* If the controller does not support Low Energy operation, then
+	 * there is also no need to register any SMP channel.
+	 */
+	if (!lmp_le_capable(hdev))
+		return 0;
+
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP);
 	if (IS_ERR(chan))
 		return PTR_ERR(chan);
-- 
2.1.0

