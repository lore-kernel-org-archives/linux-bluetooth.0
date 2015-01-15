Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add paranoid check for existing LE and BR/EDR SMP channels
Date: Thu, 15 Jan 2015 08:04:21 -0800
Message-Id: <1421337861-22334-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the SMP channels have been already registered, then print out a
clear WARN_ON message that something went wrong. Also unregister the
existing channels in this case before trying to register new ones.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 08a9314f3ca7..37d9180bfe1c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3072,6 +3072,12 @@ int smp_register(struct hci_dev *hdev)
 	if (!lmp_le_capable(hdev))
 		return 0;
 
+	if (WARN_ON(hdev->smp_data)) {
+		chan = hdev->smp_data;
+		hdev->smp_data = NULL;
+		smp_del_chan(chan);
+	}
+
 	chan = smp_add_cid(hdev, L2CAP_CID_SMP);
 	if (IS_ERR(chan))
 		return PTR_ERR(chan);
@@ -3091,6 +3097,12 @@ int smp_register(struct hci_dev *hdev)
 		return 0;
 	}
 
+	if (WARN_ON(hdev->smp_bredr_data)) {
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

