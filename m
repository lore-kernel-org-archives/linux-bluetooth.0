Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sending write_le_host_supporte for LE-only controllers
Date: Fri, 19 Apr 2013 17:07:12 +0300
Message-Id: <1366380432-16237-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Bluetooth Core Specification (4.0) defines the Write LE Host
Supported HCI command as only available for controllers supporting
BR/EDR. This is further reflected in the Read Local Extended Features
HCI command also not being available for LE-only controllers. In other
words, host-side LE support is implicit for single-mode LE controllers
and doesn't have explicit HCI-level enablement.

We do however still want user space to explicitly enable LE support in
order to use it (all user space versions already do this) so all the
mgmt_set_le command should affect is the HCI_LE_ENABLED flag without
causing any HCI commands to be sent.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c830c6..8a4b4da 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1356,7 +1356,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	val = !!cp->val;
 	enabled = lmp_host_le_capable(hdev);
 
-	if (!hdev_is_powered(hdev) || val == enabled) {
+	if (!hdev_is_powered(hdev) || val == enabled ||
+	    !lmp_bredr_capable(hdev)) {
 		bool changed = false;
 
 		if (val != test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
@@ -3347,7 +3348,8 @@ static int powered_update_hci(struct hci_dev *hdev)
 		hci_req_add(&req, HCI_OP_WRITE_SSP_MODE, 1, &ssp);
 	}
 
-	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags) &&
+	    lmp_bredr_capable(hdev)) {
 		struct hci_cp_write_le_host_supported cp;
 
 		cp.le = 1;
-- 
1.7.10.4

