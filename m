Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/15] Bluetooth: Add Privacy lag to mgmt supported/current settings
Date: Sat, 22 Feb 2014 19:06:35 +0200
Message-Id: <1393088805-28658-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
References: <1393088805-28658-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch makes sure that the Privacy flag is available in the mgmt
supported settings for all LE capable controllers and in the current
settings whenever the HCI_PRIVACY flag is set.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 37a6c4eab881..301b18a1c6a0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -390,6 +390,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	if (lmp_le_capable(hdev)) {
 		settings |= MGMT_SETTING_LE;
 		settings |= MGMT_SETTING_ADVERTISING;
+		settings |= MGMT_SETTING_PRIVACY;
 	}
 
 	return settings;
@@ -438,6 +439,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_DEBUG_KEYS, &hdev->dev_flags))
 		settings |= MGMT_SETTING_DEBUG_KEYS;
 
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags))
+		settings |= MGMT_SETTING_PRIVACY;
+
 	return settings;
 }
 
-- 
1.8.5.3

