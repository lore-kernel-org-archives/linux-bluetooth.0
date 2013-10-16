Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix updating the right variable in update_scan_rsp_data()
Date: Wed, 16 Oct 2013 15:31:07 +0300
Message-Id: <1381926667-6255-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This function should be operating on scan_rsp_data_len and scan_rsp_data
and not the advertising data variables.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0bf823b..a727b47 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -575,12 +575,12 @@ static void update_scan_rsp_data(struct hci_request *req)
 
 	len = create_scan_rsp_data(hdev, cp.data);
 
-	if (hdev->adv_data_len == len &&
-	    memcmp(cp.data, hdev->adv_data, len) == 0)
+	if (hdev->scan_rsp_data_len == len &&
+	    memcmp(cp.data, hdev->scan_rsp_data, len) == 0)
 		return;
 
-	memcpy(hdev->adv_data, cp.data, sizeof(cp.data));
-	hdev->adv_data_len = len;
+	memcpy(hdev->scan_rsp_data, cp.data, sizeof(cp.data));
+	hdev->scan_rsp_data_len = len;
 
 	cp.length = len;
 
-- 
1.8.3.1

