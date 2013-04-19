Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix sending write_le_host_supporte for LE-only controllers
Date: Fri, 19 Apr 2013 18:35:21 +0300
Message-Id: <1366385721-4558-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Bluetooth Core Specification (4.0) defines the Write LE Host
Supported HCI command as only available for controllers supporting
BR/EDR. This is further reflected in the Read Local Extended Features
HCI command also not being available for LE-only controllers. In other
words, host-side LE support is implicit for single-mode LE controllers
and doesn't have explicit HCI-level enablement.

This patch ensures that the LE setting is always exposed as enabled
through mgmt and returns a "rejected" response if user space tries to
toggle the setting. The patch also ensures that Write LE Host Supported
is never sent for LE-only controllers.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Instead of requiring user space to explicitly enable the setting it
is now always enabled and trying to toggle it through mgmt will cause a
rejected error. One missing check for bredr_supported in the HCI init
sequence was also added.

 net/bluetooth/hci_core.c |   10 ++++++++++
 net/bluetooth/mgmt.c     |    8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b522be8..49550ff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -377,6 +377,8 @@ static void bredr_setup(struct hci_request *req)
 
 static void le_setup(struct hci_request *req)
 {
+	struct hci_dev *hdev = req->hdev;
+
 	/* Read LE Buffer Size */
 	hci_req_add(req, HCI_OP_LE_READ_BUFFER_SIZE, 0, NULL);
 
@@ -391,6 +393,10 @@ static void le_setup(struct hci_request *req)
 
 	/* Read LE Supported States */
 	hci_req_add(req, HCI_OP_LE_READ_SUPPORTED_STATES, 0, NULL);
+
+	/* LE-only controllers have LE implicitly enabled */
+	if (!lmp_bredr_capable(hdev))
+		set_bit(HCI_LE_ENABLED, &hdev->dev_flags);
 }
 
 static u8 hci_get_inquiry_mode(struct hci_dev *hdev)
@@ -574,6 +580,10 @@ static void hci_set_le_support(struct hci_request *req)
 	struct hci_dev *hdev = req->hdev;
 	struct hci_cp_write_le_host_supported cp;
 
+	/* LE-only devices do not support explicit enablement */
+	if (!lmp_bredr_capable(hdev))
+		return;
+
 	memset(&cp, 0, sizeof(cp));
 
 	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c830c6..35fef22 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1351,6 +1351,11 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				  MGMT_STATUS_INVALID_PARAMS);
 
+	/* LE-only devices do not allow toggling LE on/off */
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+				  MGMT_STATUS_REJECTED);
+
 	hci_dev_lock(hdev);
 
 	val = !!cp->val;
@@ -3347,7 +3352,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
 	}
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    lmp_bredr_capable(hdev)) {
 		struct hci_cp_write_le_host_supported cp;
 
 		cp.le = 1;
-- 
1.7.10.4

