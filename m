Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: mgmt: Fix EIR toggling with SSP
Date: Wed, 22 Feb 2012 16:02:41 +0200
Message-Id: <1329919363-23660-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch fixes setting the EIR properly when the SSP flag has been set
when powered off (in such a case there is no pending Set_SSP command).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9fb4490..bdaadb2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3437,14 +3437,13 @@ int mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 	if (changed)
 		err = new_settings(hdev, match.sk);
 
-	if (match.sk) {
+	if (match.sk)
 		sock_put(match.sk);
 
-		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
-			update_eir(hdev);
-		else
-			clear_eir(hdev);
-	}
+	if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags))
+		update_eir(hdev);
+	else
+		clear_eir(hdev);
 
 	return err;
 }
-- 
1.7.9

