Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@codecoup.pl>
Subject: [PATCH v2] Bluetooth: Fix powering on with privacy and advertising
Date: Sun, 22 Nov 2015 21:42:21 +0100
Message-Id: <1448224941-834-1-git-send-email-andrzej.kaczmarek@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to enable advertising with privacy enabled, SMP has to be
registered in order to generate new RPA. During power on, it will be
registered at the very end which is the reason why advertising is not
enabled and it's not possible to enable it anymore due to mismatch
between hci_dev settings and actual controller state.

This fixes this problem by moving SMP registration earlier, just after
controller is powered (which is ok, because LE SMP will be already able
to decide on identity address to be used), but before advertising is
enabled.
---
 net/bluetooth/mgmt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dc8e428..e8a2f8b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7305,13 +7305,6 @@ static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 	BT_DBG("status 0x%02x", status);
 
 	if (!status) {
-		/* Register the available SMP channels (BR/EDR and LE) only
-		 * when successfully powering on the controller. This late
-		 * registration is required so that LE SMP can clearly
-		 * decide if the public address or static address is used.
-		 */
-		smp_register(hdev);
-
 		restart_le_actions(hdev);
 		hci_update_background_scan(hdev);
 	}
@@ -7423,6 +7416,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 		return 0;
 
 	if (powered) {
+		/* Register the available SMP channels (BR/EDR and LE) only
+		 * when successfully powering on the controller. This late
+		 * registration is required so that LE SMP can clearly
+		 * decide if the public address or static address is used.
+		 */
+		smp_register(hdev);
+
 		if (powered_update_hci(hdev) == 0)
 			return 0;
 
-- 
2.6.2

