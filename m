Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Use lmp_bredr_capable where applicable
Date: Tue, 24 Jul 2012 15:03:46 -0300
Message-Id: <1343153033-898-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch replaces all LMP_NO_BREDR bit checking by the helper
macro lmp_bredr_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 2a0f695..990ec6a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -383,7 +383,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (hdev->features[6] & LMP_SIMPLE_PAIR)
 		settings |= MGMT_SETTING_SSP;
 
-	if (!(hdev->features[4] & LMP_NO_BREDR)) {
+	if (lmp_bredr_capable(hdev)) {
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
 	}
@@ -413,7 +413,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_PAIRABLE, &hdev->dev_flags))
 		settings |= MGMT_SETTING_PAIRABLE;
 
-	if (!(hdev->features[4] & LMP_NO_BREDR))
+	if (lmp_bredr_capable(hdev))
 		settings |= MGMT_SETTING_BREDR;
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
-- 
1.7.11.2

