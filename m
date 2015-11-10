Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/12] Bluetooth: Use req_workqueue for background scanning when powering on
Date: Tue, 10 Nov 2015 20:14:28 +0200
Message-Id: <1447179274-12276-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
References: <1447179274-12276-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can easily use the new req_workqueue based background scan update
for the power on case. This also removes the last external user of
__hci_update_background_scan().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b268a6ed0c5f..95184c1e8877 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7465,9 +7465,8 @@ void mgmt_index_removed(struct hci_dev *hdev)
 }
 
 /* This function requires the caller holds hdev->lock */
-static void restart_le_actions(struct hci_request *req)
+static void restart_le_actions(struct hci_dev *hdev)
 {
-	struct hci_dev *hdev = req->hdev;
 	struct hci_conn_params *p;
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
@@ -7488,8 +7487,6 @@ static void restart_le_actions(struct hci_request *req)
 			break;
 		}
 	}
-
-	__hci_update_background_scan(req);
 }
 
 static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
@@ -7505,6 +7502,9 @@ static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 		 * decide if the public address or static address is used.
 		 */
 		smp_register(hdev);
+
+		restart_le_actions(hdev);
+		hci_update_background_scan(hdev);
 	}
 
 	hci_dev_lock(hdev);
@@ -7583,8 +7583,6 @@ static int powered_update_hci(struct hci_dev *hdev)
 			 hdev->cur_adv_instance)
 			schedule_adv_instance(&req, hdev->cur_adv_instance,
 					      true);
-
-		restart_le_actions(&req);
 	}
 
 	link_sec = hci_dev_test_flag(hdev, HCI_LINK_SECURITY);
-- 
2.5.0

