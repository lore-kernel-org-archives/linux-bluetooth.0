Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] Bluetooth: mgmt: Fix current settings values when powered off
Date: Tue, 21 Feb 2012 19:43:46 +0200
Message-Id: <1329846229-7919-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
References: <1329846229-7919-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should not stop iterating through the various settings if powered off
since most may still be set even then.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index eec70a4..86e63a7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -392,10 +392,7 @@ static u32 get_current_settings(struct hci_dev *hdev)
 {
 	u32 settings = 0;
 
-	if (!test_bit(HCI_UP, &hdev->flags))
-		return settings;
-
-	if (!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (hdev_is_powered(hdev))
 		settings |= MGMT_SETTING_POWERED;
 
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-- 
1.7.9

