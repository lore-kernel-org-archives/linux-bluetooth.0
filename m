Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix connectable and discoverable supported settings values
Date: Tue,  8 Jul 2014 16:07:34 +0300
Message-Id: <1404824854-1358-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The connectable and discoverable mgmt settings are supported both for LE
and BR/EDR controllers so they do not belong behind a lmp_bredr_capable()
condition. This patch fixes the issue in get_supported_settings().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a4232bc237f3..376b164c5250 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -555,12 +555,12 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_POWERED;
 	settings |= MGMT_SETTING_PAIRABLE;
 	settings |= MGMT_SETTING_DEBUG_KEYS;
+	settings |= MGMT_SETTING_CONNECTABLE;
+	settings |= MGMT_SETTING_DISCOVERABLE;
 
 	if (lmp_bredr_capable(hdev)) {
-		settings |= MGMT_SETTING_CONNECTABLE;
 		if (hdev->hci_ver >= BLUETOOTH_VER_1_2)
 			settings |= MGMT_SETTING_FAST_CONNECTABLE;
-		settings |= MGMT_SETTING_DISCOVERABLE;
 		settings |= MGMT_SETTING_BREDR;
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
-- 
1.9.3

