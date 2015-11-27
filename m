Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix updating wrong instance's scan_rsp data
Date: Fri, 27 Nov 2015 10:52:39 +0200
Message-Id: <1448614359-27089-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The __hci_req_update_scan_rsp_data gets the instance to be updated
which should get passed to update_inst_scan_rsp_data() instead of
always enabling the current instance.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index adfcd6f1d0de..edf2199de4ff 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1018,7 +1018,7 @@ void __hci_req_update_scan_rsp_data(struct hci_request *req, int instance)
 	if (instance == HCI_ADV_CURRENT)
 		instance = get_current_adv_instance(req->hdev);
 
-	update_inst_scan_rsp_data(req, get_current_adv_instance(req->hdev));
+	update_inst_scan_rsp_data(req, instance);
 }
 
 static u8 create_instance_adv_data(struct hci_dev *hdev, u8 instance, u8 *ptr)
-- 
2.5.0

