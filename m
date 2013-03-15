Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 24/26] Bluetooth: Fix fast connectable state when enabling page scan
Date: Fri, 15 Mar 2013 17:07:14 -0500
Message-Id: <1363385236-25704-25-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering on or enabling page scan we need to ensure that the page
scan parameters are as they should be. This is because some controllers
do not properly reset these values upon HCI_Reset. Since the
write_scan_parameters function is now called from several new places it
also checks for the >= 1.2 HCI version requirement before sending the
commands.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7783b8d..75c9d92 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1006,6 +1006,9 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 
+	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
+		return;
+
 	if (enable) {
 		type = PAGE_SCAN_TYPE_INTERLACED;
 
@@ -1125,7 +1128,13 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
 
-	if (!cp->val && test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+	/* If we're going from non-connectable to connectable or
+	 * vice-versa when fast connectable is enabled ensure that fast
+	 * connectable gets disabled. write_fast_connectable won't do
+	 * anything if the page scan parameters are already what they
+	 * should be.
+	 */
+	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
 		write_fast_connectable(&req, false);
 
 	err = hci_req_run(&req, set_connectable_complete);
@@ -3287,6 +3296,12 @@ static void set_bredr_scan(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	u8 scan = 0;
 
+	/* Ensure that fast connectable is disabled. This function will
+	 * not do anything if the page scan parameters are already what
+	 * they should be.
+	 */
+	write_fast_connectable(req, false);
+
 	if (test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
 		scan |= SCAN_PAGE;
 	if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
-- 
1.7.10.4

