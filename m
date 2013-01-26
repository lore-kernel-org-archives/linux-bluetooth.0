Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix link security setting when powering on
Date: Sat, 26 Jan 2013 16:33:49 -0600
Message-Id: <1359239630-3579-1-git-send-email-johan.hedberg@gmail.com>
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
index fbc8edf..f6ef8ff 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3096,6 +3096,13 @@ int mgmt_powered(struct hci_dev *hdev, u8 powered)
 					     sizeof(cp), &cp);
 		}
 
+		if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags) !=
+		    test_bit(HCI_AUTH, &hdev->flags)) {
+			u8 val = test_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+			hci_send_cmd(hdev, HCI_OP_WRITE_AUTH_ENABLE,
+				     sizeof(val), &val);
+		}
+
 		if (lmp_bredr_capable(hdev)) {
 			set_bredr_scan(hdev);
 			update_class(hdev);
-- 
1.7.10.4

