Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2 v2] Bluetooth: Fix link security setting when powering on
Date: Sun, 27 Jan 2013 08:32:00 -0600
Message-Id: <1359297121-9022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If a controller is powered on while the HCI_AUTO_OFF flag is set the
link security setting (HCI_LINK_SECURITY) might not be in sync with the
actual state of the controller (HCI_AUTH). This patch fixes the issue by
checking for inequality between the intended and actual settings and
sends a HCI_Write_Auth_Enable command if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fbc8edf..ae7585d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3073,6 +3073,8 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 	mgmt_pending_foreach(MGMT_OP_SET_POWERED, hdev, settings_rsp, &match);
 
 	if (powered) {
+		u8 link_sec;
+
 		if (test_bit(HCI_SSP_ENABLED, &hdev->dev_flags) &&
 		    !lmp_host_ssp_capable(hdev)) {
 			u8 ssp = 1;
@@ -3096,6 +3098,11 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 					     sizeof(cp), &cp);
 		}
 
+		link_sec = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+		if (link_sec != test_bit(HCI_AUTH, &hdev->flags))
+			hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+				     sizeof(link_sec), &link_sec);
+
 		if (lmp_bredr_capable(hdev)) {
 			set_bredr_scan(hdev);
 			update_class(hdev);
-- 
1.7.10.4

