Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/9] Bluetooth: Check for flag instead of features in update_scan_rsp_data()
Date: Sat, 19 Oct 2013 23:38:15 +0300
Message-Id: <1382215103-6968-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

It's better to check for the device flag instead of device features so
that we avoid unnecessary HCI commands when the feature is supported but
disabled (i.e. the flag is unset).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fb7fc9f..f39bab0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -568,7 +568,7 @@ static void update_scan_rsp_data(struct hci_request *req)
 	struct hci_cp_le_set_scan_rsp_data cp;
 	u8 len;
 
-	if (!lmp_le_capable(hdev))
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
 		return;
 
 	memset(&cp, 0, sizeof(cp));
-- 
1.8.3.1

