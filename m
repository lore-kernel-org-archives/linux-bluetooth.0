Return-Path: <cyrus@holtmann.org>
From: Florian Grandel <fgrandel@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 16/20] Bluetooth: mgmt: program multi-adv on power on
Date: Thu, 18 Jun 2015 03:16:49 +0200
Message-Id: <1434590213-26599-17-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
References: <1434590213-26599-1-git-send-email-fgrandel@gmail.com>
In-Reply-To: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
References: <1434166873-21595-1-git-send-email-fgrandel@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Advertising instances programmed while powered off should be advertised
once the device is powered. This patch ensures that all combinations
of setting and/or adding advertising configuration while powered off
will be correctly activated on power on.

Signed-off-by: Florian Grandel <fgrandel@gmail.com>
---
 net/bluetooth/mgmt.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c8ed16d..57e27b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7564,6 +7564,7 @@ static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 static int powered_update_hci(struct hci_dev *hdev)
 {
 	struct hci_request req;
+	struct adv_info *adv_instance;
 	u8 link_sec;
 
 	hci_req_init(&req, hdev);
@@ -7603,14 +7604,27 @@ static int powered_update_hci(struct hci_dev *hdev)
 		 * advertising data. This also applies to the case
 		 * where BR/EDR was toggled during the AUTO_OFF phase.
 		 */
-		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
+		if (hci_dev_test_flag(hdev, HCI_LE_ENABLED) &&
+		    (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+		     !hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))) {
 			update_adv_data(&req);
 			update_scan_rsp_data(&req);
 		}
 
-		if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
-		    hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE))
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+		    hdev->cur_adv_instance == 0x00 &&
+		    !list_empty(&hdev->adv_instances)) {
+			adv_instance = list_first_entry(&hdev->adv_instances,
+							struct adv_info, list);
+			hdev->cur_adv_instance = adv_instance->instance;
+		}
+
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
 			enable_advertising(&req);
+		else if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INSTANCE) &&
+			 hdev->cur_adv_instance)
+			schedule_adv_instance(&req, hdev->cur_adv_instance,
+					      true);
 
 		restart_le_actions(&req);
 	}
-- 
1.9.1

