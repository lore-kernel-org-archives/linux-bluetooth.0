Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add paranoid check for existing LE and BR/EDR SMP channels
Date: Wed, 14 Jan 2015 16:01:02 -0800
Message-Id: <1421280062-14191-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the SMP channels have been already registered, then print out a
clear error message that something when wrong. Also unregister the
existing channels in this case before trying to register new ones.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 08a9314f3ca7..150dfd59efa0 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3072,6 +3072,13 @@ int smp_register(struct hci_dev *hdev)
 	if (!lmp_le_capable(hdev))
 		return 0;
 
+	if (hdev->smp_data) {
+		BT_ERR("%s Found existing LE Security Manager", hdev->name);
+		chan = hdev->smp_data;
+		hdev->smp_data = NULL;
+		smp_del_chan(chan);
+	}
+
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP);
 	if (IS_ERR(chan))
 		return PTR_ERR(chan);
@@ -3091,6 +3098,13 @@ int smp_register(struct hci_dev *hdev)
 		return 0;
 	}
 
+	if (hdev->smp_bredr_data) {
+		BT_ERR("%s Found existing BR/EDR Security Manager", hdev->name);
+		chan = hdev->smp_bredr_data;
+		hdev->smp_bredr_data = NULL;
+		smp_del_chan(chan);
+	}
+
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP_BREDR);
 	if (IS_ERR(chan)) {
 		int err = PTR_ERR(chan);
-- 
2.1.0

