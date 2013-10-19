Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Bluetooth: Fix sending write_scan_enable when BR/EDR is disabled
Date: Sat, 19 Oct 2013 23:38:21 +0300
Message-Id: <1382215103-6968-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
References: <1382215103-6968-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We should only send the HCI_Write_Scan_Enable command from
mgmt_set_powered_failed() when BR/EDR support is enabled. This is
particularly important when the discoverable setting is also tied to LE.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 20f6309..67b95a8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4337,7 +4337,6 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err)
 void mgmt_discoverable_timeout(struct hci_dev *hdev)
 {
 	struct hci_request req;
-	u8 scan = SCAN_PAGE;
 
 	hci_dev_lock(hdev);
 
@@ -4349,7 +4348,11 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 
 	hci_req_init(&req, hdev);
-	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
+	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		u8 scan = SCAN_PAGE;
+		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE,
+			    sizeof(scan), &scan);
+	}
 	update_class(&req);
 	hci_req_run(&req, NULL);
 
-- 
1.8.3.1

