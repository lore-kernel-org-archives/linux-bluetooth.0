Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: Update Set Discoverable to support LE
Date: Sun, 20 Oct 2013 19:00:07 +0300
Message-Id: <1382284807-26311-1-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1382259320-20009-1-git-send-email-johan.hedberg@gmail.com>
References: <1382259320-20009-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch updates the Set Discoverable management command to also be
applicable for LE. In particular this affects the advertising flags
where we can say "general discoverable" or "limited discoverable".

Since the device flags may not be up-to-date when the advertising data
is written this patch introduces a get_adv_discov_flags() helper
function which also looks at any pending mgmt commands (a pending
set_discoverable would be the exception when the flags are not yet
correct).

The patch also adds HCI_DISCOVERABLE flag clearing to the
mgmt_discoverable_timeout function, since the code was previously
relying on the mgmt_discoverable callback to handle this, which is only
called for the BR/EDR-only HCI_Write_Scan_Enable command.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v3:
 * Fix updating advertising flags when switching connectable off while
   limited discoverable is enabled.
v2:
 * Fix advertising flags update when disabling connectable while
  discoverable is enabled.
 * Fix redundant check for HCI_LE_ENABLED

 net/bluetooth/mgmt.c | 80 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 69 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 796db58..bd91ee5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -599,12 +599,35 @@ static void update_scan_rsp_data(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_RSP_DATA, sizeof(cp), &cp);
 }
 
+static u8 get_adv_discov_flags(struct hci_dev *hdev)
+{
+	struct pending_cmd *cmd;
+
+	/* If there's a pending mgmt command the flags will not yet have
+	 * their final values, so check for this first.
+	 */
+	cmd = mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev);
+	if (cmd) {
+		struct mgmt_mode *cp = cmd->param;
+		if (cp->val == 0x01)
+			return LE_AD_GENERAL;
+		else if (cp->val == 0x02)
+			return LE_AD_LIMITED;
+	} else {
+		if (test_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags))
+			return LE_AD_LIMITED;
+		else if (test_bit(HCI_DISCOVERABLE, &hdev->dev_flags))
+			return LE_AD_GENERAL;
+	}
+
+	return 0;
+}
+
 static u8 create_adv_data(struct hci_dev *hdev, u8 *ptr)
 {
 	u8 ad_len = 0, flags = 0;
 
-	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
-		flags |= LE_AD_GENERAL;
+	flags |= get_adv_discov_flags(hdev);
 
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
 		if (lmp_le_br_capable(hdev))
@@ -1120,15 +1143,15 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct pending_cmd *cmd;
 	struct hci_request req;
 	u16 timeout;
-	u8 scan, status;
+	u8 scan;
 	int err;
 
 	BT_DBG("request for %s", hdev->name);
 
-	status = mgmt_bredr_support(hdev);
-	if (status)
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
-				  status);
+				  MGMT_STATUS_REJECTED);
 
 	if (cp->val != 0x00 && cp->val != 0x01 && cp->val != 0x02)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
@@ -1228,6 +1251,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_init(&req, hdev);
 
+	/* The procedure for LE-only controllers is much simpler - just
+	 * update the advertising data.
+	 */
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags))
+		goto update_ad;
+
 	scan = SCAN_PAGE;
 
 	if (cp->val) {
@@ -1260,6 +1289,9 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, sizeof(scan), &scan);
 
+update_ad:
+	update_adv_data(&req);
+
 	err = hci_req_run(&req, set_discoverable_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
@@ -1451,8 +1483,17 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_init(&req, hdev);
 
-	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags) &&
-	    cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
+	/* If BR/EDR is not enabled and we disable advertising as a
+	 * by-product of disabling connectable, we need to update the
+	 * advertising flags.
+	 */
+	if (!test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+		if (!cp->val) {
+			clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+			clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+		}
+		update_adv_data(&req);
+	} else if (cp->val != test_bit(HCI_PSCAN, &hdev->flags)) {
 		if (cp->val) {
 			scan = SCAN_PAGE;
 		} else {
@@ -4348,6 +4389,7 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 	 * safe to unconditionally clear the flag.
 	 */
 	clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
+	clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
 
 	hci_req_init(&req, hdev);
 	if (test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
@@ -4356,10 +4398,13 @@ void mgmt_discoverable_timeout(struct hci_dev *hdev)
 			    sizeof(scan), &scan);
 	}
 	update_class(&req);
+	update_adv_data(&req);
 	hci_req_run(&req, NULL);
 
 	hdev->discov_timeout = 0;
 
+	new_settings(hdev, NULL);
+
 	hci_dev_unlock(hdev);
 }
 
@@ -4374,13 +4419,26 @@ void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev))
 		return;
 
-	if (discoverable)
+	if (discoverable) {
 		changed = !test_and_set_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
-	else
+	} else {
+		clear_bit(HCI_LIMITED_DISCOVERABLE, &hdev->dev_flags);
 		changed = test_and_clear_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+	}
+
+	if (changed) {
+		struct hci_request req;
+
+		/* In case this change in discoverable was triggered by
+		 * a disabling of connectable there could be a need to
+		 * update the advertising flags.
+		 */
+		hci_req_init(&req, hdev);
+		update_adv_data(&req);
+		hci_req_run(&req, NULL);
 
-	if (changed)
 		new_settings(hdev, NULL);
+	}
 }
 
 void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
-- 
1.8.3.1

