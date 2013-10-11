Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Don't advertise high speed support without SSP
Date: Fri, 11 Oct 2013 09:48:47 -0700
Message-Id: <1381510127-1094-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is not allowed to enable high speed support when Secure Simple
Pairing is not available or disabled.

However the support for high speed gets advertised on a controller
that does not even support Secure Simple Pairing. Since there is
no way to enable high speed support on such a controller, do not
even advertise its support.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f57ec19..aa59490 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -363,9 +363,6 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_POWERED;
 	settings |= MGMT_SETTING_PAIRABLE;
 
-	if (lmp_ssp_capable(hdev))
-		settings |= MGMT_SETTING_SSP;
-
 	if (lmp_bredr_capable(hdev)) {
 		settings |= MGMT_SETTING_CONNECTABLE;
 		if (hdev->hci_ver >= BLUETOOTH_VER_1_2)
@@ -373,7 +370,11 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_DISCOVERABLE;
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
-		settings |= MGMT_SETTING_HS;
+
+		if (lmp_ssp_capable(hdev)) {
+			settings |= MGMT_SETTING_SSP;
+			settings |= MGMT_SETTING_HS;
+		}
 	}
 
 	if (lmp_le_capable(hdev)) {
-- 
1.8.3.1

